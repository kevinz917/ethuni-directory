//SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "./Interface/IDirectory.sol";

contract Directory is IDirectory {
    mapping(address => bool) public people; // running list of all students

    function modifyPerson(address _addr, bool _state) public override {
        people[_addr] = _state;
    }

    function isMember(address _addr) public view override returns (bool) {
        return people[_addr];
    }
}
