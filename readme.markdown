# Welcome to VimStar! 

This is a NeoVim/Vim  distribution optimized for *writing*. Colors and fonts (in GUI mode) are a homage to WordStar. 

## Quick Guide: 

1.  There's a pull down menu. In normal mode, hit the space bar twice to see the functions. These will grow over time. 

2.  There are WordStar-like key bindings with helpful menus. Instead, however, of the Ctrl key, they're prefixed with Space instead, to avoid collision with Vim keys (such as Ctrl-o). See Space-k, Space-o, Space-q, and Space-g. 

3.  Plugins provided by VimPlug, and should be downloaded automatically after installing. 

4.  Configuration is symlinked, so you can try VimStar and then easily go back to your own configuration (have a look at the install script). 

Function keys are somewhat a homage to WordPerfect: 

**F3:** File browser. 

**F4:** In a GUI, go to Focus Mode. 

**F5:** Run Latexmk to produce a document out of your LaTeX. 

**F8:** Preview your Markdown files. 

**F9:** Toggle between word processor and Code mode. Changes the screen background so you can always tell which mode you're in. 

## Installation

Execute this at the CLI: 

```bash
curl -sLf https://raw.githubusercontent.com/sez11a/VimStar/master/install-vimstar.sh | bash
```

## Screenshots

![VimStar starts with a most recently used files list.](./vimstar-1.png)

![Markdown files are the default format in VimStar.](./vimstar-2.png)

That's all for now. Enjoy!
