// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;

contract Fuzz {
    function checkMax(uint256 num) public pure returns(uint256) {
        if(type(uint256).max >= 2**num) {
            return num;
        }
        return 0;
    }
}