// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "hardhat/console.sol";

// import "@openzeppelin/contracts/token/ERC20/ERC20.sol"

import "./IERC20.sol";
contract LendAndBorrow{
    mapping(address => uint256) public balances;
    mapping(address => uint256) public collateral;
IERC20 public erc20token; 
    constructor(address _addressOfToken)
   {
    erc20token  = IERC20(_addressOfToken);
    }

//    function balanceOf(address account) public view virtual override returns (uint256) {
//         return _balances[account];
//     }



    function depositCollateral(uint256 amount) internal {
        require(amount > 0, "Collateral must be greater than 0");
        erc20token.transferFrom(msg.sender, address(this), amount);
        collateral[msg.sender] += amount;
        console.log("deposit collateral: ",collateral[msg.sender]);
    }

    function borrow(uint256 amountToBorrow,uint256 collateral) external payable {
        depositCollateral(collateral);
        require(msg.value >= amountToBorrow, "Insufficient collateral");

        
        // collateral[msg.sender] -= amountToBorrow;

        // Transfer borrowed amount to borrower
        payable(msg.sender).transfer(amountToBorrow);

    }

    function lend() external payable {
        // require(msg.value > 0, "Insufficient amount to Lend");
        // balances[msg.sender] += msg.value;
        // payable(msg.sender).transfer(balances[msg.sender]);
        // console.log("lended amount: ",balances[msg.sender]);

        require(msg.value > 0,"Unable to lend");
        balances[msg.sender] += msg.value;
        payable(msg.sender).transfer(balances[msg.sender]);
        // console.log(msg.sender);

    }

//  function acceptLendedAmount() external payable {
//     console.log(balances[msg.sender]);
//     uint256 amountToAccept = balances[msg.sender];
//     require(amountToAccept > 0, "No lended amount to accept");

//     balances[msg.sender] = 0;
//     payable(msg.sender).transfer(amountToAccept);

//     console.log("Accepted lended amount: ", amountToAccept);
// }

    function returnBalance() external payable{
      console.log("balances[msg.sender]: ",balances[msg.sender]);
      require(msg.value> 0, "No balance to return");

    uint256 amountToReturn =balances[msg.sender];

balances[msg.sender] =0;

    // Transfer balance back to the lender
   
   payable(msg.sender).transfer(amountToReturn);
    console.log("Returned balance: ", amountToReturn);
    console.log("balance after returing to lender: ", balances[msg.sender]);
    }



    function returnCollateral(uint256 amount) external  {

        //  erc20token.transferFrom(msg.sender, address(this), amount);
        // collateral[msg.sender] += amount;
        // console.log("deposit collateral: ",collateral[msg.sender]);


    console.log("new collateral: ",collateral[msg.sender]);
//      require(collateral[msg.sender]> 0,"Nothing to return collateral");
   
//    erc20token.transferFrom(address(this), msg.sender, amount);
// uint256 collateralreturn =collateral[msg.sender];
//     //  console.log(collateralreturn);
// //makecollateral zero
// collateral[msg.sender] -= amount;
// //transfer this on borrower's address
// payable(msg.sender).transfer(collateralreturn);

require(collateral[msg.sender] >=  amount,"Insufficient amount");
erc20token.transfer(msg.sender, amount);
collateral[msg.sender] -= amount;
console.log("Finally Transferred");
    }
}
