pragma solidity ^0.8.3;
import "https://github.com/OpenZeppelin/openzeppelin-contracts/contracts/cryptography/ECDSA.sol";

contract KeyManagement {
    // Mapping to store the public key associated with each address
    mapping(address => bytes32) public publicKey;

    /**
     * @dev Associates a public key with an address, if the provided signature is valid.
     * @param _publicKey bytes32: the public key to associate with the address
     * @param _signature bytes: the signature of the message 'register' signed with the private key corresponding to the address
     * @return bool: true if the registration was successful, false otherwise
     */
    function register(bytes32 _publicKey, bytes memory _signature) public view returns (bool) {
        address msgSender = msg.sender;
        bytes memory message = "register";
        require(ECDSA.verify(message, _signature, _publicKey), "Invalid signature");
        publicKey[msgSender] = _publicKey;
        return true;
    }

    /**
     * @dev Retrieves the public key associated with the provided address.
     * @param _address address: the address
     * @return bytes32: the public key associated with the provided address
     */
    function getPublicKey(address _address) public view returns (bytes32) {
        return publicKey[_address];
    }

    /**
     * @dev Verify a signature of a message against the public key of an address
     * @param _address address: the address to verify the signature against
     * @param _message bytes: the message to be verified
     * @param _signature bytes: the signature of the message
     * @return bool: true if the signature is valid, false otherwise
     */
    function verify(address _address, bytes memory _message, bytes memory _signature) public view returns (bool) {
        return ECDSA.verify(_message, _signature, publicKey[_address]);
    }
}

