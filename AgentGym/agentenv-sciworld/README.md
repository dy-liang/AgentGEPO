# Agent Environments - SciWorld

## Setup
Before running: You will have to have Java 1.8+ installed on your system (shipped with most linux distributions).
``` sh
conda create --name agentenv-sciworld python=3.8
conda activate agentenv-sciworld
pip install -e .
```

## Launch

``` sh
export NO_PROXY=127.0.0.1,localhost
export no_proxy=127.0.0.1,localhost
sciworld --host 0.0.0.0 --port 36001
```
