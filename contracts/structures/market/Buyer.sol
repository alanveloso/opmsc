// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.16 <0.8.0;

import { Agent } from "../../bade/core/Agent.sol";

contract Buyer is Agent {

    address[] goods;

    function buy(address seller, string memory itemName, uint price) public {
        bytes memory message = abi.encodeWithSignature("sell((string))", itemName);
        bytes memory reply = send(seller, message, price);
        address item = abi.decode(reply, (address));
        goods.push(item);
    }
}