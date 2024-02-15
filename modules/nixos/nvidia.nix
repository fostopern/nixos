{config, pkgs, ...}:
{
  
  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.beta;
    prime   = {
      offload.enable = true;        # Enable PRIME offloading
      intelBusId     = "PCI:0:2:0"; # lspci | grep VGA | grep Intel
      nvidiaBusId    = "PCI:1:0:0"; # lspci | grep VGA | grep NVIDIA
    };
  };
  services.xserver.videoDrivers = [ "nvidia" ]; 
}
