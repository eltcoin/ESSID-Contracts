pragma solidity ^0.8.3;
import "https://github.com/ethereum/EIPs/blob/main/EIPS/eip-2335.md";

contract KeyHub {
    using KeyEventReceipt for bytes32;

    // Event to emit when a key is registered
    event KeyRegistered(address indexed owner, bytes32 indexed key);

    // Event to emit when a key is revoked
    event KeyRevoked(address indexed owner, bytes32 indexed key);

    // Event to emit when a key is recovered
    event KeyRecovered(address indexed owner, bytes32 indexed key);

    /**
     * @dev Register a public key for the msg.sender address
     * @param _publicKey bytes32: the public key to register
     */
    function registerKey(bytes32 _publicKey) public {
        address msgSender = msg.sender;
        require(keyHasNotBeenRevoked(_publicKey), "Key has been revoked");
        emit KeyRegistered(msgSender, _publicKey);
    }

    /**
     * @dev Revoke the public key associated with the msg.sender address
     * @param _publicKey bytes32: the public key to revoke
     */
    function revokeKey(bytes32 _publicKey) public {
        address msgSender = msg.sender;
        require(keyHasNotBeenRevoked(_publicKey), "Key has been revoked");
        emit KeyRevoked(msgSender, _publicKey);
    }

    /**
     * @dev Recover the public key associated with the msg.sender address
     * @param _publicKey bytes32: the public key to recover
     */
    function recoverKey(bytes32 _publicKey) public {
        address msgSender = msg.sender;
        require(keyHasBeenRevoked(_publicKey), "Key has not been revoked");
        emit KeyRecovered(msgSender, _publicKey);
    }

    /**
     * @dev Check if a key has been revoked
     * @param _publicKey bytes32: the public key to check
     * @return bool: true if the key has been revoked, false otherwise
     */
    function keyHasBeenRevoked(bytes32 _publicKey) public view returns (bool) {
        return KeyEventReceipt(_publicKey).revoked();
    }

    /**
     * @dev Check if a key has not been revoked
     * @param _publicKey bytes32: the public key to check
     * @return bool: true if the key has not been revoked, false otherwise
     */
    function keyHasNotBeenRevoked(bytes32 _publicKey) public view returns (bool) {
        return !keyHasBeenRevoked(_publicKey);
    }
}
