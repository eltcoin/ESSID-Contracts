pragma solidity ^0.8.3;
import "./KeyManagement.sol";
import "https://github.com/ethereum/EIPs/blob/main/EIPS/eip-2334.md";

contract IdentityProvider {
    using KeyManagement for KeyManagement.PublicKey;

    // Mapping to store the identity associated with each address
    mapping(address => string) public identity;

    // Reference to the KeyManagement contract
    KeyManagement public keyManagement;

    /**
     * @dev Associates an identity with an address, if the address has a valid public key registered.
     * @param _identity string: the identity to associate with the address
     * @return bool: true if the registration was successful, false otherwise
     */
    function registerIdentity(string memory _identity) public {
        address msgSender = msg.sender;
        bytes32 publicKey = keyManagement.publicKey(msgSender);
        require(publicKey != address(0), "Address has no registered public key");
        require(keyHasNotBeenRevoked(publicKey), "Public key has been revoked");
        identity[msgSender] = _identity;
    }

    /**
     * @dev Retrieves the identity associated with the provided address.
     * @param _address address: the address
     * @return string: the identity associated with the provided address
     */
    function getIdentity(address _address) public view returns (string memory) {
        return identity[_address];
    }

    /**
     * @dev Check if a key has been revoked
     * @param _publicKey bytes32: the public key to check
     * @return bool: true if the key has not been revoked, false otherwise
     */
    function keyHasNotBeenRevoked(bytes32 _publicKey) public view returns (bool) {
        bytes32 keyHash = keccak256(_publicKey);
        bytes32 eventSignature = keccak256(abi.encodePacked("KeyRevoked(bytes32)", keyHash));
        // Check if the KeyRevoked event has been emitted for the keyHash
        for (uint i = 0; i < ethereum.blockNumber; i++) {
            if (keccak256(abi.encodePacked("KeyRevoked(bytes32)", keyHash)) == eventSignature) {
                return false;
            }
        }
        return true;
    }
}
