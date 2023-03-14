# CUDA-labs

### To get the nvvp to run without root on x86 platforms:
  modprobe nvgpu NVreg_RestrictProfilingToAdminUsers=0
  
  
# Error

> ERR_NVGPUCTRPERM: Permission issue with Performance Counters

# Solutions for this issue

NVIDIA has a [page](https://developer.nvidia.com/ERR_NVGPUCTRPERM) that addresses the issue. Unfortunately, the instructions didn't solve the problem for me. However, I found a solution from rameshgunjal in the NVIDIA [forums](https://forums.developer.nvidia.com/t/nvprof-warning-the-user-does-not-have-permission-to-profile-on-the-target-device/72374/4).

## Option 1: Running the program as admin
You might have noticed that `sudo nv-nsight-cu` results in an error. Instead, you have to provide the path: `sudo /usr/local/cuda/bin/nv-nsight-cu`. The same applies for other applications as well: `sudo /usr/local/cuda/bin/nsight-sys`.

## Option 2: Enable access for all users
You might be thinking: There must be a reason why NVIDIA restricted access to admins only - and [there is](https://nvidia.custhelp.com/app/answers/detail/a_id/4738). In the Description it is stated, that the security flaw is 'not a network or remote attack vector'. Further, NVIDIA has released updated drivers to address this issue in February 2019. So I don't think there is much to worry about.

If you temporarily want to enable access for all users you can call:

    modprobe nvidia NVreg_RestrictProfilingToAdminUsers=0

For persistence across reboots:

1. Create a .conf file with a file name of your choice in the `/etc/modprobe.d/` directory
2. Write `options nvidia "NVreg_RestrictProfilingToAdminUsers=0"` into it
3. Restart your computer

Steps 1 and 2 can be performed with the following command:

    (echo 'options nvidia "NVreg_RestrictProfilingToAdminUsers=0"') | sudo tee -a /etc/modprobe.d/RestrictedProfiling.conf >/dev/null

You can check if everything worked by calling the following command:

    cat /proc/driver/nvidia/params | grep RmProfilingAdminOnly

It should return `RmProfilingAdminOnly: 0`.
