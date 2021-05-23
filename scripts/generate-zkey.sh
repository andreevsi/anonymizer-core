action=$1

echo "[INFO] Start generating zkey for $action"

echo "[INFO] Stage 1. Building r1cs, wasm and sys..."
circom "../circuits/$action.circom" --r1cs --wasm --sym -v

echo "[INFO] Stage 2. Generating zkey.."
snarkjs zkey new "$action.r1cs" pot19_final.ptau "${action}_0000.zkey"

echo "[INFO] Stage 3. Contributing zkey..."
snarkjs zkey contribute "${action}_0000.zkey" "${action}_0001.zkey" --name="1st Contributor Name" -v -e="My rubic stays cubic"

echo "[INFO] Stage 4. "
snarkjs zkey beacon "${action}_0001.zkey" "${action}_final.zkey" 0102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f 10 -n="Final Beacon phase2"

echo "[INFO] Stage 5. Exporting zkey..."
snarkjs zkey export verificationkey "${action}_final.zkey" "${action}_verification_key.json"


mv "${action}_final.zkey" "../circuits-dist/${action}/${action}_final.zkey"
mv "${action}_verification_key.json" "../circuits-dist/${action}/${action}_verification_key.json"
mv "${action}.sym" "../circuits-dist/${action}/${action}.sym"
mv "${action}.wasm" "../circuits-dist/${action}/${action}.wasm"
mv "${action}.r1cs" "../circuits-dist/${action}/${action}.r1cs"
rm "${action}_0000.zkey" "${action}_0001.zkey"
