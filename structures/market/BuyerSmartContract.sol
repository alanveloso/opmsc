// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.16 <0.7.0;
pragma experimental ABIEncoderV2;

abstract contract BuyerSmartContract {
    // The list of known seller smart contracts.
    address[] private sellerSmartContracts;
    
    function purchase (string memory itemName, int price) public {
            bytes memory data = abi.encodeWithSignature("reciveOffer((string, int))", itemName, price);
            address(sellerSmartContracts).call{value: 1}(data);                                                                                                                         
        }
    }
}