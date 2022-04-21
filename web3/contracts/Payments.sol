// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

contract Payments {
  event Payment (
    address _from,
    address _to,
    uint    amount
  );

  mapping(address => uint) public receivedPayments;

  address payable public owner;
  address payable public myAccount = payable(0x1EAEaAEfFf5526B796EB3eB116cAbCd2805f7ea2);

  constructor() {
    owner = payable(msg.sender);
  }

  function destroySmartContract() public {
    require(msg.sender == owner, "You are not the owner");
    selfdestruct(owner);
  }

  function receiveMoney() public payable {
    assert(receivedPayments[msg.sender] + msg.value >= receivedPayments[msg.sender]);
    receivedPayments[msg.sender] += msg.value;
  }

  function withdrawMoney(uint _amount) public {
    require(_amount <= receivedPayments[msg.sender], "not enough funds.");
    assert(receivedPayments[msg.sender] >= receivedPayments[msg.sender] - _amount);
    receivedPayments[msg.sender] -= _amount;
    myAccount.transfer(_amount);
  } 

  receive() external payable {
    receiveMoney();
  }
}
