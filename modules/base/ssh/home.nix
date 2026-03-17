{
  den.aspects.ssh.provides.home = {
    homeManager = {
      programs.ssh = {
        matchBlocks = {
          router = {
            host = "192.168.1.1 router.home.arpa router";
            hostname = "router.home.sharparam.net";
            user = "sharparam";
            extraOptions = {
              PasswordAuthentication = "no";
            };
          };
          switch = {
            host = "192.168.1.2 switch";
            hostname = "switch01.home.sharparam.net";
            user = "root";
            extraOptions = {
              PasswordAuthentication = "no";
            };
          };
          ap = {
            host = "192.168.1.3 ap";
            hostname = "ap01.home.sharparam.net";
            user = "root";
            extraOptions = {
              PasswordAuthentication = "no";
            };
          };
        };
      };
    };
  };
}
