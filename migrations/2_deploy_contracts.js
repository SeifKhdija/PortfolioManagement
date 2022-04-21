
const PortfolioStorage = artifacts.require("PortfolioStorage");
module.exports = async function(deployer, network, accounts) {
  await deployer.deploy(PortfolioStorage)
}
