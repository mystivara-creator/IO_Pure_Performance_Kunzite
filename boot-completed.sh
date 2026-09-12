#!/system/bin/sh
MODDIR=${0%/*}
LOG_FILE="/tmp/kernel_tuning.log"

echo "" > "$LOG_FILE"
echo "============================================" >> "$LOG_FILE"
echo " EficienyKernelTweaksKunzite — $(date)" >> "$LOG_FILE"
echo "============================================" >> "$LOG_FILE"

# Memastikan proses booting Android selesai sepenuhnya
until [ "$(getprop sys.boot_completed)" -eq 1 ]; do
  sleep 3
done

# === VIRTUAL MEMORY TUNING (Hanya mengubah yang berbeda dari stock) ===
test -w /proc/sys/vm/dirty_background_ratio && echo 5 > /proc/sys/vm/dirty_background_ratio && echo " ✅ dirty_background_ratio: 5" >> "$LOG_FILE"
test -w /proc/sys/vm/dirty_ratio && echo 10 > /proc/sys/vm/dirty_ratio && echo " ✅ dirty_ratio: 10" >> "$LOG_FILE"
test -w /proc/sys/vm/dirty_expire_centisecs && echo 1500 > /proc/sys/vm/dirty_expire_centisecs && echo " ✅ dirty_expire_centisecs: 1500" >> "$LOG_FILE"
test -w /proc/sys/vm/dirty_writeback_centisecs && echo 300 > /proc/sys/vm/dirty_writeback_centisecs && echo " ✅ dirty_writeback_centisecs: 300" >> "$LOG_FILE"
test -w /proc/sys/vm/page-cluster && echo 0 > /proc/sys/vm/page-cluster && echo " ✅ page-cluster: 0" >> "$LOG_FILE"
test -w /proc/sys/vm/swappiness && echo 60 > /proc/sys/vm/swappiness && echo " ✅ swappiness: 60" >> "$LOG_FILE"
test -w /proc/sys/vm/vfs_cache_pressure && echo 60 > /proc/sys/vm/vfs_cache_pressure && echo " ✅ vfs_cache_pressure: 60" >> "$LOG_FILE"

echo "" >> "$LOG_FILE"

# === MULTI-QUEUE STORAGE TUNING (sda–sdf) ===
for dev in sda sdb sdc sdd sde sdf; do
  if [ -d "/sys/block/$dev" ]; then
    echo "--- Tuning Storage Device: $dev ---" >> "$LOG_FILE"
    
    # Menaikkan nilai nr_requests dari bawaan (62) ke 256
    if [ -f /sys/block/$dev/queue/nr_requests ]; then
      echo 256 > /sys/block/$dev/queue/nr_requests
      echo " ✅ $dev nr_requests: 256" >> "$LOG_FILE"
    fi
    
    # Memastikan add_random mati untuk memotong overhead CPU
    if [ -f /sys/block/$dev/queue/add_random ]; then
      echo 0 > /sys/block/$dev/queue/add_random
    fi

    # mq-deadline Scheduler Tunables (Pengunci Latensi)
    if [ -f /sys/block/$dev/queue/iosched/low_latency ]; then
      echo 0 > /sys/block/$dev/queue/iosched/low_latency
      echo " ✅ $dev low_latency: 0" >> "$LOG_FILE"
    fi
    if [ -f /sys/block/$dev/queue/iosched/slice_idle ]; then
      echo 0 > /sys/block/$dev/queue/iosched/slice_idle
      echo " ✅ $dev slice_idle: 0" >> "$LOG_FILE"
    fi
    if [ -f /sys/block/$dev/queue/iosched/fifo_batch ]; then
      echo 8 > /sys/block/$dev/queue/iosched/fifo_batch
      echo " ✅ $dev fifo_batch: 8" >> "$LOG_FILE"
    fi
  fi
done

echo "" >> "$LOG_FILE"
echo " ✅ Semua pengaturan penting berhasil diterapkan!" >> "$LOG_FILE"
echo "============================================" >> "$LOG_FILE"
