//SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./Interface/IDirectory.sol";

contract UniToken is ERC20 {
    mapping(address => bool) public canMint;
    IDirectory public directory;
    address public admin;

    constructor(IDirectory _dir, address _admin) ERC20("Uni", "UNI") {
        directory = _dir;
        admin = _admin;
    }

    function modifyCanMint(address _addr, bool _state) public _onlyOnwer {
        require(directory.isMember(_addr), "not a member");
        canMint[_addr] = _state;
    }

    function mint(address _recipient, uint256 _amount) public {
        require(canMint[msg.sender], "minter not approved");
        require(directory.isMember(_recipient), "not a member");
        _mint(_recipient, _amount);
    }

    // for example, event admins call this to reward users
    function batchMint(address[] memory _recipients, uint256[] memory _amounts)
        public
    {
        require(_recipients.length == _amounts.length, "invalid input");
        for (uint256 i = 0; i < _recipients.length; i++) {
            mint(_recipients[i], _amounts[i]);
        }
    }

    modifier _onlyOnwer() {
        require(msg.sender == admin, "not admin");
        _;
    }
}
