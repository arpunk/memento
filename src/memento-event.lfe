(defmodule memento-event
  (export (handle 2)
          (observe 2)
          (subscribe 1)
          (unsubscribe 1)
          (report 1)))

(defun handle
  (('() fn)
   (receive
     (v (funcall fn v)))
   (handle '() fn))
  ((categories fn)
   (lists:foreach fn categories)))

(defun observe
  "Observe the given events with the given FN"
  ((categories fn) (when (is_list categories))
   (spawn (MODULE) 'handle '(categories fn)))
  ((category fn)
   (observe '(category) fn)))

(defun subscribe (category)
  "Subscribe to events of a given category"
  (mnesia:subscribe category))

(defun unsubscribe (category)
  "Unsubscribe from events of a given category"
  (mnesia:unsubscribe category))

(defun report (event)
  "Report an event"
  (mnesia:report_event event))
