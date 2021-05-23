action=$1

echo "[INFO] Start generating solidity code for $action"

echo "[INFO] Stage 1. Generating solidity code..."
snarkjs zkey export solidityverifier "../circuits-dist/${action}/${action}_final.zkey" "${action}.sol"
