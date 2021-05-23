/* Generates Hasher artifact at compile-time using Truffle's external compiler mechanism */
const path = require('path');
const fs = require('fs');
const genContract = require('circomlib/src/mimcsponge_gencontract.js');

/* where Truffle will expect to find the results of the external compiler command */
const buildDirPath = path.join(process.cwd(), 'build');
const outputPath = path.join(buildDirPath, 'Hasher.json');

function main () {
    const contract = {
        contractName: 'Hasher',
        abi: genContract.abi,
        bytecode: genContract.createCode('mimcsponge', 220)
    };


    if (!fs.existsSync(buildDirPath)){
        fs.mkdirSync(buildDirPath);
    }

    fs.writeFileSync(outputPath, JSON.stringify(contract));
}

main();
