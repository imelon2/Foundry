// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;
import "forge-std/Test.sol";
import "../src/Fuzz.sol";

contract FuzzTest is Test {
    Fuzz private fuzz;

    function setUp() public {
        fuzz = new Fuzz();
    }

    function testFuzzing(uint256 x) public {
        assertEq(fuzz.checkMax(x), x);
    }

    // assume - 조건이 거짓이면 fuzzer는 현재 fuzz 입력을 버리고 새 fuzz 실행을 시작합니다.
    // - run 256을 실행하며, 조건에 맞지 않은 실행값은 버린다.
    function testFuzzingAssume(uint256 x) public {
        vm.assume(x < 255);
        assertEq(fuzz.checkMax(x), x,"Test Assume");
    }

    // bound(input, min, max) - 설정된 최소값과 최대값 사이의 입력 값만 실행한다. 
    // - run 256을 실행하며, 조건에 맞지 않은 실행값은 버린다.
    function testFuzzingBound(uint256 x) public {
        x = bound(x,1,100);
        assertEq(fuzz.checkMax(x), x);
    }
}