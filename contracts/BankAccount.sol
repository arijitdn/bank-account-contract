// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract BankAccount {
    mapping (address => uint) private _balance;

    function deposit() payable public {
        _balance[msg.sender] += msg.value;
    }

    function withdraw(uint _amount) public {
        require(_balance[msg.sender] >= _amount, "Insufficient funds.");
        (bool sent, bytes memory data) = msg.sender.call{value: _amount}("");
        if(sent) {
            _balance[msg.sender] -= _amount;
        }
    }

    function getBalance() public view returns (uint) {
        return _balance[msg.sender];
    }

    function payUser(address payable _address, uint _amount) public payable {
        require(_balance[msg.sender] >= _amount, "Insufficient funds.");
        _balance[msg.sender] -= _amount;
        _balance[_address] += _amount;
    }

    function transferToWallet(address payable _address, uint _amount) public payable {
        require(_balance[msg.sender] >= _amount, "Insufficient funds.");
        (bool sent, bytes memory data) = _address.call{value: _amount}("");
        if(sent) {
            _balance[msg.sender] -= _amount;
        }
    }
}