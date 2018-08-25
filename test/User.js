const User = artifacts.require('./User.sol')
const assert = require('assert')

contract('User', (accounts) => {
	const owner = accounts[0]
	const account1 = accounts[1]
	const account2 = accounts[2]
	const account3 = accounts[3]
	const username1 = 'Serknight'
	const username2 = 'Topher'
	const username3 = 'Rehpotsirhc'
  const ipfsHash = 'QmQBRN4iaNbwXpDP8ogYcSwhXGkFu1Bbi9sXA8b7tm8gS6';

	it('should create a User successfully', async () => {
    const userProfile = await User.deployed();

		await userProfile.createUser(username1, ipfsHash, {from: account1});
  	const userCount = await userProfile.getUserCount({from: account1});
  	// one user is created by the contract creation
		assert.equal(userCount, 2);
 	})

	it('should only allow one user to be created per address & username', async () => {
    const userProfile = await User.deployed();
    try { 
    	await userProfile.createUser(username1, ipfsHash, {from: account1});
    	assert(false, 'the contract should throw here') 
    } catch (error) { 
    	assert( /invalid opcode|revert/.test(error), 'the error message should be invalid opcode or revert' ) 
    }
 	})

	it('should allow profile creation from a new address & username', async () => {
    const userProfile = await User.deployed();
		await userProfile.createUser(username2, ipfsHash, {from: account2});
  	const userCount = await userProfile.getUserCount({from: account2});
  	// one user is created by the contract creation
		assert.equal(userCount, 3);
 	})

	it('should not allow profile creation from a new address with existing username', async () => {
    const userProfile = await User.deployed();
    try { 
    	await userProfile.createUser(username1, ipfsHash, {from: account3});
    	assert(false, 'the contract should throw here') 
    } catch (error) { 
    	assert( /invalid opcode|revert/.test(error), 'the error message should be invalid opcode or revert' ) 
    }
 	})

	it('should emit a LogUserCreated event on User creation', async () => {
    const userProfile = await User.deployed();
  	
 		await userProfile.createUser(username3, ipfsHash, {from: account3});

  	const expectedEventResult = {userAddress: account3};

  	const LogUserCreated = await userProfile.LogUserCreated();
  	const log = await new Promise(function(resolve, reject) {
	    LogUserCreated.watch(function(error, log){ resolve(log);});
  	});

  	const myAccountAddress = log.args.userAddress;
  	assert.equal(expectedEventResult.userAddress, myAccountAddress);
 	})
})