pragma solidity ^0.8.0;

contract DIDKERIRegistry {
    mapping(string => bytes32) public didToKERI;
    mapping(bytes32 => string) public keritoDid;
    mapping(string => address) public didToAddress;

    function registerDID(string memory _did, bytes32 _keri) public {
        require(didToKERI[_did] == bytes32(0), "DID already registered");
        didToKERI[_did] = _keri;
        keritoDid[_keri] = _did;
    }

    function associateAddress(string memory _did, address _address) public {
        require(didToKERI[_did] != bytes32(0), "DID not registered");
        didToAddress[_did] = _address;
    }

    function resolveDID(string memory _did) public view returns (address) {
        require(didToKERI[_did] != bytes32(0), "DID not registered");
        return didToAddress[_did];
    }

    function resolveKERI(bytes32 _keri) public view returns (string memory) {
        return keritoDid[_keri];
    }
}
