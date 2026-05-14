#conda activate agentenv-sciworld

export NO_PROXY=127.0.0.1,localhost
export no_proxy=127.0.0.1,localhost
nohup sciworld --host 0.0.0.0 --port 36001 > log/out_server_05.log 2>&1 &