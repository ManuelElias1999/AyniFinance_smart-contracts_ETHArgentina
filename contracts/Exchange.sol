// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Exchange {
    IERC20 public usdcToken;
    IERC20 public finkaToken;
    uint exchangeTax;
    address public finkaOwner;
    address public usdtCustodial;
    address public usdtOwner;

    constructor() {
        exchangeTax = 10;
        usdcToken = IERC20(0x0FA8781a83E46826621b3BC094Ea2A0212e71B23);  
        finkaToken = IERC20(0x151275fAd226e25817e72b388862Ef28bf7d461A);  
        usdtOwner = 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266;
        finkaOwner = 0x77625006c16eE0572b44A52016D0e74B9de74633;
        usdtCustodial = 0xe9A07Ce1E5eb916359D1E4BE6D928E6E77442177;
        // exvhange 0x8D61Ec05733A983Bd17E7E3523f04d56fAf5aE93
    }

    function deposit(uint amount) public {
        require(usdcToken.balanceOf(msg.sender) > amount, "Not enough USDT balance");
        require(usdcToken.transferFrom(msg.sender, usdtCustodial, amount), "Usdt transfer failed");
        uint finkaTokens = amount*exchangeTax;
        require(finkaToken.balanceOf(finkaOwner) > finkaTokens, "Not enough finkaTokens balance");
        require(finkaToken.transferFrom(finkaOwner, msg.sender, finkaTokens), "Finka tokanes transfer failed");
    }
}