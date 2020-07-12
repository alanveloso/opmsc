// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.16 <0.7.0;
pragma experimental ABIEncoderV2;

import { Messages } from "../libraries/Messages/Messages.sol";

contract SubordinateSmartContract {
    
    address[] subordinates;
    address chief;

    function sendCommand(Messages.Message memory task) public {
        for (uint i = 0; i < subordinates.length; i++) {
            Messages.Message memory subtask = splitTask(task, subordinates[i]);
            bytes memory data = abi.encodeWithSignature("reciveCommand((address, address, string))", subtask);
            address(subordinates[i]).call(data);
        }
    }

    function reciveCommand (Messages.Message memory task) public {
        require(
            msg.sender == chief
            "Only chief can send a task message"
        );
        if (checkFinalizableTask(task)) {
            performTask(task);
        }
        else {
            sendCommand(task);
        }
    }

    function reciveInfo (Messages.Message memory task) public {
        
    }

    function performTask (Messages.Message memory task) private;

    function checkFinalizableTask(Messages.Message memory task) returns (bool);

    function splitTask(Messages.Message memory task, address subordinate) private returns (Messages.Message) {
        ...
    }

}