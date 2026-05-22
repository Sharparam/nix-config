{
  den.aspects.ssh.provides.home = {
    homeManager = {
      programs.ssh = {
        settings = {
          router = {
            header = "Host 192.168.1.1 router.home.arpa router";
            Hostname = "router.home.sharparam.net";
            User = "sharparam";
            PasswordAuthentication = false;
          };
          switch = {
            header = "Host 192.168.1.2 switch";
            Hostname = "switch01.home.sharparam.net";
            User = "root";
            PasswordAuthentication = false;
          };
          ap = {
            header = "Host 192.168.1.3 ap";
            Hostname = "ap01.home.sharparam.net";
            User = "root";
            PasswordAuthentication = false;
          };
        };
      };
    };
  };
}
