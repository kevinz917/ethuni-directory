//SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

interface IDirectory {
    function modifyPerson(address _addr, bool _state) external;

    function isMember(address _addr) external returns (bool);
}
