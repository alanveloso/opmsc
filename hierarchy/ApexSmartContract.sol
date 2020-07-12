// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.16 <0.7.0;
pragma experimental ABIEncoderV2;

import { Messages } from "../libraries/Messages/Messages.sol";

contract ApexSmartContract {

    address[] subordinates;

    function sendCommand(Messages.Message memory task) public {
        for (uint i = 0; i < subordinates.length; i++) {
            Messages.Message memory subtask = splitTask(task, subordinates[i]);
            bytes memory data = abi.encodeWithSignature("reciveCommand((address, address, string))", subtask);
            address(subordinates[i]).call(data);
        }
    }

    function splitTask(Messages.Message memory task, address subordinate) private returns (Messages.Message) {
        ...
    }
}