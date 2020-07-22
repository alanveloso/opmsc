// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.16 <0.7.0;
pragma experimental ABIEncoderV2;

import { Item } from "../libraries/Item/Item.sol";

abstract contract SellerSmartContract {
    // The list of known seller smart contracts.
    mapping(string => uint) priceCatalog;
    mapping(string => address[]) itemCatalog;
    
    function sellItem (string memory itemName) public payable {
        uint itemValue = priceCatalog[itemName];    
        require(msg.value >= itemValue);
        
        address[] storage itemList = itemCatalog[itemName];
        require(itemList.length != uint(0x0));

        deliverItem(msg.sender, itemList[itemList.length - 1]);

        itemList.pop;
    }

    function deliverItem (address newOwner, address item) private {
        Item(item).transferOwnership(newOwner);
        bytes memory data = abi.encodeWithSignature("receive((address))", item);
        address(newOwner).call(data);
    }
    
}