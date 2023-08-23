const { expect } = require("chai");
const { poll } = require("ethers/lib/utils");
const { waffle,ethers } = require("hardhat");
const { userInfo } = require("os");
const provider = waffle.provider;
const web3 = require("web3");

const { BigNumber } = require('bignumber.js');
const exp = require("constants");
const { utils } = require("mocha");

const [Lender, Borrower] = provider.getWallets();
describe('Greeter', () =>{



    beforeEach( async () =>{
        Greeter = await ethers.getContractFactory("Greeter");
        greeter = await Greeter.deploy("Hello World");

        // Lend = await ethers.getContractFactory("Lend");
        // lend = await Lend.deploy();
        // console.log("Lend address: ",lend.address);

        //  let minCollateral = web3.utils.toWei("0.002","ether")
        //  let amountToDeposit = web3.utils.toWei("0.0001","ether");
        // Borrow = await ethers.getContractFactory("Borrow");
        // borrow = await Borrow.deploy(lend.address,minCollateral,amountToDeposit);
        // console.log("Borrower Address: ", borrow.address);

    //     Borrow = await ethers.getContractFactory("Borrow");
    //    borrow = await Borrow.deploy();
    //    console.log(borrow.address);


  ERC20  = await ethers.getContractFactory("ERC20");
  erc20 = await ERC20.connect(Borrower).deploy("HAMMADTOKEN","HTK");
  console.log("mytoken address: ",erc20.address)

    LendAndBorrow = await ethers.getContractFactory("LendAndBorrow")
    lendandborrow = await LendAndBorrow.connect(Lender).deploy(erc20.address);
    console.log("lend and borrow address: ",lendandborrow.address)

})



    it("it allows to borrow after depositing collateral: " , async()=>{
        
      

        

        let collateralAmount = "10" ;
        let amountToBorrow = web3.utils.toWei("1","ether");
        //approve and allowance
// erc20 is allowing Borrower to approve lendandborrow address as spender for tokens

//Borrower allows contract to as a spender for tokens deposit
 await erc20.connect(Borrower).approve(lendandborrow.address,collateralAmount)
 //Borrower set allowance for himself as a owner and contract as a spender
 let allowance = await erc20.connect(Borrower).allowance(Borrower.address,lendandborrow.address)
 console.log("allowance",allowance);
         

 // the lender is lending eth to the contract
 await lendandborrow.connect(Lender).lend({value:amountToBorrow}); // LENDING THE MONEY to the contract (lendandborrow)

 //Borrower deposits the collateral and borrowes the eth from contract
 await lendandborrow.connect(Borrower).borrow(amountToBorrow,collateralAmount,{value:amountToBorrow});
  let borrowerbalance = await provider.getBalance(Borrower.address);
                 console.log("Borrower balance : ", borrowerbalance.toString())
        
  
    // the borrower returns the balance back to the contract

await lendandborrow.returnBalance({value:amountToBorrow});

// the collateral is being returned to the borrower 
await erc20.connect(Borrower).approve(lendandborrow.address,collateralAmount)
 //lender is the owner and it is allowing lendandborrow which is spender to spend the
let allowance0 = await erc20.allowance(Borrower.address,lendandborrow.address)
expect(allowance0).to.equal(collateralAmount);
await lendandborrow.connect(Borrower).returnCollateral(collateralAmount);
// await lendandborrow.connect(Borrower).returnCollateral();
    })

   
})