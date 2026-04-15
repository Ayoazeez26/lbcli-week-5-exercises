# Construct a 2-of-3 multisig redeem script (serialized hex) using the following public keys:
#
publicKey1=02da2f10746e9778dd57bd0276a4f84101c4e0a711f9cfd9f09cde55acbdd2d191
#
publicKey2=02bfde48be4aa8f4bf76c570e98a8d287f9be5638412ab38dede8e78df82f33fa3
#
publicKey3=02e3af28965693b9ce1228f9d468149b831d6a0540b25e8a9900f71372c11fb277
# The script should follow this pattern: OP_2 <pubkey1> <pubkey2> <pubkey3> OP_3 OP_CHECKMULTISIG

OP_2="52"     # required signatures
OP_3="53"     # total keys
OP_CHECKMULTISIG="ae"
PUSH_PUBKEY="21"  # 33 bytes per compressed pubkey

redeem_script="${OP_2}${PUSH_PUBKEY}${publicKey1}${PUSH_PUBKEY}${publicKey2}${PUSH_PUBKEY}${publicKey3}${OP_3}${OP_CHECKMULTISIG}"