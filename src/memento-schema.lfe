(defmodule memento-schema
  (export (print 0) (print 1)
          (create 1)
          (destroy 1)))

(defun print ()
  "Prints the schema information"
  (mnesia:schema))

(defun print (table)
  "Prints the schema of a given TABLE"
  (mnesia:schema table))

(defun create (nodes)
  "Create the schema on the given NODES"
  (mnesia:create_schema nodes))

(defun destroy (nodes)
  "Destroys the schema on the given NODES"
  (mnesia:delete_schema nodes))
