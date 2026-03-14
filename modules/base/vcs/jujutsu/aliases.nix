{
  den.aspects.base = {
    homeManager = {
      home.shellAliases =
        let
          jj = "jj";
        in
        {
          jb = "${jj} bookmark";
          jba = "${jj} bookmark advance";
          jbc = "${jj} bookmark create";
          jbd = "${jj} bookmark delete";
          jbf = "${jj} bookmark forget";
          jbl = "${jj} bookmark list";
          jbm = "${jj} bookmark move";
          jbr = "${jj} bookmark rename";
          jbs = "${jj} bookmark set";
          jc = "${jj} commit";
          jci = "${jj} commit --interactive";
          jcm = "${jj} commit --message";
          jd = "${jj} describe";
          jdm = "${jj} describe --message";
          je = "${jj} edit";
          jg = "${jj} git";
          jgf = "${jj} git fetch";
          jgp = "${jj} git push";
          jl = "${jj} log";
          jn = "${jj} new";
          jr = "${jj} rebase";
          js = "${jj} show";
          jsq = "${jj} squash";
          jst = "${jj} status";
          jt = "${jj} tag";
          jw = "${jj} workspace";
        };
      programs.jujutsu.settings.aliases = {
        d = [ "diff" ];
        s = [ "show" ];
        ll = [
          "log"
          "--template"
          "builtin_log_detailed"
        ];
        tug = [
          "bookmark"
          "advance"
        ];
      };
    };
  };
}
