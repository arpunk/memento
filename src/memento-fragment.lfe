(defmodule memento-fragment
  (export (activate 1) (activate 2)
          (deactivate 1)
          (add 2)
          (delete 1)
          (add-node 2)
          (delete-node 2)
          (properties 1)))

(defun activate (table)
  "Activate fragmentation on the given TABLE"
  (mnesia:change_table_frag table #(activate ())))

(defun activate (table nodes)
  "Active fragmentation on the given TABLE on the given NODES"
  (mnesia:change_table_frag table #(activate (#(node_pool ,nodes)))))

(defun deactivate (table)
  "Deactivate fragmentation on the TABLE"
  (mnesia:change_table_frag table 'deactivate))

(defun add (table nodes)
  "Add a fragment to the TABLE on the given NODES"
  (mnesia:change_table_frag table #(add_frag ,nodes)))

(defun delete (table)
  "Delete all fragments from the given TABLE"
  (mnesia:change_table_frag table 'del_frag))

(defun add-node (table node)
  "Add a given NODE to the fragments of the given TABLE"
  (mnesia:change_table_frag table #(add_node ,node)))

(defun delete-node (table node)
  "Delete a given NODE to the fragments of the given TABLE"
  (mnesia:change_table_frag table #(del_node ,node)))

(defun properties (table)
  "Get the fragment properties of the given TABLE"
  (mnesia:table_info table 'frag_properties))
