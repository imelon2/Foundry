// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

contract Auction {
    uint256 public startAt = block.timestamp + 1 days;
    uint256 public endAt = block.timestamp + 2 days;

    //@dev 1일이 지나야만 하고, 2일이 지나면 안됨
    function bid() view external {
        require(
            block.timestamp >= startAt && block.timestamp < endAt, "cannot bid"
        );
    }

    // 2일보다 더 지나야함
    function end() view external {
        require(block.timestamp >= endAt, "cannot end");
    }
}