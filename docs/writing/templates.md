---
layout: single
title: "Templates"
permalink: /writing/templates/
sidebar:
  nav: "main"
toc: true
---

VimStar ships with several templates for exporting Markdown files into various formats: 

- Article/Handout
- Book
- Submission Format
- Planner Page 

More templates are planned; if you have an idea for a template, [submit an issue](https://github.com/sez11a/VimStar/issues) for it. 

To make these work, you must have installed either [LaTeX](https://tug.org/texlive/) or [Typst](https://typst.app/open-source/#download), along with [Pandoc](https://pandoc.org). 

Currently, templates are formatted via both LaTeX and Typst. LaTeX has been around a lot longer and has a lot more features, but Typst is catching up. LaTeX, however, is a gigantic download and sometimes difficult to install and configure. Because of this, I'm in the process of migrating the templates to Typst. My hope is since Typst is smaller and easier to install, it'll be a better prerequisite for people to get going than LaTeX is. Once I'm done, I'll remove the LaTeX prerequisite, and only Pandoc and Typst will be necessary. For now, however, you'll see `<Space>p` menu items for both the Typst and LaTeX templates. 

# Using Templates 

Templates format your Markdown document in useful ways. Type one command in VimStar, and your Markdown file is turned into an article, formatted for submission to a publication, formatted for use with a paper-based planner, or laid out as a paperback book. You write your Markdown as you would any Markdown file; the only difference is in the YAML headers. 

Exporting your Markdown file to a PDF using the templates requires using the `<Space>p` (Print Controls) menu. Commands for the various templates appear there. Note that if you're using images in your Markdown files, before exporting via a template, change the working directory to the location of the currently open file with `<Space>kl`. 

# Article/Handout 

This, along with the planner, is the simplest template. At the top of your Markdown file, place a YAML header containing these fields: 

```markdown
---
title: Your Title
subtitle: Your Subtitle
author: Firstname Lastname
---

The rest of your Markdown file goes here. Use headings and other Markdown features normally. 
```

When you're ready to produce your article or handout, in Normal mode hit `<Space>pp` (LaTeX) or `<Space>pP` (Typst). It produces a document suitable as an article or handout: 

![The article/handout is a basic format with a title, subtitle, author, headings, and page numbers.](/assets/images/article-screenshot.png)

# Planner Page 

The Planner Page template takes the exact same YAML headers as the Article/Handout, but it lays out the page horizontally: 

![The planner page is suitable for cutting in half and inserting into a planner.](/assets/images/planner-screenshot.png)

This way, you can cut the page in half or fold it and stick it in your paper-based planner. To use the planner page, use `<Space>pe`. 

# Book 

The book template formats your document as a digest-sized paperback book. If you are a writer who self-publishes your work, you could write your entire novel in VimStar, use this template to lay it out, and upload it to Amazon, IngramSpark, Lulu, or any other self-publishing platform. 

The book template accepts the same YAML headers as the Article/Handout (`title`, `subtitle`, `author`), with optional headers for the dedication, the ISBN, and the book typefaces: 

```markdown
---
title: "My Great Book"
subtitle: "A Story of Greatness"
author: "Firstname Lastname"
dedication: "For my family, who endured the writing process."
isbn: "978-1234567890"
body-font: "Alegreya"
heading-font: "Alegreya Sans"
---

# Chapter One

The rest of your Markdown file goes here. Each level-1 heading begins a new chapter. 
```

The dedication, if present, appears on its own page after the copyright page. The ISBN, if present, appears on the copyright page.

`body-font` sets the serif font used for the body text.

`heading-font` sets the sans font used for the chapter headings (level 1), the sub-headings (levels 2–4), the figure captions, and the running header.

Both are optional. The value is the name of a font installed on the computer doing the compilation. If you leave a header out or name a font that isn't installed there, the template walks down a fallback list of common, cross-platform fonts (Windows, macOS, and Linux) and uses the first one it can find, so the PDF always renders with a sensible typeface. If you set a font that is installed, it takes precedence over the built-in defaults. Note that Typst shows warnings when fonts aren't installed; these are normal and don't affect the PDF output.

![The book template formats your Markdown file as a paperback book.](/assets/images/book-screenshot.png)

# Submission Format

If you're a writer who submits stories for publication, this template can format your story for you perfectly. It needs a lot more metadata to do that, in the form of these YAML headers: 

```markdown 
---
title: "A Great Story"
author: "Dude Dud"
surname: "Dud"
shorttitle: "Story"
wordcount: "about 12,000 words"
name: "Dudeness M. Dud"
address: "123 Main Street"
city: "Anywhere, XX  00000"
phone: "123-456-7890"
email: "dude@place.com"
affiliation: ""
---
```

Set these headers and then hit one of the commands below. This produces a manuscript in the proper format for a publication: 

![The submission format is for submitting a story or article to a publication.](/assets/images/submission-screenshot.png)

| Command | Output |
| -------------- | --------------- |
| `Space-ps` | Submission in PDF format |
| `Space-pS` | Submission in .odt (LibreOffice) format |

Submission in .docx format (exported from LibreOffice) coming soon! 

