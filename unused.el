(defvar-local endless/margin-overlays nil
  "List of overlays in current buffer.")

(defun endless/setup-margin-overlays ()
  "Put overlays on each line which is visually wrapped."
  (interactive)
  (let ((ww (- (window-width)
               (if (= 0 (or (cdr fringe-mode) 1)) 1 0)))
        ov)
    (mapc #'delete-overlay endless/margin-overlays)
    (save-excursion
      (goto-char (point-min))
      (while (null (eobp))
        ;; On each logical line
        (forward-line 1)
        (save-excursion
          (forward-char -1)
          ;; Check if it has multiple visual lines.
          (while (>= (current-column) ww)
            (endles/make-overlay-at (point))
            (forward-char (- ww))))))))

(defun endles/make-overlay-at (p)
  "Create a margin overlay at position P."
  (push (make-overlay p (1+ p)) endless/margin-overlays)
  (overlay-put
   (car endless/margin-overlays) 'before-string
   (propertize " "  'display endless/margin-display)))
