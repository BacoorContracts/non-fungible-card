// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "oz-custom/contracts/oz/utils/Context.sol";
import "./Transferable.sol";

import "./IWithdrawable.sol";

error Withdrawable__Expired();

abstract contract Withdrawable is Context, Transferable, IWithdrawable {
    receive() external payable virtual {
        emit Received(_msgSender(), msg.value);
    }

    function withdraw(
        address token_,
        address to_,
        uint256 amount_
    ) external virtual override;
}
