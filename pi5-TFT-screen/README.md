# 🚀 RECOVERY GUIDE: ILI9341 2.4" SPI DISPLAY 
# RASPBERRY PI 5 8GB

## SYSTEM OVERVIEW
This guide restores the Landscape Orientation & UI Scaling for KlipperScreen.
**Backup Location:** `~/pi5-TFT-screen/`

## 🔌 STEP 0: WIRING DIAGRAM (GPIO TO SCREEN)
Ensure the physical pins are connected as follows to match SPI5:

| SCREEN PIN | PI 5 PIN (GPIO) | PIN NO. | FUNCTION |
| :--- | :--- | :--- | :--- |
| **VCC** | 3.3V | 1 | Power |
| **GND** | Ground | 6 | Ground |
| **CS** | GPIO 13 (CE1) | 33 | Chip Select |
| **RESET** | GPIO 25 | 22 | Reset |
| **DC/RS** | GPIO 24 | 18 | Data/Command |
| **SDI (MOSI)** | GPIO 12 (MOSI) | 32 | Data Input |
| **SCK** | GPIO 14 (SCLK) | 8 | Clock |
| **LED** | 3.3V (or GPIO) | 17 | Backlight |
| **SDO (MISO)** | GPIO 15 (MISO) | 10 | Data Output |

## 📦 PRE-REQUISITES
Ensure your backup directory contains these 9 essential files:

1. `cmdline.txt`
2. `config.txt`
3. `spi5-ili9341.dtbo`
4. `spi5-ili9341.dts`
5. `my24in.bin`
6. `ili9341.txt`
7. `99-spi-display.conf`
8. `KlipperScreen-start.sh`
9. `KlipperScreen.conf`

---

## 📟 STEP 1: KERNEL BOOT PARAMETERS
Sets the display buffer and 270-degree rotation.

```bash
# Copy the kernel command line parameters
sudo cp ~/pi5-TFT-screen/cmdline.txt /boot/firmware/cmdline.txt
```

## 🔌 STEP 2: HARDWARE INTERFACE (SPI5)
Enables SPI5 and loads the custom screen overlay.

```bash
# Apply the hardware configuration for the SPI interface
sudo cp ~/pi5-TFT-screen/config.txt /boot/firmware/config.txt
```

## 🧩 STEP 3: DEVICE TREE OVERLAY (DTBO)
Maps the physical Pi 5 pins to the ILI9341 driver.

```bash
# Install the compiled device tree blob overlay
sudo cp ~/pi5-TFT-screen/spi5-ili9341.dtbo /boot/firmware/overlays/
```

## 💾 STEP 4: CONTROLLER FIRMWARE (BIN)
Contains the register init sequence (including the 0xE8 Landscape fix).

```bash
# Copy the initialization binary to the firmware directory
sudo cp ~/pi5-TFT-screen/my24in.bin /lib/firmware/
```

## 🖥️ STEP 5: X11 GRAPHICAL SERVER
Forces the UI to render on the SPI framebuffer (/dev/fb0).

```bash
# Configure the X11 server to target the SPI display
sudo cp ~/pi5-TFT-screen/99-spi-display.conf /etc/X11/xorg.conf.d/
```

## 📏 STEP 6: UI SCALING (GDK)
Injects GDK_SCALE=2 to make buttons clickable on the 2.4" screen.

```bash
# Deploy the startup script and grant execution permissions
cp ~/pi5-TFT-screen/KlipperScreen-start.sh ~/KlipperScreen/scripts/
chmod +x ~/KlipperScreen/scripts/KlipperScreen-start.sh
```

## ⚙️ STEP 7: KLIPPERSCREEN CONFIG
Sets internal app rotation and font sizes.

```bash
# Apply the KlipperScreen specific configurations
cp ~/pi5-TFT-screen/KlipperScreen.conf ~/printer_data/config/
```

## 🔄 STEP 8: APPLY & REBOOT
Apply all changes by restarting the service and the system.

```bash
# Restart the display service and reboot the Pi
sudo systemctl restart KlipperScreen
sudo reboot
```

---

💡 **PRO-TIP:** Check logs if the screen stays white:

```bash
# Filter the kernel ring buffer for SPI initialization logs
dmesg | grep spi
```
