# Neovim Guide

## Table of Contents

- [Neovim Guide](#neovim-guide)
  - [Table of Contents](#table-of-contents)
  - [Overview](#overview)
    - [Description](#description)
    - [Key Features](#key-features)
  - [Guides](#guides)
    - [General Hotkeys](#general-hotkeys)
    - [Popular Extensions](#popular-extensions)

## Overview

### Description

Neovim is a powerful, highly extensible text editor and a modern fork of the popular Vim editor. It was designed to improve upon the foundation laid by Vim, addressing various shortcomings and adding new features to enhance the overall editing experience.

### Key Features

1. **Modularity:** Neovim follows a modular architecture, making it easier for developers to extend and customize its functionality. Users can take advantage of plugins and scripts to tailor the editor to their specific needs.

2. **Performance:** Neovim is optimized for speed and responsiveness. Its asynchronous processing capabilities allow for faster handling of tasks, resulting in a smoother editing experience, especially when dealing with large files.

3. **Built-in Terminal Emulation:** The editor includes a built-in terminal emulator, enabling users to execute shell commands directly from within Neovim. This integration streamlines workflows by reducing the need to switch between the editor and external terminal applications.

4. **Modern User Interface:** Neovim supports modern UI features, such as true-color, custom font rendering, and support for various graphical elements, making it visually appealing and customizable.

5. **Backward Compatibility:** While Neovim introduces several improvements, it remains backward compatible with Vim. Vim configurations and plugins can be used with Neovim, easing the transition for existing Vim users.

6. **LSP Integration:** Neovim offers Language Server Protocol (LSP) integration, enhancing its support for various programming languages. LSP allows for intelligent code completion, syntax checking, and other language-specific features.

7. **Community-Driven Development:** Neovim is an open-source project with an active and supportive community. This community-driven development approach fosters continuous improvement and encourages the contribution of new features and bug fixes.

## Guides

[Official reference](https://neovim.io/doc/user/quickref.html)

### General Hotkeys

1. **Navigation:**
   - **h, j, k, l**: Left, down, up, and right navigation, respectively.
   - **w**: Move forward by word.
   - **b**: Move backward by word.
   - **gg**: Go to the beginning of the file.
   - **G**: Go to the end of the file.
   - **<line_number>G**: Go to a specific line number.
   - **Ctrl + d**: Scroll down half a screen.
   - **Ctrl + u**: Scroll up half a screen.
   - **Ctrl + f**: Scroll down one full screen.
   - **Ctrl + b**: Scroll up one full screen.

2. **Editing:**
   - **i**: Enter insert mode at the current cursor position.
   - **I**: Enter insert mode at the beginning of the line.
   - **a**: Enter insert mode after the current cursor position.
   - **A**: Enter insert mode at the end of the line.
   - **o**: Insert a new line below and enter insert mode.
   - **O**: Insert a new line above and enter insert mode.
   - **u**: Undo the last change.
   - **Ctrl + r**: Redo the last undone change.
   - **yy**: Yank (copy) the current line.
   - **p**: Paste the yanked text after the current cursor position.
   - **P**: Paste the yanked text before the current cursor position.
   - **x**: Delete the character under the cursor.
   - **dd**: Delete the current line.
   - **dw**: Delete from the cursor to the end of the word.
   - **db**: Delete from the cursor to the beginning of the word.

3. **Search and Replace:**
   - **/search_term**: Search for "search_term" forward in the document.
   - **?search_term**: Search for "search_term" backward in the document.
   - **n**: Move to the next search result.
   - **N**: Move to the previous search result.
   - **:%s/old_text/new_text/g**: Replace "old_text" with "new_text" throughout the entire file.
   - **:&#8203;s/old_text/new_text/g**: Replace "old_text" with "new_text" on the current line.
   <!-- &#8203; used to prevent rendering emoji -->

4. **Saving and Quitting:**
   - **:w**: Save the current file.
   - **:q**: Quit Neovim.
   - **:wq** or **ZZ**: Save and quit.

### Popular Extensions

Extensions can be found [here](https://neovimcraft.com/).

**Vim-Plug**: Before diving into specific plugins, it's worth mentioning Vim-Plug. It's a popular plugin manager for Neovim that makes it easy to install and manage plugins efficiently.

Now, let's take a look at some noteworthy plugins:

1. **CoC.nvim (Conquer of Completion)**: A powerful completion engine that offers language server protocol (LSP) support. It provides smart autocompletion and code navigation for a wide range of programming languages.

2. **NERDTree**: A file system explorer that allows you to navigate and open files and directories from within Neovim easily.

3. **Ale**: A highly useful plugin for linting and syntax checking your code in real-time. It supports various programming languages and helps you maintain clean and error-free code.

4. **Fugitive**: A Git wrapper that enables seamless Git integration within Neovim. It offers quick access to Git commands and status information.

5. **Telescope**: A versatile fuzzy finder that allows you to search and browse through files, buffers, and other elements of your project quickly.

6. **UltiSnips**: A powerful snippet engine that saves you time by allowing you to insert code snippets and templates effortlessly.

7. **Vim-Commentary**: A simple plugin that makes commenting and uncommenting code a breeze.

8. **Gruvbox**: A popular color scheme that provides an eye-pleasing, retro vibe to your Neovim setup.

9. **vim-surround**: This plugin lets you manipulate parentheses, brackets, quotes, and other surroundings with ease. It's a real productivity booster.

10. **IndentLine**: It displays vertical lines to represent the indentation levels in your code, which can be very helpful for code readability.

Tags: #linux, #bash, #vim, #WIP
