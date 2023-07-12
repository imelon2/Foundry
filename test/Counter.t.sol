// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../src/Counter.sol";

contract CounterTest is Test {
    Counter public counter;

    function setUp() public {
        counter = new Counter();
        counter.setNumber(0);
    }

    function testIncrement() public {
        counter.increment();
        assertEq(counter.number(), 1);
    }

    // test + Fail => expect Fail
    function testFailDec() public {
        counter.increment();
        // counter.dec();
        console.log("HERE",counter.number());
        assertEq(counter.number(),2);
    }

    function testDecUnderflow() public {
        vm.expectRevert(stdError.arithmeticError); // Arithmetic over/underflow error
        counter.dec();
    }
}
