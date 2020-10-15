// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.16 <=0.7.0;

abstract contract Manager {
    
    /* Attributes */
    address owner;
    address[] partners;
    mapping(address => bool) allowedPartners;
    bytes jointMentalState; // Any thing.


    /* Modifiers */
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    modifier onlyPartners() {
        require(allowedPartners[msg.sender]);
        _;
    }

    /* Agent */
    constructor() {
        owner = msg.sender;
    }

    function setup(address[] memory _partners) public onlyOwner {
        if (_partners.length > 0) {
            for (uint i = 0; i < _partners.length; ++i) {
                partners.push(_partners[i]);
                allowedPartners[_partners[i]] = true;
            }
        }
    }

    function send(address to, bytes memory data) public {
        (bool success, ) = to.call(data);
        require(success);
    }

    /* Behaviours */

    function shareJMS() private {
        if (partners.length > 0) {
            for (uint i = 0; i < partners.length; ++i) {
                send(partners[i], jointMentalState);
            }
        }
    }

    function updateJMS() public {
        bytes memory sharedMS = abi.decode(msg.data[4:], (bytes));
        jointMentalState = sharedMS;
    }

}