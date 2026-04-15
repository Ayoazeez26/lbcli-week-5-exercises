# Create a time-based CSV script that would lock funds for 6 months (using 30-day months)
# Time-based CSV uses 512-second units with the type flag (bit 22) set
# 6 months = 6 * 30 days = 180 days
# 180 days * 24 hours * 60 minutes * 60 seconds = 15,552,000 seconds

# CSV time-based unit = 512 seconds
# 15,552,000 / 512 = 30,375 units

# Time-based flag: bit 22 must be set -> OR with 0x400000
# 30,375 = 0x007697
# 0x007697 | 0x400000 = 0x407697

# Encode 0x407697 as 3-byte little-endian -> 97 76 40

publicKey=02e3af28965693b9ce1228f9d468149b831d6a0540b25e8a9900f71372c11fb277

seconds=$((180 * 24 * 60 * 60))
units=$((seconds / 512))

csv_value=$((units | 0x400000))

csv_le=$(printf '%06x' $csv_value | sed 's/\(..\)\(..\)\(..\)/\3\2\1/')

PUSH_3_BYTES="03"
OP_CSV="b2"
OP_DROP="75"
PUSH_PUBKEY="21"
OP_CHECKSIG="ac"

csv_script="${PUSH_3_BYTES}${csv_le}${OP_CSV}${OP_DROP}${PUSH_PUBKEY}${publicKey}${OP_CHECKSIG}