// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.16 <=0.7.0;

import { Agent } from "../../bade/core/Agent.sol";

contract Manager is Agent {

    address[] subordinates;
    mapping(address => bool) allowedSubordinates;

    modifier onlySubordinates() {
        require(allowedSubordinates[msg.sender]);
        _;
    }
}