(defmodule memento-table
  (export (wait 1) (wait 2)
          (force 1)
          (exists? 1)
          (transform 2) (transform 3) (transform 4)
          (info 2)
          (properties 1)
          (type 1)
          (bag? 1)
          (set? 1)
          (ordered-set? 1)
          (mode 2)
          (copying 3)
          (priority 2)
          (majority 2)
          (add-copy 2) (add-copy 3)
          (move-copy 3)
          (delete-copy 2)
          (add-index 2)
          (delete-index 2)
          (master-nodes 2)
          (lock 2)
          (destroy 1)
          (clear 1)
          (member? 2)
          (count 1)
          (read 3) (read! 2)
          (read-at 3) (read-at! 3)
          (keys 1) (keys! 1)
          (at! 2)
          (first 1) (first! 1)
          (next 2) (next! 2)
          (prev 2) (prev! 2)
          (last 1) (last! 1)
          (select 2) (select! 2) (select 3) (select 4)
          (match 3) (match! 2)
          (foldl 3) (foldr 3)
          (delete 2) (delete 3) (delete! 2)
          (write 2) (write 3) (write! 2)))

(defun wait (names)
  "Wait infinitively for the passed tables"
  (mnesia:wait_for_tables names 'infinity))

(defun wait (names timeout)
  "Wait for the passed tables the timeout amount"
  (mnesia:wait_for_tables timeout))

(defun force (table)
  "Force the loading of the given TABLE"
  (mnesia:force_load_table table))

(defun exists? (table)
  "Checks if a TABLE exists"
  (lists:member table (mnesia:system_info 'tables)))

(defun transform (table attrs)
  "Transform a TABLE with a list of ATTRS"
  (mnesia:transform_table table 'ignore attrs))

(defun transform
  ((table attrs fn) (when (is_function fn))
   "Transform a TABLE with a list of ATTRS and a given FN"
   (mnesia:transform_table table fn attrs))
  ((table new-name attrs)
   "Transform a TABLE with a list of ATTRS while renaming it to
NEW-NAME"
   (mnesia:transform_table table 'ignore attrs new-name)))

(defun transform (table new-name attrs fn)
  "Transform a TABLE while renaming it to NEW-NAME"
  (mnesia:transform_table table fn attrs new-name))

(defun info (table key)
  "Get information KEY about a given TABLE"
  (mnesia:table_info table key))

(defun properties (table)
  "Return properties of the given TABLE"
  (info table 'all))

(defun type (table)
  "Return the type of the given TABLE"
  (info table 'type))

(defun bag? (table)
  "Check if the given TABLE is a bag"
  (=:= (type table) 'bag))

(defun set? (table)
  "Check if the given TABLE is a set"
  (=:= (type table) 'set))

(defun ordered-set? (table)
  "Check if the given TABLE is an ordered set"
  (=:= (type table) 'ordered_set))

(defun mode (table value)
  "Change the access mode VALUE of the given TABLE"
  (mnesia:change_table_access_mode table value))

(defun copying (table node mode)
  "Change the copying MODE of the given TABLE on the given NODE"
  (mnesia:change_table_copy_type table node mode))

(defun priority (table value)
  "Change the given TABLE priority to VALUE"
  (mnesia:change_table_load_order table value))

(defun majority (table value)
  "Change the given TABLE majority to VALUE"
  (mnesia:change_table_majority table value))

(defun add-copy (table node)
  "Add a copy of the TABLE to the given NODE using 'disk_copies"
  (add-copy table node 'disk_copies))

(defun add-copy (table node type)
  "Add a copy of the TABLE to the given NODE with the given TYPE"
  (mnesia:add_table_copy table node type))

(defun move-copy (table from to)
  "Move the copy of the given TABLE between two nodes"
  (mnesia:move_copy table from to))

(defun delete-copy (table node)
  "Delete a copy of the TABLE on the given NODE"
  (mnesia:del_table_copy table node))

(defun add-index (table attr)
  "Add an index to the given TABLE for the given ATTR"
  (mnesia:add_table_index table attr))

(defun delete-index (table attr)
  "Delete an index on the given TABLE for the given ATTR"
  (mnesia:del_Table_index table attr))

(defun master-nodes (table nodes)
  "Set the master NODES for the given TABLE"
  (mnesia:set_master_nodes table nodes))

(defun lock (table type)
  "Lock the given TABLE for the given TYPE of lock"
  (mnesia:lock #(table ,table) type))

(defun destroy (table)
  "Deletes and destroys the given TABLE"
  (mnesia:delete_table table))

(defun clear (table)
  "Clear all the records from a given TABLE"
  (mnesia:clear_table table))

(defun member? (table key)
  "Check if the KEY is present in the given TABLE"
  (case (mnesia:dirty_read table key)
    ('() 'false)
    (_ 'true)))

(defun count (table)
  "Get the number of records in the given TABLE"
  (info table 'size))

(defun read (table key lock)
  "Read records from the given TABLE with the given KEY and a LOCK"
  (case (mnesia:read table key lock)
    ('() 'not_found)
    (result result)))

(defun read! (table key)
  "Read records from the given TABLE with the given KEY in a dirty
operation"
  (case (mnesia:dirty_read table key)
    ('() 'not_found)
    (result result)))

(defun read-at (table key position)
  "Read records on the given TABLE based on a secondary index given as
POSITION"
  (case (mnesia:index_read table key position)
    ('() 'not_found)
    (result result)))

(defun read-at! (table key position)
  "Read records on the given TABLE based on a secondary index given as
POSITION in a dirty operation"
  (case (mnesia:dirty_index_read table key position)
    ('() 'not_found)
    (result result)))

(defun keys (table)
  "Read all keys in the given TABLE"
  (mnesia:all_keys table))

(defun keys! (table)
  "Read all keys in the given TABLE in a dirty operation"
  (mnesia:dirty_all_keys table))

(defun at! (table position)
  "Read a POSITION from the given TABLE in a dirty operation"
  (case (mnesia:dirty_slot table position)
    ('$end_of_table 'nil)
    (value value)))

(defun first (table)
  "Get the first key in the TABLE"
  (case (mnesia:first table)
    ('$end_of_table 'nil)
    (value value)))

(defun first! (table)
  "Get the first key in the TABLE in a dirty operation"
  (case (mnesia:dirty_first table)
    ('$end_of_table 'nil)
    (value value)))

(defun next (table key)
  "Get the next key in the TABLE starting from the given KEY"
  (case (mnesia:next table key)
    ('$end_of_table 'nil)
    (value value)))

(defun next! (table key)
  "Get the next key in the TABLE starting from the given KEY in a
dirty operation"
  (case (mnesia:dirty_next table key)
    ('$end_of_table 'nil)
    (value value)))

(defun prev (table key)
  "Get the previous key in the TABLE starting from the given KEY"
  (case (mnesia:prev table key)
    ('$end_of_table 'nil)
    (value value)))

(defun prev! (table key)
  "Get the previous key in the TABLE starting from the given KEY in a
dirty operation"
  (case (mnesia:dirty_prev table key)
    ('$end_of_table 'nil)
    (value value)))

(defun last (table)
  "Get the last key in the TABLE"
  (case (mnesia:last table)
    ('$end_of_table 'nil)
    (value value)))

(defun last! (table)
  "Get the last key in the TABLE in a dirty operation"
  (case (mnesia:dirty_last table)
    ('$end_of_table 'nil)
    (value value)))

(defun select (table spec)
  "Select records in the given TABLE using a SPEC"
  (mnesia:select table spec))

(defun select
  ((table spec limit) (when (is_integer limit))
   "Select records in the given TABLE using a SPEC passing a LIMIT"
   (mnesia:select table spec limit 'read))
  ((table spec lock) (when (is_atom lock))
   "Select records in the given TABLE using a SPEC passing a LOCK"
   (case (lists:member lock (list 'read 'write))
     ('true (mnesia:select table spec lock))
     (otherwise 'invalid_lock))))

(defun select (table lock spec limit)
  "Select records in the given TABLE using a SPEC passing a LIMIT and
a LOCK"
  (case (lists:member lock (list 'read 'write))
    ('true (mnesia:select table spec limit lock))
    (otherwise 'invalid_lock)))

(defun select! (table spec)
  "Select records in the given TABLE using a SPEC in a dirty
operation"
  (mnesia:dirty_select table spec))

(defun match (table lock pattern)
  "Select records in the given table using simple don't care values"
  (case (lists:member lock (list 'read 'write))
    ('true (mnesia:match_object table lock pattern))
    (otherwise 'invalid_lock)))

(defun match! (table pattern)
  "Select records in the given table using simple don't care values in
a dirty operation"
  (mnesia:dirty_match_object table pattern))

(defun foldl (table acc fn)
  "Fold the whole given table from the left"
  (mnesia:foldl fn acc table))

(defun foldr (table acc fn)
  "Fold the whole given table from the right"
  (mnesia:foldr fn acc table))

(defun delete (table key)
  "Delete the given KEY on the TABLE using a 'write lock"
  (delete table key 'write))

(defun delete (table key lock)
  "Delete the given KEY on the TABLE using the LOCK"
  (mnesia:delete table key lock))

(defun delete! (table key)
  "Delete the given KEY on the TABLE in a dirty operation"
  (mnesia:dirty_delete table key))

(defun write (table data)
  "Write the given DATA in the TABLE using a 'write lock"
  (write table data 'write))

(defun write (table data lock)
  "Write the given DATA in the TABLE using the LOCK"
  (mnesia:write table data lock))

(defun write! (table data)
  "Write the given DATA in the TABLE in a dirty operation"
  (mnesia:dirty_write table data))
