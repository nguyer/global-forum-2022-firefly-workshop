import { ethers } from "hardhat";

async function main() {
  const WorkshopContract = await ethers.getContractFactory("FireFlyWorkshopBadge");
  const contract = await WorkshopContract.deploy();

  await contract.deployed();

  console.log(`Workshop contract deployed to ${contract.address}`);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
