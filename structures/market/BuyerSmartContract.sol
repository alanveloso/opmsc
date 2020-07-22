// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.16 <0.7.0;
pragma experimental ABIEncoderV2;

abstract contract BuyerSmartContract {

    address[] goods;
  
    function buyItem (address sellerSmartContract, string memory itemName, uint price) public {
        bytes memory data = abi.encodeWithSignature("sellItem((string))", itemName);
        address(sellerSmartContract).call{value: price}(data);
    }

    function receiveItem (address newItem) public {
        goods.push(newItem);
    }
}