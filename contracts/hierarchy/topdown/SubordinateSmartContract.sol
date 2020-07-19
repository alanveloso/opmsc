// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.16 <0.7.0;
pragma experimental ABIEncoderV2;

import { Messages } from "../libraries/Messages/Messages.sol";

abstract contract SubordinateSmartContract {
    
    address[] subordinates;
    address chief;

    // Send command task to subordinates.
    function sendCommand(Messages.Message memory task) public {
        for (uint i = 0; i < subordinates.length; i++) {
            Messages.Message memory subtask = splitTask(task, subordinates[i]);
            bytes memory data = abi.encodeWithSignature("reciveCommand((address, address, string))", subtask);
            address(subordinates[i]).call(data);
        }
    }

    // Recive commands from chief adress.
    // Can Only be called by the chief contract.
    function reciveCommand (Messages.Message memory task) public {
        require(msg.sender == chief);
        if (checkFinalizableTask(task)) {
            performTask(task);
        }
        else {
            sendCommand(task);
        }
    }

    // Sends info (e.g., about tasks) to the chief address.
    function sendInfo (Messages.Message memory info) private {
        bytes memory data = abi.encodeWithSignature("reciveCommand((address, address, string))", info);
        address(chief).call(data);
    }

    // Recive info from subordinates.
    function reciveInfo (Messages.Message memory info) public virtual;

    // Perform a task according to specifications.
    function performTask (Messages.Message memory task) public virtual;

    // Check if the task can be performed by contract.
    function checkFinalizableTask(Messages.Message memory task) public virtual returns (bool);

    // Split a task in subtasks.
    function splitTask(Messages.Message memory task, address subordinate) public virtual returns (Messages.Message memory);

}