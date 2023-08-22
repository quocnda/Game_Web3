// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
const hre = require("hardhat");
const {items}  = require("../contracts/item.json");
const { Contract } = require("hardhat/internal/hardhat-network/stack-traces/model");
require ('dotenv').config();
async function main() {
      const [deployer] = await ethers.getSigners();
      const Dapp = await ethers.getContractFactory("Marketplace");
      const dapp = await Dapp.deploy(10,process.env.NFT_CONTRACT,process.env.COIN_CONTRACT);
      await dapp.deployed();
      // for(let i =0;i<items.length;i++) {
      //   const transaction = await dapp.connect(deployer).list(
      //     items[i].name,
      //     items[i].id,
      //     items[i].image,
      //     items[i].stock
      //   )
      //   await transaction.wait()
      // }

      console.log(dapp.address);
      console.log("HI anh em");
      
     
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
