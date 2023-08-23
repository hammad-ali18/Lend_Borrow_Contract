//  pragma solidity >=0.8.0;

// // Hi dear candidate!
// // Please review the following contract to find the 2 vulnerbilities that results in loss of funds.(High/Critical Severity)
// // Please write a short description for each vulnerbillity you found alongside with a PoC in hardhat/foundry.
// // Your PoC submission should be ready to be run without any modification
// // Feel free to add additional notes regarding informational/low severity findings
// import "hardhat/console.sol";
// import "./Lend.sol";

// contract Borrow {
//   Lend public lendContract;

//     uint256 public collateralAmount;
//     uint256 public minimumCollateral;
//     uint256 public amountToBorrow;


//      constructor(address _lendContractAddress, uint256 _minimumCollateral, uint256 _amountToBorrow){
//      lendContract = Lend(_lendContractAddress);
//              minimumCollateral = _minimumCollateral;
//         amountToBorrow = _amountToBorrow;
//      }

// function depositCollateral() external payable{
//     require(msg.value  >= minimunCollateral, "Insuffficient collateral" );
//     collateralAmount = msg.value; //120
// }
// function borrow()external payable{
//     require(collateralAmount >= minimumCollateral, "Unable to borrow");
//     collateralAmount -= minimumCollateral;

//      //borrow eth from the lend
//      lendContract.lend(amountToBorrow);
//  //transfer borrowed eth to the borrower
//      payable(msg.sender).transfer(amountToBorrow);
// }
//  }