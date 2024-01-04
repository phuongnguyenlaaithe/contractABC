// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./contractB.sol";

contract A {
    address public owner;
    B public bToken;

    mapping(address => uint256) public lockedBalance;

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    constructor (address _bTokenAddress) {
        owner = msg.sender;
        bToken = B(_bTokenAddress);
    }

    function lock(uint256 amount) external {
        require(bToken.allowance(msg.sender,address(this))>=amount,"the allowance is not enough");
        bToken.transferFrom(msg.sender,address(this),amount);
        lockedBalance[msg.sender] += amount;
    }

    function mint(uint256 amount) external onlyOwner {
        bToken.mint(address(this), amount);
    }

    function burn(uint256 amount) external onlyOwner {
        bToken.burn(address(this), amount);
    }

    function withdraw(uint256 amount) external {
        require(lockedBalance[msg.sender]>=amount,"The lock asset is smaller than required amount");
        bToken.transfer(msg.sender,amount);
        lockedBalance[msg.sender]-=amount;
    }
}
