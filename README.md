# KernelSU UFS & Memory Optimizer

## 🗑️ Cara Menghapus
1. Buka KernelSU → Modules
2. Tekan ikon hapus (🗑️) pada modul ini
3. Reboot perangkat

> ⚠️ Catatan: Semua perubahan modul ini bersifat SEMENTARA di memori.
> Saat dihapus dan direboot, semua nilai OTOMATIS kembali murni ke bawaan pabrik.
> Tidak ada perubahan permanen pada sistem — aman dan bisa dikembalikan kapan saja.

Modul KernelSU untuk optimasi I/O dan manajemen memori pada perangkat Xiaomi dengan Snapdragon 6 Gen 3.
Mengutamakan pendekatan minimalis — hanya mengubah yang benar-benar perlu, membiarkan perangkat keras bekerja murni.

## Penulis
© 2026 Mystivara
Author: Mystivara

## Fitur
- ⚡ Optimasi I/O Scheduler — kurangi penundaan akses UFS
- 🧠 Penanganan data tulis lebih mulus, kurangi jeda
- 🔄 zRAM tetap bawaan pabrik — LZ4 dipertahankan
- ✅ Semua parameter lain tetap murni bawaan pabrik

## Cara Pasang
1. ZIP folder modul
2. Pasang melalui KernelSU Manager
3. Reboot perangkat
4. Cek hasil: `cat /data/local/tmp/kernel_tuning.log`

## Lisensi
MIT License — lihat file LICENSE untuk detail.
