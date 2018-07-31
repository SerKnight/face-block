pragma solidity 0.4.21;


contract Family {

  address public owner;

  function Family() public {
    owner = msg.sender;
  }


  function kill() public {
    if(mesg.sender == owner) selfdestruct(owner);
  }

}