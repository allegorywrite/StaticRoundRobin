const { privateKey, polygonscanApiKey, alchemyApiKey} = require("./secrets.json");

require("@nomiclabs/hardhat-waffle");
require('@nomiclabs/hardhat-ethers');
require("@nomiclabs/hardhat-etherscan");

module.exports = {
  solidity: {
    version: "0.8.4",
    settings:{
      optimizer:{
        enabled: true,
        runs: 200
      }
    }
  },
  networks: {
    hardhat: {},
    rinkeby: {
      url: "https://eth-rinkeby.alchemyapi.io/v2/" + alchemyApiKey,
      chainId: 4,
      accounts: [ privateKey ]
    },
    matic_mainnet: {
      url: "https://matic-mainnet.chainstacklabs.com",
      chainId: 137,
      accounts: [ privateKey ]
    },
    matic_testnet: {
      url: "https://rpc-mumbai.maticvigil.com",
      chainId: 80001,
      accounts: [ privateKey ]
    },
    // polygonscan: {
    //   apiKey: polygonscanApiKey
    // }
  }
};
