/**
 * SPDX-License-Identifier: MIT
*/

pragma solidity ^0.8.10;

interface IERC20 {
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
}

contract LockerUnit {
    address public owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    constructor () {
        owner = msg.sender;
        emit OwnershipTransferred(address(0), msg.sender);
    }

    modifier onlyOwner() {
        require(owner == msg.sender, "Ownable: only the master contract can be the owner");
        _;
    }

    function withdraw(address token) external onlyOwner {
        require(IERC20(token).balanceOf(address(this)) > 0, 'There is no such tokens');
        IERC20(token).transfer(msg.sender, IERC20(token).balanceOf(address(this)));
        selfdestruct(payable(msg.sender));
    }
}
