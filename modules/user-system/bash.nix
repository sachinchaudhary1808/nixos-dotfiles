let
  myAliases = {
    nixupdate = "sudo nixos-rebuild switch";
    u = "sudo nixos-rebuild switch --flake ~/nixos-dotfiles/";
    uf = "sudo nixos-rebuild switch --flake ~/nixos-dotfiles/ --fast";
    nixgen = "sudo nix-env -p /nix/var/nix/profiles/system --list-generations";
    ns = "nix-shell -p";
    nr = "nix run";
    v = "nvim";
    sv = "sudo nvim";
    e = "exit";
    #z
    cd = "z";
    cdi = "zi";
    gp = "git push -u origin main";
    npi = "nix profile install";
    h = "htop";
    gc = "git commit -m";
  };
in {
  programs.bash = {
    enable = true;
    enableCompletion = true;

    initExtra = ''
                   # nitch
             #      if [ -f $HOME/.bashrc-personal ]; then
              #       source $HOME/.bashrc-personal
               #    fi
      set -o vi


    '';
    bashrcExtra = ''
      export MANPAGER="$(which nvim >/dev/null 2>&1 && echo 'nvim +Man!' || echo 'less')"
    '';

    shellAliases = myAliases;
  };
}
