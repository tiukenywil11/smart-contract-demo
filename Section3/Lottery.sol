pragma solidity ^0.4.26;

contract Lottery {
    address public manager;
	address[] public players;

    // msg is a global variable that includes data from transaction.
    constructor () public payable{
        manager = msg.sender;
    }
	
	function enter() public payable {
        // require is a function that checks for requirements, before executing a function
        // require the sender to send at least 0.1 ether to enter.
        require(msg.value > .01 ether);
		players.push(msg.sender);
	}

    // helper function that creates a random number
    function random() private view returns (uint) {
        // sha3() & keccak256() are the same hash function
        // takes block difficult, current time, and list of players as parameters
        // parse the hash to uint, for the return type
        return uint(keccak256(block.difficulty, now, players));
    }

    function pickWinner() public {
        // Use the random function to create a very large number, then use modulo to limit the number to the number of players
        uint index = random() % players.length;
        // Use transfer(this.balance), parameter stating that all the balance in this contract will be transferred, to the address of player chosen. 
        players[index].transfer(this.balance);
    }

}