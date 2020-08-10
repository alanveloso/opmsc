var Intermediator = artifacts.require("./IntermediatorMock.sol");
var Federated = artifacts.require("./FederatedMock.sol");

module.exports = function(deployer) {
    deployer.deploy(Intermediator);
    deployer.deploy(Federated);
};