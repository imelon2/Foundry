// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../src/WETH.sol";

import {CommonBase} from "forge-std/Base.sol";
import {StdCheats} from "forge-std/StdCheats.sol";
import {StdUtils} from "forge-std/StdUtils.sol";

/**
 * 컨트렉트 시나리오
 */
contract Handler is CommonBase, StdCheats, StdUtils {
    WETH private weth;
    uint256 public wethBalance;

    constructor(WETH _weth) {
        weth = _weth;
    }

    receive() external payable {}

    function sendToFallback(uint256 amount) public {
        amount = bound(amount, 0, address(this).balance);
        wethBalance += amount;

        (bool ok,) = address(weth).call{value: amount}("");
        require(ok, "sendToFallback failed");
    }

    function deposit(uint256 amount) public {
        amount = bound(amount, 0, address(this).balance);
        wethBalance += amount;

        weth.deposit{value: amount}();
    }

    function withdraw(uint256 amount) public {
        amount = bound(amount, 0, weth.balanceOf(address(this)));
        wethBalance -= amount;

        weth.withdraw(amount);
    }

    // function fail() external pure {
    //     revert("fail");
    // }
}

/**
 * Handler에 작성한 시나리오를 통해 불변성 테스트 진행
 */
contract WETH_Handler_Invariant_Test is Test {
    WETH public weth;
    Handler public handler;

    function setUp() public {
        weth = new WETH();
        handler = new Handler(weth);

        deal(address(handler), 100 * 1e18); // transfer 100 Ether

        // Set fuzzer to only call the handler
        // check targetContract || non-targetContract revert count
        targetContract(address(handler));

        // Handler.fail() not called
        bytes4[] memory selectors = new bytes4[](3);
        selectors[0] = Handler.deposit.selector;
        selectors[1] = Handler.withdraw.selector;
        selectors[2] = Handler.sendToFallback.selector;

        targetSelector(
            FuzzSelector({addr: address(handler), selectors: selectors})
        );
    }

    function invariant_eth_balance() public {
        // a >= b
        assertEq(address(weth).balance, handler.wethBalance());
    }
}
