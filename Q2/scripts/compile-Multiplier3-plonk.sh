#!/bin/bash

# [assignment] create your own bash script to compile Multipler3.circom using PLONK below


cd contracts/circuits

mkdir _plonk_Multiplier3

if [ -f ./powersOfTau28_hez_final_10.ptau ]; then
    echo "powersOfTau28_hez_final_10.ptau already exists. Skipping."
else
    echo 'Downloading powersOfTau28_hez_final_10.ptau'
    wget https://hermez.s3-eu-west-1.amazonaws.com/powersOfTau28_hez_final_10.ptau
fi

echo "Compiling Multiplier3.circom..."


circom Multiplier3.circom --r1cs --wasm --sym -o _plonk_Multiplier3
snarkjs r1cs info _plonk_Multiplier3/Multiplier3.r1cs


snarkjs plonk setup _plonk_Multiplier3/Multiplier3.r1cs powersOfTau28_hez_final_10.ptau _plonk_Multiplier3/circuit_final.zkey
snarkjs zkey export verificationkey _plonk_Multiplier3/circuit_final.zkey _plonk_Multiplier3/verification_key.json

snarkjs zkey export solidityverifier _plonk_Multiplier3/circuit_final.zkey ../Multiplier3Verifier.sol

cd ../..