wget https://bitcoincore.org/bin/bitcoin-core-28.0/bitcoin-28.0-x86_64-linux-gnu.tar.gz
tar -xzvf bitcoin-28.0-x86_64-linux-gnu.tar.gz
ln -s $PWD/bitcoin-28.0/bin/* /usr/local/bin/
bitcoind -daemon -signet -signetchallenge=0014bdec02fe5ec499cc2cb52dc160230643a84dd118 -blocksonly=1 -addnode=146.190.155.176:28333
while true; do
    blockcount=$(bitcoin-cli -signet getblockcount)
    if [[ $blockcount -ge 300 ]]; then
        echo "blocks: $blockcount"
        break
    else
        sleep 1
    fi
done

# The following invalidates block 400 and all the subsequent blocks. Call it to
# make validation faster if needed.
bitcoin-cli -signet invalidateblock 000001d844f6d2684dc456317d96eb4aec0d681b93074d93072c4604fdf8cc4a

# The following is used to undo the previous, but it may take some minutes until
# a new block is mined to fully restore the chain.
# bitcoin-cli -signet reconsiderblock 000001d844f6d2684dc456317d96eb4aec0d681b93074d93072c4604fdf8cc4a
