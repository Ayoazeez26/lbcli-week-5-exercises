# Create a CLTV script with a timestamp of 1495584032 and public key below:
#
publicKey=02e3af28965693b9ce1228f9d468149b831d6a0540b25e8a9900f71372c11fb277

timestamp=1495584032

timestamp_le=$(printf '%08x' $timestamp | sed 's/\(..\)\(..\)\(..\)\(..\)/\4\3\2\1/')

pubkey_hash=$(echo "$publicKey" | xxd -r -p | openssl dgst -sha256 -binary | openssl dgst -ripemd160 -binary | xxd -p -c 20)

PUSH_4="04"
OP_CLTV="b1"
OP_DROP="75"
OP_DUP="76"
OP_HASH160="a9"
PUSH_20="14"
OP_EQUALVERIFY="88"
OP_CHECKSIG="ac"

cltv_script="${PUSH_4}${timestamp_le}${OP_CLTV}${OP_DROP}${OP_DUP}${OP_HASH160}${PUSH_20}${pubkey_hash}${OP_EQUALVERIFY}${OP_CHECKSIG}"

bitcoin-cli -regtest decodescript "$cltv_script"