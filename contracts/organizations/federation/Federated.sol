// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.16 <=0.7.0;

abstract contract Federated {
    address intermediary;
    address owner;

    modifier onlyIntermediary() {
        require(msg.sender == intermediary);
        _;
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    event Enroll(
        address indexed _intermediary,
        bool _success
    );

    constructor() {
        owner = msg.sender;
    }

    function setup(address _intermediary) public onlyOwner() {
        // intermediary = abi.decode(msg.data[4:], (address));
        intermediary = _intermediary;
        bytes memory data = abi.encodeWithSignature("enroll()");
        (bool success,) = address(intermediary).call(data);
        emit Enroll(intermediary, success);
    }

    function action(bytes memory info) public onlyIntermediary() returns (bytes memory result) {
        (, address origin) = abi.decode(msg.data[4:], (bytes, address));
        result = run(info);
        reply(result, origin); // for async communication.
    }

    function run(bytes memory info) public virtual returns (bytes memory result);

    // Reply method is for async communication.
    function reply(bytes memory result, address origin) public {
        bytes memory data = abi.encodeWithSignature("recive((bytes))", result);
        data = bytes(abi.encodePacked(data, origin));
        (bool success, ) = address(intermediary).call(data);
        require(success);
    }
}