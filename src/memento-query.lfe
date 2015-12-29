(defmodule memento-query
  (export (append 1) (append 2)
          (cursor 1) (cursor 2)
          (delete-cursor 1)
          (select 2)
          (eval 1) (eval 2)
          (fold 3) (fold 4)
          (keysort 2) (keysort 3)
          (next 1) (next 2)
          (sort 1) (sort 2)))

(include-lib "stdlib/include/qlc.hrl")

(defun select (table match-spec)
  "Matches the objects in TABLE using a MATCH-SPEC."
  (mnesia:select table match-spec))

(defun append (query)
  "Appends a QUERY and returns a query handler."
  (qlc:append query))

(defun append (first-query second-query)
  "Appends two query handlers and returns the resulting handler."
  (qlc:append first-query second-query))

(defun cursor (query)
  "Creates a query cursor using the given QUERY."
  (qlc:cursor query))

(defun cursor (query opts)
  "Creates a query cursor using the given QUERY with the given OPTS."
  (qlc:cursor query opts))

(defun delete-cursor (cursor)
  "Deletes a query CURSOR."
  (qlc:delete_cursor cursor))

(defun eval (query)
  "Evaluates a QUERY handle."
  (qlc:eval query))

(defun eval (query opts)
  "Evaluates a QUERY handle with the given OPTS."
  (qlc:eval query opts))

(defun fold (query acc fn)
  "Reduces a QUERY given an initial ACC and a reduce FN."
  (qlc:fold fn acc query))

(defun fold (query acc fn opts)
  "Reduces a QUERY given an initial ACC, a reduce FN and some OPTS."
  (qlc:fold fn acc query opts))

(defun keysort (query pos)
  "Sorts the keys of a a QUERY with the given POSITION."
  (qlc:keysort pos query))

(defun keysort (query pos opts)
  "Sorts the keys of a QUERY with the given POSITION and some OPTS."
  (qlc:keysort pos query opts))

(defun next (cursor)
  "Returns the next answer to a query CURSOR."
  (qlc:next_answers cursor))

(defun next (cursor records)
  "Returns the next answer to a query CURSOR and limits the result to
RECORDS."
  (qlc:next_answers cursor records))

(defun sort (query)
  "Sorts the given QUERY."
  (qlc:sort query))

(defun sort (query opts)
  "Sorts the given QUERY with some OPTS."
  (qlc:sort query opts))
