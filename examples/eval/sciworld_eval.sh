set -x
export VLLM_USE_MODELSCOPE=0
export VLLM_WORKER_MULTIPROC_METHOD=spawn
export VLLM_ATTENTION_BACKEND=XFORMERS
export HF_ENDPOINT=https://hf-mirror.com
export NO_PROXY=127.0.0.1,localhost
export no_proxy=127.0.0.1,localhost
task_name="sciworld"

# cd AgentGym-RL
# source activate
# conda activate agentgym-rl sh examples/eval/sciworld_eval.sh
export VLLM_ATTENTION_BACKEND=XFORMERS

env_server_url="http://127.0.0.1:36001"

sample_num=1
max_rounds=30

ckpt_path="/home/hly/projects/llm-agent/AgentGym-RL/saves/agentgym_rl_7b_qapo/global_step_200/actor"
model_path=${ckpt_path}/huggingface

cd AgentGym-RL/scripts
python model_merger.py \
    --local_dir ${ckpt_path}

HYDRA_FULL_ERROR=1 python3 -m verl.agent_trainer.main_generation  \
    data.path=/home/hly/projects/llm-agent/AgentGym-RL/AgentItemId/eval \
    data.max_prompt_length=1024 \
    data.max_response_length=8192 \
    data.n_samples=${sample_num} \
    data.batch_size=32 \
    agentgym.task_name=${task_name} \
    agentgym.env_addr=${env_server_url} \
    agentgym.max_rounds=${max_rounds} \
    agentgym.timeout=500 \
    model.path=${model_path} \
    rollout.gpu_memory_utilization=0.95 \
    rollout.temperature=1 \
    rollout.max_model_len=32768 \
    rollout.max_tokens=200 \
    rollout.tensor_model_parallel_size=1 \
    rollout.rollout_log_dir=executer_logs \
    trainer.n_gpus_per_node=4 \
    trainer.nnodes=1 \
# status=$?
# exit $status
