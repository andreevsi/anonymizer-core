action=$1

echo "[INFO] Start generating solidity input parameters for $action"

echo "[INFO] Stage 1. Generating witness..."
snarkjs wtns calculate "../circuits-dist/${action}/${action}.wasm" "../circuits-dist/${action}/proof/input.json" witness.wtns

echo "[INFO] Stage 2. Generating proof..."
snarkjs groth16 prove "../circuits-dist/${action}/${action}_final.zkey" witness.wtns "../circuits-dist/${action}/proof/proof.json" "../circuits-dist/${action}/proof/public.json"

mv witness.wtns "../circuits-dist/${action}/proof/witness.wtns"

echo "[INFO] Stage 3. Generating solidity input parameters..."
snarkjs generatecall "../circuits-dist/${action}/proof/public.json" "../circuits-dist/${action}/proof/proof.json"
