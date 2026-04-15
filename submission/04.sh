# Create a CLTV script with a timestamp of 1495584032 and public key below:
#
publicKey=02e3af28965693b9ce1228f9d468149b831d6a0540b25e8a9900f71372c11fb277

timestamp=1495584032

timestamp_le=$(printf '%08x' $timestamp | sed 's/\(..\)\(..\)\(..\)\(..\)/\4\3\2\1/')

timestamp_push_len="04"

pubkey_push_len="21"

OP_CLTV="b1"
OP_DROP="75"
OP_CHECKSIG="ac"

cltv_script="${timestamp_push_len}${timestamp_le}${OP_CLTV}${OP_DROP}${pubkey_push_len}${publicKey}${OP_CHECKSIG}"

bitcoin-cli -regtest decodescript "$cltv_script"