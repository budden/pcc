(in-package #:pcc)

(defvar bdebug)
(defvar ddebug)
(defvar edebug)
(defvar idebug)
(defvar ndebug)
(defvar odebug)
(defvar pdebug)
(defvar sdebug)
(defvar tdebug)
(defvar xdebug)
; (defvar wdebug) in mip-common
(defvar b2debug)
(defvar c2debug)
(defvar e2debug)
(defvar f2debug)
(defvar g2debug)
(defvar o2debug)
(defvar r2debug)
(defvar s2debug)
(defvar t2debug)
(defvar u2debug)
(defvar x2debug)
(defvar gflag)
(defvar kflag)
(defvar pflag)
(defvar sflag)
(defvar sspflag)
(defvar xssa)
(defvar xtailcall)
(defvar xtemps)
(defvar xdeljumps)
(defvar xdce)
(defvar xinline)
(defvar xccp)
(defvar xgnu89)
(defvar xgnu99)
(defvar xuchar)
(defvar freestanding)
(defvar prgname "pcc")

(defun xopt (x)
  (dolist (e x)
    (ecase e
      ((ssa) (incf xssa))
      ((tailcall) (incf xtailcall))
      ((tailcall) (incf xtailcall))
      ((deljumps) (incf xdeljumps))
      ((dce) (incf xdce))
      ((inline) (incf xinline))
      ((ccp) (incf xccp))
      ((gnu89) (incf xgnu89))
      ((gnu99) (incf xgnu99))
      ((uchar) (incf xuchar)))))

(defun fflags (f)
  (dolist (e f)
    (case e
      ((stack-protector) (setf sspflag 1))
      ((stack-protector-all) (setf sspflag 1))
      ((freestanding) (setf freestanding 1))
      ((pack-struct) (setf pragma_allpacked 1))
      (else
       (if (and (consp e) (eq (car e) 'pack-struct))
           (setf pragma_allpacked (cdr e))
           (error "unknown -f option ~a" e))))))



(defun main (#:key Xb Xd Xe Xi Xn Xo Xp Xs Xt Xx 
                   Zb Zc Ze Zf Zg Zn Zo Zr Zs Zt Zu Zx
                   f g k m p s w ww x)
  (setf bdebug 0 ddebug 0 edebug 0 idebug 0 ndebug 0 
        odebug 0 pdebug 0 sdebug 0 tdebug 0 xdebug 0 wdebug 0
        b2debug 0 c2debug 0 e2debug 0 f2debug 0 g2debug 0 o2debug 0
        r2debug 0 s2debug 0 t2debug 0 u2debug 0 x2debug 0
        gflag 0 kflag 0 pflag 0 sflag 0 sspflag 0
        xssa 0 xtailcall 0 xtemps 0 xdeljumps 0 xdce 0 xinline 0 
        xccp 0 xgnu89 0 xgnu99 0 xuchar 0 freestanding 0
        pragma_allpacked 0)
  
  (when Xb (incf bdebug)) ; buildtree
  (when Xd (incf ddebug)) ; declarations
  (when Xe (incf edebug)) ; pass1 exit 
  (when Xi (incf idebug)) ; initializations
  (when Xn (incf ndebug)) ; node allocation 
  (when Xo (incf odebug)) ; optim
  (when Xp (incf pdebug)) ; prototype
  (when Xs (incf sdebug)) ; inline
  (when Xt (incf tdebug)) ; type match
  (when Xx (incf xdebug)) ; MD code

  (when Zb (incf b2debug)) ; basic block and SSA building
  (when Zc (incf c2debug)) ; code printout
  (when Ze (incf e2debug)) ; print tree upon pass2 enter
  (when Zf (incf f2debug)) ; instruction matching
  (when Zg (incf g2debug)) ; print flow graphs
  (when Zn (incf n2debug)) ; node allocation
  (when Zo (incf o2debug)) ; instruction generator
  (when Zr (incf r2debug)) ; register alloc/graph coloring
  (when Zs (incf s2debug)) ; shape matching
  (when Zt (incf t2debug)) ; type matching
  (when Zu (incf u2debug)) ; Sethi-Ullman debugging
  (when Zx (incf x2debug)) ; target specific

  (when f (fflags f))   ; Language
  (when g (incf gflag)) ; Debugging
  (when k (incf kflag)) ; PIC code
  (when m (mflags m)) ; Target-specific
  (when p (incf pflag)) ; Profiling
  (when s (incf sflag)) ; Statistics
  (when w (incf wdebug)) ; No warnings emitted
  (when ww (incf (Wflags ww)) ; Enable different warnings
  (when x (xopt x)) ; Enable different warnings

  (mkdope)
  )
  