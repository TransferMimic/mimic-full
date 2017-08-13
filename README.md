# Full mimic

## Dependencies:

### Linux

##### On Debian/Ubuntu
```
sudo apt-get install gcc make pkg-config libasound2-dev python3-pip ninja-build
pip3 install --user meson
```

##### On Fedora
```
sudo dnf install gcc make pkgconfig alsa-lib-devel python3-pip ninja-build
pip3 install --user meson
```

##### On Arch
```
sudo pacman -S --needed install gcc make pkg-config alsa-lib python-pip ninja
pip3 install --user meson
```

### Mac OSX

- Install *Brew*
  ```
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  ```

- Install *python3*, *ninja*, *pkg-config*, *pcre2* and *PortAudio*
  ```
  brew install python3 ninja pkg-config pcre2 portaudio
  pip3 install --user meson
  ```


### Installation instructions

```
git clone https://github.com/zeehio/mimic-full.git
cd mimic-full
git submodule update --init
meson builddir --prefix="$PWD/install_dir"
ninja -C builddir test install
```

