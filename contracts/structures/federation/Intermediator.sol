// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.16 <=0.7.0;

abstract contract Intermediator {
    
    /* Attributes */
    address[] federateds;
    mapping(address => bool) allowedFederateds;
    mapping(address => bytes) pendingReturns;

    /* Modifiers */
    modifier onlyIntermediary() {
        require(allowedFederateds[msg.sender]);
        _;
    }

    /* Agent */
    function send(address to, bytes memory data) public returns (bool) {
        (bool success, ) = to.call(data);
        return success;
    }

    function receive(bytes memory message) public {
        (bytes memory result, address origin) = abi.decode(message, (bytes, address));
        pendingReturns[origin] = result;
    }

    /* Behaviours */
    // Interface for send data (e.g., task info) to all federation federateds.
    fallback() external {
        bytes memory data = msg.data;
        bool status = false;
        data = bytes(abi.encodePacked(data, msg.sender));
        
        for (uint i = 0; i < federateds.length; i++) {
            (bool success,) = address(federateds[i]).call(data);
            // Checks if it ever worked.
            if (success) {
                status = true;
            }
        }

        require(status);
    }

    // Function for other smart contracts
    function enroll() public {
        if (allowedFederateds[msg.sender])
        federateds.push(msg.sender);
    }

    // Withdraw a result from a call.
    function withdraw() public returns (bytes memory) {
        bytes memory result = pendingReturns[msg.sender];
        if (result.length != 0) {
            pendingReturns[msg.sender] = "";
        }
        
        return (result);
    }
}