include "./lib/merkle-tree.circom";
include "./lib/commitment-hasher.circom";

/**
 * @param n amount of tokens types
 * @param m number of bits in amount of token
 * @param levels number of levels it the Merkle tree
*/
template Deposit(n, levels) {
    signal input root;
    signal input concealer_old;
    signal input ai_deltas[n];

    signal private input ai_list_old[n];
    signal private input ai_list_new[n];
    signal private input secret_old;
    signal private input secret_new;
    signal private input concealer_new;
    signal private input pathElements[levels];
    signal private input pathIndices[levels];

    signal output commitment_new;


    component hasher = CommitmentHasher(n);
    hasher.concealer <== concealer_old;
    hasher.secret <== secret_old;
    for (var i = 0; i < n; i++) {
        hasher.ai_list[i] <== ai_list_old[i];
    }


    /* Check if commitment in the merkle tree */
    component tree = MerkleTreeChecker(levels);
    tree.leaf <== hasher.commitment;
    tree.root <== root;
    for (var i = 0; i < levels; i++) {
        tree.pathElements[i] <== pathElements[i];
        tree.pathIndices[i] <== pathIndices[i];
    }


   /*  Generate commitment for new wallet state */
    component hasher_new = CommitmentHasher(n);
    hasher_new.concealer <== concealer_new;
    hasher_new.secret <== secret_new;
    for (var i = 0; i < n; i++) {
        hasher_new.ai_list[i] <== ai_list_new[i];
    }
    commitment_new <== hasher_new.commitment;

    /* Deposit logic */
    for (var i = 0; i < n; i++) {
        ai_list_new[i] === ai_deltas[i] + ai_list_old[i];
    }
}
component main = Deposit(100, 20);
