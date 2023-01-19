pragma solidity ^0.8.3;

contract DIDRegistry {
    // Mapping to store the public key associated with each DID
    mapping(bytes32 => bytes32) public keyByDID;
    // Mapping to store the DID associated with each public key
    mapping(bytes32 => bytes32) public DIDByKey;

    /**
     * @dev Creates a new DID and associates it with the provided public key.
     * @param _did bytes32: the new DID to be created
     * @param _publicKey bytes32: the public key to be associated with the new DID
     */
    function createDID(bytes32 _did, bytes32 _publicKey) public {
        // Ensure that the DID does not already exist
        require(keyByDID[_did] == 0);
        // Add the new DID and its associated public key to the mappings
        keyByDID[_did] = _publicKey;
        DIDByKey[_publicKey] = _did;
    }

    /**
     * @dev Updates the public key associated with the provided DID.
     * @param _did bytes32: the DID whose public key is to be updated
     * @param _publicKey bytes32: the new public key to be associated with the DID
     */
    function updateDID(bytes32 _did, bytes32 _publicKey) public {
        // Ensure that the DID already exists
        require(keyByDID[_did] != 0);
        // Update the public key associated with the DID
        keyByDID[_did] = _publicKey;
        DIDByKey[_publicKey] = _did;
    }

    /**
     * @dev Retrieves the public key associated with the provided DID.
     * @param _did bytes32: the DID whose public key is to be retrieved
     * @return bytes32: the public key associated with the provided DID
     */
    function resolveDID(bytes32 _did) public view returns (bytes32) {
        return keyByDID[_did];
    }

    /**
     * @dev Retrieves the DID associated with the provided public key.
     * @param _publicKey bytes32: the public key whose associated DID is to be retrieved
     * @return bytes32: the DID associated with the provided public key
     */
    function getDID(bytes32 _publicKey) public view returns (bytes32) {
        return DIDByKey[_publicKey];
    }
}
