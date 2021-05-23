const DepositVerifier = artifacts.require('DepositVerifier')

module.exports = function(deployer) {
    deployer.deploy(DepositVerifier);
}
