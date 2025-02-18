// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract StakingRewards {
    mapping(address => uint256) public stakes;
    mapping(address => uint256) public rewards;
    uint256 public rewardRate = 1;  // 1 reward token per staked token per block

    event Staked(address indexed user, uint256 amount);
    event Unstaked(address indexed user, uint256 amount);
    event RewardPaid(address indexed user, uint256 reward);

    function stake(uint256 amount) external {
        stakes[msg.sender] += amount;
        emit Staked(msg.sender, amount);
    }

    function unstake(uint256 amount) external {
        require(stakes[msg.sender] >= amount, "Insufficient stake");
        stakes[msg.sender] -= amount;
        emit Unstaked(msg.sender, amount);
    }

    function claimReward() external {
        uint256 reward = stakes[msg.sender] * rewardRate;
        rewards[msg.sender] += reward;
        emit RewardPaid(msg.sender, reward);
    }

    function balanceOf(address user) external view returns (uint256) {
        return stakes[user];
    }
}