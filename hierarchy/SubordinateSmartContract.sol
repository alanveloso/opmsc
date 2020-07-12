// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.16 <0.7.0;
pragma experimental ABIEncoderV2;

import { Messages } from "../libraries/Messages/Messages.sol";

contract SubordinateSmartContract {
    
    address[] subordinates;
    address chief;

    function sendCommand(Messages.Message memory task) public{
        for (uint i = 0; i<subordinates.length; i++) {
            bytes memory data = abi.encodeWithSignature("reciveCommand((address, address, string))", task);
            address(subordinates[i]).call(data);
        }
    }

    function reciveCommand (Messages.Message memory task) public {
        require(
            msg.sender == chief
            "Only chief can send a task message"
        );

        performTask(task);
    }

    function reciveInfo (Messages.Message memory task) public {
        
    }

    function performTask (Messages.Message memory task) private;

}