# 🛠️ KLIPPER CONFIGURATION ARCHITECTURE | RASPBERRY PI 5 🚀

## SYSTEM OVERVIEW
This directory contains the core logic, hardware definitions, and macros for the 3D printer running Klipper on Raspberry Pi 5.

## 📂 CORE FILE STRUCTURE
The configuration is split into modular components for easier maintenance:

| FILE NAME | FUNCTION |
| :--- | :--- |
| **printer.cfg** | Main entry point and MCU pin definitions |
| **macros.cfg** | Print start/end, park, and utility commands |
| **mainsail.cfg** | Web interface and dashboard settings |
| **KlipperScreen.conf** | UI, rotation, and theme for the TFT display |
| **moonraker.conf** | API, update manager, and backup settings |

## 📡 HARDWARE RECOVERY (MCU)
If you flash a new board or replace the MCU, use these settings:

* **Micro-controller:** [Board Name, e.g., SKR Pico / Octopus]
* **Communication:** USB or CAN-bus (Check `printer.cfg` `[mcu]` section)
* **Firmware:** Klipper (Build with: `make menuconfig`)

## 🔄 BACKUP & SYNC
The configuration is automatically backed up to GitHub using:

```bash
# Execute the automated backup script
~/klipper-backup/script.sh
```

To trigger a manual backup now:

```bash
# Execute a manual backup with a specific commit message
~/klipper-backup/script.sh -c "Manual config update"
```

## 📏 CALIBRATION & MAINTENANCE
Common commands to run after hardware changes:

```text
# Run PID tuning for the extruder heater
PID_CALIBRATE HEATER=extruder TARGET=210

# Calibrate the bed mesh
BED_MESH_CALIBRATE

# Save the new configuration and restart
SAVE_CONFIG
```

---

💡 **PRO-TIP:** Always check "Klipper Log" (`/tmp/klippy.log`) after changing configuration files to debug errors.
