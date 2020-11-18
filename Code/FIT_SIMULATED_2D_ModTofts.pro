PRO FIT_SIMULATED_2D_ModTofts, DataSet, tolerance=tol, Grid_size=grid, NCR=ncr, NOMOCO=nomoco, ERROR=p_err, SUBFOLDER=subfolder

	IF N_ELEMENTS(NCR) EQ 0 THEN NCR=0E
	IF N_ELEMENTS(subfolder) EQ 0 THEN subfolder=''

	DEVICE, Decomposed = 0
	DEVICE, Bypass_Translation = 0

;Display settings

   	Parameters = ['Ktrans', 'VP', 'VE']
    range = FLTARR(3,2)
    range[0,*] = [0,0.05] ;Ktrans
    range[1,*] = [0,1] ;VP
    range[2,*] = [0,1] ;VE

;Export path

	folder = Dataset
	folder += '_[CNR '+ strcompress(1/NCR,/remove_all) +']'
	IF N_ELEMENTS(tol) NE 0 THEN folder += '_[tolerance '+ strcompress(tol,/remove_all) +']'
	IF N_ELEMENTS(grid) NE 0 THEN folder += '_[gridsize '+ strcompress(grid,/remove_all) +']'
 	path = MDR_PATH('Results') + subfolder + folder + '\'
	FILE_MKDIR, path

;Load simulated data

	LOAD_DATA, DataSet, time=time, Caif=Ca, Data=Data, Baseline=Baseline
	Source = REFORM(Data[*,*,*,0])
	n = Size(Source, /Dimensions)
	Independent = {t:time, ca:Ca, n0:Baseline}

;Add noise and export

	Source += ncr*max(Ca)*RANDOMN(seed, n)
	EXPORT_GIF, source, path + 'Dynamics', [0,max(source)]

;Fit parameters

	win = {p:[0,0L], n:n[1:2]}
	ModelName = 'ModifiedTofts'

;Fit data and export

	IF KEYWORD_SET(nomoco) THEN BEGIN
	 ; Source = MoCoModelFit(Source, ModelName, Independent, PARAMETERS=p_rec)
	 ; IF ModelName EQ 'TwoCompartmentFiltration' THEN p_rec = PHYSICAL_2CFM_PARS(p_rec)
	  Source = MoCoModelFit(Source, ModelName, Independent, PARAMETERS=p_rec)
	  p_rec = physical_ModTofts_pars(p_rec)
  	  EXPORT_GIF, Source, path + 'Dynamics_fit', [0,max(source)]
  	  p_err = DRO_MDR_ERROR(Data[*,*,*,1:*], p_rec, win, p_fix=p_fix)
	  FOR par=0L,3 DO BEGIN
	    file = path + parameters[par] + '_fit'
	    EXPORT_TIF, REFORM(p_rec[par,*,*]), file, Range[par,*]
	    file = path + parameters[par] + '_fit_truth.tif'
		EXPORT_TIF, REFORM(p_fix[par,*,*]), file, Range[par,*]
       	file = path + parameters[par] + '_fit_error'
       	EXPORT_TIF, REFORM(p_err[par,*,*]), file, [-20,20]
      ENDFOR
      RETURN
    ENDIF

;Perform MDR and export

    current_time = systime(1)
  	MOCOMO, source, ModelName, Independent, GRID_SIZE=grid, TOLERANCE=tol, WINDOW=win, DEFORMATION_FIELD=Def
  	calculation_time = systime(1)-current_time
  	print, 'Calculation time (min)', calculation_time/60.0
  	EXPORT_GIF, source, path + 'Dynamics_mdr', [0,max(source)]
  	EXPORT_GIF, Def, path + 'Deformation_fields', [0,max(Def)]

;Fit MDR and export
;	Source = MoCoModelFit(Source, ModelName, Independent, PARAMETERS=p_rec)
;	IF ModelName EQ 'TwoCompartmentFiltration' THEN p_rec = PHYSICAL_2CFM_PARS(p_rec)
	Source = MoCoModelFit(Source, ModelName, Independent, PARAMETERS=p_rec)
	p_rec = physical_ModTofts_pars(p_rec)
	EXPORT_GIF, Source, path + 'Dynamics_mdr_fit', [0,max(source)]

;Calculate error maps and export results

	p_err = DRO_MDR_ERROR(Data[*,*,*,1:*], p_rec, win, p_fix=p_fix)
	FOR par=0L,2 DO BEGIN
		file = path + parameters[par] + '_mdr'
	   	EXPORT_TIF, REFORM(p_rec[par,*,*]), file, Range[par,*]
		file = path + parameters[par] + '_mdr_truth.tif'
		EXPORT_TIF, REFORM(p_fix[par,*,*]), file, Range[par,*]
       	file = path + parameters[par] + '_mdr_error'
       	EXPORT_TIF, REFORM(p_err[par,*,*]), file, [-20,20]
    ENDFOR


END



