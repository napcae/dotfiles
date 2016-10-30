[![Build Status](https://travis-ci.org/napcae/dotfiles.svg?branch=butterfinger)](https://travis-ci.org/napcae/dotfiles)

# Dotfiles

My OS X / Ubuntu dotfiles.

These dotfiles are forked from "Cowboy" Ben Alman

## What, exactly, does the "dotfiles" command do?

It's really not very complicated. When [dotfiles][dotfiles] is run, it does a few things:

1. Git is installed if necessary, via APT or Homebrew (which is installed if necessary).
2. This repo is cloned into the `~/.dotfiles` directory (or updated if it already exists).
2. Files in `init` are executed (in alphanumeric order).
3. Files in `copy` are copied into `~/`.
4. Files in `link` are linked into `~/`.

Note:

* The `backups` folder only gets created when necessary. Any files in `~/` that would have been overwritten by `copy` or `link` get backed up there.
* Files in `bin` are executable shell scripts ([~/.dotfiles/bin][bin] is added into the path).
* Files in `source` get sourced whenever a new shell is opened (in alphanumeric order)..
* Files in `conf` just sit there. If a config file doesn't _need_ to go in `~/`, put it in there.
* Files in `caches` are cached files, only used by some scripts. This folder will only be created if necessary.

## Installation
### OS X
Notes:

* You need to be an administrator (for `sudo`).
* You need to have installed [XCode Command Line Tools](https://developer.apple.com/downloads/index.action?=command%20line%20tools), which are available as a separate, optional (and _much smaller_) download from XCode.

```sh
bash -c "$(curl -fsSL https://raw.github.com/napcae/dotfiles/master/bin/dotfiles)" && source ~/.bashrc
```

### Ubuntu
Notes:

* You need to be an administrator (for `sudo`).
* If APT hasn't been updated or upgraded recently, it will probably be a few minutes before you see anything.

```sh
sudo apt-get -qq update && sudo apt-get -qq upgrade && sudo apt-get -qq install curl && echo &&
bash -c "$(curl -fsSL https://raw.github.com/napcae/dotfiles/master/bin/dotfiles)" && source ~/.bashrc
```

## The "init" step
These things will be installed, but _only_ if they aren't already.

### OS X
* Homebrew
  * git
  * tree
  * curl
  * lesspipe
  * irssi
  * screen
  * nmap
  * git-extras
  * htop-osx
  * mobile-shell
  * youtube-dl
  * lynx
  * autojump
  * ack

### Ubuntu
* APT
  * build-essential
  * libssl-dev
  * git-core
  * tree
  * nmap
  * telnet
  * htop

### Both
* Nave
  * Npm (latest stable)
    * Grunt
    * JSHint
    * Uglify-JS
* Rbenv
  * Ruby 1.9.3-p194 (default)
  * Ruby 1.9.2-p290 (default)
* Ruby Gems
  * bundler
  * awesome_print
  * interactive_editor

## The ~/ "copy" step
Any file in the `copy` subdirectory will be copied into `~/`. Any file that _needs_ to be modified with personal information (like [.gitconfig](https://github.com/cowboy/dotfiles/blob/master/copy/.gitconfig) which contains an email address and private key) should be _copied_ into `~/`. Because the file you'll be editing is no longer in `~/.dotfiles`, it's less likely to be accidentally committed into your public dotfiles repo.

## The ~/ "link" step
Any file in the `link` subdirectory gets symbolically linked with `ln -s` into `~/`. Edit these, and you change the file in the repo. Don't link files containing sensitive data, or you might accidentally commit that data!

## Aliases and Functions
To keep things easy, the `~/.bashrc` and `~/.bash_profile` files are extremely simple, and should never need to be modified. Instead, add your aliases, functions, settings, etc into one of the files in the `source` subdirectory, or add a new file. They're all automatically sourced when a new shell is opened. Take a look, I have [a lot of aliases and functions](https://github.com/cowboy/dotfiles/tree/master/source). I even have a [fancy prompt](https://github.com/cowboy/dotfiles/blob/master/source/50_prompt.sh) that shows the current directory, time and current git/svn repo status.

## Scripts
In addition to the aforementioned [dotfiles][dotfiles] script, there are a few other [bash scripts][bin]. This includes [ack](https://github.com/petdance/ack), which is a [git submodule](https://github.com/cowboy/dotfiles/tree/master/libs).

* [dotfiles][dotfiles] - (re)initialize dotfiles. It might ask for your password (for `sudo`).
* [src](https://github.com/cowboy/dotfiles/blob/master/link/.bashrc#L6-15) - (re)source all files in `source` directory
* Look through the [bin][bin] subdirectory for a few more.


## License
Copyright (c) 2012 "Cowboy" Ben Alman  
Licensed under the MIT license.  
<http://benalman.com/about/license/>
