# Notes
* `git clone --recurse-submodules git@github.com:Dr-Deep/dots.git`

## hexdump
* `hexdump -v -C /file | less`

## ZFS: zpool
* `zpool list -v zsys`
* `zpool attach -w zsys /dev/gpt/zsys  /dev/ada2p2.eli`
* `zpool detach zsys /dev/device`

## NVME nullen
* `nvmecontrol format -E /dev/nvme0`
* `nvmecontrol sanitize -a block /dev/nvme0`

## hbsdcontrol
* [shlibrandom, segvguard, prohibit_ptrace_capsicum,]
* [pageexec, mprotect, insecure_kmod]
* [harden_shm, disallow_map32bit]
* `hbsdcontrol pax list`
* `hbsdcontrol -H -d pax disable feature $(which file)`
* `hbsdcontrol pax disable insecure_kmod /path/module.ko`

## kern
* `sysctl hardening.harden_rtld`


## vm-bhyve
* `vm create `



```conf
# lnxlab@bsdlab

## 
loader="uefi"
cpu="1"
memory="4G"

debug="yes"

## Network
network0_type="virtio-net"
network0_switch="public"
network0_mac="00:DE:AD:BE:EF:01"

## Disk
disk0_type="virtio-blk"
disk0_name="zvol"
disk0_dev="sparse-zvol"

uuid="7d023263-5ab1-4f1b-88d6-44d31bff598a"
```





`qemu-nbd -f raw --persistent -p 10809 /dev/vda`
