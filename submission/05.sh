# Create a CSV script that would lock funds until one hundred and fifty blocks had passed
#
publicKey=02e3af28965693b9ce1228f9d468149b831d6a0540b25e8a9900f71372c11fb277

blocks=150

blocks_le=$(printf '%04x' $blocks | sed 's/\(..\)\(..\)/\2\1/')

blocks_push_len="02"

pubkey_hash=$(python3 -c "
import hashlib
pk = bytes.fromhex('$publicKey')
sha = hashlib.sha256(pk).digest()
print(hashlib.new('ripemd160', sha).digest().hex())
")


OP_DUP="76"
OP_HASH160="a9"
PUSH_20="14"
OP_EQUALVERIFY="88"
OP_CSV="b2"
OP_DROP="75"
OP_CHECKSIG="ac"

csv_script="${blocks_push_len}${blocks_le}${OP_CSV}${OP_DROP}${OP_DUP}${OP_HASH160}${PUSH_20}${pubkey_hash}${OP_EQUALVERIFY}${OP_CHECKSIG}"

echo "$csv_script"