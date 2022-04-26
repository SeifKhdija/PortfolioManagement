// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;
import { PortfolioNFT } from "./PortfolioNFT.sol";
import {PortfolioToken} from "./PortfolioToken.sol";
contract PortfolioManagement {
  constructor() {
  }
  event PortfolioCreated(
        address owner,
        address portfolioTokenAddress,
        address portfolioNFTAddress,
        string name,
        string symbol,
        string description, 
        address[] assetsNames, 
        uint256[] assetsValues, 
        address[] strategy, 
        uint256[] yield
        );

      function createNewPortfolio( string memory name , string memory symbol , string memory description , address[] memory assetsNames,
      uint256[] memory assetsValues , address[] memory strategy,  uint256[] memory yield
      ) public {
      address owner = msg.sender; 
      PortfolioNFT portfolioNFT = new PortfolioNFT(owner ,name, symbol ,description,assetsNames ,assetsValues ,strategy ,yield );
      PortfolioToken portfolioToken =  new PortfolioToken(owner ,name, symbol ,description,assetsNames ,assetsValues ,strategy ,yield );
      emit PortfolioCreated(msg.sender, address(portfolioToken),address(portfolioNFT), name,symbol, description , assetsNames, assetsValues, strategy, yield);
     }

     function joinPortfolio(address portfolioAddress,uint amountDeposit ,address tokenDeposit ) public{
      PortfolioToken portfolioJoined = PortfolioToken(portfolioAddress);
      portfolioJoined.join(amountDeposit, tokenDeposit);
      portfolioJoined.swap();
     }
}
