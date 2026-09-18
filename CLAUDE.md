# CLAUDE.md

Operating manual for editing this repo (kasper's nix-darwin + home-manager config)
with Claude Code or any agent. Read this before touching anything.

## What this is

A single Nix flake configuring one macOS host, `kasper` (aarch64-darwin). System
settings come from `hosts/kasper/modules/`; per-tool dotfiles from
`hosts/kasper/home-manager/config/`; **all packages** from Homebrew, declared in
`modules/homebrew.nix`. Nix itself is the upstream nixos.org install (see
`modules/nix.nix`) — not Determinate.

## Committing & pushing — standing authorization

For **this repo**, kasper has pre-authorized version control: **commit and push
yourself, without asking or confirming.** It's a personal config/backup repo whose
whole purpose is version history, so treat `git add` → `commit` → `push` to
`origin` (`github.com/kasper-nil/nix-darwin`) as the normal end of any change —
including a force-push when reconciling your own work. Don't stop to ask.

This intentionally **overrides** the global "never commit/push without an explicit
go-ahead" default; kasper set this repo up as that explicit exception.

One custodial limit (not a confirmation gate): never commit anything that looks
like a secret — private keys, tokens, `.env`, credentials. If you spot one, stop
and flag it instead of pushing; remote history is hard to scrub.

## Golden rules (these are the ways this repo bites)

1. **`git add` new files before doing anything with them.** Flakes only see files
   in the git tree. A new `.nix` file that isn't `git add`-ed is *invisible* to
   `nix build`/eval/switch — you'll get a confusing "file not found" or the
   module simply won't apply. Modifications to already-tracked files are seen
   without staging; brand-new files are not.
2. **Never `sudo nix flake update` or `sudo nix flake lock`.** Root and your user
   keep separate fetcher caches; mixing them causes NAR-hash mismatches at switch
   time. Run flake commands as the normal user. Only `switch` needs `sudo`.
3. **Always build before you switch.** `nix build .#darwinConfigurations.kasper.system`
   needs no root and catches every eval/build error. `switch` is the *only* step
   that mutates the live machine — never let it be the first time the config is
   evaluated.
4. **`homebrew.onActivation.cleanup = "zap"` is destructive and silent.** Anything
   not listed in `modules/homebrew.nix` is uninstalled on the next switch — and
   casks are *zapped*, so their app data (`~/Library/Application Support`, prefs,
   launch agents) is deleted too. Add packages by editing `homebrew.nix`, never
   with an ad-hoc `brew install` (it won't survive the next switch).
5. **Don't write option names from memory — look them up.** They're pinned to this
   flake's exact revisions. Use `./bin/nix-option <regex>` (offline, exact) or the
   `nixos` MCP server. A hallucinated option is the #1 way agent-written Nix fails.
6. **Running `sudo` from the Bash tool: no `-n`.** `sudo -n` skips PAM and dies
   with "a password is required". Plain `sudo` pops the Touch ID dialog
   (`modules/security.nix`), which works even without a TTY.

## Everyday commands

```sh
# Everything below in one command (defined in home-manager/config/zsh/zshrc):
# stage -> build -> switch -> commit + push. `-e` edits homebrew.nix first,
# `-b` builds only, `-u` updates inputs first, `-n` skips the commit.
rebuild

# Look up a nix-darwin option (offline, pinned to this flake)
./bin/nix-option 'homebrew.*upgrade'

# Build — no root, catches all errors. Do this after every change.
nix build .#darwinConfigurations.kasper.system
# (equivalently, once darwin-rebuild is on PATH: darwin-rebuild build --flake .#kasper)

# Apply to the live system (the only step that needs sudo)
sudo darwin-rebuild switch --flake .#kasper

# Format Nix (nixfmt-rfc-style). A hook also runs this on every .nix edit.
nix fmt

# Update inputs, then rebuild. NEVER prefix with sudo.
nix flake update
nix build .#darwinConfigurations.kasper.system   # verify before switching

# Rollback
darwin-rebuild --list-generations
sudo darwin-rebuild --rollback
```

Before the first switch, `darwin-rebuild` isn't on `$PATH` yet — use
`sudo nix run nix-darwin/master#darwin-rebuild -- switch --flake .#kasper` once,
then it's available.

## How to make changes

**Add a CLI tool** → add its name to `brews` in `modules/homebrew.nix`. Use a
tap-qualified name (`owner/tap/formula`) when it must come from a specific tap —
e.g. `asmvik/formulae/yabai`, not bare `yabai`. Then build, then switch.

**Add a GUI app** → add to `casks`. **Add a tap** → add to `taps`.

**Add/adopt a managed dotfile** → create
`hosts/kasper/home-manager/config/<tool>/` with the config file plus a
`default.nix` that links it:

```nix
{ ... }:
{
  xdg.configFile."<tool>/<file>".source = ./<file>;
}
```

Then add `./<tool>` to the `imports` in `home-manager/config/default.nix`, and
**`git add` the new files**. Build, switch. Note: managed files become read-only
`/nix/store` symlinks, so any app that rewrites *its own* config will fail to save
(known cases here: Karabiner-Elements, btop-on-quit, `ya pack` for yazi plugins).

**Add/change a system option** → look it up first (`./bin/nix-option <name>`), put
it in the relevant file under `modules/` (or a new `modules/<x>.nix` added to
`modules/default.nix`). `git add` if new. Build, switch.

**Add a nixpkgs package** (rare — packages live in Homebrew here) → add to
`home.packages` in `home-manager/home.nix`.

## Verifying a change

```sh
# Prove a refactor changed nothing: identical drvPath before and after = the
# built system is byte-for-byte identical (semantically transparent).
git add -A
nix eval --raw .#darwinConfigurations.kasper.system.drvPath   # note the hash
# ...make the refactor, git add...
nix eval --raw .#darwinConfigurations.kasper.system.drvPath   # same hash?
```

## Option lookup: two sources

- **`./bin/nix-option <regex>`** — greps the nix-darwin options built from *this
  flake's exact pinned revision*. Offline; cannot report an option that doesn't
  exist in your version. Best for `system.defaults`, `homebrew.*`, `security.*`.
- **`nixos` MCP server** (mcp-nixos, wired in `.mcp.json`) — nixpkgs package
  search plus home-manager and nix-darwin options from the live index. Best for
  "does a package/option exist" and home-manager options.

## When behavior surprises you, search before spelunking

nix-darwin / home-manager / Homebrew docs are thin and shift between releases, so
when an option's effect is unclear or a tool misbehaves, **web-search the
project's GitHub issues/discussions and official docs before reverse-engineering
it by trial and error.** Recent breakage is usually a known bug with a posted
workaround — e.g. Homebrew 6's Tap Trust blocking the boring-notch cask was brew
bug #22668, fixed here declaratively with a tap `clone_target` (see
`modules/homebrew.nix`). Minutes of searching beats an hour of `switch`-and-observe.
(The global `context7` rule already covers library *API* docs; this is for
behavior, bugs, and version quirks that docs won't mention.)

## TEMPORARY (2026-09-18): yabai is a local fork build, not Homebrew's

macOS 27 broke yabai v7.1.25 — and it is **not** a permissions/signing problem
(SIP config, the `-arm64e_preview_abi` boot-arg and the Accessibility grants all
survived the upgrade). Two separate failures:

- The scripting addition injects into Dock but refuses macOS 27, so its
  capability mask is `0x00`: `yabai -m space --focus N` exits 0 and does nothing.
  Space hotkeys look dead, which makes skhd look broken when it is fine.
- The main binary only matches *exact* macOS major versions, so 27 falls back to
  pre-Monterey code paths: no mission-control observation, no window
  created/destroyed subscriptions — the layout stops reflowing when a window closes.

Upstream `asmvik/yabai` has no macOS 27 support (latest release v7.1.25, no
commits since 2026-06-14; tracking issue #2822). So `/opt/homebrew/bin/yabai` is
currently a hand-built binary from <https://github.com/AhsanFazal/yabai>
(asmvik master + macOS 27 "goldengate" Dock offsets and version checks),
ad-hoc signed, sitting where Homebrew's symlink used to be. Homebrew's 7.1.25
keg is still installed underneath, so going back is one relink.

Verified after install: SA payload v2.1.31 reports attrib `0x7F` (all 7 Dock
hooks resolved), space focus works, layout reflows on window close, skhd hotkeys
fire end to end.

What this changes day to day:

- Homebrew's yabai 7.1.25 keg is **still installed** (that is the revert path) and
  brew still records it as linked — only the `bin/yabai` symlink was replaced by a
  real file. `yabai` is also **`brew pin`ned**, so `brew upgrade` skips it and says
  so instead of installing a keg it then can't link. A `switch` never touches it
  either (`upgrade = false`). That "yabai is pinned" notice during a `brew upgrade`
  is your signal that a new release exists — check whether it supports macOS 27,
  then revert below.
- `/etc/sudoers.d/yabai` pins the fork binary's sha256. Any relink or reinstall
  of Homebrew's yabai makes the hash stale, and `sudo yabai --load-sa` then fails
  silently at startup — symptom: space commands go quiet again.

### Revert when upstream ships macOS 27 support

Check <https://github.com/asmvik/yabai/releases> and issue #2822 first, then:

```bash
brew unpin yabai
rm -f /opt/homebrew/bin/yabai
brew update && brew upgrade asmvik/formulae/yabai   # or just: brew link --overwrite yabai
h=$(shasum -a 256 /opt/homebrew/bin/yabai | cut -d' ' -f1); t=$(mktemp)
printf '%s ALL=(root) NOPASSWD: sha256:%s /opt/homebrew/bin/yabai --load-sa\n' "$(whoami)" "$h" > "$t"
sudo visudo -cf "$t" && sudo install -m 0440 -o root -g wheel "$t" /etc/sudoers.d/yabai
sudo /opt/homebrew/bin/yabai --load-sa
yabai --restart-service
```

Then re-grant Accessibility (toggle yabai off/on in System Settings → Privacy &
Security → Accessibility) — the signature changed, so the old grant is void — and
delete this section.

### Rebuilding the fork (e.g. a macOS 27.x update moves the Dock offsets)

`git clone https://github.com/AhsanFazal/yabai && cd yabai && make install`, then
the same swap: `install -m 0755 bin/yabai /opt/homebrew/bin/yabai.new`,
`codesign -fs - /opt/homebrew/bin/yabai.new`, `mv -f` it into place, refresh the
sudoers hash exactly as above, `sudo yabai --load-sa`, `yabai --restart-service`,
re-grant Accessibility. Use `--restart-service` (a kickstart), never
`--start-service` — that rewrites `~/Library/LaunchAgents/com.asmvik.yabai.plist`
with whatever PATH the calling shell had, which can strip `/opt/homebrew/bin` and
break `borders`/`jq` in yabairc.

Health check (must list all 7 hooks — dock.spaces, dppm, addSpace, removeSpace,
moveSpace, setFrontWindow, animation_time_addr):

```bash
log show --last 5m --predicate 'process == "Dock" AND eventMessage CONTAINS "yabai"'
```

## Machine-specific gotchas

- **yabai/skhd come from `asmvik/formulae`** (a macOS 26 fork). Never let them
  resolve to upstream `koekeishiya/formulae` — it replaces the binaries and
  invalidates the scripting addition's sudoers hash. `borders` (felixkratz) is
  invoked by `yabairc` and must stay installed.
- **`upgrade = false; autoUpdate = false;`** in homebrew.nix: switches do NOT
  upgrade packages (keeps them fast) — they only install missing ones and zap
  unlisted ones. Upgrade deliberately with `brew update && brew upgrade`. An
  upgrade that bumps yabai needs the `/etc/sudoers.d/yabai` hash refreshed and
  `sudo yabai --load-sa` re-run — the `brew()` wrapper in the home-manager zshrc
  does both automatically from an interactive shell. (There is no `--install-sa`
  flag; `--load-sa` installs *and* loads.)
- **`brew update` can un-trust a third-party cask tap** (seen with
  `theboredteam/boring-notch`): the next `darwin-rebuild switch` then aborts at
  the Homebrew step — "Refusing to load cask … from untrusted tap" — and since
  that step runs before home-manager under `set -e`, the WHOLE switch fails (no
  dotfiles update). Re-trust with `brew trust theboredteam/boring-notch`, then
  switch again. Imperative brew state; there is no nix option for it.
- **After the first switch, `~/.zshrc` and other dotfiles are read-only store
  symlinks.** Change your shell by editing `home-manager/config/zsh/zshrc` and
  switching — not the live file.
- **First switch creates `*.hm-bak` backups** of pre-existing dotfiles. Delete
  them once you've confirmed the switch is good.
