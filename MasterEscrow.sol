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
	address public seller;
	address public purchaser;
	string public ipfsHash;
	enum State { Created, Locked, Inactive }
	State public state;
    
	constructor(address contractSeller, string contractHash) public payable {
    	seller = contractSeller;
    	ipfsHash = contractHash;
    	value = msg.value;
	}

	modifier condition(bool _condition) {
    	require(_condition);
    	_;
	}

	modifier onlyPurchaser() {
    	require(msg.sender == purchaser);
    	_;
	}

	modifier onlySeller() {
    	require(msg.sender == seller);
    	_;
	}

	modifier inState(State _state) {
    	require(state == _state);
    	_;
	}

	event Aborted();
	event PurchaseConfirmed();
	event AssetReceived();

	/// Abort the purchase and reclaim the ether.
	/// Can only be called by the seller before
	/// the contract is locked.
	function abort()
    	public
    	onlySeller
    	inState(State.Created)
	{
    	emit Aborted();
    	state = State.Inactive;
    	seller.transfer(address(this).balance);
	}

	/// Confirm the purchase as purchaser.
	/// The ether will be locked until confirmReceived
	/// is called.
	function confirmPurchase()
    	public
    	inState(State.Created)
    	condition(msg.value == value)
    	payable
	{
    	emit PurchaseConfirmed();
    	purchaser = msg.sender;
    	state = State.Locked;
	}

	/// Confirm that you (the purchaser) received the Asset.
	/// This will release the locked ether.
	function confirmReceived()
    	public
    	onlyPurchaser
    	inState(State.Locked)
	{
    	emit AssetReceived();
    	// It is important to change the state first because
    	// otherwise, the contracts called using `send` below
    	// can call in again here.
    	state = State.Inactive;

    	// NOTE: This actually allows both the purchaser and the seller to
    	// block the refund - the withdraw pattern should be used.
    	purchaser.transfer(value);
    	seller.transfer(address(this).balance);
	}
}
