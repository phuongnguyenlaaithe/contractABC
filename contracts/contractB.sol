// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

contract B is ERC20, AccessControl{

    bytes32 public constant  BURN_MINT_ROLE= 0x00;

    constructor() ERC20("B Token", "BT") {
        _mint(msg.sender, 10000 * (10**decimals())); // Mint initial supply
        _grantRole(DEFAULT_ADMIN_ROLE,msg.sender);
        _grantRole(BURN_MINT_ROLE,msg.sender);
    }

    function grantBurnMintRole(address account) public onlyRole(DEFAULT_ADMIN_ROLE){
        grantRole(BURN_MINT_ROLE,account);
    }

    function mint(address account, uint256 amount) external onlyRole(BURN_MINT_ROLE) {
        _mint(account, amount);
    }

    function burn (address account, uint256 amount) external onlyRole(BURN_MINT_ROLE) {
        _burn(account, amount);
    }
}
