# MasterEscrow
Escrow Contract Generator - HoldMeHostage™ Agreements

# WIP
Deploys a constructor for escrow smart contracts controlled by counterparty. Chiefly, these smart contracts allow a party to stake any amount of ETH on their promise to do or send a thing -- only releasable by their promisee counterparty ("HoldMeHostage"). 

Among other benefits and use cases, this automated escrow function can help parties better transact online with less need for trust and/or agents at a distance, and is an extension of https://solidity.readthedocs.io/en/v0.3.2/solidity-by-example.html#safe-remote-purchase.  

For example, by calling MasterContract, an online seller can create a personal escrow account to stake their promise to mail an item with a similar value of ETH (or whatever else may be negotiated to effect the transaction), fully returnable by purchaser when the item is actually delivered and the transaction completes. Both parties could also agree to and designate a third-party to observe the transaction and control the collateral (entering relevant calls on behalf of promisee to promisor's escrow smart contract) - - though not a huge leap over traditional escrow services, this simple procedure with radically low overhead (handled entirely online) would allow all parties to  audit the status of their collateral and transaction in real-time on the Ethereum blockchain (an Oracle AI could also fill this agent role quite cheaply, with more ready application in situations where promisor performance is mostly digital in nature).  

As WIP, the current iteration of MasterEscrow still poses certain counterparty and security risks:

*Third-party can freeze ETH collateral to extract payoff before a promisee accepts and takes control of ETH. 
Clearly, this is less than ideal for high-value transactions. There is some degree of safety, however, in the pseudonymous nature of blockchain transactions and the relatively low monetary incentive to freeze a stranger's collateral (cannot seize for yourself, can only freeze or return to sender). Be that as it may, there is room for improvement. 

*Note: This third-party threat is effectively neutralized in uni-lateral contract situations (e.g., Ebay) where promisee acceptance of a standing offer can immediately create privity and right to control. 

*In more negotiated situations, such as an Asset Purchase Agreement, this threat can be also be substantially reduced by making contract execution itself functions to MasterEscrow, putting the promisee in control of collateral upon signing.

In progress:
* OpenLaw Template integration: https://openlaw.io/
* Reduce promisee counterparty risk -- require promisee to match promisor returnable stake?
* Include promisee consideration in escrow contract (transferred to promisor on satisfaction)?
* Allow promisee to either (i) return or (ii) seize ETH collateral after receiving promised benefit (currently, can only *return*).
* Allow promisor to assign collateral to specific Ethereum address on creating new escrow contract (close window on third-party risks).
