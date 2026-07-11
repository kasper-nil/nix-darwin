---
description: Look up a nix-darwin option (offline, pinned to this flake)
---

Look up the nix-darwin option(s) matching `$ARGUMENTS` using the repo's offline,
pinned option database:

```sh
./bin/nix-option "$ARGUMENTS"
```

This greps the nix-darwin `options.json` built from **this flake's exact pinned
revision**, so it can't invent an option that doesn't exist in the installed
version. Report the name, type, default, and description for the matches.

If the query is about a **home-manager** option or whether a **nixpkgs package**
exists, use the `nixos` MCP server instead (its `nix` tool — action `options`
with source `home-manager`, or action `search`).
