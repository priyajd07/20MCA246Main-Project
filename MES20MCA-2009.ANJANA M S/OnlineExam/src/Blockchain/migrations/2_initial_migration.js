const Migrations = artifacts.require("onlineexamination");

module.exports = function (deployer) {
  deployer.deploy(Migrations);
};
