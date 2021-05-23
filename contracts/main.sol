pragma solidity 0.5.17;

import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
import "./lib/transfer-helper.sol";
import "./merkle-tree.sol";
import "./operations-processor.sol";
import "./utils.sol";
import "./verifiers/create-wallet-verifier.sol";
import "./verifiers/deposit-verifier.sol";
import "./verifiers/swap-verifier.sol";
import "./verifiers/withdraw-verifier.sol";
import "./verifiers/drop-wallet-verifier.sol";

contract Anonymizer is
OperationsProcessor,
MerkleTreeWithHistory,
Utils,
ReentrancyGuard
{
    CreateWalletVerifier public createWalletVerifier;
    DepositVerifier public depositVerifier;
    SwapVerifier public swapVerifier;
    WithdrawVerifier public withdrawVerifier;
    DropWalletVerifier public dropWalletVerifier;

    mapping(bytes32 => bool) concealers;

    uint256 public constant MAX_VALUE = 2**170;

    event Commitment(
        bytes32 indexed commitment,
        uint32 leafIndex,
        uint256 timestamp
    );

    event Debug (
        uint256 tokenFrom,
        uint256 tokenTo,
        uint256 indexFrom,
        uint256 indexTo
    );

    event Log(string message);

    event LogAddress(address message);

    event CreateWallet(
        bytes32 indexed commitment,
        uint32 leafIndex,
        uint256 timestamp
    );

    event DropWallet(
        bytes32 indexed commitment,
        uint256 timestamp
    );

    constructor(
        CreateWalletVerifier _createWalletVerifier,
        DepositVerifier _depositVerifier,
        SwapVerifier _swapVerifier,
        WithdrawVerifier _withdrawVerifier,
        DropWalletVerifier _dropWalletVerifier,
        uint32 _merkleTreeHeight
    ) public MerkleTreeWithHistory(_merkleTreeHeight) {
        createWalletVerifier = _createWalletVerifier;
        depositVerifier = _depositVerifier;
        swapVerifier = _swapVerifier;
        withdrawVerifier = _withdrawVerifier;
        dropWalletVerifier = _dropWalletVerifier;
    }

    function createWallet(
        uint256[2] calldata a,
        uint256[2][2] calldata b,
        uint256[2] calldata c,
        uint256[] calldata input
    ) external payable nonReentrant {
        require(input.length == CURRENCIES_NUMBER + 1, "Incorrect input length");
        require(
            createWalletVerifier.verifyProof(a, b, c, input),
            "Anonymizer: wrong proof"
        );
        uint256[] memory tokensAmounts = sliceArray(input, 1);
        processCreateWallet(tokensAmounts);

        uint32 index = _insert(bytes32(input[0]));
        emit Commitment(bytes32(input[0]), index, block.timestamp);
        emit CreateWallet(bytes32(input[0]), index, block.timestamp);
    }

    function deposit(
        uint256[2] calldata a,
        uint256[2][2] calldata b,
        uint256[2] calldata c,
        uint256[] calldata input
    ) external payable nonReentrant {
        require(input.length == CURRENCIES_NUMBER + 3, "Incorrect input length");
        require(
            depositVerifier.verifyProof(a, b, c, input),
            "Anonymizer: wrong proof"
        );
        bytes32 commitment_new = bytes32(input[0]);
        bytes32 root = bytes32(input[1]);
        bytes32 concealer_old = bytes32(input[2]);
        uint256[] memory tokens_amounts = sliceArray(input, 3);

        _deposit(root, concealer_old, tokens_amounts);

        uint32 index = _insert(commitment_new);
        emit Commitment(commitment_new, index, block.timestamp);
    }

    function swap (
        uint256[2] calldata a,
        uint256[2][2] calldata b,
        uint256[2] calldata c,
        uint256[] calldata input
    ) external nonReentrant {
        require(input.length == CURRENCIES_NUMBER + 6, "Incorrect input length");
        require(
            swapVerifier.verifyProof(a, b, c, input),
            "Anonymizer: wrong proof"
        );
        bytes32 commitment_success = bytes32(input[0]);
        bytes32 commitment_fail = bytes32(input[1]);
        bytes32 root = bytes32(input[2]);
        bytes32 concealer_old = bytes32(input[3]);
        uint256 fee = uint256(input[4]);
        address relayer = address(input[5]);
        uint256[] memory tokens_deltas = sliceArray(input, 6);

        TransferHelper.safeTransferETH(relayer, fee);

        (bool success,) =
        address(this).delegatecall(
            abi.encodePacked(
                this._swap.selector,
                abi.encode(root, concealer_old, tokens_deltas)
            )
        );

        concealers[concealer_old] = true;

        bytes32 commitment;

        if (success) {
            commitment = commitment_success;
        } else {
            commitment = commitment_fail;
        }

        uint32 index = _insert(commitment);
        emit Commitment(commitment, index, block.timestamp);
    }

    function withdraw (
        uint256[2] calldata a,
        uint256[2][2] calldata b,
        uint256[2] calldata c,
        uint256[] calldata input
    ) external nonReentrant {
        require(input.length == CURRENCIES_NUMBER + 7, "Incorrect input length");
        require(
            withdrawVerifier.verifyProof(a, b, c, input),
            "Anonymizer: wrong proof"
        );
        bytes32 commitment_success = bytes32(input[0]);
        bytes32 commitment_fail = bytes32(input[1]);
        bytes32 root = bytes32(input[2]);
        bytes32 concealer_old = bytes32(input[3]);
        uint256 fee = uint256(input[4]);
        address recipient = address(input[5]);
        address relayer = address(input[6]);
        uint256[] memory deltas = sliceArray(input, 7);

        TransferHelper.safeTransferETH(relayer, fee);

        (bool success,) =
        address(this).delegatecall(
            abi.encodePacked(
                this._withdraw.selector,
                abi.encode(root, concealer_old, deltas, recipient)
            )
        );

        concealers[concealer_old] = true;

        bytes32 commitment;

        if (success) {
            commitment = commitment_success;
        } else {
            commitment = commitment_fail;
        }

        uint32 index = _insert(commitment);
        emit Commitment(commitment, index, block.timestamp);
    }

    function dropWallet (
        uint256[2] calldata a,
        uint256[2][2] calldata b,
        uint256[2] calldata c,
        uint256[] calldata input
    ) external nonReentrant {
        require(input.length == CURRENCIES_NUMBER + 4, "Incorrect input length");
        require(
            dropWalletVerifier.verifyProof(a, b, c, input),
            "Anonymizer: wrong proof"
        );
        bytes32 root = bytes32(input[0]);
        bytes32 concealer_old = bytes32(input[1]);
        uint256 fee = uint256(input[2]);
        address recipient = address(input[3]);
        address relayer = address(input[4]);
        uint256[] memory amounts = sliceArray(input, 5);

        TransferHelper.safeTransferETH(relayer, fee);

        address(this).delegatecall(
            abi.encodePacked(
                this._withdraw.selector,
                abi.encode(root, concealer_old, amounts, recipient)
            )
        );

        concealers[concealer_old] = true;
        emit DropWallet(concealer_old, block.timestamp);
    }

    function _deposit(
        bytes32 root,
        bytes32 concealer_old,
        uint256[] memory currenciesAmounts
    ) private {
        require(isKnownRoot(root), "Root is not valid");
        require(!concealers[concealer_old], "Deposit has already withdrawn");
        processDeposit(currenciesAmounts);
    }

    function _swap(
        bytes32 root,
        bytes32 concealer_old,
        uint256[] memory token_deltas
    ) public payable {
        emit Log("inside _swap");
        require(isKnownRoot(root), "Root is not valid");
        require(!concealers[concealer_old], "Deposit has already withdrawn");
        emit Log("start extract");

        uint256 amountFrom;
        uint256 amountTo;
        uint256 indexFrom;
        uint256 indexTo;

        for (uint i = 0; i < CURRENCIES_NUMBER; i++) {
            if (token_deltas[i] != 0) {
                if (amountFrom != 0 && amountTo != 0) {
                    revert("You can swap only one tokens pair");
                }
                if (token_deltas[i] > MAX_VALUE) {
                    amountFrom = FIELD_SIZE - token_deltas[i];
                    indexFrom = i;
                    if (amountTo > MAX_VALUE) {
                        revert("Max swap value is 170");
                    }
                } else {
                    amountTo = token_deltas[i];
                    indexTo = i;
                }
            }
        }
        emit Log("end extract");
        emit Debug(amountFrom, amountTo, indexFrom, indexTo);
        require(amountFrom != 0 && amountTo != 0, "From amount and to amount must be not zeros");
        processSwap(amountFrom, indexFrom, amountTo, indexTo);
        emit Log("end swap");
    }

    function _withdraw(
        bytes32 root,
        bytes32 concealer_old,
        uint256[] memory deltas,
        address recipient
    ) public payable {
        require(isKnownRoot(root), "Root is not valid");
        require(!concealers[concealer_old], "Deposit has already withdrawn");
        processWithdraw(deltas, recipient);
    }
}
