const { expect } = require("chai");
const { poll } = require("ethers/lib/utils");
const { waffle,ethers } = require("hardhat");
const { userInfo } = require("os");
const provider = waffle.provider;
const web3 = require("web3");

const { BigNumber } = require('bignumber.js')

const [owner, accountOne] = provider.getWallets();
describe('Greeter', () =>{



    beforeEach( async () =>{
        Greeter = await ethers.getContractFactory("Greeter");
        greeter = await Greeter.deploy("Hello World");

        Lend = await ethers.getContractFactory("Lend");
        lend = await Lend.deploy();
        console.log(lend.address);

        Borrow = await ethers.getContractFactory("Borrow");
       borrow = await Borrow.deploy();
       console.log(borrow.address);

})


    it('Funds the Lend contract', async () =>{
        const valueString = '10000000000000000000';

// Convert the value to a BigNumber
const value = ethers.BigNumber.from(valueString);

// Convert the BigNumber to its hexadecimal representation
const hexValue = ethers.utils.hexlify(value);

        await lend.setDeadline(1692102820+86400);
        await lend.addNewAffilliate(accountOne.address);
console.log("32")
        await owner.sendTransaction({to:lend.address,value:hexValue});

        const balance = await provider.getBalance(lend.address);
        console.log(balance);
        await expect(balance).equal(hexValue);


        //transfer the ownership to lend

   // Transfer ownership from Lend to Borrow
   await lend.connect(owner).transferOwnership(borrow.address);

   // Verify the ownership transfer
   const newOwner = await lend.owner();
   expect(newOwner).to.equal(borrow.address);
console.log("Ownership transfered");
   
//await withdraw

await borrow.connect(owner).ownerWithdraw(lend.address,hexValue);
console.log("Money withdrawed");
 

    })

   
})