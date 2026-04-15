# Create a CSV script that would lock funds until one hundred and fifty blocks had passed
#
publicKey=02e3af28965693b9ce1228f9d468149b831d6a0540b25e8a9900f71372c11fb277

blocks=150

blocks_le=$(printf '%06x' $blocks | sed 's/\(..\)\(..\)\(..\)/\3\2\1/')

blocks_push_len="03"

OP_CSV="b2"
OP_DROP="75"
OP_CHECKSIG="ac"

pubkey_push_len="21"

csv_script="${blocks_push_len}${blocks_le}${OP_CSV}${OP_DROP}${pubkey_push_len}${publicKey}${OP_CHECKSIG}"

echo "$csv_script"