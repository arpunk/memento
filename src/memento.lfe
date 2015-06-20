(defmodule memento
  (export (start 0)
          (stop 0)
          (debug 1)
          (info 0) (info 1)
          (error 1)
          (load 1)
          (dump 1)
          (master-nodes 1)
          (transaction? 2)
          (transaction 2) (transaction 3)
          (transaction! 2) (transaction! 3)
          (ets 2)
          (async 2)
          (sync 2)))

(defun start ()
  "Starts the database"
  (mnesia:start))

(defun stop ()
  "Stops the database"
  (mnesia:stop))

(defun debug (level)
  "Changes the debug level"
  (mnesia:set_debug_level level))

(defun info ()
  "Prints information about the mnesia database"
  (mnesia:info))

(defun info (key)
  "Prints information about the running instance"
  (mnesia:system_info key))

(defun error (code)
  "Get the error description for the given code"
  (mnesia:error_description code))

(defun load (path)
  "Load a dump from a text file"
  (mnesia:load_textfile path))

(defun dump (path)
  "Dump the database to a text file"
  (mnesia:dump_to_textfile path))

(defun master-nodes (nodes)
  "Set the master nodes"
  (mnesia:set_master_nodes nodes))

(defun lock (key nodes mode)
  "Lock the whole database on the given NODE for the given keys with the given
  MODE.

  * Modes
    - 'write
    - 'sticky_write
    - 'read"
  (mnesia:lock (tuple 'global key nodes) mode))

(defun transaction? (fn args)
  "Check if its inside a transaction or not"
  (mnesia:is_transaction))

(defun transaction (fn args)
  "Start a transaction with the given FN passing the ARGS to it"
  (mnesia:transaction fn args))

(defun transaction (fn args retries)
  "Start a transaction with the given FN passing the ARGS to it,
trying to take a lock of max RETRIES times"
  (mnesia:transaction fn args retries))

(defun transaction! (fn args)
  "Starts a syncronous transaction with the given FN passing the ARGS
to it"
  (mnesia:sync_transaction fn args))

(defun transaction! (fn args retries)
  "Starts a syncronous transaction with the given FN passing the ARGS
to it trying to take a lock maximum RETRIES times"
  (mnesia:sync_transaction fn args retries))

(defun ets (fn args)
  "Run the passed FN in the ETS context passing over ARGS to it"
  (mnesia:ets fn args))

(defun async (fn args)
  "Run the passed FN in a dirty asynchronous context passing over the
passed ARGS"
  (mnesia:async_dirty fn args))

(defun sync (fn args)
  "Run the passed FN in a dirty synchronous context passing over the
passed ARGS"
  (mnesia:sync_dirty fn args))
