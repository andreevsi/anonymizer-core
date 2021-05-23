pragma solidity ^0.5.17;

library Hasher {
    function MiMCSponge(uint256 xL_in, uint256 xR_in)
    public
    pure
    returns (uint256 xL, uint256 xR);
}
