pragma solidity >=0.4.22 <0.9.0;
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import '@openzeppelin/contracts/token/ERC20/ERC20.sol' ;
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import {IUniswapV2Router} from "./IUniswapV2Router.sol";
contract PortfolioToken is ERC20  {
    using SafeMath for uint256;
    address private constant UNISWAP_V2_ROUTER = 0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D;
    address[] public pair;
    address owner;
    string description;
    // users joined this portfolio
    mapping (address => bool) public users;
    // user with the amount of each deposited asset
    mapping (address => tokenDeposited) public tokensDeposited;
    struct tokenDeposited{
        address tokenName ; 
        uint256 amount;
    }
    struct Asset {
        address assetAddress;
        uint256 assetValue;
    }

    struct Strategy{
        address strategyAddress;
        uint256 yield;
    } 

    Asset[] pourcentageAssets;
    Strategy[] yieldStrategies;
    
    constructor ( address _owner,  
        string memory _Name, 
        string memory _Symbol,
        string memory _description,
        address[] memory  _assetsNames,
        uint[] memory _assetsValues,
        address[] memory _strategy ,
        uint[] memory _yield
 )  ERC20(_Name, _Symbol) {
        owner = _owner;
        description = _description;
        fillPourcentageAssets (_assetsNames ,_assetsValues );
        fillYieldStrategies (_strategy , _yield ) ;
    }

    function fillPourcentageAssets(address[] memory  _assetsNames,uint[] memory _assetsValues)  private {
        for (uint i = 0; i < _assetsNames.length; i++) {
            Asset memory asset = Asset ({
                assetAddress : _assetsNames[i] ,
                assetValue : _assetsValues[i] 
            });
            pourcentageAssets.push(asset); 
        }
    }

    function fillYieldStrategies (address[] memory _strategy , uint[] memory _yield) private {

        for (uint i = 0; i < _strategy.length; i++) {
             Strategy memory strategy = Strategy ({
                strategyAddress : _strategy[i] ,
                yield : _yield[i] 
            });
            yieldStrategies.push(strategy);
        }
    }

    function join(uint amountIn ,address tokenDeposit) external{
    require(users[msg.sender] == false , "User is elready joined");
    users[msg.sender] = true;
    tokenDeposited memory depositToken = tokenDeposited(tokenDeposit,amountIn);  
    tokensDeposited[msg.sender] = depositToken;
    IERC20(tokenDeposit).transferFrom(msg.sender,address(this) ,amountIn);
    }
    
    function swap() external{
    require(users[msg.sender] == true , "Not joined user");
    require(tokensDeposited[msg.sender].amount >0, "User didn't deposit yet");
    address tokenToSwap ;
    uint pourcentage ; 
    for (uint i=0 ; i < pourcentageAssets.length ; i++)
    {
            tokenToSwap = pourcentageAssets[i].assetAddress ;
            pourcentage = pourcentageAssets[i].assetValue ;
            pair = [ tokensDeposited[msg.sender].tokenName ,tokenToSwap ];
            uint256 value = tokensDeposited[msg.sender].amount.mul(pourcentage).div(100);
            IERC20(tokensDeposited[msg.sender].tokenName).approve(UNISWAP_V2_ROUTER , value);
            IUniswapV2Router(UNISWAP_V2_ROUTER).swapExactTokensForTokens(value, 0,pair , address(this), block.timestamp) ;
        }
    }

    
    

}
