// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.16 <=0.7.0;

abstract contract Employee {
    
    address manager;

    mapping(address => bytes) pendingReturns;

    modifier onlyManager() {
        require(manager == msg.sender);
        _;
    }

    // Perform a task according to specifications.
    function run(bytes memory info) public virtual;

    fallback() external virtual {
        require(manager != address(0));
        bytes memory data = bytes(abi.encodePacked(msg.data, msg.sender));
        send(manager, data);
    }

    function send(address to, bytes memory data) public {
        (bool success, ) = to.call(data);
        require(success);
    }

    function receive() onlyManager public {
        (bytes memory result, address origin) = abi.decode(msg.data, (bytes, address));
        pendingReturns[origin] = result;
    }

}