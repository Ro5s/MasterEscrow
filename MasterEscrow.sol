pragma solidity ^0.4.24;
// deploy an escrow generator
contract MasterEscrow {
	address[] public contracts;
	address public lastContractAddress;
    
	event newEscrowContract(
   	address contractAddress
	);

	constructor()
    	public
	{

	}

	function getContractCount()
    	public
    	constant
    	returns(uint contractCount)
	{
    	return contracts.length;
	}

	// deploy a new escrow contract
	function newEscrow(string contractHash)
    	public
    	payable
    	returns(address newContract)
	{
    	Escrow c = (new Escrow).value(msg.value)(address(msg.sender), contractHash);
    	contracts.push(c);
    	lastContractAddress = address(c);
    	emit newEscrowContract(c);
    	return c;
	}

	//tell me a position and I will tell you its address   
	function seeEscrow(uint pos)
    	public
    	constant
    	returns(address contractAddress)
	{
    	return address(contracts[pos]);
	}
}

contract Escrow {
	uint public value;
	address public promisor;
	address public promisee;
	string public ipfsHash;
	enum State { Created, Locked, Inactive }
	State public state;
    
	constructor(address contractPromisor, string contractHash) public payable {
    	promisor = contractPromisor;
    	ipfsHash = contractHash;
    	value = msg.value;
	}

	modifier condition(bool _condition) {
    	require(_condition);
    	_;
	}

	modifier onlyPromisee() {
    	require(msg.sender == promisee);
    	_;
	}

	modifier onlyPromisor() {
    	require(msg.sender == promisor);
    	_;
	}

	modifier inState(State _state) {
    	require(state == _state);
    	_;
	}

	event Aborted();
	event PromiseConfirmed();
	event BenefitReceived();

	/// Abort the promise and reclaim the ether collateral.
	/// Can only be called by the promisor before
	/// the contract is locked.
	function abort()
    	public
    	onlyPromisor
    	inState(State.Created)
	{
    	emit Aborted();
    	state = State.Inactive;
    	promisor.transfer(address(this).balance);
	}

	/// Confirm the promise as promisee.
	/// The ether will be locked until confirmReceived
	/// is called.
	function confirmPromise()
    	public
    	inState(State.Created)
    	condition(msg.value == (1 * value))
    	payable
	{
    	emit PromiseConfirmed();
    	promisee = msg.sender;
    	state = State.Locked;
	}

	/// Confirm that you (the promisee) received the Benefit.
	/// This will release the locked ether.
	function confirmReceived()
    	public
    	onlyPromisee
    	inState(State.Locked)
	{
    	emit BenefitReceived();
    	// It is important to change the state first because
    	// otherwise, the contracts called using `send` below
    	// can call in again here.
    	state = State.Inactive;

    	// NOTE: This actually allows both the promisee and the promisor to
    	// block the refund - the withdraw pattern should be used.
    	promisee.transfer(value);
    	promisor.transfer(address(this).balance);
	}
}
