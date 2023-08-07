// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "forge-std/Test.sol";
import {Auction} from "../src/Time.sol";

// forge test --match-path test/Time.t.sol -vvvv

contract TimeTest is Test {
    Auction public auction;
    uint256 private startAt;

    // vm.warp - set block.timestamp to future timestamp
    // vm.roll - set block.number
    // skip - increment current timestamp
    // rewind - decrement current timestamp

    function setUp() public {
        auction = new Auction();
        startAt = block.timestamp;
    }

    function testBidFailsBeforeStartTime() public {
        vm.expectRevert(bytes("cannot bid"));
        auction.bid();
    }

    function testBid() public {
        vm.warp(startAt + 1 days);
        auction.bid();
    }

    function testBidFailsAfterEndTime() public {
        vm.expectRevert(bytes("cannot bid"));
        vm.warp(startAt + 2 days);
        auction.bid();
    }

    function testTimestamp() public {
        uint t = block.timestamp;

        // skip - increment current timestamp
        // set block.timestamp to t + 100
        skip(100);
        assertEq(block.timestamp, t + 100);


        // rewind - decrement current timestamp
        // set block.timestamp to t + 100 - 10
        rewind(10);
        assertEq(block.timestamp, t + 100 - 10);
    }

    function testBlockNumber() public {
        // vm.roll - set block.number
        // set block number to 11
        vm.roll(11);
        assertEq(block.number, 11);
    }
}