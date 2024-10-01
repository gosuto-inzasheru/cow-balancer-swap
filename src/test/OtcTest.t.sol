// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity ^0.8.15;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

import {BaseFixture} from "./BaseFixture.sol";
import {OtcEscrowApprovals} from "../OtcEscrowApprovals.sol";

contract OtcTest is BaseFixture {
    function testSwap() public {
        // Balancer Treasury approving spend of balancer amount to OTC Escrow Approvals contract
        vm.prank(BALANCER_TREASURY);
        IERC20(BALANCER_TOKEN_ADDRESS).approve(address(otcEscrowApprovals), BAL_AMOUNT);

        // Cow Treasury approving spend of cow amount to OTC Escrow Approvals contract
        vm.prank(COW_TREASURY);
        IERC20(COW_TOKEN_ADDRESS).approve(address(otcEscrowApprovals), COW_AMOUNT);

        address rando = address(13371337);
        vm.prank(rando);
        otcEscrowApprovals.swap();
    }

    function testSecondSwap() public {
        testSwap();
        vm.expectRevert(OtcEscrowApprovals.SwapAlreadyOccured.selector);
        otcEscrowApprovals.swap();
    }

    function testWithoutApprovals() public {
        vm.expectRevert(bytes("ERC20: transfer amount exceeds allowance"));
        otcEscrowApprovals.swap();
    }

    function testWithoutBalApproval() public {
        // Balancer Treasury approving spend of balancer amount to OTC Escrow Approvals contract
        vm.prank(BALANCER_TREASURY);
        IERC20(BALANCER_TOKEN_ADDRESS).approve(address(otcEscrowApprovals), BAL_AMOUNT);

        vm.expectRevert(bytes("ERC20: transfer amount exceeds allowance"));
        otcEscrowApprovals.swap();
    }
}
