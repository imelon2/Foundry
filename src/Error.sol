// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;

contract Error {
    // custom Error
    error NotAuthorized();

    function throwError() external pure {
        require(false, "Not Authorized");
    }

    function throwCustomError() external pure {
        revert NotAuthorized();
    }
}
