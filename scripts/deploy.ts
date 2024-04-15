import { ethers } from "hardhat";

async function main() {
  const lock = await ethers.deployContract("Tether");
  await lock.waitForDeployment();
  const usdtContractAddress = lock.target;
  console.log({ usdtContractAddress });
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
