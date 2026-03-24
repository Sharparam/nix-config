{ lib, ... }:
let
  rubyAliases = {
    rb = "ruby";
    rbbc = "bundle clean";
    rbbe = "bundle exec";
    rbbi = "bundle install";
    rbbl = "bundle list";
    rbbo = "bundle open";
    rbbp = "bundle package";
    rbbu = "bundle update";
  };

  railsAliases = {
    ror = "bundle exec rails";
    rorc = "bundle exec rails console";
    rordc = "bundle exec rails dbconsole";
    rordm = "bundle exec rake db:migrate";
    rordM = "bundle exec rake db:migrate db:test:clone";
    rordr = "bundle exec rake db:rollback";
    rorg = "bundle exec rails generate";
    # requires prezto function
    # rorl = "tail -f \"$(ruby-app-root)/log/development.log\"";
    rorlc = "bundle exec rake log:clear";
    rorp = "bundle exec rails plugin";
    rorr = "bundle exec rails runner";
    rors = "bundle exec rails server";
    rorsd = "bundle exec rails server --debugger";
    rorx = "bundle exec rails destroy";
  };
in
{
  den.aspects.base = {
    homeManager = {
      home.shellAliases = lib.mkMerge [
        rubyAliases
        railsAliases
      ];

      # `>>!` is zsh-specific
      programs.zsh.initContent = lib.mkAfter ''
        alias rbbI='rbbi \
          && bundle package \
          && print .bundle       >>! .gitignore \
          && print vendor/assets >>! .gitignore \
          && print vendor/bundle >>! .gitignore \
          && print vendor/cache  >>! .gitignore'
      '';
    };
  };
}
