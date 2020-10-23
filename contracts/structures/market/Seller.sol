// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.16 <0.8.0;

import { Agent } from "../../bade/core/Agent.sol";
import { Item } from "../../libraries/Item/Item.sol";

abstract contract Seller is Agent {
    
    /* Attributes */
    mapping(string => uint) catalogue;
    mapping(string => address[]) stock;

    /* Behaviours */
    function sell(string memory itemName) public payable returns (address){
        uint price = catalogue[itemName];
        require(price > 0, "not-available");
        uint value = msg.value;
        require(value >= price);
        address[] storage stockedItemList = stock[itemName];
        uint amtStockedItemList = stockedItemList.length;
        require(amtStockedItemList != 0);
        address itemSold = stockedItemList[amtStockedItemList - 1];
        stockedItemList.pop;
        return itemSold;
    }
}