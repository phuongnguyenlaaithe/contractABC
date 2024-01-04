// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

contract B is ERC20, AccessControl{

    bytes32 public constant  BURN_MINT_ROLE=keccak256("BURN_MINT_PERMISSION");

    constructor() ERC20("B Token", "BT") {
        _mint(msg.sender, 10000 * (10**decimals())); // Mint initial supply
        _grantRole(DEFAULT_ADMIN_ROLE,msg.sender);
        _grantRole(BURN_MINT_ROLE,msg.sender);
    }

    function grantMintRole(address account) public onlyRole(DEFAULT_ADMIN_ROLE){
        grantRole(BURN_MINT_ROLE,account);
    }

    function mint(address to, uint256 amount) external onlyRole(BURN_MINT_ROLE) {
        _mint(to, amount);
    }

    function burn (address to, uint256 amount) external onlyRole(BURN_MINT_ROLE) {
        _burn(to, amount);
    }
}
