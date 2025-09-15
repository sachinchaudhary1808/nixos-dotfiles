{ config, pkgs, ... }: {
  systemd.user.services.swayidle = {
    Unit = {
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
      Requisite = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart = ''
        ${pkgs.swayidle}/bin/swayidle -w \
          timeout 300 '${pkgs.swaylock}/bin/swaylock -f -c 000000' \
          timeout 400 'systemctl suspend' \
          before-sleep '${pkgs.swaylock}/bin/swaylock -f -c 000000' \
          after-resume '${pkgs.playerctl}/bin/playerctl pause'
      '';
      Restart = "on-failure";
    };

    Install = { WantedBy = [ "graphical-session.target" ]; };
  };
}
