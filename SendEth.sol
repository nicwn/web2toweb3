//SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

// Useful for debugging. Remove when deploying to a live network.
import "hardhat/console.sol";

// Use openzeppelin to inherit battle-tested implementations (ERC20, ERC721, etc)
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * Week 2 day 5
 * A smart contract that allows changing a state variable of the contract and tracking the changes
 * It also allows the owner to withdraw the Ether in the contract
 * @author BuidlGuidl
 */
contract SendEth is Ownable{

    string public hello = "Hello World!";
    uint256 public counter;

    constructor() payable {
        transferOwnership(0x70997970C51812dc3A010C7d01b50e0d17dc79C8); // Account #1
    }

    function deposit() public payable {
        console.log(msg.sender, "deposited", msg.value);
    }
    
    function withdraw() public payable onlyOwner {
        payable(msg.sender).transfer( address(this).balance );
    }

    function withdrawViaCall(address payable _to) public payable onlyOwner {
        // Call returns a boolean value indicating success or failure.
        // This is the current recommended method to use.
        _to = payable(msg.sender);
        (bool sent, ) = _to.call{value: address(this).balance}("");
        require(sent, "Failed to send Ether");
    }

    /**
	 * Function that allows the contract to receive ETH
	 */
	receive() external payable {
        counter++;
        deposit();
    }
}