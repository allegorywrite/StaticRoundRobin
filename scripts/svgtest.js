const destination = process.env.DESTINATION_ADDRESS;

async function main() {
  const fs = require("fs");
  const factory = await ethers.getContractFactory("RoundRobin");
  const contract = await factory.deploy();
  console.log("Deployed to:", contract.address);
  tx = await contract.createPlainRobin();
  await tx.wait();
  tx1 = await contract.signing("tora",0);
  await tx1.wait();
  tx2 = await contract.inherit(destination,0);
  await tx2.wait();
  const svg = await contract.getSVG(); 
  fs.writeFileSync("test.svg", svg);
}
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });