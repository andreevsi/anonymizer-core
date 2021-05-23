include "./lib/merkle-tree.circom";
include "./lib/commitment-hasher.circom";
include "../node_modules/circomlib/circuits/comparators.circom";


/**
 * @param n amount of tokens types
 * @param m number of bits in amount of token
 * @param levels number of levels it the Merkle tree
*/
template DropWallet(n, m, levels) {
    signal input root;
    signal input concealer_old;
    signal input fee;
    signal input recipient;
    signal input relayer;
    signal input ai_withdraw_list[n];

    signal private input ai_list_old[n];
    signal private input old_secret;
    signal private input pathElements[levels];
    signal private input pathIndices[levels];

    var fieldLog = 180;

    component hasher = CommitmentHasher(n);
    hasher.secret <== old_secret;
    hasher.concealer <== concealer_old;
    for (var i = 0; i < n; i++) {
         hasher.ai_list[i] <== ai_list_old[i];
    }

    component tree = MerkleTreeChecker(levels);
    tree.leaf <== hasher.commitment;
    tree.root <== root;
    for (var i = 0; i < levels; i++) {
        tree.pathElements[i] <== pathElements[i];
        tree.pathIndices[i] <== pathIndices[i];
    }

     /* Drop wallet logic*/
    component lte[n];

    lte[0] = LessEqThan(fieldLog);
    lte[0].in[0] <== ai_withdraw_list[0] + fee;
    lte[0].in[1] <== ai_list_old[0];
    lte[0].out === 1;

    for (var i = 1; i < n; i++) {
        lte[i] = LessEqThan(fieldLog);
        lte[i].in[0] <== ai_withdraw_list[i];
        lte[i].in[1] <== ai_list_old[i];
        lte[i].out === 1;
    }

    /* Add hidden signals to make sure that tampering with recipient or fee will invalidate the snark proof
       Most likely it is not required, but it's better to stay on the safe side and it only takes 2 constraints
       Squares are used to prevent optimizer from removing those constraints */
    signal recipientSquare;
    signal relayerSquare;
    relayerSquare <== relayer * relayer;
    recipientSquare <== recipient * recipient;

}

component main = DropWallet(100, 170, 20);
