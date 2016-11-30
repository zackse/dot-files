# dot-files

Some of my configuration files. See [this comprehensive list](http://dotfiles.github.io/) for other offerings.

## installation

Quick start (assumes GNU Stow is already installed; see below):

```bash
cd
git clone https://github.com/zackse/dot-files.git
cd dot-files
stow bash python vim  # etc.
```

This repo is arranged for the use of [GNU Stow](http://www.gnu.org/software/stow/) for management/installation. You can install `stow` with your package manager. For example:

- `apt-get install stow`
- `brew install stow`

The `stow` command will create symlinks in the parent directory of this repo by default, meaning it expects to be located under `$HOME/dot-files`. If you clone this repo to a different location, change to that directory, then run `stow` with the `-t` argument to target your home directory:

```bash
cd /path/to/dot-files
stow -t ~ bash # ...
```

Each subdirectory of this repo is a "package" to be installed, meaning it contains files and/or directories that will be installed via symlinks.

## further reading

- http://dotfiles.github.io/
- http://codyreichert.github.io/blog/2015/07/07/managing-your-dotfiles-with-gnu-stow/
- https://taihen.org/managing-dotfiles-with-gnu-stow/
- https://alexpearce.me/2016/02/managing-dotfiles-with-stow/
