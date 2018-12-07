# MasterEscrow
Deploys a constructor for escrow smart contracts on Ethereum. Extension of https://solidity.readthedocs.io/en/v0.3.2/solidity-by-example.html#safe-remote-purchase. 

Special thanks to Jackson Ng for his helpful series on "Escrow Service as a Smart Contract" and Solidity elaborations.

# Instructions
[ . . . ]

# Escrow Description
Seller stakes ETH value of Asset in new escrow smart contract ('asset purchase price').  

Purchaser matches ETH value of Asset and locks contract balance (-> seller collateral + asset purchase price).

Seller cannot unlock contract balance or abort escrow smart contract.

Seller is trusted to send Asset, but is incentivized to do so in order to retrieve collateral of equal value and purchase price.

Upon confirming receipt of Asset, Purchaser releases balance: transferring asset purchase price and remaining (original) collateral back to Seller.

Example:
If an Item is worth 0.2 ETH, a Seller can stake 0.2 ETH ('advertised price') to secure their offer to transfer it. 
Before lockup, the Seller has a chance to abort and relist their escrow smart contract to change the advertised price; however, during this time, a Purchaser can also accept the Seller's offer and lock the contract for transaction by sending 0.2 ETH, creating a lockup balance of 0.4 ETH that will only be released when Purchaser confirms that Seller actually transferred the Item.   

When the transaction completes, 0.4 ETH is delivered to Seller (including original 0.2 ETH collateral). In essence, this format allowed Purchaser to use an automated escrow to pay Seller 0.2 ETH with better assurance that the requested Item will be delivered from a stranger.
