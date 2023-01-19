pragma solidity ^0.8.3;

contract EBSLite {

    // Evidence Management Contract address
    address private evidenceManagementContract;

    /**
     * @dev Constructor to set the address of the Evidence Management Contract
     * @param _evidenceManagementContract address: address of the Evidence Management Contract
     */
    constructor(address _evidenceManagementContract) public {
        evidenceManagementContract = _evidenceManagementContract;
    }

    /**
     * @dev Function to calculate trust score
     * @param _publicKey bytes32: the public key for which trust score is calculated
     * @return int: trust score for the public key
     */
    function calculateTrustScore(bytes32 _publicKey) public view returns (int) {
        // Base trust score
        int trustScore = 50;
        // Get all evidence for the public key
        mapping(address => EvidenceManagement.Evidence) memory evidence = EvidenceManagement(evidenceManagementContract).getAllEvidence(_publicKey);
        // Iterate through the evidence and update the trust score
        for (address endorser in evidence) {
            trustScore = trustScore + calculateEndorserTrustScore(endorser);
        }
        // Return the trust score
        return trustScore;
    }

    /**
     * @dev Function to calculate trust score for an endorser
     * @param _endorser address: the endorser for which trust score is calculated
     * @return int: trust score for the endorser
     */
    function calculateEndorserTrustScore(address _endorser) private view returns (int) {
        // Get the trust score for the endorser
        int endorserTrustScore = TrustRegistry(trustRegistryContract).getTrustScore(_endorser);
        // If the trust score is not set, set it to a base value
        if (endorserTrustScore == 0) {
            endorserTrustScore = 50;
        }
        // Return the trust score
        return endorserTrustScore;
    }
}

