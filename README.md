# dot-files

Some of my configuration files. See [this comprehensive list](http://dotfiles.github.io/) for other offerings.

## installation

Quick start (assumes [GNU Stow](http://www.gnu.org/software/stow/) is already installed; see below):

```bash
cd
git clone https://github.com/zackse/dot-files.git
cd dot-files

# install all:
stow --no-folding */

# or selected:
stow --no-folding bash python vim  # etc.
```

This repo is arranged for the use of [GNU Stow](http://www.gnu.org/software/stow/) for management/installation. You can install `stow` with your package manager. For example:

- `apt-get install stow`
- `brew install stow`

The `stow` command will create symlinks in the parent directory of the repo by default, meaning it expects this repository to be installed in `$HOME/dot-files`, for example. If you clone this repo to a different location, change to that directory, then run `stow` with the `-t` argument to target your home directory:

```bash
cd /path/to/dot-files
stow --no-folding -t ~ bash vim  # etc.
```

Each subdirectory of this repo is a [package](https://www.gnu.org/software/stow/manual/stow.html#Terminology) to be installed, meaning it contains files and/or directories that will be installed via symlinks. The `--no-folding` argument is necessary if you plan to put other stow-managed files into any subdirectories. For example, I have `bash/.bashrc.d/work` and `bash/.bashrc.d/personal` in another repo, and to install those alongside the files in this repo, it's necessary to prevent `stow` from [folding directories](https://www.gnu.org/software/stow/manual/stow.html#tree-folding).

## further reading

- http://dotfiles.github.io/
- http://codyreichert.github.io/blog/2015/07/07/managing-your-dotfiles-with-gnu-stow/
- https://taihen.org/managing-dotfiles-with-gnu-stow/
- https://alexpearce.me/2016/02/managing-dotfiles-with-stow/
