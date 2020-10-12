### Financial products management kernel built on the Ether blockchain

# Structure:

CryptoFlowDepositManager.sol - external management contract of financial products<br />
CryptoFlowInvestmentManager.sol - financial product’s contract call<br />
ICFProduct.sol - financial product contract’s interface<br />
CFProductAave.sol - financial product which provide deposit to AAVE<br />
CFBrokerManager.sol - management of broker’s call of remote contracts<br />
ICFBroker.sol - broker’s interface<br />
CFAaveBroker.sol - broker of interaction with AAVE’s contracts<br />
CFCommon.sol - common structures and types<br />
CFEnvironment - constants network-dependent<br />
