const DropWalletVerifier = artifacts.require('DropWalletVerifier')

module.exports = function(deployer) {
    deployer.deploy(DropWalletVerifier);
}
