const Anon = artifacts.require('Anonymizer');
const CreateWalletVerifier = artifacts.require('CreateWalletVerifier');
const DepositVerifier = artifacts.require('DepositVerifier');
const SwapVerifier = artifacts.require('SwapVerifier');
const WithdrawVerifier = artifacts.require('WithdrawVerifier');
const DropWalletVerifier = artifacts.require('DropWalletVerifier');
const hasherContract = artifacts.require('Hasher');
const fs = require('fs');

module.exports = function(deployer, network, accounts) {
    return deployer.then(async () => {
        const { MERKLE_TREE_HEIGHT, UNISWAP } = process.env;
        const createWalletVerifier = await CreateWalletVerifier.deployed();
        const depositVerifier = await DepositVerifier.deployed();
        const swapVerifier = await SwapVerifier.deployed();
        const withdrawVerifier = await WithdrawVerifier.deployed();
        const dropWalletVerifier = await DropWalletVerifier.deployed();

        const addr_array = JSON.parse(fs.readFileSync(process.cwd() + '/tokens.json').toString())

        const hasherInstance = await hasherContract.deployed();
        await Anon.link(hasherContract, hasherInstance.address);
        const anonymizer = await deployer.deploy(
            Anon,
            createWalletVerifier.address,
            depositVerifier.address,
            swapVerifier.address,
            withdrawVerifier.address,
            dropWalletVerifier.address,
            MERKLE_TREE_HEIGHT

        );
        await anonymizer.init(addr_array, UNISWAP);
        console.log('Anonymizer\'s address ', anonymizer.address);
    })
}
