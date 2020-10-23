// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.16 <=0.7.0;

import { Agent } from "../../bade/core/Agent.sol";

contract Manager is Agent {
    
    address[] teammate;
    mapping(address => bool) allowedTeammate;

    /// @notice Allow only teammate.
    modifier onlyTeammate() {
        require(allowedTeammate[msg.sender]);
        _;
    }
}