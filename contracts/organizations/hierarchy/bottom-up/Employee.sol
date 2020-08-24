// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.16 <=0.7.0;

abstract contract Employee {
    
    /* Attributes */
    address owner;

    address manager;

    mapping(address => bytes) pendingReturns;

    /* Modifiers */
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    modifier onlyManager() {
        require(manager == msg.sender);
        _;
    }

    /* Agent */
    constructor() {
        owner = msg.sender;
    }

    function setup(address _manager) public onlyOwner {
        manager = _manager;
    }

    function send(address to, bytes memory data) public {
        (bool success, ) = to.call(data);
        require(success);
    }

    // pick up messages from its message queue
    // function receive() onlyManager public {
    //     // Process the message
    //     (bytes memory result, address origin) = abi.decode(msg.data, (bytes, address));
    //     pendingReturns[origin] = result;
    // }

    /* Behaviours */
    // fallback() external virtual {
    //     require(manager != address(0));
    //     bytes memory data = bytes(abi.encodePacked(msg.data, msg.sender));
    //     send(manager, data);
    // }

    // e.g. for mock
    // function purchase(string title, uint maxPrice, Date deadline) public pure returns (uint) {
    //     uint initTime = System.currentTimeMillis();
    //     deltaT = deadline - initTime;

    //     long currentTime = System.currentTimeMillis(); 
    //     if (currentTime > deadline) { 
    //         // Deadline expired 
    //         myGui.notifyUser("Cannot buy book "+title); 
    //         // stop();
    //     }
    //     else { 
    //         // Compute the currently acceptable price and start a negotiation
    //         long elapsedTime = currentTime - initTime; 
    //         int acceptablePrice = maxPrice * (elapsedTime / deltaT); 
    //         // myAgent.addBehaviour(new BookNegotiator(title, acceptablePrice, this));

    //     }
    // }
}