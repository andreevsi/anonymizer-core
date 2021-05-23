include "../../node_modules/circomlib/circuits/bitify.circom";
include "../../node_modules/circomlib/circuits/pedersen.circom";
include "../../node_modules/circomlib/circuits/mimcsponge.circom";


/**
 * @param n {field element} amount of tokens types
 * @param m {field element} number of bits in amount of token
*/
template CommitmentHasher(n) {
    signal input secret;
    signal input concealer;
    signal input ai_list[n];

    signal output commitment;


    component secretBits    = Num2Bits(248);
    component concealerBits = Num2Bits(248);
    component hashAiBits    = Num2Bits(2 * 248);

   /* Calculate hash of ai's. We calc mimc on first and second, after that on second and third and so on.
      Keep doing it before we get one hash. It will be ai_copy[n-1] */
    component aiHasher = MiMCSponge(n, 1);
    for (var i = 0; i < n; i++)
    {
        aiHasher.ins[i] <== ai_list[i];
    }
    aiHasher.k <== 0;


    /* Calculate commitment */
    component commitmentHasher = Pedersen(4 * 248);
    concealerBits.in <== concealer;
    secretBits.in <== secret;
    hashAiBits.in <== aiHasher.outs[0];

    for (var i = 0; i < 248; i++) {
        commitmentHasher.in[i] <== concealerBits.out[i];
        commitmentHasher.in[i + 248] <== secretBits.out[i];
    }

    for (var i = 0; i < 2*248; i++) {
        commitmentHasher.in[i + 248*2] <== hashAiBits.out[i];
    }
    commitment <== commitmentHasher.out[0];
}
