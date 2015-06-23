(defmacro with-transaction (block)
  `(mnesia:transaction (lambda () ,block)))

(defmacro with-transaction! (block)
  `(mnesia:sync_transaction (lambda () ,block)))

(defmacro async (block)
  `(mnesia:async_dirty (lambda () ,block)))

(defmacro sync (block)
  `(mnesia:sync_dirty (lambda () ,block)))

(defun loaded-transaction ()
  'ok)
