#############################################################################
RECOVERY GUIDE: ILI9341 2.4 INCH SPI DISPLAY ON RASPBERRY PI 5
#############################################################################

This guide assumes all backup files are stored in: /pi5-backup-FTF/
The backup directory should contain:

cmdline.txt
config.txt
spi5-ili9341.dtbo (Binary overlay)
spi5-ili9341.dts (Source code)
my24in.bin (Binary firmware)
ili9341.txt (Register config)
99-spi-display.conf (X11 config)
KlipperScreen-start.sh (Scaling script)
KlipperScreen.conf (App config)

#############################################################################
STEP 1: KERNEL COMMAND LINE
#############################################################################
This file tells the Linux kernel how to initialize the display buffer and
sets the initial 270-degree rotation for the boot sequence.

cp /pi5-backup-FTF/cmdline.txt /boot/firmware/cmdline.txt

#############################################################################
STEP 2: FIRMWARE CONFIGURATION
#############################################################################
This file enables the SPI interface and loads the custom overlay for the
display on SPI5.

cp /pi5-backup-FTF/config.txt /boot/firmware/config.txt

#############################################################################
STEP 3: HARDWARE OVERLAY (DTBO)
#############################################################################
The DTBO file maps the physical GPIO pins of the Raspberry Pi 5 to the
ILI9341 driver.

cp /pi5-backup-FTF/spi5-ili9341.dtbo /boot/firmware/overlays/spi5-ili9341.dtbo

If you only have the .dts source, use this to compile:
dtc -I dts -O dtb -o /boot/firmware/overlays/spi5-ili9341.dtbo /pi5-backup-FTF/spi5-ili9341.dts

#############################################################################
STEP 4: DISPLAY CONTROLLER FIRMWARE (BIN)
#############################################################################
The .bin file contains the specific initialization registers (including the
0xE8 landscape command) for the ILI9341 controller.

cp /pi5-backup-FTF/my24in.bin /lib/firmware/my24in.bin

If you only have the .txt source, use this to compile:
./mipi-dbi-cmd /lib/firmware/my24in.bin /pi5-backup-FTF/ili9341.txt

#############################################################################
STEP 5: X11 GRAPHICAL SERVER CONFIG
#############################################################################
This configuration forces the graphical interface to use the /dev/fb0
framebuffer with the correct 320x240 resolution.

cp /pi5-backup-FTF/99-spi-display.conf /etc/X11/xorg.conf.d/99-spi-display.conf

#############################################################################
STEP 6: KLIPPERSCREEN SCALING SCRIPT
#############################################################################
This script injects the GDK_SCALE=2 variable to make the UI elements and
buttons large enough for the 2.4 inch screen.

cp /pi5-backup-FTF/KlipperScreen-start.sh /home/tal/KlipperScreen/scripts/KlipperScreen-start.sh
chmod +x /home/tal/KlipperScreen/scripts/KlipperScreen-start.sh

#############################################################################
STEP 7: KLIPPERSCREEN APPLICATION CONFIG
#############################################################################
The main configuration file for KlipperScreen settings such as font size
and rotation within the app.

cp /pi5-backup-FTF/KlipperScreen.conf /home/tal/printer_data/config/KlipperScreen.conf

#############################################################################
STEP 8: APPLY CHANGES
#############################################################################
Commands to restart the service or reboot the system to apply all changes.

sudo systemctl restart KlipperScreen
sudo reboot
