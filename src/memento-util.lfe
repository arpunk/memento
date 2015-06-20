(defmodule memento-util
  (export all))

(defun get-version ()
  (lutil:get-app-version 'memento))

(defun get-versions ()
  (++ (lutil:get-versions)
      `(#(memento ,(get-version)))))
