// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;

import "forge-std/Test.sol";
import "../src/Error.sol";

contract ErrorTest is Test {
    Error public err;

    function setUp() public {
        err = new Error();
    }

    function testFail() public {
        err.throwError();
    }

    function testRevert() public {
        vm.expectRevert(); // 바로 아래 로직은 expect error 케이스로 적용
        err.throwError();
    }

    function testRequireMessage() public {
        // 바로 아래 로직은 expect error msg("Not Authorized") 케이스로 적용
        vm.expectRevert(bytes("Not Authorized"));
        err.throwError();
    }

    function testCustomError() public {
        // 바로 아래 로직은 expect Custom error NotAuthorized() 케이스로 적용
        vm.expectRevert(Error.NotAuthorized.selector);
        err.throwCustomError();
    }

    function testErrorLabel() public {
        assertEq(uint256(1), uint256(1), "test 1");
        assertEq(uint256(1), uint256(1), "test 2");
        assertEq(uint256(1), uint256(1), "test 3");
        assertEq(uint256(1), uint256(2), "test 4"); // 해당 라벨 애러 호출
        assertEq(uint256(1), uint256(1), "test 5");
    }
}
