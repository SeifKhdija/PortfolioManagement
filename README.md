**Smart contracts**
1. PortfolioToken: ERC20 token smart contract, created when an investor or user create a portfolio, so each portfolio has its own smart contract(passing name, symbol, description, assetsNames, assetsValues, strategy , yield in constructor) and we execute the join, swap, deposit functions inside this smart contract.
2. PortfolioNFT: The same as PortfolioToken but it's an ERC721 token, and it holds informations about all the minted portfolios so it's not depending on any external solution like IPFS, that means everything inside the chain, so the whole NFT file will be in the smart contract level.
3. PortfolioManagement: Responsible for executing the creation and joining a portfolio and emitting the creation and joining events.

**Compiling**

create file .secret under main directory that contains ethrereum 12 words mnemonic

create file .infura under main directory that contains infura id

run npm install
