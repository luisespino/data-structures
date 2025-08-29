; Depth First Search Algorithm
; Copyrigth (c) 2015 Luis Espino

; Problem: Points matrix
; Sucesors rule: every possible node around
; 1 2 3
; 4 5 6
; 7 8 9

(defun successors (node)
    (cond
        ((= node 1) (list 2 4 5))
        ((= node 2) (list 1 3 4 5 6))
        ((= node 3) (list 2 5 6))
        ((= node 4) (list 1 2 5 7 8))
        ((= node 5) (list 1 2 3 4 6 7 8 9))
        ((= node 6) (list 2 3 5 8 9))
        ((= node 7) (list 4 5 8))
        ((= node 8) (list 4 5 6 7 9))
        ((= node 9) (list 5 6 8))
        (t nil)))

(defun depth-search (start-node end-node)
    (format t "DEPTH FIRST SEARCH:~%~%")
    (setq l (list start-node))
    (loop until (null l) do
        (setq current-node (car l))
        (format t "Current node: ~a~%" current-node)
        (setq l (cdr l))
        (if (= current-node end-node) 
            (return-from depth-search (print "SOLUTION FOUND")))
        (setq temp (successors current-node))
        (setq temp (reverse temp)) ; to avoid cycling
        (format t "Current node successors: ~a~%" temp)
        (if (not (null temp)) (setq l (append temp l)))
        (format t "List content: ~a~%~%" l))
    (print "SOLUTION NOT FOUND"))

(depth-search 1 9)
(format t "~%")
(quit)
