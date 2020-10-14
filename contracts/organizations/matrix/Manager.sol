// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.16 <=0.7.0;

abstract contract Manager {
    
    /* Attributes */
    address owner;
    address[] subordinates;
    mapping(address => bool) allowedSubordinates;

    /* Modifiers */
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    modifier onlySubordinates() {
        require(allowedSubordinates[msg.sender]);
        _;
    }

    /* Agent */
    constructor() {
        owner = msg.sender;
    }

    function setup(address[] memory _subordinates) public onlyOwner {
        if (_subordinates.length > 0) {
            for (uint i = 0; i < _subordinates.length; ++i) {
                subordinates.push(_subordinates[i]);
                allowedSubordinates[_subordinates[i]] = true;
            }
        }
    }

    function send(address to, bytes memory data) public {
        (bool success, ) = to.call(data);
        require(success);
    }

    /* Behaviours */

}