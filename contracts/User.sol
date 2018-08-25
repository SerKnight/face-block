pragma solidity ^ 0.4 .19;
contract User {

  mapping(address => uint) private addressToIndex;
  mapping(bytes16 => uint) private usernameToIndex;
  address[] private addresses;
  bytes16[] private usernames;
  bytes16[] private ipfsHashes;

  event LogUserCreated(address userAddress);

  constructor() public {
    // mappings are virtually initialized to zero values so we need to "waste" the first element of the arrays
    // instead of wasting it we use it to create a user for the contract itself
    addresses.push(msg.sender);
    usernames.push('self');
    ipfsHashes.push('not-available');
  }

  function hasUser(address userAddress) public view returns(bool hasIndeed) {
    return (addressToIndex[userAddress] > 0 || userAddress == addresses[0]);
  }

  function usernameTaken(bytes16 username) public view returns(bool takenIndeed) {
    return (usernameToIndex[username] > 0 || username == 'self');
  }

  function ipfsHashPresent(bytes16 ipfsHash) internal pure returns(bool hashPresent) {
    return (ipfsHash.length > 40);
  }

  function createUser(bytes16 username, bytes16 ipfsHash) public returns(bool success) {
    require(!hasUser(msg.sender));
    require(!usernameTaken(username));
    require(!ipfsHashPresent(ipfsHash));
    addresses.push(msg.sender);
    usernames.push(username);
    ipfsHashes.push(ipfsHash);
    addressToIndex[msg.sender] = addresses.length - 1;
    usernameToIndex[username] = addresses.length - 1;

    emit LogUserCreated(msg.sender);

    return true;
  }

  function getUserCount() public view returns(uint count) {
    return addresses.length;
  }

  function getAddressByIndex(uint index) public view returns(address userAddress) {
    require(index < addresses.length);
    return addresses[index];
  }

  function getUsernameByIndex(uint index) public view returns(bytes16 username) {
    require(index < addresses.length);
    return usernames[index];
  }

  function getIpfsHashByIndex(uint index) public view returns(bytes16 ipfsHash) {
    require(index < addresses.length);
    return ipfsHashes[index];
  }
}
