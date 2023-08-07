// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "forge-std/Test.sol";
import {Event} from "../src/Event.sol";

contract EventTest is Test {
    Event public e;

    event Transfer(address indexed from, address indexed to,uint256 amount);

    function setUp() public {
        e = new Event();
    }

    function testEmitTransferEvent() public {
        // function expectEmit(
        //     bool checkTopic1,
        //     bool checkTopic2,
        //     bool checkTopic3,
        //     bool checkData
        // ) external;

        // 1. Tell Foundry which data to check
        // Check index 1, index 2 and data
        vm.expectEmit(true,true,false,true);
        // 2. Emit the expected event
        emit Transfer(address(this), address(123), 456);
        // 3. Call the function that should emit the event
        e.transfer(address(this), address(123), 4567);


        vm.expectEmit();
        emit Transfer(address(this), address(123), 456);
        e.transfer(address(this), address(123), 456);
    }
}