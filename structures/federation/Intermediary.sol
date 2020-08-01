// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.16 <0.7.0;
pragma experimental ABIEncoderV2;

abstract contract Intermediary {

    address[] members;

    mapping(address => bytes) pendingReturns;

    // Send data (e.g., task info) to all federation members.
    fallback() external {
        bytes memory data = msg.data;
        bool status = false;
        checkData(data);
        for (uint i = 0; i < members.length; i++) {
            (bool success, bytes memory result) = address(members[i]).call(data);
            // Checks if it ever worked.
            if (success) {
                status = true;
                pendingReturns[msg.sender] = result;
            }
        }

        require(status);
    }

    // Check info about the data.
    function checkData(bytes memory data) public virtual;

    // Withdraw a result from a call.
    function withdraw() public returns (bytes memory) {
        bytes memory result = pendingReturns[msg.sender];
        if (result.length != 0) {
            pendingReturns[msg.sender] = "";
        }
        
        return(result);
    }

}