---
layout: home
title: "VimStar"
subtitle: "A Neovim distribution for writing, inspired by WordStar"
---

<div class="hero">
  <h1>{{ page.title }}</h1>
  
  <p>VimStar is a pre-configured Neovim setup optimized for writing Markdown while maintaining strong coding support. It's inspired by the classic DOS word processor WordStar, using Space as the leader key for intuitive menu access.</p>
  
  <div class="quick-actions">
    <a href="/install" class="btn btn-primary">Get Started</a>
    <a href="/keybindings" class="btn btn-secondary">View Keybindings</a>
  </div>
</div>

<div class="features">
  <div class="feature-card">
    <h3>📝 Writing First</h3>
    <p>Markdown as default filetype, spell check for prose, word count in status bar, Pandoc publishing</p>
  </div>
  <div class="feature-card">
    <h3>⚡ WordStar Menus</h3>
    <p>Space-k (Block/Save), Space-o (Format), Space-p (Print), Space-q (Quick) - intuitive menus</p>
  </div>
  <div class="feature-card">
    <h3>🤖 AI Assistant</h3>
    <p>CodeCompanion with Ollama for inline suggestions and chat</p>
  </div>
  <div class="feature-card">
    <h3>💻 Language Support</h3>
    <p>LSPs for Lua, TypeScript, Python, Java, C; debugging for Python, Go, Java</p>
  </div>
  <div class="feature-card">
    <h3>📚 Wiki System</h3>
    <p>Journaling with templates (daily, monthly, project, notes)</p>
  </div>
  <div class="feature-card">
    <h3>🛠️ Auto-Installed</h3>
    <p>Plugins install automatically via Lazy.nvim</p>
  </div>
</div>

<h2>Quick Start</h2>

<p>VimStar installs to <code>~/.VimStar</code> (symlinked to <code>~/.config/nvim</code> on Linux) and automatically downloads plugins via Lazy.nvim.</p>

<h3>Linux/macOS</h3>
<pre><code>curl -sLf https://raw.githubusercontent.com/sez11a/VimStar/master/install-vimstar.sh | bash</code></pre>

<h3>Windows</h3>
<pre><code>Set-ExecutionPolicy Bypass -Scope Process -Force
 irm https://raw.githubusercontent.com/sez11a/VimStar/master/install-vimstar.ps1 | iex</code></pre>

<h3>After Installation</h3>
<p>Run <code>nvim</code> to finish setup. Plugins download automatically via Lazy.nvim.</p>

<h2>Documentation</h2>

<ul class="docs-list">
  <li><a href="/install">Installation</a> - Get started in 30 seconds</li>
  <li><a href="/quickstart">Quick Start</a> - Your first 5 minutes</li>
  <li><a href="/keybindings">Keybindings</a> - Complete reference</li>
  <li><a href="/writing">Writing</a> - Markdown, Pandoc, live preview</li>
  <li><a href="/coding">Coding</a> - LSP, debugging, AI assistant</li>
  <li><a href="/wiki">Wiki System</a> - Journaling with templates</li>
  <li><a href="/customization">Customization</a> - Make it yours</li>
  <li><a href="/troubleshooting">Troubleshooting</a> - Common issues and solutions</li>
</ul>

<h2>WordStar Heritage</h2>

<p>VimStar borrows the menu system from the 1980s word processor that defined keyboard shortcuts for generations of writers.</p>

<table class="wordstar-table">
  <thead>
    <tr>
      <th>WordStar</th>
      <th>VimStar (Space prefix)</th>
      <th>Function</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><code>Ctrl-K</code></td>
      <td><code>&lt;leader&gt;k</code></td>
      <td>Block and Save (buffers, save, quit)</td>
    </tr>
    <tr>
      <td><code>Ctrl-O</code></td>
      <td><code>&lt;leader&gt;o</code></td>
      <td>Onscreen Format (format, actions, preview)</td>
    </tr>
    <tr>
      <td><code>Ctrl-P</code></td>
      <td><code>&lt;leader&gt;p</code></td>
      <td>Print Controls (Pandoc publishing)</td>
    </tr>
    <tr>
      <td><code>Ctrl-Q</code></td>
      <td><code>&lt;leader&gt;q</code></td>
      <td>Quick Menu (plugins, debugging)</td>
    </tr>
  </tbody>
</table>

<h2>Screenshots</h2>

<div class="screenshots">
  <div class="screenshot">
    <h3>Dashboard</h3>
    <p>The ASCII art dashboard shows recently opened files.</p>
    <img src="./images/vimstar-1.png" alt="VimStar dashboard">
  </div>
  <div class="screenshot">
    <h3>Markdown Editing</h3>
    <p>Markdown is the default filetype with spell check enabled.</p>
    <img src="./images/vimstar-2.png" alt="Markdown editing">
  </div>
</div>

<h2>License</h2>

<p>MIT License - see <a href="/license">LICENSE</a> for details.</p>