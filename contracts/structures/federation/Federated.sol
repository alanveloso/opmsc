// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.16 <=0.7.0;

import { Agent } from "../../bade/core/Agent.sol";

contract Federated is Agent{

    address intermediary;

    /// @notice Allow only intermediary.
    modifier onlyIntermediary() {
        require(msg.sender == intermediary);
        _;
    }
}