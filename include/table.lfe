;; The following has been ripped off from lutil
(defmacro create-table
  ((record-table-name '())
   `(create-table ,record-table-name (list (tuple 'type 'set))))
  ((record-table-name table-defs)
   (let* ((record-fields (^-^ 'fields- record-table-name))
          (computed-record-fields `(,record-fields)))
     `(mnesia:create_table
       ',record-table-name
       (++ ,table-defs
           (list (tuple 'attributes ,computed-record-fields)))))))

(eval-when-compile
  (defun ^-^ (a b)
    (list_to_atom
     (++ (atom_to_list a) (atom_to_list b)))))

(defun loaded-tables ()
  'ok)
