const WithdrawVerifier = artifacts.require('WithdrawVerifier')

module.exports = function(deployer) {
    deployer.deploy(WithdrawVerifier);
}
