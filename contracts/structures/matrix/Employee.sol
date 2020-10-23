// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.16 <=0.7.0;

import { Agent } from "../../bade/core/Agent.sol";

contract Employee is Agent {
    
    address[] managers;
    mapping(address => bool) allowedManagers;
    
    modifier onlyManagers() {
        require(allowedManagers[msg.sender]);
        _;
    }
}