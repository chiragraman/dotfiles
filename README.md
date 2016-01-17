# chiragraman does dotfiles

Your dotfiles are how you configure your system. These are mine.

After spending hours configuring my machine to my liking, I realized that the files weren't organized in a way conducive to synchronizing them across machines. A quick gander through the interwebs for pointers on a better setup led to my discovery of [Github does dotfiles](https://dotfiles.github.io/), and subsequently [Zach Holman's sweet setup](https://github.com/holman/dotfiles). This setup mimics his topical organization.

Midway through setting these up I decided to jump ship to zsh, and discovered the [Antibody](https://github.com/getantibody/antibody) bundle manager, which these now use.  

##install

Run the following commands:

```sh
git clone https://github.com/chiragraman/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
script/bootstrap
```

This will symlink the appropriate files in `.dotfiles` to your home directory.
Everything is configured and tweaked within `~/.dotfiles`.

The main file you'll want to change right off the bat is `zsh/zshrc.symlink`,
which sets up a few paths that'll be different on your particular machine.

`dot_update` is a simple script that installs some dependencies, sets sane OS X
defaults, and so on. Occasionally run `dot_update` to keep your environment fresh and up-to-date. You can find
this script in `bin/`.

##thanks

I originally started by forking [Zach Holman's repository](https://github.com/holman/dotfiles), and made updates based on [Carlos Becker's setup](https://github.com/caarlos0/dotfiles). There's a decent amount of code here that I've copied from other repositories as well, so it's pretty sweet to see people share their workflows!
