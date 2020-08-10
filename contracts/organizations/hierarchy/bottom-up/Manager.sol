// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.16 <=0.7.0;
pragma experimental ABIEncoderV2;

import {Employee} from "./Employee.sol";

abstract contract Manager is Employee {
    
    address[] subordinates;

    mapping(address => bool) allowedSubordinates;

    modifier onlySubordinates() {
        require(allowedSubordinates[msg.sender]);
        _;
    }


    fallback() external override {
        address origin = msg.sender;
        if (manager == address(0)) {
            send(msg.sender, "");
        }
        bytes memory data = bytes(abi.encodePacked(msg.data, origin));
        send(manager, data);
    }

    // Subordinates call when the manager need to make a Decision.
    function makeDecision(bytes memory info) public virtual onlySubordinates returns (bytes memory decision) {
        // run(info)
    }

    // Perform a task according to specifications.
    function peform(bytes memory info) public virtual onlySubordinates {
        // Only run if subordinates call.
    }

}