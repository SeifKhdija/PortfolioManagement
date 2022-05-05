const ERC20Mock = artifacts.require("ERC20Mock");
const PortfolioManagement = artifacts.require("PortfolioManagement");
const PortfolioNFT = artifacts.require("PortfolioNFT");
const PortfolioToken = artifacts.require("PortfolioToken");
const UniswapV2Factory = artifacts.require("UniswapV2Factory");
const UniswapV2Pair = artifacts.require("UniswapV2Pair");
const UniswapV2Router01 = artifacts.require("UniswapV2Router01");
const UniswapV2Router02 = artifacts.require("UniswapV2Router02");
const WETH = artifacts.require("WETH");
module.exports = async function(deployer, network, accounts) {
  const [admin, _] = accounts

  await deployer.deploy(PortfolioManagement);
  const portfoliomanagement = await PortfolioManagement.deployed();

  await deployer.deploy(PortfolioToken);
  const tortfoliotoken = await PortfolioToken.deployed();

  await deployer.deploy(PortfolioNFT);
  const portfolionFT = await PortfolioNFT.deployed();
  /*await deployer.deploy(WETH);
  const weth = await WETH.deployed();
  const tokenA = await ERC20Mock.new('token A', 'TKA', web3.utils.toWei(String(1000),'ether'));
  const tokenB = await ERC20Mock.new('token B', 'TKB', web3.utils.toWei(String(1000),'ether'));
  await deployer.deploy(UniswapV2Factory,admin);
  const factory = await UniswapV2Factory.deployed();
  await factory.createPair(weth.address,tokenA.address);
  await factory.createPair(weth.address,tokenB.address);
  await factory.createPair(tokenA.address,tokenB.address);
  await deployer.deploy(UniswapV2Router02,factory.address,weth.address);
  const router = await UniswapV2Router02.deployed();
  */


}
