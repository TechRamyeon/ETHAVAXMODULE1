# EMI1 Token Contract  

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)  
[![Solidity](https://img.shields.io/badge/solidity-%5E0.8.0-lightgrey.svg)](https://soliditylang.org/)  

## Overview  
The **EMI1** smart contract is an ERC-20-compliant token called **Emiru (EMI)**. It is designed with additional minting and burning functionalities. The contract is built using the [OpenZeppelin](https://openzeppelin.com/contracts/) library to ensure security and compliance with Ethereum standards.  

---

## Features  
- **ERC-20 Compliant**: Fully implements the ERC-20 standard.  
- **Minting**: The contract owner can mint new tokens with a minimum amount condition.  
- **Burning**: Token holders can burn their tokens to reduce supply.  
- **Custom Transfer Logic**: Prevents transfers with insufficient balance or to the zero address.  

---

## Requirements  
- **Solidity Version**: ^0.8.0  
- **Dependencies**:  
  - [OpenZeppelin ERC20](https://github.com/OpenZeppelin/openzeppelin-contracts/tree/master/contracts/token/ERC20)  
  - [OpenZeppelin Ownable](https://github.com/OpenZeppelin/openzeppelin-contracts/tree/master/contracts/access)  

---

## Contract Details  

### Contract Name: `EMI1`  
- **Token Name**: Emiru  
- **Token Symbol**: EMI  

### Constructor  
The constructor initializes the contract by:  
1. Minting the initial supply to the deployer.  
2. Assigning ownership to the deployer using the `Ownable` module.  

```solidity  
constructor(uint256 initialSupply) ERC20("Emiru", "EMI") Ownable(msg.sender) {  
    _mint(msg.sender, initialSupply);  
}  
```  

---

## Functions  

### Minting  
Allows the owner to mint new tokens with a minimum amount condition.  

```solidity  
function mint(address account, uint256 amount) public onlyOwner {  
    require(amount > 100, "Mint amount must be greater than 190 Emiru Token");  
    assert(account != address(0));  
    _mint(account, amount);  
}  
```  

### Burning  
Enables token holders to burn their tokens to reduce supply.  

```solidity  
function burn(uint256 amount) public {  
    require(amount > 0, "Burn amount must be greater than zero");  
    require(amount <= balanceOf(msg.sender), "Insufficient balance to burn");  
    _burn(msg.sender, amount);  
}  
```  

### Transfer  
Overrides the ERC-20 `transfer` function to add custom logic for safety.  

```solidity  
function transfer(address to, uint256 value) public override returns (bool) {  
    require(to != address(0), "Transfer to the zero address");  
    if (value > balanceOf(msg.sender)) {  
        revert("Insufficient balance");  
    }  
    _transfer(_msgSender(), to, value);  
    return true;  
}  
```  
## License  
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.  

