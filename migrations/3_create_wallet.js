const CreateWalletVerifier = artifacts.require('CreateWalletVerifier')

module.exports = function(deployer) {
    deployer.deploy(CreateWalletVerifier);
}
