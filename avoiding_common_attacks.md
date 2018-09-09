### To *Avoid Commond Attacks* for a simple application such as face-block I took the following measures.

* Unit tested the scenarios that posed the most risk to the application

* Used require conditions to validate that user input varibles are valid and of the right type

* Defined limits on *uint* that limit the size of the integers

* Defined *bytes16* limit the ensures the max size of the strings


-------- 

### Things I could have implemented if the complexity of the application evolved include:

* Implementing a circuit breaker by stopping when a new error is thrown.

* being very aware of open function & calls to external functions to stop any recursive calls

* Rate limiting / throttling payable functions to a reasonable degree for usage

* Making a. contract with significant importance multi-sig, so that if the onwer key is taken control my bad actor, the power is not completely lost.

* Be careuful looping over arrays of un-predetermined lengths.

* Setup / Run tests for solidity contract gas usage
