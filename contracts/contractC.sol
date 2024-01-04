// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract C {
    address public bTokenAddress;

    constructor(address _bTokenAddress) {
        bTokenAddress = _bTokenAddress;
    }

    function delegateMint(bytes memory data) external {
        (bool success, ) = bTokenAddress.delegatecall(data);
        require(success, "Delegate call to BToken failed");
    }

    function delegateBurn (bytes memory data) external {
        (bool success, ) = bTokenAddress.delegatecall(data);
        require(success, "Delegate call to BToken failed");
    }
}