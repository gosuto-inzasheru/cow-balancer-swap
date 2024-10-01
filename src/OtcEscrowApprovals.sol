// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.15;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

/*
    OtcEscrowApprovals.sol is a fork of:
    https://github.com/fei-protocol/fei-protocol-core/blob/339b2f71e9fda31df628d5e17dd3e4482c91d088/contracts/utils/OtcEscrow.sol

    It uses only ERC20 approvals, without transfering any tokens to this contract as part of the swap.
    It assumes both parties have approved it to spend the appropriate amounts ahead of calling swap().

    To revoke the swap, any party can remove the approval granted to this contract and the swap will fail.
*/
contract OtcEscrowApprovals {
    using SafeERC20 for IERC20;

    address public constant BALANCER_TREASURY = 0x10A19e7eE7d7F8a52822f6817de8ea18204F2e4f;
    address public constant COW_TREASURY = 0xcA771eda0c70aA7d053aB1B25004559B918FE662;

    IERC20 public constant BAL = IERC20(0xba100000625a3754423978a60c9317c58a424e3D);
    IERC20 public constant COW = IERC20(0xDEf1CA1fb7FBcDC777520aa7f396b4E015F497aB);

    uint256 public constant BAL_AMOUNT = 250_000e18;
    uint256 public constant COW_AMOUNT = 2118898802088361831901126; /// @dev uint256(250_000e18) * uint256(187776583) / uint256(22154973)

    bool public hasSwapOccured;

    event Swap(uint256 balAmount, uint256 cowAmount);

    error SwapAlreadyOccured();

    /// @dev Atomically trade specified amounts of BAL token and COW token
    /// @dev Anyone may execute the swap if sufficient token approvals are given by both parties
    function swap() external {
        // Check in case of infinite approvals and prevent a second swap
        if (hasSwapOccured) revert SwapAlreadyOccured();
        hasSwapOccured = true;

        // Transfer expected receivedToken from beneficiary
        BAL.safeTransferFrom(BALANCER_TREASURY, COW_TREASURY, BAL_AMOUNT);

        // Transfer sentToken to beneficiary
        COW.safeTransferFrom(COW_TREASURY, BALANCER_TREASURY, COW_AMOUNT);

        emit Swap(BAL_AMOUNT, COW_AMOUNT);
    }
}
