# anonymizer

## Setup 
1. create .env file following format 

```
ETHERSCAN_API_KEY=<api key>
PRIVATE_KEY=<your test account private key>
INFURA_ID_PROJECT=<id>

DEPLOY_GAS_LIMIT = 7000000
DEPLOY_GAS_PRICE = 150

MERKLE_TREE_HEIGHT=0x00000004
```

2. create `circuits-dist` directory

3. compile circuit to zkey:
- let `CN` be a circuit name without extension e.g. "create-wallet"
- create folder `circuits-dist/<CN>`
- run `bash generate-zkey.sh <CN>`

4. generate sol code:
- run `bash generate-sol-code.sh <CN>`

5. generate proof and sol parameters:
- create `circuits-dist/<CN>/proof` directory
- create `input.json` file into `circuits-dist/<CN>/proof`
- add the input signals to `input.json` file. Use following format for create-wallet circuit
```
{
  "secret": "1097960736851745550612267157572001968046033229221515168044208032394520776",
  "concealer": "46196577931206311728473227015595847553136674693909529482659791242804802620",
  "ai_list": [
    "5", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0",
    "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0",
    "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0",
    "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0",
    "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0",
    "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0",
    "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0",
    "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0",
    "0", "0", "0", "0", "0", "0", "0", "0", "0", "0", "0",
    "0"
  ]
}

```

- run `bash generate-sol-parameters.sh <CN>`



## Test tokens list
0. Native (ETH)
1. WEENUS
2. YEENUS
3. XEENUS
4. RBC

## Kovan contract address
`0xC49C0BAB559d55b5E3aF7B3E96A5c234bA436856`
