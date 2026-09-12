#!/system/bin/sh
MODDIR=${0%/*}

# === BALIKIN SETTING MEMORY/VM KE ANGKA BAWAAN ASLI ===
test -w /proc/sys/vm/dirty_background_ratio && echo 10 > /proc/sys/vm/dirty_background_ratio
test -w /proc/sys/vm/dirty_ratio && echo 20 > /proc/sys/vm/dirty_ratio
test -w /proc/sys/vm/dirty_expire_centisecs && echo 3000 > /proc/sys/vm/dirty_expire_centisecs
test -w /proc/sys/vm/dirty_writeback_centisecs && echo 500 > /proc/sys/vm/dirty_writeback_centisecs
test -w /proc/sys/vm/page-cluster && echo 3 > /proc/sys/vm/page-cluster
test -w /proc/sys/vm/swappiness && echo 120 > /proc/sys/vm/swappiness
test -w /proc/sys/vm/vfs_cache_pressure && echo 100 > /proc/sys/vm/vfs_cache_pressure

# === BALIKIN SETTING I/O DEVICES KE ANGKA BAWAAN ASLI SCREENSHOT ===
for dev in sda sdb sdc sdd sde sdf; do
  if [ -d "/sys/block/$dev" ]; then
    if [ -f /sys/block/$dev/queue/nr_requests ]; then
      echo 62 > /sys/block/$dev/queue/nr_requests
    fi
    if [ -f /sys/block/$dev/queue/add_random ]; then
      echo 1 > /sys/block/$dev/queue/add_random
    fi
    
    # Balikin iosched tunables bawaan
    if [ -f /sys/block/$dev/queue/iosched/low_latency ]; then
      echo 1 > /sys/block/$dev/queue/iosched/low_latency
    fi
    if [ -f /sys/block/$dev/queue/iosched/slice_idle ]; then
      echo 8 > /sys/block/$dev/queue/iosched/slice_idle
    fi
    if [ -f /sys/block/$dev/queue/iosched/fifo_batch ]; then
      echo 16 > /sys/block/$dev/queue/iosched/fifo_batch
    fi
  fi
done

exit 0
