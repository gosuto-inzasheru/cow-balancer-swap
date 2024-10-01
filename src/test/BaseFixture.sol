// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity ^0.8.15;

// testing libraries
import "@std/Test.sol";

// contract dependencies
import "../OtcEscrowApprovals.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract BaseFixture is Test {
    event Swap(uint256 balAmount, uint256 cowAmount);

    address public constant COW_TOKEN_ADDRESS = 0xDEf1CA1fb7FBcDC777520aa7f396b4E015F497aB;
    address public constant BALANCER_TOKEN_ADDRESS = 0xba100000625a3754423978a60c9317c58a424e3D;

    address public constant COW_TREASURY = 0xcA771eda0c70aA7d053aB1B25004559B918FE662;
    address public constant BALANCER_TREASURY = 0x10A19e7eE7d7F8a52822f6817de8ea18204F2e4f;

    uint256 public constant COW_AMOUNT = 2118898802088361831901126;
    uint256 public constant BAL_AMOUNT = 250_000e18;

    OtcEscrowApprovals public otcEscrowApprovals;

    function setUp() public {
        vm.createSelectFork("ethereum");

        otcEscrowApprovals = new OtcEscrowApprovals();

        vm.label(address(otcEscrowApprovals), "OtcEscrowApprovals");
        vm.label(COW_TOKEN_ADDRESS, "COW_TOKEN_ADDRESS");
        vm.label(BALANCER_TOKEN_ADDRESS, "BALANCER_TOKEN_ADDRESS");
        vm.label(COW_TREASURY, "COW_TREASURY");
        vm.label(BALANCER_TREASURY, "BALANCER_TREASURY");
    }
}
