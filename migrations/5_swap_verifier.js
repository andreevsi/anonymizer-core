const SwapVerifier = artifacts.require('SwapVerifier')

module.exports = function(deployer) {
    deployer.deploy(SwapVerifier);
}
