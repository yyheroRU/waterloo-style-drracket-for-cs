# Waterloo Style for CS (DrRacket)

A small DrRacket tool that colors parentheses `(`, `[`, `{` by nesting depth
using a muted gold-and-gray palette, so matching brackets are easier to spot
when writing Racket for CS courses.

> This is a personal project. It is not an official University of Waterloo
> tool and is not affiliated with or endorsed by the university.

## Install

```
raco pkg install https://github.com/yyheroRU/waterloo-style-drracket-for-cs.git
```

Then restart DrRacket. The colors apply automatically in the definitions window.

## Uninstall

```
raco pkg remove waterloo-style-drracket-for-cs
```

## How it works

On every edit, the tool re-lexes the text with `syntax-color/racket-lexer`
and applies a color to each bracket based on its depth.
The colors cycle through five shades (see `colors` in `tool.rkt`).

## Customize the colors

Clone the repo, edit the `colors` list at the top of `tool.rkt`, then install
your local copy:

```
git clone https://github.com/yyheroRU/waterloo-style-drracket-for-cs.git
cd waterloo-style-drracket-for-cs
raco pkg install --link .
```

If it is already installed from GitHub, run `raco pkg remove` first.
Restart DrRacket after any change.

## Limitations

- The whole file is re-lexed after each edit, so very large files may feel slow.
- Only the definitions window is affected, not the interactions window.

## License

MIT
