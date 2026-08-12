---
layout: single
title: "WordStar"
permalink: /writing/wordstar/
sidebar:
  nav: "main"
toc: true
---

VimStar takes its inspiration from WordStar, a decades-old word processor first written for CP/M and then DOS in the 1980s. Neovim itself derives from Vim, which was written originally in the 1980s for the Commodore Amiga and then ported to Linux. Clearly, if both Vim and WordStar still have an influence when they were invented in the 80s, there's something to them. One might ask the question first: why Neovim, and second: why WordStar?  

The answer: speed. Modern systems are great for novices. They offer a nice, visual interface for commanding the system through point and click, dialog boxes, rows of icons, and more. The keyboard is used solely for typing. Vim and WordStar (and thus VimStar) offer a keyboard-only interface. Whether you use the DOS, Amiga, or Linux CLI, you do *nothing* with the mouse. For touch typists, this means speed, speed, speed. At some point, novices *must* graduate from the point and click to the keyboard interface and take their places as experts. For more on this, see [VimStar: A Writer's Word Processor](/vimstar-a-writers-wordprocessor/). 

There are [great](https://www.vim-hero.com) [tutorials](https://openvim.com/) out there for Vim already, so I commend you to them. As for WordStar, I only recommend trying to run it for research purposes, to see where VimStar gets its influences. You can try in your browser a version of WordStar that's older than the one I used [here](https://nampara-ai.github.io/wordstar/). Your other options are to get Robert J. Sawyer's [WordStar archive](https://sfwriter.com/ws7.htm) running in a DOS emulator, or try the alpha quality [WordTsar](https://wordtsar.ca/) clone. 

VimStar is influenced by WordStar in several ways: 

- It adopts the WordStar block commands. These are unique to WordStar and aren't found in any other software I know about (other than clones like [WordTsar](https://wordtsar.ca/) or [Joe's Own Editor](https://joe-editor.sourceforge.io/)). 
- It adds WordStar movement keys in Vim's Insert mode. This makes Vim a little easier to adopt, and it supports the WordStar die hards' muscle memory. 
- It organizes its menu system the way WordStar did, which you'll find is quite intuitive. 

# Block Commands 

WordStar's block commands are legendary for writers. They're probably the main reason some writers have stuck with WordStar for so long. Nothing else, including Vim and Neovim, has had them, until now. These block commands are implemented in VimStar. They're clearly designed for someone who is creating, not editing, at the keyboard. Once you start using them, you'll likely prefer them.

In VimStar, you can use the WordStar block commands in concert with Vim's regular block highlighting (i.e., Visual mode) and registers.  

Every other editor expects you to mark a block and then do something with that block immediately. That's not how VimStar's block commands work. You can mark the beginning of a block (`Space-kb`) and then go keep writing elsewhere in the document. If you decide later that you want the beginning of the block somewhere else, you mark that spot (`Space-kb` again), and the beginning marker moves there. Once you figure out where the end of the block should go, mark that (`Space-kk`), and the block is highlighted. 

At that point, you still don't have to do anything with the block. You can go write or edit in the document somewhere else. The block stays marked. When you figure out where you want that block to go, a command moves (`Space-kv`) or copies (`Space-kc`) it to the cursor location. If you want to bounce back to where the block was moved from, you can (`Space-qv`). 

VimStar, as WordStar did, stores two blocks this way. If you have a block marked, you can mark another one. Once the second block is marked, you can switch back and forth between the two blocks (`Space-ku`) to perform operations on them (i.e., copying or moving).

These block operations make sense when the use case is creating and editing at the keyboard. Sometimes you realize your brain jumped ahead, and you wrote something that doesn't belong where it is. You may not know where it's supposed to go yet---in fact, you may not even have yet written the passage where it's supposed to go. You can mark that block and keep going. 

Most editors use their block commands not only for moving text around, but also for formatting with bold and italics and such. These commands are not for that; they're for *editing* the text: moving it, shaping it, carving it into what it should be. 

When you want to format the text in VimStar, use the regular Visual mode commands---for example, hit `v` to go to visual mode, highlight some text, and then hit `S` for Surround, and then `*` for italics (in Markdown). These existing Vim commands are perfect for operations like those, when you know exactly what you want to do with the text you're highlighting. When you want to *edit* the text---move it, shape it---use the WordStar-inspired block commands.

# Movement

WordStar (and thus VimStar in Insert mode) organizes its movement keys differently from Vim, in what's called the WordStar diamond: 

|  |E | | 
| --------------- | --------------- | --------------- | 
| S |  | D | 
|  | X |  | 

While in Insert mode, you can access these keys via the Ctrl key, so Ctrl-E moves the cursor up, Ctrl-S moves the cursor to the left, Ctrl-D moves the cursor to the right, and Ctrl-X moves the cursor down. 

Various other commands expand the diamond. Ctrl-F (next to the D) moves the cursor one word to the right; Ctrl-A moves the cursor one word to the left. WordStar expanded this further, by implementing page up and page down via Ctrl-R and Ctrl-C, but that's not implemented in VimStar. 

In Neovim's Normal mode, WordStar's other movement commands appear in the Q menu (`Space-q`) in VimStar. 

# Menu System 

Vim (and Neovim) by themselves have no menu system at all. One of the common criticisms of Vim is how unapproachable it is for newcomers. VimStar aims to change that by implementing a menu system mirrored from WordStar. 

I came to WordStar later than most, so both the versions I used (version 6.0 and version 7.0d) had pull-down menus. VimStar doesn't emulate those; instead, along with menus of its own that cover features the WordStar people could never have predicted (i.e., Git), it emulates the classic WordStar menus: 

- Block and Save (`Space-k`)
- Onscreen Format (`Space-o`)
- Print Controls (`Space-p`) 
- Quick Menu (`Space-q`) 

As WordStar was modeless, these menus were accessed via the Control key on the keyboard; VimStar implements them in Normal mode via the space bar. The Block and Save menu particularly should help those who are new to Vim perform basic functions such as saving a file or exiting VimStar, freeing them from the famous "exit Vim" meme. 

VimStar adds these menus for functions WordStar didn't have: 

- Debug (`Space-d`), for debugging code
- Code (`Space-c`), for AI integration features
- Java (`Space-j`), for Java-specific functions
- Wiki (`Space-w`), for Wiki functions
- Find (`Space-f`), for various Telescope and find functions
- Git (`Space-g`), for various Git functions

The goal for VimStar is to provide the best writing and editing environment possible for text and code alike by combining the functionality of two of the best editors that have ever existed. 
