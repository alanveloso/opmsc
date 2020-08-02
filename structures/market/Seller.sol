// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.16 <0.7.0;

import { Item } from "../libraries/Item/Item.sol";

abstract contract Seller {
    // The list of known seller smart contracts.
    mapping(bytes => uint) priceCatalog;
    mapping(bytes => address[]) itemCatalog;
    
    function sell(bytes memory item) public payable {
        address buyer = msg.sender;
        uint itemValue = priceCatalog[item];    
        
        require(msg.value >= itemValue);
        
        address[] storage itemList = itemCatalog[item];
        
        require(itemList.length != 0);

        address itemSold = itemList[itemList.length - 1];

        itemList.pop;

        deliver(buyer, itemSold);

    }

    function deliver (address newOwner, address item) private {
        Item(item).transferOwnership(newOwner);
        bytes memory data = abi.encodeWithSignature("receiveItem((address))", item);
        address(newOwner).call(data);
    }
    
}