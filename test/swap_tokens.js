const WETH = artifacts.require('WETH')
const UniswapV2Router02 = artifacts.require('UniswapV2Router02')
const UniswapV2Pair = artifacts.require('UniswapV2Pair')
const UniswapV2Factory = artifacts.require('UniswapV2Factory')
const PortfolioManagement = artifacts.require('PortfolioManagement')
const PortfolioToken = artifacts.require('PortfolioToken')
const PortfolioNFT = artifacts.require('PortfolioNFT')
const ERC20Mock = artifacts.require('ERC20Mock')
const { ethers } = require("ethers");
function tokens(n) {
    return web3.utils.toWei(n, 'ether');
}
contract('UniswapV2Factory', ([owner, provider]) => {
    let factory,weth,pair,root,tokenA,tokenB,pairAdress,pairSwap,router,created_at,amountIn
    before(async () => {
        weth = await WETH.new()
        pair = await UniswapV2Pair.new()  
        factory = await UniswapV2Factory.new(owner)
        router = await UniswapV2Router02.new(factory.address,weth.address)
        // creating 2 tokens to create a pool
        tokenA = await ERC20Mock.new('token A', 'TKA', String(1000))
        tokenB = await ERC20Mock.new('token B', 'TKB', String(1000))
        // trasfer amount to both tokens
        await tokenA.transfer(provider, 100, { from: owner })
        await tokenB.transfer(provider, 100, { from: owner })
        await tokenA.approve( router.address, 100, { from: provider } )
        await tokenB.approve( router.address, 100, { from: provider } )
        // Create pool using tokenA and tokenB pair
        await factory.createPair(tokenA.address,tokenB.address)
        created_at = Math.floor(Date.now() / 1000)
    //    await router.addLiquidity(tokenA.address, tokenB.address,50,50,0,0,provider,created_at)
        // swap amount of tokenA into TokenB
      /*  await router.swapExactTokensForTokens(
          tokens('30'),
          0,
          [tokenA.address, tokenB.address],
          provider,
          created_at,
          { from: provider})*/
      })
      describe('Adding pair', async () => {
        
          it('Provider has enaugh tokenB', async () => {
            let balanceB = await tokenB.balanceOf(provider)
            assert.equal(balanceB.toString(), 100)
          })
          it('pair added to the list', async () => {
              let length = await factory.allPairsLength()
            assert.equal(length, 1,"there is no pair ")
          })
          it('Pool tokenA-TokenB created', async () => {
          let addr = await factory.getPair(tokenA.address, tokenB.address)
            assert.notEqual(addr,'0x0000000000000000000000000000000000000000',"tokenA tokenB exist")
          })
          it('swapTokens', async () => {
            // balance of provider after swap
             let ba = await tokenA.balanceOf(provider)
              assert.equal(ba,70,"balance is wrong")
            })
      })
  })
  