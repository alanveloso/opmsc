// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.16 <0.7.0;
pragma experimental ABIEncoderV2;

import { Item } from "../libraries/Item/Item.sol";

abstract contract SellerSmartContract {
    // The list of known seller smart contracts.
    mapping(string => uint) priceCatalog;
    mapping(string => address[]) itemCatalog;
    
    function reciveOffer (string memory itemName) public payable {
        uint itemValue = priceCatalog[itemName];        
        require(itemValue != uint(0x0));
        
        address[] storage itemList = itemCatalog[itemName];
        require(itemList.length != uint(0x0));

        Item(itemList[itemList.length - 1]).transferOwnership(msg.sender);

        itemList.pop;
    }
}