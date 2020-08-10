// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.16 <=0.7.0;

import "../../organizations/federation/Federated.sol";

contract FederatedMock is Federated {
    function run(bytes memory info) public pure override returns (bytes memory result) {
        result = info;
    }

}