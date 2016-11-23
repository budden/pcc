(in-package #:pcc)

(defun bjobcode ()
  (setf (gethash 'INT astypnames) (tab ".long"))
  (setf (gethash 'UNSIGNED astypnames) (tab ".long"))
  (setf (gethash 'LONG astypnames) (tab ".quad"))
  (setf (gethash 'ULONG astypnames) (tab ".quad"))
  (let ((gp_offset (addname "gp_offset"))
	(fp_offset (addname "fp_offset"))
	(overflow_arg_area (addname "overflow_arg_area"))
	(reg_save_area (addname "reg_save_area"))
	(rp (bstruct nil 'SNAME nil))
    ))
