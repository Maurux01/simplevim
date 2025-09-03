# NixOS Installation

Installation on NixOS is preferably done declaratively using `home-manager`.

**1. Prerequisites**

Ensure you have `neovim`, `git`, and `home-manager` installed and configured on your NixOS system. You should also install the necessary language servers and formatters.

Example for `home.nix`:
```nix
{
  pkgs, ...
}:

{
  home.packages = with pkgs;
    [ 
      neovim
      git
      # For LSP and formatters
      nodejs
      python3
      lua-language-server
      pyright
      typescript-language-server
      prettier
      black
      isort
    ];
}
```

**2. Installation**

You have two options for installing simplevim on NixOS.

**Option 1: Manual (Not Recommended)**

This method clones the repository directly into your config directory. This is not the idiomatic way to manage configurations on NixOS, but it is simpler.

```bash
# Backup existing config (optional)
mv ~/.config/nvim ~/.config/nvim.backup

# Clone simplevim
git clone https://github.com/Maurux01/simplevim.git ~/.config/nvim
```

**Option 2: Declarative with home-manager (Recommended)**

This is the idiomatic "Nix way" to manage your configuration.

1.  Add this repository as an input to your flake's `flake.nix`:

    ```nix
    {
      inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        home-manager.url = "github:nix-community/home-manager";
        simplevim = {
          url = "github:Maurux01/simplevim";
          flake = false;
        };
      };
    }
    ```

2.  In your `home.nix`, use the `xdg.configFile` option to place the simplevim configuration in the correct location:

    ```nix
    {
      pkgs, inputs, ...
    }:

    {
      home.file.".config/nvim" = {
        source = inputs.simplevim;
        recursive = true;
      };
    }
    ```



After either installation method, run `nvim`. The plugins will be installed automatically on the first run.


