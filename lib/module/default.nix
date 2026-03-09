_: {
  enabled = {
    ## Quickly enable an option.
    ##
    ## ```nix
    ## services.nginx.enable = true;
    ## ```
    ##
    #@ true
    enable = true;
  };

  disabled = {
    ## Quickly disable an option.
    ##
    ## ```nix
    ## services.nginx.enable = true;
    ## ```
    ##
    #@ false
    enable = false;
  };
}
