// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;

contract Error {
    // custom Error
    error NotAuthorized();

    function throwError() external {
        require(false,"Not Authorized");
    }

    function throwCustomError() external {
        revert NotAuthorized();
    }
}