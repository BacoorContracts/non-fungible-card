// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import "../external-upgradeable/utils/cryptography/draft-EIP712Upgradeable.sol";

import "./ISignableUpgradeable.sol";

import "../libraries/AddressLib.sol";

abstract contract SignableUpgradeable is
    EIP712Upgradeable,
    ISignableUpgradeable
{
    using AddressLib for address;
    using ECDSAUpgradeable for bytes32;

    mapping(bytes32 => uint256) internal _nonces;

    function __Signable_init() internal onlyInitializing {}

    function __Signable_init_unchained() internal onlyInitializing {}

    function nonces(address sender_)
        external
        view
        virtual
        override
        returns (uint256)
    {
        return _nonce(sender_);
    }

    function _verify(
        address sender_,
        address verifier_,
        bytes32 structHash_,
        bytes calldata signature_
    ) internal view virtual {
        _checkVerifier(
            sender_,
            verifier_,
            _hashTypedDataV4(structHash_),
            signature_
        );
    }

    function _verify(
        address sender_,
        address verifier_,
        bytes32 structHash_,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) internal view virtual {
        _checkVerifier(
            sender_,
            verifier_,
            _hashTypedDataV4(structHash_),
            v,
            r,
            s
        );
    }

    function _checkVerifier(
        address sender_,
        address verifier_,
        bytes32 digest_,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) internal view virtual {
        if (digest_.recover(v, r, s) != verifier_)
            revert Signable__InvalidSignature(sender_);
    }

    function _checkVerifier(
        address sender_,
        address verifier_,
        bytes32 digest_,
        bytes calldata signature_
    ) internal view virtual {
        if (digest_.recover(signature_) != verifier_)
            revert Signable__InvalidSignature(sender_);
    }

    function _useNonce(address sender_) internal virtual returns (uint256) {
        unchecked {
            return _nonces[sender_.fillLast12Bytes()]++;
        }
    }

    function _nonce(address sender_) internal view virtual returns (uint256) {
        return _nonces[sender_.fillLast12Bytes()];
    }

    function _splitSignature(bytes calldata signature_)
        internal
        pure
        virtual
        returns (
            bytes32 r,
            bytes32 s,
            uint8 v
        )
    {
        assembly {
            r := calldataload(add(signature_.offset, 0x20))
            s := calldataload(add(signature_.offset, 0x40))
            v := byte(0, calldataload(add(signature_.offset, 0x60)))
        }
    }

    function DOMAIN_SEPARATOR()
        external
        view
        virtual
        override
        returns (bytes32)
    {
        return _domainSeparatorV4();
    }

    /**
     * @dev This empty reserved space is put in place to allow future versions to add new
     * variables without shifting down storage in the inheritance chain.
     * See https://docs.openzeppelin.com/contracts/4.x/upgradeable#storage_gaps
     */
    uint256[49] private __gap;
}
