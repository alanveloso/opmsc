// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.16 <0.7.0;

abstract contract Intermediator {

    address[] members;

    mapping(address => bytes) pendingReturns;

    // Interface for send data (e.g., task info) to all federation members.
    fallback() external {
        bytes memory data = msg.data;
        bool status = false;
        require(check(data));
        data = bytes(abi.encodePacked(data, msg.sender));
        
        for (uint i = 0; i < members.length; i++) {
            (bool success,) = address(members[i]).call(data);
            // Checks if it ever worked.
            if (success) {
                status = true;
            }
        }

        require(status);
    }

    // Check info about the data.
    function check(bytes memory data) public virtual returns (bool);

    // Withdraw a result from a call.
    function withdraw() public returns (bytes memory) {
        bytes memory result = pendingReturns[msg.sender];
        if (result.length != 0) {
            pendingReturns[msg.sender] = "";
        }
        
        return (result);
    }

    // Function for other smart contracts
    function enroll() public {
        members.push(msg.sender);
    }

    function recive(bytes memory message) public {
        (bytes memory result, address origin) = abi.decode(message, (bytes, address));
        pendingReturns[origin] = result;
    }

}