// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

interface IERC4907 {
    error Rentable__NotValidTransfer();
    error Rentable__OnlyOwnerOrApproved();
    struct UserInfo {
        address user; // address of user role
        uint96 expires; // unix timestamp, user expires
    }
    // Logged when the user of a NFT is changed or expires is changed
    /// @notice Emitted when the `user` of an NFT or the `expires` of the `user` is changed
    /// The zero address for user indicates that there is no user address
    event UserUpdated(
        uint256 indexed tokenId,
        address indexed user,
        uint256 expires
    );

    /// @notice Get the user address of an NFT
    /// @dev The zero address indicates that there is no user or the user is expired
    /// @param tokenId The NFT to get the user address for
    /// @return The user address for this NFT
    function userOf(uint256 tokenId) external view returns (address);

    /// @notice Get the user expires of an NFT
    /// @dev The zero value indicates that there is no user
    /// @param tokenId The NFT to get the user expires for
    /// @return The user expires for this NFT
    function userExpires(uint256 tokenId) external view returns (uint256);
}
