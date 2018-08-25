pragma solidity ^ 0.4 .19;
contract User {

  mapping(address => uint256) private addressToIndex;
  mapping(bytes16 => uint256) private usernameToIndex;
  address[] private addresses;
  bytes16[] private usernames;
  bytes16[] private ipfsHashes;

  event LogUserCreated(address userAddress);

  constructor() public {
    addresses.push(msg.sender);
    /* 
      push a username of self for the user's address who inits the Contract
      while defaulting that user's ipfsHash to not-available
    */
    usernames.push('self');
    ipfsHashes.push('not-available');
  }

  function hasUser(address userAddress) public view returns(bool hasIndeed) {
    return (addressToIndex[userAddress] > 0 || userAddress == addresses[0]);
  }

  function usernameTaken(bytes16 username) public view returns(bool takenIndeed) {
    return (usernameToIndex[username] > 0 || username == 'self');
  }

  function createUser(bytes16 username, bytes16 ipfsHash) public returns(bool success) {
    require(!hasUser(msg.sender));
    require(!usernameTaken(username));
    addresses.push(msg.sender);
    usernames.push(username);
    ipfsHashes.push(ipfsHash);
    addressToIndex[msg.sender] = addresses.length - 1;
    usernameToIndex[username] = addresses.length - 1;

    emit LogUserCreated(msg.sender);

    return true;
  }

  function getUserCount() public view returns(uint256 count) {
    return addresses.length;
  }

  function getAddressByIndex(uint256 index) public view returns(address userAddress) {
    require(index < addresses.length);
    return addresses[index];
  }

  function getUsernameByIndex(uint256 index) public view returns(bytes16 username) {
    require(index < addresses.length);
    return usernames[index];
  }

  function getIpfsHashByIndex(uint256 index) public view returns(bytes16 ipfsHash) {
    require(index < addresses.length);
    return ipfsHashes[index];
  }
}
