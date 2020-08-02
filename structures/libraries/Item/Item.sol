// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.16 <0.7.0;
pragma experimental ABIEncoderV2;

contract Item {
    address public owner;

    modifier onlyOwner() {
        require(
            msg.sender == owner,
            "Sender not authorized."
        );
        _;
    }

    function transferOwnership(address newOwner) public onlyOwner returns (bool) {
        owner = newOwner;
        return true;
    }

}