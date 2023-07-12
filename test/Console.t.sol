// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "forge-std/console.sol";


contract ConsoleTest is Test {
    function testLogSomething() public {
        int x = -1;
        console.logInt(x);
    }
}
