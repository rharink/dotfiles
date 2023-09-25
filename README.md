# Dotfiles

These are my dotfiles. 

# Chezmoi

My dotfiles are managed by [Chezmoi](https://chezmoi.io)

## Init a new machine

```shell
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply rharink
```

This command will pull the rharink/dotfiles repo and run chezmoi `init` and `apply`

For setting up transitory environments (e.g. short-lived Linux containers) you
can install chezmoi, install your dotfiles, and then remove all traces of
chezmoi, including the source directory and chezmoi's configuration directory,
with a single command:

```shell
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --one-shot rharink
```

## Daily operations

### Update
You can pull the changes from your repo and apply them in a single command:

```shell
chezmoi update
```

This runs `git pull --autostash --rebase` in your source directory and then chezmoi apply.

### Update without apply
Pull the latest changes from your repo and see what would change, without actually applying the changes

```shell
chezmoi git pull -- --autostash --rebase && chezmoi diff
```

If you're happy with the changes, then you can run

```shell
chezmoi apply
```

### Update configuration

Run `chezmoi edit` to open the chezmoi dir in `$EDITOR` (nvim)

### Re-add/update config

Run `chezmoi re-add <files>` to add newer version of configuration files edited
outside of `chezmoi edit`

### Add new config

use `chezmoi add <files>` to add files to chezmoi
