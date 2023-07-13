// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;

import "forge-std/Test.sol";

contract Invariant0 {
    bool public flag;

    function func1() external {}
    function func2() external {}
    function func3() external {}
    function func4() external {}

    function func5() external {
        flag = true;
    }
}

contract Invariant0Test is Test {
    Invariant0 private targat;

    function setUp() public {
        targat = new Invariant0();
    }

    function invariant_flag_is_always_false() public {
        assertEq(targat.flag(), false);
    }
}
