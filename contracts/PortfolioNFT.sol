// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
contract PortfolioNFT is ERC721 {

    uint256 public tokenCounter;

    struct  Portfolio {  
        string name;
        string symbol;
        string description;
        address[] assetsNames;
        uint256[] assetsValues;
        address[] strategy;
        uint256[] yield;
        }

    // hold informations about all the minted portfolios
    mapping(uint256 => Portfolio) public attributes;

    constructor (
        address _to,
        string memory _Name, 
        string memory _Symbol,
        string memory _description,
        address[] memory  _assetsNames,
        uint[] memory _assetsValues,
        address[] memory _strategy ,
        uint[] memory _yield

 )  ERC721("Portfolio","PORTFOLIO") {
        mint_portfolio(_to, _Name, _Symbol, _description, _assetsNames, _assetsValues, _strategy, _yield);
    }

    function mint_portfolio(
        address to,
        string memory _Name, 
        string memory _Symbol,
        string memory _description,
        address[] memory  _assetsNames,
        uint[] memory _assetsValues,
        address[] memory _strategy ,
        uint[] memory _yield
        
        ) public payable{
        uint256 newItemId = tokenCounter;
        _safeMint(to, newItemId);
        attributes[newItemId] = Portfolio(_Name, _Symbol, _description, _assetsNames, _assetsValues, _strategy, _yield);
        tokenCounter = tokenCounter + 1;
  
    }
    
    function _beforeTokenTransfer(address from, address to, uint256 tokenId)
        internal
        override(ERC721)
    {
        super._beforeTokenTransfer(from, to, tokenId);
    }
     function _burn(uint256 tokenId) internal override(ERC721) {
        super._burn(tokenId);
    }

}