# FaceBlock

> A decentralized application that creates profiles stored on the Ethereum blockchain using IPFS to house a user's data.

![](https://media.giphy.com/media/vXGwYDn5HX9Ti/giphy.gif)

### Dependencies
* Metamask
* Ganache
* IPFS

### Metamask
Download: (MetaMask)[https://chrome.google.com/webstore/detail/metamask/nkbihfbeogaeaoehlefnkodbefgpgknn?hl=en]

### Ganache
Ganache is used to local blockchain to interface with our smart contracts
Download: (Ganache)[https://truffleframework.com/ganache]

### IPFS
*Inter Planetary File Storage* IPFS works similarly to the bittorent client in that it uses a content based lookup system instead of an address based on like HTTP. This enables users to request files stored on the network that are the closest to the client, vs at a predefined adress. Theoretically if someone from Mars downloaded a movie from IPFS, the first load would take a day or so, but other Mars network users would then get the file from that local source, rather than having to re-download it from Earth!

This app will save a Face-Block entries data on IPFS and the user's ethereum address will store the address to fetch the correct data for the profiles.

`brew install ipfs`
`ipfs init`
`ipfs config --json API.HTTPHeaders.Access-Control-Allow-Origin "[\"*\"]"`
`ipfs config --json API.HTTPHeaders.Access-Control-Allow-Credentials "[\"true\"]"`
`ipfs daemon` -> starts ipfs on port 8080

## Running the Application

```
npm install -g truffle
npm install
```

----------------------
1. `ipfs daemon`
2. `npm run dev`
2. Boot Ganache desktop app, in the settings *top right* make sure the port is set to `8545`
4. Open up `http://localhost:8081` -> ipfs will default to 8080, so webpack should increment this by 1 port
5. Connect `Metamask` to `Ganache`
	* Open `Metamask` chrome plugin from browser
	* Click settings dropdown, then `Custom RPC`
	* Enter `http://localhost:8545` under Custom RPC & Save

Last things, then we can do stuff!

`truffle compile`

`truffle migrate`

# Creating a FaceBlock profile

> 1. Open up the *Transactions* tab in the `Ganache` GUI, you should see some transactions from the Apps initialization.
> 2. Under `Ganache's` Accounts tab, show one of the pre-seeded account keys on the right, and copy it in clipboard.
> 3. Head over to `http://localhost:8081` and in the `MetaMask` plugin, click the users icon, and at the bottom, *Import Account*
> 4. Reload the page, and your imported account address should be loaded in the Signup *Eth Address* input
> 5. Paste into *private key*
> 6. Enter all details to create a profile & hit **Sign Up**

You now have a running application. There is only one user allowed per private key, to add addition profiles, repeat steps *2..6*


# Testing

Test can be run using:

`truffle test --development`

Test suite is focused around UserProfile creation being limited to one per address & that certain validations and events are emitted during contract usage.

-------------------------------------------

# Common Errors

> If you start/stop ganache occasionally gets our of sync, and you may have to run `truffle migrate --reset`

> If you get failed transactions ex *after importing lots of accounts / restarting Ganache*, the console errors might say Nonce is off. (Documentation of issue)[https://github.com/MetaMask/metamask-extension/issues/1999] To fix You can do the following: 
	* Change network id in ganache ui (settings) and restart
  * `truffle migrate --reset`
	* go to browser and change to another network (ex. Ropsten) and afterwards back to the private network, `http://localhost:8545`
	