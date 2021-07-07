pragma solidity ^0.6.2;

// SPDX-License-Identifier: MIT License

import "./Context.sol";

contract Charitable is Context {
    address private _charityWallet;

    event CharityWalletTransferred(address indexed previousCharityWallet, address indexed newCharityWallet);

    /**
     * @dev Initializes the contract setting the deployer as the initial charity wallet.
     */
    constructor () public {
        address msgSender = _msgSender();
        _charityWallet = msgSender;
        emit CharityWalletTransferred(address(0), msgSender);
    }

    /**
     * @dev Returns the address of the current charity wallet.
     */
    function charityWalletAddress() public view returns (address) {
        return _charityWallet;
    }

    /**
     * @dev Throws if called by any account other than the charity wallet.
     */
    modifier onlyCharityWallet() {
        require(_charityWallet == _msgSender(), "Charitable: caller is not the current charity wallet");
        _;
    }


    /**
     * @dev Transfers charity wallet guardianship of the contract to a new account (`newCharityWallet`).
     * Can only be called by the current charity wallet.
     */
    function transferCharityWalletGuardianship(address newCharityWallet) public virtual onlyCharityWallet {
        require(newCharityWallet != address(0), "Charitable: new charity wallet is the zero address");
        emit CharityWalletTransferred(_charityWallet, newCharityWallet);
        _charityWallet = newCharityWallet;
    }
}