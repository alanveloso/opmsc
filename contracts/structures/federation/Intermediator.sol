// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.16 <=0.7.0;

import { Agent } from "../../bade/core/Agent.sol";

contract Intermediator is Agent {
    
    address[] federateds;
    mapping(address => bool) allowedFederateds;
    mapping(address => bytes) pendingReturns;

    /// @notice Allow only federateds members.
    modifier onlyFederateds() {
        require(allowedFederateds[msg.sender]);
        _;
    }

    /* Behaviours */
    // Interface for send data (e.g., task info) to all federation federateds.
    fallback() external {
        bytes memory data = msg.data;
        bool status = false;
        data = bytes(abi.encodePacked(data, msg.sender));
        
        for (uint i = 0; i < federateds.length; i++) {
            (bool success,) = address(federateds[i]).call(data);
            // Checks if it ever worked.
            if (success) {
                status = true;
            }
        }

        require(status);
    }

    // Withdraw a result from a call.
    function withdraw() public returns (bytes memory) {
        bytes memory result = pendingReturns[msg.sender];
        if (result.length != 0) {
            pendingReturns[msg.sender] = "";
        }
        return (result);
    }
}