// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.16 <=0.7.0;
pragma experimental ABIEncoderV2;

abstract contract Buyer {

    address[] goods;
  
    function buy(address seller, bytes memory item, uint price) public {
        bytes memory data = abi.encodeWithSignature("sell((bytes))", item);
        (bool success, ) = address(seller).call{value: price}(data);
        require(success);
    }

    function receiveItem(address item) public {
        goods.push(item);
    }
}