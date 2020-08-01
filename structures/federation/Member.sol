// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.16 <0.7.0;
pragma experimental ABIEncoderV2;

abstract contract Member {
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

    constructor() internal {
        owner = msg.sender;
    }

    function setup() public onlyOwner() {
        intermediary = abi.decode(msg.data[4:], (address));
        bytes memory data = abi.encodeWithSignature("enroll()");
        (bool success,) = address(intermediary).call(data);
        emit Enroll(intermediary, success);
    }

    function action(bytes memory info) public onlyIntermediary() returns (bytes memory result) {
        result = run(info);
        // replay(msg.sender, result); for async communication.
    }

    function run(bytes memory info) public virtual returns (bytes memory result);

    // Reply method is for async communication.
    function reply(address to, bytes memory result) public {
        bytes memory data = abi.encodeWithSignature("reciveCommand((bytes))", result);
        address(to).call(data);
    }
}