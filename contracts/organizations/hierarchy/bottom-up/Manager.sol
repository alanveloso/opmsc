// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.16 <=0.7.0;
pragma experimental ABIEncoderV2;

import {Employee} from "./Employee.sol";

abstract contract Manager is Employee {
    
    /* Attributes */
    address[] subordinates;

    mapping(address => bool) allowedSubordinates;

    /* Modifiers */
    modifier onlySubordinates() {
        require(allowedSubordinates[msg.sender]);
        _;
    }

    /* Agent */
    function setup(address _manager, address[] memory _subordinates) public onlyOwner {
        if (_manager != address(0)) {
            manager = _manager;
        }
        if (_subordinates.lenght > 0) {
            for (uint i = 0; i < _subordinates.lenght; ++i) {
                subordinates.push(_subordinates[i]);
            }
        }
    }

    /* Behaviours */
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

}