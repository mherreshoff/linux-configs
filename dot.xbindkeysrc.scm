(use-modules (ice-9 popen))
(use-modules (ice-9 rdelim))

;; Prints out all its arguments with a newline
(define (display* . L)
  (for-each display L)
  (newline))

;; Return first line printed out by 'cmd' (with spaces stripped.)
(define (first-output-line cmd)
  (let* ((port (open-input-pipe cmd))
         (str  (read-line port)))
    (display* str)
    (close-pipe port)
    (string-trim-both str)))

;; Returns the X11 window ID of the currently active window.
(define (active-window)
  (string->number (first-output-line "xdotool getactivewindow")))

;; Activates the window with the specified X11 ID.
(define (set-active-window! window-id)
  (system* "xdotool" "windowactivate" (number->string window-id)))


;; Returns two functions.
;; (1) A function which saves the currently active window.
;; (2) One which activates whichever window was last saved by (1)
(define (create-dynamic-window-fns)
  (let ((window-id #f))
    (cons 
      (lambda () (set! window-id (active-window)))
      (lambda ()
        (if (number? window-id)
          (set-active-window! window-id)
          (display* "You haven't bound that key yet."))))))


;; Bind keystrokes 'k1' and 'k2' such that 'k1' remembers the current window
;; and 'k2' switches to the window remembered by k1.
(define (bind-dynamic-window-keys k1 k2)
  (let ((fns (create-dynamic-window-fns)))
    (xbindkey-function k1 (car fns))
    (xbindkey-function k2 (cdr fns))))

(define (divvy-binding)
  (define (bind-divvy k . args)
    (xbindkey-function
      k (lambda ()
          (apply system* (cons "move_window" (map number->string args)))
          (main-binding))))
  (display* "starting divvy mode.")
  (ungrab-all-keys) (remove-all-keys)
  (xbindkey-function '(control space) main-binding)
  (xbindkey-function 'escape main-binding)
  (bind-divvy 'space 1 0 1 1 0 1)
  (bind-divvy 'f 2 0 1 1 0 1)
  (bind-divvy '(control f)  2 1 1 1 0 1)
  (bind-divvy 'd 1 0 1 2 0 1)
  (bind-divvy '(control d) 1 0 1 2 1 1)
  (bind-divvy "1" 4 0 1 2 0 1)
  (bind-divvy "2" 4 1 1 2 0 1)
  (bind-divvy "3" 4 2 1 2 0 1)
  (bind-divvy "4" 4 3 1 2 0 1)
  (bind-divvy 'q 4 0 1 2 1 1)
  (bind-divvy 'w 4 1 1 2 1 1)
  (bind-divvy 'e 4 2 1 2 1 1)
  (bind-divvy 'r 4 3 1 2 1 1)

  (bind-divvy '(control "1") 4 0 1 1 0 1)
  (bind-divvy '(control "2") 4 1 1 1 0 1)
  (bind-divvy '(control "3") 4 2 1 1 0 1)
  (bind-divvy '(control "4") 4 3 1 1 0 1)

  (bind-divvy '(shift "1") 4 0 2 2 0 1)
  (bind-divvy '(shift "2") 4 1 2 2 0 1)
  (bind-divvy '(shift "3") 4 2 2 2 0 1)
  (bind-divvy '(shift q) 4 0 2 2 1 1)
  (bind-divvy '(shift w) 4 1 2 2 1 1)
  (bind-divvy '(shift e) 4 2 2 2 1 1)
  (grab-all-keys))



;; Set up the function keys so that Control-F1 remembers a window for F1 to
;; pick, and similarly F2 through F12.
;; Make Control-space start divvy mode.
(define (main-binding)
  (display* "starting main mode.")
  (ungrab-all-keys) (remove-all-keys)
  (for-each
    (lambda (f-key)
      (bind-dynamic-window-keys `(control ,f-key) f-key))
    '(F1 F2 F3 F4 F5 F6 F7 F8 F9 F10 F11 F12))
  (xbindkey-function '(control space) divvy-binding)
  (grab-all-keys))



(main-binding)


