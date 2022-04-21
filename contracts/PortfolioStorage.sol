// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract PortfolioStorage {
    uint public portfolioCount;
    event AllocationDetails (address owner, address storeTo, uint portfolioID,address[] assetsNames,uint256[] assetsValues,address[] strategy,uint256[] yield);
    struct  Portfolio {  
        uint portfolioID;
        address owner;
        address[] assetsNames;
        uint256[] assetsValues;
        address[] strategy;
        uint256[] yield;
    }
    Portfolio[] public portfolios;
    mapping (uint => address) private portfolioOwners;

    function setCreatePortfolio(address _owner, address[] memory _assetsNames, uint256[] memory _assetsValues,address[] memory _strategy,uint256[] memory _yield) public{
    portfolioCount++;
    Portfolio memory newPortfolio = Portfolio(portfolioCount,_owner,_assetsNames,_assetsValues,_strategy,_yield);      
    portfolioOwners[portfolioCount] = _owner;
    portfolios.push(newPortfolio);
    emit AllocationDetails(msg.sender,address(this),portfolioCount,_assetsNames,_assetsValues, _strategy, _yield);
    }

    function getPortfolio(uint id) public view returns (Portfolio memory _portfolio) {
        return portfolios[id];
    }

    function getAllPortfoliosCreatedByUser (address _owner) public view  returns (Portfolio[] memory) {
        uint256 resultCount;
        for (uint i = 0; i < portfolios.length; i++) {
        if(portfolios[i].owner == _owner){
            resultCount++;
        }
    }
    Portfolio[] memory portfoliosInsance = new Portfolio[](resultCount);
        for(uint i = 0; i < portfolios.length; i++) {
            if(portfolios[i].owner == _owner){
              portfoliosInsance[i] = portfolios[i];
            }
        }
        return portfoliosInsance;
    }

    constructor() {
    }
}
