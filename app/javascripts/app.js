import jQuery from 'jquery';
window.$ = window.jQuery = jQuery;
import 'bootstrap';
import '../stylesheets/app.scss';
import { default as Web3 } from 'web3';
import { default as contract } from 'truffle-contract'

var accounts;
var account;

window.App = {
  start: function() {
    var self = this;
    
    web3.eth.getAccounts(function(err, accs) {
      if (err != null) {
        alert("There was an error fetching your accounts.");
        return;
      }
      
      if (accs.length == 0) {
        alert("Couldn't get any accounts! Make sure your Ethereum client is configured correctly.");
        return;
      }
      
      accounts = accs;
      account = accounts[0];

    });
  },
};

window.addEventListener('load', function() {

  // Checking if Web3 has been injected by the browser (Mist/MetaMask)
  if (typeof web3 !== 'undefined') {
    console.warn("Using web3 detected from external source.");
    // Use Mist/MetaMask's provider

    window.web3 = new Web3(web3.currentProvider);

  } else {

    console.warn("No web3 detected. Please use MetaMask or Mist browser.");
  }

App.start();
  
});