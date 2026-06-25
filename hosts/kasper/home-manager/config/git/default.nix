{ ... }:
{
  # Global gitignore (~/.config/git/ignore). user.name/email aren't in your
  # dotfiles — add programs.git here later if you want HM to manage them.
  xdg.configFile."git/ignore".source = ./ignore;
}
