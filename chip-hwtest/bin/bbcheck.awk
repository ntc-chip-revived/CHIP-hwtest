#!/usr/bin/gawk -f

/bad blocks/ {
	bad_blocks=$5
}

/bbt blocks/ {
	bbt_blocks=$5
}

END {
	printf("%d %d\n",bad_blocks,bbt_blocks)
}
