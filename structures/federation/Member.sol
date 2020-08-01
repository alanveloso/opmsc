// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.16 <0.7.0;
pragma experimental ABIEncoderV2;

abstract contract Member {
    address intermediary;

    modifier onlyIntermediary() {
        require(msg.sender == intermediary);
        _;
    }

    function run(bytes memory info) public onlyIntermediary(){
        bytes memory result;

        // Execute

        reply(msg.sender, result);
    }

    function reply(address to, bytes memory info) public {
        bytes memory data = abi.encodeWithSignature("reciveCommand((bytes))", info);
        address(to).call(data);
    }
}