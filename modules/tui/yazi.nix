{
  programs.yazi = {
    enable = true;
    settings = {
      log = {
        enabled = false;
      };
      mgr = {
        show_hidden = true;
        sort_by = "mtime";
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
