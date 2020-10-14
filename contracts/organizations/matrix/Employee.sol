// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.16 <=0.7.0;

abstract contract Employee {
    
    /* Attributes */
    address owner;
    address[] managers;
    mapping(address => bool) allowedManagers;
    mapping(address => bytes) pendingReturns;

    /* Modifiers */
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    modifier onlyManagers() {
        require(allowedManagers[msg.sender]);
        _;
    }

    /* Agent */
    constructor() {
        owner = msg.sender;
    }

    function setup(address[] memory _managers) public onlyOwner {
        if (_managers.length > 0) {
            for (uint i = 0; i < _managers.length; ++i) {
                managers.push(_managers[i]);
                allowedManagers[_managers[i]] = true;
            }
        }
    }

    /* Behaviours */
}