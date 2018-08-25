## Some of the design pattern descisions I decide to use: 

* Simplicity. I kept the main User contract scoped to a single profile, that only stored the username & a pointer to the IPFS hash which is actually what stores most of the UserProfile data to display.

* I used cheap getter functions to display back the data on a page load.

I went forward with implementing a *emergency stop* pattern, but it did not fit the needs & risk tolerance for my particular application.