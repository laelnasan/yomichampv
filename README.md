# Yomichampv
A simple script that enables mpv to work with Yomichan

![](https://media1.giphy.com/media/MCS5hVmcZ4JqLM28a6/giphy.gif)

## Getting Started

If you already have mpv and Yomichan installed just copy the lua script
to your mpv ``scripts`` directory.

The default key binding is 'y', the script simply copies the subtitle to
the clipboard

### Prerequisites

- mpv https://mpv.io/
- Yomichan https://foosoft.net/projects/yomichan/index.html
- [Linux/BSD/etc only] xsel or xclip, Windows and Mac are fine

### Installing

Just copy the script to the proper folder in your mpv installation. In
Unix systems it should be
```
cd ~/.config/mpv/scripts/
wget https://raw.githubusercontent.com/laelnasan/yomichampv/master/yomichampv.lua
```

## License

This project is licensed under the ISC License - see the [LICENSE.md](LICENSE.md) file for details
