// SPDX-License-Identifier: MIT
pragma solidity >=0.8.20;

import {IERC20TokenTracker} from "./IERC20TokenTracker.sol";

interface ISaldcoinStaking is IERC20TokenTracker {
    struct Reward {
        uint256 rewardId;
        uint256 amount;
        bytes32[] proof;
    }

    error InvalidAddress();
    error InvalidAmount();
    error InvalidProof();
    error InvalidStakingSetup();
    error InsufficientStakedBalance();
    error StakingNotAvailable();
    error Unauthorized();
    error UpgraderRenounced();

    event Staked(address indexed user, uint256 amount, uint256 stakedAt);
    event Unstaked(address indexed user, uint256 amount, uint256 unstakedAt);
    event RewardRedeemed(address user, uint256 rewardId, uint256 amount, uint256 redeemedAt);
    event RewardStaked(uint256 rewardId, uint256 amount, uint256 stakedAt);
    event StakingStatusUpdated(bool isActive);
    event UpgraderUpdated(address _upgrader);

    /**
     * @notice Stake SALD into staking contract
     * @param amount The amount of SALD to stake from user's wallet
     */
    function stake(uint256 amount) external;


    /**
     * @notice Unstake SALD from staking contract
     * @param amount The total amount of SALD to unstake from staked balance and any unredeemed rewards
    */
    function unstake(uint256 amount) external;

    /**
     * @notice Stake rewards with specified address of depositor. Can only be called by the owner.
     * @param depositor The address to stake SALD as rewards
     * @param rewardId The ID of reward
     * @param amount The amount of rewards to stake
     * @param root The Merkle root to verify users' reward
     */
    // function stakeRewards(address depositor, uint256 rewardId, uint256 amount, bytes32 root) external;

    /**
     * @notice Pause/unpause staking. Can only be called by the owner.
     * @param isActive New boolean to indicate active or not
     */
    function setStakingActive(bool isActive) external;

    /**
     * @notice Set the staking start date and set staking as active
     * @param _stakingStartDate The date where staking starts
     */
    function setStakingStartDate(uint64 _stakingStartDate) external;

    /**
     * @notice Get user staked balance plus any unredeemed rewards, given valid proofs of rewards
     * @param user The address of user
     * @param rewards Array of Rewards (rewardId, amount and proof) to verify any undeemed rewards
     */
    // function stakeOf(address user, Reward[] calldata rewards) external view returns (uint256 balance);

    /**
     * @notice Get the timestamp of when the reward was redeemed. Returns 0 if it has not been redeemed.
     * @param user The address of user
     * @param rewardId The ID of reward
     */
    function getRewardRedeemedAt(address user, uint256 rewardId) external view returns (uint256);
}
