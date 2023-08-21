pragma solidity >=0.8.0;

// Hi dear candidate!
// Please review the following contract to find the 2 vulnerbilities that results in loss of funds.(High/Critical Severity)
// Please write a short description for each vulnerbillity you found alongside with a PoC in hardhat/foundry.
// Your PoC submission should be ready to be run without any modification
// Feel free to add additional notes regarding informational/low severity findings
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "hardhat/console.sol";

contract Lend is ReentrancyGuard, Ownable {


    constructor() Ownable(){
     
    }

mapping (address => uint256) public collateralBalance;
event CollateralDeposited(address collateral,uint256 amount);
event CollateralWithDrawned( address collateral, uint256 amount);

event RegistrationDeadline(uint256 registrationDeadline);
event Withdraw(uint256 amount);


uint256 private registrationDeadline;
address[] public affiliates_;
mapping(address => bool) public affiliates;
uint256 public affiliatesCount;


modifier onlyAfilliates() {

    bool affiliate;

    for (uint256 i = 0; i < affiliatesCount; i++) {
    if (affiliates_[i] == msg.sender) {
    affiliate = true;
    }
    }
    require(affiliate == true, "Not an Affiliate!");
    _;
}
    function setDeadline(uint256 _regDeadline) external onlyOwner {
    registrationDeadline = _regDeadline;
    emit RegistrationDeadline(registrationDeadline);
    }


// function buyOwnerRole(address newAdmin) external payable onlyAfilliates {
// require(msg.value == 10 ether, "Invalid Ether amount");
// _transferOwnership(newAdmin);
// }

function depositCollateral(uint256 amount) external onlyOwner{
    require(amount > 0,"Insufficient Collateral amount to deposit");

    //update collateral amount

    collateralBalance[msg.sender] += amount;

    //emit the event that collteral has been added

    emit CollateralDeposited(msg.sender,amount);

}
function withDrawCollateral(uint256 amount) external onlyOwner{
        require(collateralBalance[msg.sender] >= amount, "Insufficient collateral amount to withdraw");

        //update collateral's balance

        collateralBalance[msg.sender] -= amount;

//transfer eth collateral back to the user
payable(msg.sender).transfer(amount);

//emit the event
emit CollateralWithDrawned(msg.sender, amount);

}


function ownerWithdraw(address to, uint256 amount) external onlyOwner {
    payable(to).call{value: amount}("");
    emit Withdraw(amount);
}

function addNewAffilliate(address newAfilliate) external onlyOwner {
    affiliatesCount += 1;
    affiliates[newAfilliate] = true;
    affiliates_.push(newAfilliate);
}

receive() external payable {}
}





//  contract Borrow is ReentrancyGuard,Ownable{
  
//      constructor()Ownable(){
     
       
//      }

// event RegistrationDeadline(uint256 registrationDeadline);
// event Withdraw(uint256 amount);

// uint256 private registrationDeadline;
// address[] public affiliates_;
// mapping(address => bool) public affiliates;
// uint256 public affiliatesCount;


// modifier onlyAfilliates() {

//     bool affiliate;

//     for (uint256 i = 0; i < affiliatesCount; i++) {
//     if (affiliates_[i] == msg.sender) {
//     affiliate = true;
//     }
//     }
//     require(affiliate == true, "Not an Affiliate!");
//     _;
// }
//     function setDeadline(uint256 _regDeadline) external onlyOwner {
//     registrationDeadline = _regDeadline;
//     emit RegistrationDeadline(registrationDeadline);
//     }


// // function buyOwnerRole(address newAdmin) external payable onlyAfilliates {
// // require(msg.value == 10 ether, "Invalid Ether amount");
// // _transferOwnership(newAdmin);
// // }
// function ownerWithdraw(address to, uint256 amount) external onlyOwner {
//     payable(to).call{value: amount}("");
//     emit Withdraw(amount);
// }



// receive() external payable {}
//  }