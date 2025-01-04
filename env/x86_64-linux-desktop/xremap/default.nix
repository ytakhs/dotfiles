# === Setup for running without sudo ===
# https://github.com/xremap/xremap#running-xremap-without-sudo
# $ sudo gpasswd -a $USER input
# $ echo 'KERNEL=="uinput", GROUP="input", TAG+="uaccess"' | sudo tee /etc/udev/rules.d/input.rules

{ xremap-flake, ... }:
{
  imports = [
    xremap-flake.homeManagerModules.default
  ];

  services.xremap = {
    withGnome = true;

    yamlConfig = ''
      modmap:
        - name: CapsLock to ctrl
          remap:
            CapsLock: Ctrl_L
    '';
  };
}
