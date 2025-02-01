### Rust Examples

Official compiler with rustup: [Rust](https://www.rust-lang.org/)

Rustup Installation on Arch Linux:
```
sudo pacman -Syu
sudo pacman -S rustup
```

Installation of the most recent and stable version of Rust:
```
rustup install stable
```

Setting environment variable:
```
export PATH="$HOME/.cargo/bin:$PATH"
```

Add the export to the end of the .bashrc file and save it:
```
nano ~/.bashrc
```

Update configuration file:
```
source ~/.bashrc
```

Check Rust version:
```
rustc --version
```


Compilation and execution:
```
$ rustc filename.rs
./filename
```
