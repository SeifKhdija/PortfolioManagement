// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity >=0.5.0;

interface IPortfolioManagement {
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
      ) external;
    function joinPortfolio(address portfolioAddress,uint amountDeposit ,address tokenDeposit ) external;
}