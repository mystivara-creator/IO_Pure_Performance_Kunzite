A minimalist KernelSU module designed for I/O Scheduler optimization and Virtual Memory (VM) management on Xiaomi devices powered by the Snapdragon 6 Gen 3 chipset. This module prioritizes a clean, lightweight approach—modifying only what is strictly necessary while allowing the core hardware to perform efficiently without redundant commands.

> ⚠️ **Important Notice:** This configuration file has been strictly tested on a single device only: the **Redmi Note 15 5G (Snapdragon 6 Gen 3)**. Proceed with caution if you plan to flash this on other hardware variants or architectures.

## ⚡ Key Features
- **I/O Scheduler Optimization (`mq-deadline`):** Eliminates silicon wait times (`slice_idle = 0`) and strips down unnecessary background logging overhead (`add_random = 0`) across storage blocks `sda` through `sdf` for instantaneous UFS 2.2 file execution.
- **Expanded Queue Capacity:** Quadruples the default storage queue size `nr_requests` to 256 (factory default is only 62) to effectively prevent data bottlenecks and system stutters during heavy multitasking or when loading massive game assets.
- **Advanced Virtual Memory (VM) Tuning:** Lowers `swappiness` to 60 (factory default is aggressively set to 120%) to prioritize physical RAM allocations for foreground applications, and reduces `vfs_cache_pressure` to 60 to retain directory and inode caches longer for a much faster UI response.
- **Anti-Spike Writeback Control:** Readjusts dirty page thresholds (`dirty_ratio` & `dirty_background_ratio`) to stop heavy background data flushes from triggering sudden micro-stutters during intensive gaming sessions.

## 🗑️ How to Uninstall
1. Open the KernelSU App → Navigate to the Modules section.
2. Tap the trash bin icon (🗑️) on this module.
3. Reboot your device.

> ⚠️ **Note:** All modifications applied by this module are purely TEMPORARY and run within the system memory. Once the module is uninstalled and the device is rebooted, the built-in clean restoration script **AUTOMATICALLY** reverts every single value back to the absolute factory default baseline. No permanent system files are modified—making it completely safe and reversible at any time.

## 👤 Author
© 2026 Mystivara-dev
