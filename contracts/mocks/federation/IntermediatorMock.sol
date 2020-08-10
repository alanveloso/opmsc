// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.16 <=0.7.0;

import "../../organizations/federation/Intermediator.sol";

contract IntermediatorMock is Intermediator {
    function check(bytes memory data) public pure override returns (bool) {
        return true;
    }
}