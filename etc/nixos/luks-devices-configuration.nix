{
  boot.initrd.luks.devices = {
    cryptkey = {
      device = "/dev/DISK3";
    };

    cryptroot = {
      device = "/dev/DISK5";
      keyFile = "/dev/mapper/cryptkey";
    };

    cryptswap = {
      device = "/dev/DISK4";
      keyFile = "/dev/mapper/cryptkey";
    };
  };
}

