import torch
import time
import argparse

def burn_gpu(gpu_id=0, mem_gb=4, util_target=100):
    if not torch.cuda.is_available():
        print("Error: No GPU found.")
        return

    device = torch.device(f"cuda:{gpu_id}")
    print(f"Targeting GPU {gpu_id}...")

    try:
        num_elements = int(mem_gb * 1024 * 1024 * 1024 / 4)
        memory_hog = torch.zeros(num_elements, dtype=torch.float32, device=device)
        print(f"Allocated {mem_gb}GB VRAM on GPU {gpu_id}.")
    except Exception as e:
        print(f"VRAM allocation warning: {e}")

    matrix_size = 784
    a = torch.randn(matrix_size, matrix_size, device=device)
    b = torch.randn(matrix_size, matrix_size, device=device)

    print(f"Starting compute loop on GPU {gpu_id}...")
    
    while True:
        c = torch.matmul(a, b)
        torch.cuda.synchronize()
        for i in range(10000):
            j = i + 1
        if util_target < 100:
            time.sleep(1) 
        if util_target < 100:
            time.sleep(1)         
        if util_target < 100:
            time.sleep(1) 
if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--gpu", type=int, default=0)
    parser.add_argument("--mem", type=int, default=4)
    args = parser.parse_args()
    burn_gpu(gpu_id=args.gpu, mem_gb=args.mem)
