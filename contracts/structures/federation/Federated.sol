// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.16 <=0.7.0;

abstract contract Federated {
    
    /* Attributes */
    address intermediary;
    address owner;

    /* Modifiers */
    modifier onlyIntermediary() {
        require(msg.sender == intermediary);
        _;
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    /* Agent */
    constructor() {
        owner = msg.sender;
    }

    function setup(address _intermediary) public onlyOwner() {
        intermediary = _intermediary;
        bytes memory data = abi.encodeWithSignature("enroll()");
        (bool success,) = address(intermediary).call(data);
        require(success);
    }

    function send(address to, bytes memory data) public {
        (bool success, ) = to.call(data);
        require(success);
    }

    /* Behaviours */
    // Behaviours are called only from intermediary.

}