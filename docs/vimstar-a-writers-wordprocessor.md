---
layout: single
title: "VimStar: A Writer's Word Processor"
description: "Homage to Robert J. Sawyer's WordStar Essay"
permalink: /vimstar-a-writers-wordprocessor/
sidebar: 
  nav: "main"
toc: true
---

*This essay is a respectful homage to Robert J. Sawyer's* WordStar: A Writer's Word Processor, *which you can find [here](https://sfwriter.com/wordstar.htm).*

I'm sure there are many writers---besides myself---who want VimStar as our writing tool of choice; they just don't know about it yet. Many Vim and Neovim users have endured years of criticism for using a tool meant for developers and with such a steep learning curve as Vim and Neovim, who have never tried it. I've used VSCode, Emacs, JEdit, and a host of word processors (including Microsoft Word), and VimStar is *by far* my favorite choice for creative composition at the keyboard. 

That's the key point: *aiding creative composition*. VimStar shines there, by adding onto the already fantastic foundation Neovim gives developers for code. To understand how VimStar does that better than other programs, let me start with a little history. 

# An Interface Designed for Touch Typists

Vi (the progenitor of both Vim and Neovim) was written by Bill Joy in 1976 (two years before WordStar), before there was any standardization in computer keyboards. Some even lacked such keys as `Tab`, `Insert`, `Delete`, `Backspace`, and `Enter`. 

About all you could count on was having a standard QWERTY typewriter layout of alphanumeric keys, a `Control` key, and an `Esc` key. This required the editor to have *modes*. Normal mode uses the keyboard to navigate around the document, using the keys on the home row. Press `i` to enter Insert mode, where you can type into the document, and press `Esc` to go back to Normal mode to move around the document. Pressing `:` brings you to Command mode, where you can type commands. Vim and Neovim added Visual mode, for selecting text. 

WordStar's original designers, Seymour Rubinstein and Rob Barnaby, selected five `Control` key sequences to be prefixes for bringing up additional menus of functions. These are implemented in VimStar as `Space` key sequences in Normal mode: `Space-o` for On-screen functions; `Space-q` for Quick cursor functions; `Space-p` for Print functions; and `Space-k` for block and file functions. 

Now, the first three of these are alphabetically mnemonic. The last one, `Space-k`, might at first glance seem to be an arbitrary choice. It isn't. Look at a keyboard. You'll see that for a touch typist, the strongest finger of the right hand rests over `k` on the home typing row. VimStar, as WordStar did, recognizes that the most-often-used functions should be the easiest physically to execute. 

But VimStar also isn't WordStar. To serve as arrow keys for moving the cursor up, left, right, or down, Vi adopted Normal mode's `h` (left), `j` (down), `k` (up), and `l` (right). Again, looking at a keyboard makes the logic of this plain. These four keys are arranged in a row under the right hand's strongest fingers. 

Such positional and alphabetic mnemonics form a large start of the Neovim interface. Additional cursor movements are modified by adding numbers. For example, in Normal mode typing `5k` moves the cursor up five lines. Pressing `w` moves the cursor forward word by word. Pressing `b` moves it back word by word. Pressing `5w`, therefore, moves the cursor forward by five words. Type `0` to move to the beginning of a line. Type `$` to move to the end of a line. You move the cursor simply by typing. But you can do more. 

Normal mode also has commands, and these commands can be combined with movement to achieve powerful things. The `c` command is for changing text. So typing `cw` changes a word: it removes what's under the cursor to the next space and drops you into Insert mode so you can type the new word. You can add an `i` (for Inner) to this, and the whole word is removed before you enter Insert mode to change it. You can combine this with other movement commands; for example, typing `c2w` (or `c2iw`) removes *two* words and then drops you into Insert mode. `c$` removes from the cursor to the end of the line. `c)` removes from the cursor to the end of the sentence. These commands are called Vim *phrases*. All you have to do is type, with your hands on the home row, to move around and modify your document. 

Other commands work the same way: `d` deletes (so `dw` deletes the word under the cursor, keeping you in Normal mode), `y` yanks (copies to a register; in VimStar this is your clipboard by default), `p` pastes. Once you get it, moving around and changing text becomes *fast*. 

With that said, VimStar adds to the mix WordStar movement keys in Insert mode. This gives WordStar users a gentle introduction to Vim movement---which, I have to say (having used both) is better once you learn it. But feel free to use `^e`, `^s`, `^d`, `^x`, its surrounding keys, and the `Space-q` equivalents to the `^q` keys (in Normal mode); they aren't going anywhere. 

Modeless editors like VSCode, Emacs, Sublime, and word processors force touch typists to move their hands constantly from the home typing row, slowing them down. To issue a command, you must grab the mouse, press a function key, or cramp your hands with some combination of Control, Alt, or Super combined with anther key or keys. Then, for many functions, you must select a sub-function. Now that your hands have moved to these keys, can you select your sub-function using them as well? You cannot. You're likely working in a dialog box, where you use the mouse to select functions. Finally, you must re-orient your hands on the home row before continuing typing. 

Indeed, even something as quotidian as backspacing to correct a mistyped character requires breaking the flow of typing by forcing your hands from the home typing row to hit the `Backspace` key; in VimStar, backspacing is also a home-typing-row `^h` that doesn't break the creative rhythm at all. 

# The Long-Hand Page Metaphor

Now, I'm a big fan of both of VimStar's interfaces: the mode-based Vim interface and the WordStar `Control`-key interface. They let me interact with my computer more efficiently than any other interface I've yet seen. This interface got me hooked for sure, but I knew I was missing something from WordStar, so I implemented them in VimStar. These strengths bring me back to VimStar time and again. 

Let me speak generally for a moment. I've concluded that there are two basic metaphors for pre-computer writing. One is the long-hand manuscript page. The other is the typewritten page. Most text editors and word processors have decided to emulate the second---and at first glance, that would seem to be the logical one to adopt. But, as an eclectic writer who writes creatively, technically, organizationally, and in many other ways, I am convinced that the long-hand page is the better metaphor. 

Consider: on a long hand page, you can jump back and forth in your document with ease. You can put in bookmarks, either actual paper ones, or just fingers slipped into the middle of the manuscript stack or notebook. You can annotate the manuscript for yourself with comments like "Fix this!" or "Don't forget to check these facts" without there being any possibility of you missing them when you next work on the document. And you can mark a block either by circling it with your pen or by physically cutting it out, without necessarily having to do anything with it right away. The entire document is your workspace. 

On a typewritten page, you are forced to deal with the next sequential character. Your thoughts are focused serially on the typing of the document. If you're in the middle of a line halfway down page 7, your only easy option is to continue on that line. To go backwards to check something is difficult, to put in a comment that won't show when your document is read by somebody else is impossible, and so on. Typing is a top-down, linear process, not at all conducive to the intuitive, leaping-here-and-there kind of thought human beings are good at. 

Now, a text editor or word processor that uses the typewriter metaphor might be ideal for those typing or preparing pre-written or dictated documents: proceeding top-down through a document that has been created in content and structure by somebody else. But for one who must start with absolutely nothing and create, from scratch, a coherent document with complex and subtle structures, the long-hand-page metaphor is the way to go. 

VimStar combines quick cursor movement (whether you choose the Vim way or the WordStar way) with WordStar's `Space-k` block commands, and these are much closer to the longhand way of writing than any other product. VimStar's powerful suite of cursor commands lets me fly all over my manuscript, without ever getting lost. That's because VimStar is constantly keeping track of where I've been and where I'm likely to want to go. `Space-qb` will take me to the beginning of the marked block; `Space-qk` will take me to the end; `Space-qv` will take me to where the marked block was moved from; `Space-qp` will take me to my previous cursor position. And, just as you would juggle up to ten fingers inserted into various places in a paper manuscript, VimStar provides you with even more bookmarks, set with `m` followed by any key on the keyboard, and equivalent keys to jump to them by using `'` (single quote) followed by the bookmark you set. These bookmarks appear conveniently in the gutter on the left of your document. 

Other VimStar cursor-movement commands, some of which were mentioned earlier, make life extraordinarily easy (left and right end of line, top and bottom of document, find specified character---all touch-typeable, all issued without ever taking my eyes off the screen). And its robust find commands use regular expressions, which runs circles around everything else. 

If I want to make a note to myself, I just make a comment in Markdown: 

```markdown
<!-- check date of birth -->
```

Comments like this don't print. However, there's no way I can miss such a comment when I re-edit the document. Modern word processors allow for comments, but you have to take your hands off the keyboard and use the mouse to select Insert -> Comment, and the comment doesn't appear inline; it appears off to the side with a line pointing at the text.

The typewritten-page metaphor is a machine-in-control situation: you must do what the machine wants you to do. Block marking is a perfect example, and regular Vim's Visual mode follows this. In any other editor, if I want to mark a block, I am forced to think through a serial sequence of steps and execute them in turn. Now that's fine for light work, say in emails or letters. But when one is *creating at the keyboard*, one wants to capture the most fleeting of thoughts, the most complex of ideas, before they evaporate into the ether, lost for good. The human-machine interface must let me stop and get a thought down, not force me to hang on until the computer is ready for me to go back to thinking. 

Regular editors require that I decide whether I want to cut or copy a block, then immediately mark the beginning of the block, then immediately mark the end of the block, then immediately position the cursor at where I want the block to go, then immediately move the block, and then find my way back to the place where I was originally working. From the moment I decide I might, perhaps, want to do something with a block of text to the moment I actually finish that operation, the editor is in control, dictating what I must do. 

VimStar, with its long-hand-page metaphor from WordStar, says hey, do whatever you want whenever you want to. This is a good spot to mark the beginning of a block (`Space-kb`)? Fine. What would *you* like to do next? Deal with the block? Continue writing? Use the thesaurus? 

After another half hour of writing, I can say, *ah hah!*, this is where I want to end that block (`Space-kk`). And two hours later I can say, and *this* is where that block should go. I'm in control, not the program. That's clearly more powerful, more intuitive, and more flexible than any other method of text manipulation I've yet seen implemented in a word processor or text editor. That VimStar lets me have separate marked blocks in each of its editing windows multiplies that power substantially: imagine doing a cut and paste job between two versions of a paper document, but being told that you could only have one piece cut out at a time. Madness! Yet that's what every other editor would force you to do. You can even, in essence, have two marked blocks per window, toggling between them with the "mark previous block" command, `Space-ku`. 

Over the years, it's become clear to me that writers work in unique ways. Little things make a big difference to how effectively they can interface with their machines. VimStar provides a vast suite of customizability options, because it's based on Neovim. It's important that the writing tool adapt to the writer, not the other way around. VimStar is strong because it can fit me like a comfortable old shoe, and then make itself over completely to fit somebody else just as well. 

Many text editors and word processors hark back to the decidedly modal days of Liquid Paper: they have you enter new material from the main typing area, but for editing make you move your hands from that area to the cursor pad, the function keys, or a mouse, and then step through layers of menus. These typewriter-metaphor programs compartmentalize writing and editing in an unnatural fashion. The human mind does not distinguish between these activities in any gross way; neither should the program. 

VimStar's adoption of the long-hand-page metaphor provides its strength in this area too. From your keyboard you can use Normal mode to get where you want quickly, or you can stay in Insert mode and use WordStar's navigation: there is no changing from writing to editing modes, and no switching of mental gears. The distinction between the modes is no more distracting than the lifting of fountain pen from paper to reposition it. Writing and revising are a continuum. VimStar supports that, whereas, again, competing programs demand that I adapt to their method of doing things, instead of the other way around. 

For me, it's clear: VimStar offers a more productive approach *at its most fundamental design level* than does its competition. 
