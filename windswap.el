;;; windswap.el --- directional window-moving routines -*- lexical-binding: t; -*-

;; Copyright (C) 2018 Ashok Menon

;; Author: Ashok Menon <amenon94@gmail.com>
;; Keywords: window, selection, convenience, windmove
;; Version: 0.0.1

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:
;;
;; This package defines a set of routines windswap-{left,up,right,down} for
;; swapping the buffer in the currently selected window with its neighbour's in
;; the given direction.  It draws inspiration from `windmove'.

;;; Code:

(defun windswap-do-window-swap (dir)
  (let* ((this-window (car (window-list)))
         (that-window (window-in-direction dir this-window t 0 t)))
    (when (and this-window that-window)
      (let ((this-buffer (window-buffer this-window))
            (this-cursor (window-point this-window))

            (that-buffer (window-buffer that-window))
            (that-cursor (window-point that-window)))
        (set-window-point that-window this-cursor)
        (set-window-buffer that-window this-buffer)

        (select-window that-window)

        (set-window-point this-window that-cursor)
        (set-window-buffer this-window that-buffer)))))

(defun windswap-left ()
  "Swap the buffer in the current window with the buffer of the
window to its left, as calculated by `window-in-direction', with
wrap-around."
  (interactive)
  (windswap-do-window-swap 'left))

(defun windswap-up ()
  "Swap the buffer in the current window with the buffer of the
window above it, as calculated by `window-in-direction', with
wrap-around."
  (interactive)
  (windswap-do-window-swap 'above))

(defun windswap-right ()
  "Swap the buffer in the current window with the buffer of the
window to its right, as calculated by `window-in-direction', with
wrap-around."
  (interactive)
  (windswap-do-window-swap 'right))

(defun windswap-down ()
  "Swap the buffer in the current window with the buffer of the
window below it, as calculated by `window-in-direction', with
wrap-around."
  (interactive)
  (windswap-do-window-swap 'below))

(defun windswap-default-keybindings (&optional modifier)
  "Installs default keybindings for `windswap' designed to work
with the default keybindings of `windmove'. Default MODIFIER is
`shift'. Assigns the keycodes M-<MODIFIER>-{left,up,right,down},
or C-M-{left,up,right,down} when MODIFIER is META."
  (interactive)
  (unless modifier (setq modifier 'shift))
  (let ((other-modifier (if (eq 'meta modifier) 'control 'meta)))
    (global-set-key (vector (list other-modifier modifier 'left)) 'windswap-left)
    (global-set-key (vector (list other-modifier modifier 'right)) 'windswap-right)
    (global-set-key (vector (list other-modifier modifier 'up)) 'windswap-up)
    (global-set-key (vector (list other-modifier modifier 'down)) 'windswap-down)))

(provide 'windswap)
;;; windswap.el ends here
