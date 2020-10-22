// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.16 <0.8.0;

import { Agent } from "../../bade/core/Agent.sol";

contract Employee is Agent {
    
    address superior;
    mapping(address => bytes) pendingReturns;
    address[] subordinates;
    mapping(address => bool) allowedSubordinates;

    /// @notice Allow just the subordinates, if not there are, allow for anyone.
    modifier onlySubordinates() {
        if (subordinates.length > 0 ) {
            require(allowedSubordinates[msg.sender]);
            _;
        }
    }

    /// @notice Allow just the superior.
    modifier onlySuperior() {
        require(superior == msg.sender);
        _;
    }
}