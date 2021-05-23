include "./lib/commitment-hasher.circom";

/**
 * @param n amount of tokens types
 * @param m number of bits in amount of token
*/
template CreateWallet(n) {
    signal private input secret;
    signal private input concealer;
    signal input ai_list[n];

    signal output commitment;

    component commitmentHasher = CommitmentHasher(n);
    commitmentHasher.secret <== secret;
    commitmentHasher.concealer <== concealer;

     for (var i = 0; i < n; i++) {
            commitmentHasher.ai_list[i] <== ai_list[i];
     }

    commitment <== commitmentHasher.commitment;
}

component main = CreateWallet(100);
