include "./lib/commitment-hasher.circom";
include "./lib/merkle-tree.circom";
include "../node_modules/circomlib/circuits/comparators.circom";


/**
 * @param n amount of tokens types
 * @param m number of bits in amount of token
 * @param levels number of levels it the Merkle tree
*/
template Withdraw(n, m, levels) {
    signal input root;
    signal input concealer_old;
    signal input fee;
    signal input recipient;
    signal input relayer;
    signal input ai_deltas[n];

    signal private input ai_list_old[n];
    signal private input ai_list_new_success[n];
    signal private input ai_list_new_fail[n];
    signal private input old_secret;
    signal private input new_secret_success;
    signal private input new_secret_fail;
    signal private input new_concealer_success;
    signal private input new_concealer_fail;
    signal private input pathElements[levels];
    signal private input pathIndices[levels];

    signal output commitment_success;
    signal output commitment_fail;

    var fieldLog = 180;

    component hasher = CommitmentHasher(n);
    hasher.concealer <== concealer_old;
    hasher.secret <== old_secret;
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


    /*  Generate commitment if operation will be successful */
     component hasher2 = CommitmentHasher(n);
     hasher2.concealer <== new_concealer_success;
     hasher2.secret <== new_secret_success;
     for (var i = 0; i < n; i++) {
         hasher2.ai_list[i] <== ai_list_new_success[i];
     }
     commitment_success <== hasher2.commitment;


    /* Gnerate commitment if operation wont be successful, this is why we use same amount of tokens */
    component hasher3 = CommitmentHasher(n);
    hasher3.concealer <== new_concealer_fail;
    hasher3.secret <== new_secret_fail;
    for (var i = 0; i < n; i++) {
        hasher3.ai_list[i] <== ai_list_old[i];
    }
    commitment_fail <== hasher3.commitment;



    /* Withdraw success logic */
    component lte[n];

    lte[0] = LessEqThan(fieldLog);
    lte[0].in[0] <== ai_deltas[0] + fee;
    lte[0].in[1] <== ai_list_old[0];
    lte[0].out === 1;
    ai_list_new_success[0] === ai_list_old[0] - ai_deltas[0] - fee;

    for (var i = 1; i < n; i++) {
        lte[i] = LessEqThan(fieldLog);
        lte[i].in[0] <== ai_deltas[i];
        lte[i].in[1] <== ai_list_old[i];
        lte[i].out === 1;

        ai_list_new_success[i] === ai_list_old[i] - ai_deltas[i];
    }

    /* Withdraw fail logic */
    component lte_fail;

    lte_fail = LessEqThan(fieldLog);
    lte_fail.in[0] <== 0;
    lte_fail.in[1] <== ai_list_old[0] - fee;
    lte_fail.out === 1;
    ai_list_new_fail[0] === ai_list_old[0] - fee;

    for (var i = 1; i < n; i++) {
        ai_list_new_fail[i] === ai_list_old[i];
    }

    /* Add hidden signals to make sure that tampering with recipient or fee will invalidate the snark proof
       Most likely it is not required, but it's better to stay on the safe side and it only takes 2 constraints
       Squares are used to prevent optimizer from removing those constraints */
    signal recipientSquare;
    signal relayerSquare;
    relayerSquare <== relayer * relayer;
    recipientSquare <== recipient * recipient;
}
component main = Withdraw(100, 170, 20);
