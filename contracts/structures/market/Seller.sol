// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.16 <0.8.0;

import { Item } from "../libraries/Item/Item.sol";

abstract contract Seller {
    
    /* Attributes */
    mapping(bytes => uint) priceCatalog;
    mapping(bytes => address[]) itemCatalog;
    mapping(bytes => bool) stockedItems;
    mapping(address => uint) pendingChange;

    /* Behaviours */   
    function sell(bytes memory item) public payable {
        address buyer = msg.sender;
        require(stockedItems[item]);
        uint itemValue = priceCatalog[item];    
        require(msg.value >= itemValue);
        address[] storage itemList = itemCatalog[item];
        require(itemList.length != 0);
        address itemSold = itemList[itemList.length - 1];
        itemList.pop;
        deliver(buyer, itemSold);
        if (msg.value - itemValue > 0) {
            pendingChange += msg.value - itemValue;
        }
    }

    function deliver(address newOwner, address item) private {
        Item(item).transferOwnership(newOwner);
        bytes memory data = abi.encodeWithSignature("receiveItem((address))", item);
        address(newOwner).call(data);
    }

    function withdraw() public {
        uint share = shares[msg.sender];
        shares[msg.sender] = 0;
        msg.sender.transfer(share);
    }
}