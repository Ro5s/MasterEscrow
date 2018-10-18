# MasterEscrow
Deploys a constructor for escrow smart contracts on Ethereum. Extension of https://solidity.readthedocs.io/en/v0.3.2/solidity-by-example.html#safe-remote-purchase. 

# Escrow Description
Seller stakes ETH value of Asset in new escrow smart contract ('asset purchase price').  

Purchaser stakes double ETH value of Asset and locks contract balance (-> seller collateral + purchaser collateral + asset purchase price).

Seller cannot unlock contract balance or abort escrow smart contract.

Purchaser cannot retrieve their collateral without also transferring asset purchase price to Seller (completing transaction).

Seller is trusted to send Asset, but is incentivized to do so in order to retrieve collateral of equal value.

Purchaser is trusted to release contract balance ('pay purchase price'), but is incentivized to do so in order to retrieve collateral of equal value.

Upon confirming receipt of Asset, Purchaser releases balance: retrieving purchaser collateral (+) transferring asset purchase price and  remaining (original) collateral back to Seller.

Example:
If an Item is worth 0.2 ETH, a Seller can stake 0.2 ETH ('advertised price') to secure their offer to transfer it. 
Before lockup, the Seller has a chance to abort and relist their escrow smart contract to change the advertised price; however, during this time, a Purchaser can also accept the Seller's offer and lock the contract for transaction by sending 0.4 ETH, creating a lockup balance of 0.6 ETH that will only be released when Purchaser confirms that Seller actually transferred the Item.   

When the transaction completes, 0.4 ETH is delivered to Seller (including original 0.2 ETH collateral), and 0.2 ETH is returned to Purchaser. In essence, this format allowed Purchaser to use an automated escrow to pay Seller 0.2 ETH with better assurance that the requested Item will be delivered from a stranger, and for the Seller, that Purchaser will not take too long to confirm Item was delivered so that they can retreive their matching collateral. 

# WIP
* OpenLaw template integration: https://openlaw.io/
* [Allow Seller to whitelist Purchaser Ethereum address?]
* [Allow Purchaser to seize seller collateral or portion?]
