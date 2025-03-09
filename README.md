# vim-substitute-latex

This Plugin is used to automatically replace common LaTeX commands with their respective UTF-8 Symbols.

This means:

`\Lambda \xor \zeta` becomes `Λ ⊻ ζ`.

This is handy for writing Math in Markdown or in Julia Source Code.

## Installation

Utilize your favorite Plugin Manager:

```
Plugin 'ruedigerblock/vim-substitute-latex'
```

## Auto Completion

If you use [asyncomplete.vim](https://github.com/prabirshrestha/asyncomplete.vim) paste this in your `.vimrc`:

```
au User asyncomplete_setup call asyncomplete#register_source({
      \ 'name': 'latex-math-symbols',
      \ 'allowlist': ['*'],
      \ 'completor': function('LatexSymbolCompletor'),
      \ })
```
