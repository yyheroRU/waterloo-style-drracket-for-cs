#lang racket/base
(require drracket/tool racket/class racket/unit racket/gui/base
         syntax-color/racket-lexer)
(provide tool@)

(define colors '("goldenrod" "dim gray" "dark goldenrod" "dark slate gray" "dark khaki"))
(define deltas
  (for/list ([c colors])
    (define d (new style-delta%))
    (send d set-delta-foreground c)
    d))

(define tool@
  (unit
    (import drracket:tool^)
    (export drracket:tool-exports^)

    (define waterloo-style-mixin
      (mixin ((class->interface text%)) ()
        (super-new)
        (define busy? #f)

        (define (recolor)
          (set! busy? #t)
          (send this begin-edit-sequence #f #f)
          (define in (open-input-string (send this get-text)))
          (port-count-lines! in)
          (let loop ([depth 0])
            (define-values (lexeme type paren start end) (racket-lexer in))
            (unless (eof-object? lexeme)
              (cond
                [(and (eq? type 'parenthesis) start end)
                 (define opening? (memq paren '(|(| |[| |{|)))
                 (define d (if opening? depth (max 0 (sub1 depth))))
                 (send this change-style
                       (list-ref deltas (modulo d (length deltas)))
                       (sub1 start) (sub1 end))
                 (loop (if opening? (add1 depth) d))]
                [else (loop depth)])))
          (send this end-edit-sequence)
          (set! busy? #f))

        (define/augment (after-edit-sequence)
          (unless busy?
            (queue-callback recolor #f))
          (inner (void) after-edit-sequence))))

    (define (phase1) (void))
    (define (phase2)
      (drracket:get/extend:extend-definitions-text waterloo-style-mixin))))
