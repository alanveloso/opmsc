// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.16 <0.8.0;

contract Item {
    
    string name;
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