// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

interface IWithdrawable {
    event Withdrawn(
        address indexed token,
        address indexed to,
        uint256 indexed value
    );
    event Received(address indexed sender, uint256 indexed value);

    function withdraw(
        address token_,
        address to_,
        uint256 amount_
    ) external;
}
