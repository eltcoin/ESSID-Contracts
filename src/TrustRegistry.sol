pragma solidity ^0.8.3;

contract TrustRegistry {
    // Mapping to store the trust score of each node
    mapping(bytes32 => uint) public trustScore;
    // Mapping to store the list of endorsers for each node
    mapping(bytes32 => bytes32[]) public endorsers;

    /**
     * @dev Endorses the provided node, increasing its trust score.
     * @param _did bytes32: the DID of the node to be endorsed
     */
    function endorse(bytes32 _did) public {
        // Increase the trust score of the node
        trustScore[_did]++;
        // Add the caller to the list of endorsers for the node
        endorsers[_did].push(msg.sender);
    }

    /**
     * @dev Retrieves an array of DIDs of nodes that have endorsed the provided node.
     * @param _did bytes32: the DID of the node whose endorsers are to be retrieved
     * @return bytes32[]: the array of DIDs of nodes that have endorsed the provided node
     */
    function getEndorsers(bytes32 _did) public view returns (bytes32[] memory) {
        return endorsers[_did];
    }

    /**
     * @dev Retrieves the trust score of the provided node.
     * @param _did bytes32: the DID of the node whose trust score is to be retrieved
     * @return uint: the trust score of the provided node
     */
    function getTrustScore(bytes32 _did) public view returns (uint) {
        return trustScore[_did];
    }

    /**
     * @dev Distributes an airdrop to the provided node.
     * @param _did bytes32: the DID of the node to receive the airdrop
     */
    function collectAirdrop(bytes32 _did) public {
        // Send the airdrop to the node
        msg.sender.transfer(10 ether);
    }
}
