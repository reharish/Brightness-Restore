# Bright-Res
The Script used to resolve brightness restoring issue mainly on distros running mate, XFCE4 and some other lightweight distros.

## Installation
* Run the Script
`bash install.sh`
* Will list all Graphics driver available on your device.
* Choose your Graphics driver.`Refer: Footnote`
* Close your eyes, Its done.

## Description
* It will store your brightness in installation folder.
* It uses systemd service to store before shutdown or reboot.
* Restore that brightness on next login.

### Note:
* Select a appropriate graphics device while an installation.
* In my case my driver is `amdgpu_bl0` you can see yours by listing `ls /sys/class/backlight/` folder
* To Verify your Graphics driver.
* Try to Change the value of `brightness` file under '/sys/class/backlight/<driver>/brightness`
* If its preferred the change will reflect on your screen.