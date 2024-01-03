#!/vendor/bin/sh
if ! applypatch --check EMMC:/dev/block/bootdevice/by-name/recovery$(getprop ro.boot.slot_suffix):81788928:4e179d66c5bca1052274c1cceaa16027284f6d7a; then
  applypatch \
          --patch /vendor/recovery-from-boot.p \
          --source EMMC:/dev/block/bootdevice/by-name/boot$(getprop ro.boot.slot_suffix):100663296:797b03272729e36c81cb7db6aec6df4c218c7952 \
          --target EMMC:/dev/block/bootdevice/by-name/recovery$(getprop ro.boot.slot_suffix):81788928:4e179d66c5bca1052274c1cceaa16027284f6d7a && \
      (/vendor/bin/log -t install_recovery "Installing new recovery image: succeeded" && setprop vendor.ota.recovery.status 200) || \
      (/vendor/bin/log -t install_recovery "Installing new recovery image: failed" && setprop vendor.ota.recovery.status 454)
else
  /vendor/bin/log -t install_recovery "Recovery image already installed" && setprop vendor.ota.recovery.status 200
fi

