{
  boot.initrd.luks.devices = {
    cryptkey = {
      device = "DISK3";
    };

    cryptroot = {
      device = "DISK5";
      keyFile = "/dev/mapper/cryptkey";
    };

    cryptswap = {
      device = "DISK4";
      keyFile = "/dev/mapper/cryptkey";
    };
  };
}

