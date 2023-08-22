require("@nomicfoundation/hardhat-toolbox");
require ('dotenv').config();
/** @type import('hardhat/config').HardhatUserConfig */

module.exports = {
  solidity: "0.8.18",
  networks: {
    klaytn : {
      url:"https://public-en-baobab.klaytn.net",
      accounts: [process.env.PRIV_KEY]
    }
  },
  etherscan : {
    apiKey : process.env.API_KEY
  }
};
