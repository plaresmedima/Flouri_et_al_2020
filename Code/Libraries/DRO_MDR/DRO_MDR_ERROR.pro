FUNCTION DRO_MDR_ERROR, p_truth, p_rec, win, p_fix=p_fix

	n = SIZE(p_truth, /Dimensions)

    x0 = win.p[0] & x1 = win.p[0] + win.n[0]-1
    y0 = win.p[1] & y1 = win.p[1] + win.n[1]-1

	Error = FLTARR(n[0])

	FOR i=0L, n[0]-1 DO BEGIN
	    ErrImg = p_rec[0,x0:x1,y0:y1] - p_truth[i,x0:x1,y0:y1,0]
	    Error[i] = MEDIAN(ABS(ErrImg))
	ENDFOR
	minErr = min(Error, MotionFreeState)

	p_fix = REFORM(p_truth[MotionFreeState,*,*,*])
	p_fix = TRANSPOSE(p_fix,[2,0,1])
	p_err = p_rec - p_fix
	FOR par=0L, n[3]-1 DO p_err[par,*,*] *= 100/max(p_fix[par,*,*])

	RETURN, p_err

END