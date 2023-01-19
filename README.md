# ESSID-Contracts


# Architecture

*Overview coming soon. *

# User Stories
## User creates a new DID and public key

- User opens the dApp and clicks on the "Create DID" button.
- User enters a unique DID identifier and a public key.
- User submits the form.
- The dApp sends a transaction to the DID Registry Contract to create a new DID and associate it with the provided public- key.
- The DID Registry Contract creates a new DID and associates it with the provided public key.

## User revokes a key



- User opens the dApp and clicks on the "Revoke Key" button.
- User enters the public key they wish to revoke.
- User submits the form.
- The dApp sends a transaction to the Key Management Contract to revoke the key associated with the provided public key.
- The Key Management Contract revokes the key associated with the provided public key.

User signs and verifies a key

- User A opens the dApp and clicks on the "Sign Key" button.
- User A enters the public key of User B they wish to sign and a signature.
- User A submits the form.
- The dApp sends a transaction to the Key Signing Contract to sign the key associated with the provided public key.
- The Key Signing Contract signs the key and associates the signature with the key.
- User B opens the dApp and clicks on the "Verify Key" button.
- User B enters the public key of User A and the signature they received.
- User B submits the form.
- The dApp sends a request to the Key Signing Contract to verify the provided signature for the provided public key.
- The Key Signing Contract verifies the signature and returns the result.

User endorses a node

- User A opens the dApp and clicks on the "Endorse Node" button.
- User A enters the address of the node they wish to endorse and their own address.
- User A submits the form.
- The dApp sends a transaction to the Trust Registry Contract to endorse the provided node by the provided endorser.
- The Trust Registry Contract adds the endorsement to the provided node and updates the trust score.

User generates key-signing proof via QR code

- User A opens the dApp and clicks on the "Generate Key-signing proof" button.
- User A scans the QR code of User B's public key.
- User A signs User B's public key and attaches the signature to the QR code.
- User B scans the QR code and retrieves the public key and signature.
- User B verifies the signature using the Key Signing Contract, which confirms that the key has been signed by User A.