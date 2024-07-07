import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import "@nomicfoundation/hardhat-verify";
import dotenv from 'dotenv'

 dotenv.config()

const config: HardhatUserConfig = {
  solidity: {
    version: "0.8.26",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200
      }
    }
  },
  paths: {
    sources: "./contracts",
    tests: "./test",
    cache: "./cache",
    artifacts: "./frontend/src/artifacts"
  },
  networks:{
    polygon :{
      url: "https://polygon-amoy.infura.io/v3/662278bfebdd4195b4b508888bc7ec56",
      accounts: [process.env.ETH_PRIVATE_KEY||'0x000']
    }
  },
  etherscan:{
    apiKey:process.env.ETHERSCAN_KEY,
  }
};

export default config;
