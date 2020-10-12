### Financial products management kernel built on the Ether blockchain

# Structure:

CryptoFlowDepositManager.sol - external management contract of financial products
CryptoFlowInvestmentManager.sol - financial product’s contract call
ICFProduct.sol - financial product contract’s interface
CFProductAave.sol - financial product which provide deposit to AAVE
CFBrokerManager.sol - management of broker’s call of remote contracts
ICFBroker.sol - broker’s interface
CFAaveBroker.sol - broker of interaction with AAVE’s contracts
CFCommon.sol - common structures and types
CFEnvironment - constants network-dependent
