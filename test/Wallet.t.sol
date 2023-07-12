// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;

import "forge-std/Test.sol";
import "../src/Wallet.sol";

contract WalletTest is Test {
    Wallet public wallet;

    function setUp() public {
        // (1) current owner == address(this)
        wallet = new Wallet();
    }

    function testSetOwner() public {
        // (2) current owner == address(1)
        wallet.setOwner(address(1));
        assertEq(wallet.owner(), address(1));
    }

    function testNotOwner() public {
        // msg.sender = address(this)
        wallet.setOwner(address(1));

        // msg.sender = address(this)
        // wallet.setOwner(address(1));

        vm.prank(address(1));
        // msg.sender = address(1)
        wallet.setOwner(address(1));
    }

    function testSetOwnerAgain() public {
        // msg.sender = address(this)
        wallet.setOwner(address(1));

        // msg.sender = address(1)
        vm.startPrank(address(1));
        wallet.setOwner(address(1));
        wallet.setOwner(address(1));
        wallet.setOwner(address(1));
        vm.stopPrank();

        // msg.sende = address(this)
        wallet.setOwner(address(1));
    }
}
