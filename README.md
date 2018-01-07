# windswap

An Emacs library for swapping buffers between neighbouring windows in a frame.

[WindMove](https://www.emacswiki.org/emacs/WindMove) is a library built into Emacs 21+ that defines routines `windmove-{left,right,up,down}` that move the point between neighbouring windows.

Similarly, **WindSwap**, provides routines `windswap-{left,right,up,down}` for swapping the current buffer between neighbouring windows.

The neighbouring window in any given direction is found by shooting a ray in that direction from the current window's point. It is the first window that intersects this ray. The ray will wrap-around the frame, so the right neighbour of the rightmost window will be to its left.

## Installation

*TODO* This package is available on [MELPA](https://melpa.org/#/)

    M-x package-install RET windswap RET

Once installed, load with

    (require 'windswap)

## Usage

`windswap` defines the following functions:

    windswap-left
    windswap-right
    windswap-up
    windswap-down

They can be called interactively, or bound to keys. Default keybindings are available, and can be enabled by a call to:

    (windswap-default-keybindings (&optional MODIFIER))

which binds `M-<MODIFIER>-{left,right,up,down}` -- or `C-M-{left,right,up,down}` when `MODIFIER` is `'meta` -- in the natural way.

*Pull Requests Welcome.*
