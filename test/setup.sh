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
bitcoin-cli -signet invalidateblock 0000027697cdb0347a40017a44e7b936be55a5217d122c570a2b68976baeff88
