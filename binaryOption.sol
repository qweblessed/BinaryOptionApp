pragma solidity ^0.8.0;

contract binaryOption {
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;


contract binaryOption {

    address public owner;
    mapping(address => uint) public bidPrice;
    mapping(address =>uint) public balances;

    constructor(uint _initalDeposit) payable{
        owner = msg.sender;
        payable(address(this)).transfer(_initalDeposit);
    }

    function getContractBalance()public view returns(uint){
        return address(this).balance;
    }

    function makeBid(uint _bidPrice)public payable
    bidPriceMatchToSendValue(_bidPrice) isEnoughToWithdrawIfWinner(_bidPrice){
        bidPrice[msg.sender] = _bidPrice;
    }

    function winnerPayOff(address payable winnerAddress)public onlyOnwner{
        balances[winnerAddress] = bidPrice[winnerAddress];
        uint valueToTransfer = (balances[winnerAddress] * 18)/10;
        winnerAddress.transfer(valueToTransfer);
        balances[winnerAddress] = 0;
    }

    modifier bidPriceMatchToSendValue(uint _bidPrice){
        require(_bidPrice == msg.value,"scam alert :)");
        _;
    }


    modifier onlyOnwner(){
        require(msg.sender == owner,"u are not an owner");
        _;
    }

    modifier isEnoughToWithdrawIfWinner(uint _bidPrice){
        uint valueToTransfer = (_bidPrice * 18)/10;
        require(valueToTransfer <= address(this).balance,"would not be enough money to withdraw if player wins");
        _;
    }

    receive() external payable{
    }

}
}
