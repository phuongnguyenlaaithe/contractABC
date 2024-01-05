// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./contractB.sol";

contract A {
    B public BToken;

    mapping(address => uint256) private lockedBalance;

    constructor (address _BTokenAddress) {
        BToken = B(_BTokenAddress);
    }

    function lockedBalanceOf(address account) public view returns (uint256) {
        return lockedBalance[account];
    }

    function lock(uint256 amount) external {
        require(BToken.allowance(msg.sender,address(this)) >= amount,"Insufficient allowance to lock");
        require(BToken.balanceOf(msg.sender) >= amount, "Insufficient balance to lock");
        BToken.transferFrom(msg.sender,address(this),amount);
        lockedBalance[msg.sender] += amount;
    }

    function mint(uint256 amount) external {
        BToken.mint(msg.sender, amount);
    }

    function burn(uint256 amount) external {
        require(BToken.balanceOf(msg.sender) >= amount, "Insufficient balance to burn");
        BToken.burn(msg.sender, amount);
    }

    function withdraw(uint256 amount) external {
        require(lockedBalance[msg.sender]>=amount,"Insufficient lockedBalance to withdraw");
        BToken.transfer(msg.sender,amount);
        lockedBalance[msg.sender]-=amount;
    }
}
