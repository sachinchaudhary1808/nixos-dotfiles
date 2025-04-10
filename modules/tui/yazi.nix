{
  programs.yazi = {
    enable = true;
    settings = {
      log = {
        enabled = false;
      };
      manager = {
        show_hidden = true;
        sort_by = "modified";
        sort_dir_first = true;
        sort_reverse = true;
      };
      opener = {
        edit = [
          {
            run = "direnv exec . $EDITOR $1";
            desc = "$EDITOR";
            block = true;
            for = "unix";
          }
        ];
      };
    };
  };
}
#
# [opener]
# edit = [
# { run = "direnv exec . ${EDITOR} $1", desc = "$EDITOR", block = true, for = "unix" },
# ...
# ]
