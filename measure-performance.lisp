;; http://lispcookbook.github.io/cl-cookbook/dates_and_times.html#internal-time

(defmacro timing (&body forms)
  (let ((real1 (gensym))
	(real2 (gensym))
	(run1 (gensym))
	(run2 (gensym))
	(result (gensym)))
    `(let* ((,real1 (get-internal-real-time))
	    (,run1 (get-internal-run-time))
	    (,result (progn ,@forms))
	    (,run2 (get-internal-run-time))
	    (,real2 (get-internal-real-time)))
       (format *debug-io* ";;; Computation took:~%")
       (format *debug-io* ";;;  ~f seconds of real time~%"
	       (/ (- ,real2 ,real1) internal-time-units-per-second))
       (format t ";;;  ~f seconds of run time~%"
	       (/ (- ,run2 ,run1) internal-time-units-per-second))
       ,result)))

;; Example
;; (timing (sleep 1))
