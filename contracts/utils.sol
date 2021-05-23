import "@openzeppelin/contracts/math/SafeMath.sol";

pragma solidity ^0.5.17;

contract Utils {
    using SafeMath for uint256;

    function sliceArray(
        uint[] memory array,
        uint indexFrom
    )
    internal
    pure
    returns (uint[] memory)
    {
        uint[] memory sliced = new uint[](array.length.sub(indexFrom));
        uint k = 0;
        for (uint i = 0; i < array.length; i++) {
            if (i < indexFrom) {
                continue;
            }
            sliced[k] = array[i];
            k++;
        }
        return sliced;
    }

    function getDeltasArray(
        uint[] memory array,
        uint indexFrom
    )
    internal
    pure
    returns (uint[] memory)
    {
        uint[] memory sliced = new uint[](array.length.sub(indexFrom+1));
        uint k = 0;
        for (uint i = 0; i < array.length; i++) {
            if (i < indexFrom) {
                continue;
            }
            sliced[k] = array[i];
            k++;
        }
        return sliced;
    }
}
