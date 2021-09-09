<h1 align=center><strong>AMD</strong> NAVI 2x GPU SETUP [LINUX]</h2>

This setup is still in development. For now it is considered to run with single GPUs only.
Supports all Navi21, Navi22, Navi23 asics.

# Prerequisites
Ubuntu 20.04.2 (Desktop LTS)

# Dependencies
- AMD 21.30 Driver
- Team Red Miner 0.8.5

# Download
Open a terminal anywhere and type
```bash
wget -O - https://b0-b.github.io/AMD-NAVI-2x-SETUP | bash 
```
and hit enter. The `setup.sh` and `uninstall.sh` will be downloaded in the home directory.

# Setup

### 1. Run setup
Go into your home directory and run the setup
```bash
cd $HOME
/bin/bash setup.sh
```
The script will ask for a password at the beginning and for a reboot when finished.
Please reboot your system.

### 2. Override Parameters
Go into the generated overdrive.sh script in the miner directory 

```bash
cd $HOME/miner/teamredminer-v0.8.5-linux/
```

To find these use the `card_from_pci.sh` script in the same directory, by trying HEX numbers starting from 0.
```bash
/bin/bash card_from_pci.sh "0"
0   # <-- If a 0 is returned a card was found at PCI slot 0
```

Once found please override the gpu call in overdrive.sh
```bash
...
function gpu () {
cd `dirname $0`
C=`./card_from_pci.sh $1`
C=`echo $C | xargs`
echo "manual" > /sys/class/drm/card$C/device/power_dpm_force_performance_level
echo "s 1 1600" > /sys/class/drm/card$C/device/pp_od_clk_voltage
echo "m 1 1000" > /sys/class/drm/card$C/device/pp_od_clk_voltage
echo "vc 2 1600 900" > /sys/class/drm/card$C/device/pp_od_clk_voltage
echo "c" > /sys/class/drm/card$C/device/pp_od_clk_voltage
cat /sys/class/drm/card$C/device/pp_od_clk_voltage
}
gpu "0"  # <-- override this line to your gpu ID in this case "0" 
```

```bash
nano overdrive.sh
```
Last edit in line 4 the Wallet address
```bash
...
declare wallet="YOUR WALLET ADDRESS HERE"
...
```

and save with `CTRL + x`.

# Run
To start the mining workload with output (process is bound to the shell) type
```bash
/bin/bash overdrive.sh
```
and to start the process in the background (ssh shell can be closed then) run the detatched mode
```bash
/bin/bash detatch.sh
```