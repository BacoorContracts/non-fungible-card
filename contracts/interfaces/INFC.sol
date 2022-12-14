// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "oz-custom/contracts/oz/token/ERC20/extensions/draft-IERC20Permit.sol";

interface INFC {
    error NFC__Expired();
    error NFC__Unexisted();
    error NFC__Unauthorized();
    error NFC__NonZeroAddress();
    error NFC__LengthMismatch();

    struct RoyaltyInfo {
        uint256 feeData;
        uint256 takerPercents;
        bytes32[] takers;
    }

    event Deposited(
        uint256 indexed tokenId,
        address indexed from,
        uint256 indexed priceFee
    );

    function setTypeFee(
        IERC20Permit feeToken_,
        uint256 type_,
        uint256 price_,
        address[] calldata takers_,
        uint256[] calldata takerPercents_
    ) external;

    function royaltyInfoOf(uint256 type_)
        external
        view
        returns (
            address token,
            uint256 price,
            uint256 length,
            address[] memory takers,
            uint256[] memory takerPercents
        );

    function setRoleAdmin(bytes32 role, bytes32 adminRole) external;

    function mint(address to_, uint256 type_) external returns (uint256 id);

    function typeOf(uint256 tokenId_) external view returns (uint256);
}
