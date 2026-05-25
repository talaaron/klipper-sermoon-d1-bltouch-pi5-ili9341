# 🖨️ Klipper Ecosystem | Raspberry Pi 5 Management

Klipper-Backup 💾
Klipper backup script for manual or automated GitHub backups.
This backup is provided by **Klipper-Backup**.

---

## 📂 Repository Structure & Navigation

This repository centralizes the system and hardware configurations for the Raspberry Pi 5. The documentation is divided into two main sections:

### 1. 📺 [ILI9341 Display Recovery](./pi5-TFT-screen/)
A detailed guide for restoring the TFT screen settings, including wiring, SPI5 configurations, and UI scaling.
- **Usage:** In case of OS reinstallation or display malfunction.
- **Direct file:** [Display README](./pi5-TFT-screen/README.md)

### 2. ⚙️ [Klipper Configuration](./printer_data/config/)
The architecture of the printer config files. Modular division of macros, MCU definitions, and Moonraker communication.
- **Usage:** Routine maintenance, PID tuning, and backup management.
- **Direct file:** [Config README](./printer_data/config/README.md)

---

## 🔄 Automated Backup Status

Backups are performed automatically. For any critical change in the config files, run the synchronization script:

```bash
# Run the synchronization script with a commit message
~/klipper-backup/script.sh -c "Update message"
```

---

💡 **Important:** Do not rely solely on automated backups. Before any significant hardware changes, manually verify that the latest commit on GitHub includes the changes in `printer.cfg`. A mismatch between configuration and hardware can lead to physical damage to the components.
