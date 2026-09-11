#!/system/bin/sh

# Buat file log
LOG_FILE="/data/local/tmp/kernel_tuning.log"
echo "============================================" > $LOG_FILE
echo "  KERNEL TUNING — $(date)" >> $LOG_FILE
echo "============================================" >> $LOG_FILE
echo "" >> $LOG_FILE

echo "⏳ Menunggu sistem siap..."
echo "[0] Menunggu sistem siap..." >> $LOG_FILE
sleep 15

echo ""
echo "============================================"
echo "  ⚡ I/O SCHEDULER TUNING"
echo "============================================"
echo "" >> $LOG_FILE
echo "--- I/O SCHEDULER ---" >> $LOG_FILE

# SDA — CFQ Settings
if [ -f /sys/block/sda/queue/iosched/low_latency ]; then
  OLD=$(cat /sys/block/sda/queue/iosched/low_latency)
  echo 0 > /sys/block/sda/queue/iosched/low_latency
  echo "✅ low_latency : $OLD → 0"
  echo "✅ low_latency : $OLD → 0" >> $LOG_FILE
else
  echo "⚠️ low_latency : tidak ditemukan, dilewati"
  echo "⚠️ low_latency : tidak ditemukan, dilewati" >> $LOG_FILE
fi

if [ -f /sys/block/sda/queue/iosched/slice_idle ]; then
  OLD=$(cat /sys/block/sda/queue/iosched/slice_idle)
  echo 0 > /sys/block/sda/queue/iosched/slice_idle
  echo "✅ slice_idle  : $OLD → 0"
  echo "✅ slice_idle  : $OLD → 0" >> $LOG_FILE
else
  echo "⚠️ slice_idle  : tidak ditemukan, dilewati"
  echo "⚠️ slice_idle  : tidak ditemukan, dilewati" >> $LOG_FILE
fi

if [ -f /sys/block/sda/queue/iosched/fifo_batch ]; then
  OLD=$(cat /sys/block/sda/queue/iosched/fifo_batch)
  echo 8 > /sys/block/sda/queue/iosched/fifo_batch
  echo "✅ fifo_batch  : $OLD → 8"
  echo "✅ fifo_batch  : $OLD → 8" >> $LOG_FILE
else
  echo "⚠️ fifo_batch  : tidak ditemukan, dilewati"
  echo "⚠️ fifo_batch  : tidak ditemukan, dilewati" >> $LOG_FILE
fi

echo ""
echo "--- nr_requests ---"
echo "" >> $LOG_FILE

for dev in sda sdb sdc sdd sde sdf; do
  if [ -f /sys/block/$dev/queue/nr_requests ]; then
    OLD=$(cat /sys/block/$dev/queue/nr_requests)
    echo 256 > /sys/block/$dev/queue/nr_requests
    echo "✅ $dev nr_requests : $OLD → 256"
    echo "✅ $dev nr_requests : $OLD → 256" >> $LOG_FILE
  else
    echo "⚠️ $dev nr_requests : tidak ditemukan, dilewati"
    echo "⚠️ $dev nr_requests : tidak ditemukan, dilewati" >> $LOG_FILE
  fi
done

echo ""
echo "============================================"
echo "  🧠 MEMORY / VM TUNING"
echo "============================================"
echo "" >> $LOG_FILE
echo "--- MEMORY / VM ---" >> $LOG_FILE

# dirty_background_ratio
OLD=$(cat /proc/sys/vm/dirty_background_ratio)
echo 5 > /proc/sys/vm/dirty_background_ratio
echo "✅ dirty_background_ratio  : $OLD → 5"
echo "✅ dirty_background_ratio  : $OLD → 5" >> $LOG_FILE

# dirty_ratio
OLD=$(cat /proc/sys/vm/dirty_ratio)
echo 10 > /proc/sys/vm/dirty_ratio
echo "✅ dirty_ratio             : $OLD → 10"
echo "✅ dirty_ratio             : $OLD → 10" >> $LOG_FILE

# dirty_expire_centisecs
OLD=$(cat /proc/sys/vm/dirty_expire_centisecs)
echo 1000 > /proc/sys/vm/dirty_expire_centisecs
echo "✅ dirty_expire_centisecs  : $OLD → 1000"
echo "✅ dirty_expire_centisecs  : $OLD → 1000" >> $LOG_FILE

# dirty_writeback_centisecs
OLD=$(cat /proc/sys/vm/dirty_writeback_centisecs)
echo 200 > /proc/sys/vm/dirty_writeback_centisecs
echo "✅ dirty_writeback_centisecs : $OLD → 200"
echo "✅ dirty_writeback_centisecs : $OLD → 0" >> $LOG_FILE

# page-cluster
OLD=$(cat /proc/sys/vm/page-cluster)
echo 0 > /proc/sys/vm/page-cluster
echo "✅ page-cluster            : $OLD → 0"
echo "✅ page-cluster            : $OLD → 0" >> $LOG_FILE

echo ""
echo "============================================"
echo "  ✅ SELESAI — Semua perubahan diterapkan"
echo "============================================"
echo ""
echo "📋 Log lengkap tersimpan di: /data/local/tmp/kernel_tuning.log"
echo "" >> $LOG_FILE
echo "=== SELESAI — $(date) ===" >> $LOG_FILE

exit 0
