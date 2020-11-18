
PRO FIT_MEASURED_2D_ModTofts, DataSet, tolerance=tol, Grid_size=grid, NOMOCO=nomoco

	IF N_ELEMENTS(DataSet) EQ 0 THEN DataSet = 'RIFF_C03'
	IF N_ELEMENTS(tol) EQ 0 THEN tol = 0.1
	IF N_ELEMENTS(grid) EQ 0 THEN grid = 1

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
	IF N_ELEMENTS(tol) NE 0 THEN folder += '_[tolerance '+ strcompress(tol,/remove_all) +']'
	IF N_ELEMENTS(grid) NE 0 THEN folder += '_[gridsize '+ strcompress(grid,/remove_all) +']'
 	path = MDR_PATH('Results') + folder + '\'
	FILE_MKDIR, path

;Load data and export

	LOAD_DATA, DataSet, time=time, Caif=Ca, Data=Source, Baseline=Baseline
	n = Size(Source, /Dimensions)
	Independent = {t:time, ca:Ca, n0:Baseline}
  	file = path + 'Dynamics'
  	EXPORT_GIF, REFORM(Source), file, [0,max(Source)]

;Fit parameters

	win = {p:[0,0L], n:n[1:2]}
    ModelName = 'ModifiedTofts'

;Fit data and export

	IF KEYWORD_SET(nomoco) THEN BEGIN
	  Source = MoCoModelFit(Source, ModelName, Independent, PARAMETERS=p_rec)
	  p_rec = physical_ModTofts_pars(p_rec)
  	  file = path + 'Dynamics_fit'
  	  EXPORT_GIF, Source, file, [0,max(source)]
	  FOR par=0L,2 DO BEGIN
	    file = path + parameters[par] + '_fit'
	    EXPORT_TIF, REFORM(p_rec[par,*,*]), file, Range[par,*]
      ENDFOR
      RETURN
    ENDIF

;Perform MDR and export

    current_time = systime(1)
  	MOCOMO, source, ModelName, Independent, GRID_SIZE=grid, TOLERANCE=tol, WINDOW=win, DEFORMATION_FIELD=Def
  	calculation_time = systime(1)-current_time
  	print, 'Calculation time (min)', calculation_time/60.0

  	file = path + 'Dynamics_mdr'
  	EXPORT_GIF, source, file, [0,max(source)]
  	file = path + 'Deformation_fields_X'
  	EXPORT_GIF, REFORM(Def[*,0,*,*]), file, [0,max(Def)]
  	file = path + 'Deformation_fields_Y'
  	EXPORT_GIF, REFORM(Def[*,1,*,*]), file, [0,max(Def)]

;Fit MDR and export

	source = MoCoModelFit(Source, ModelName, Independent, PARAMETERS=p_rec)
	p_rec = physical_ModTofts_pars(p_rec)

  	file = path + 'Dynamics_mdr_fit'
  	EXPORT_GIF, source, file, [0,max(source)]
	FOR par=0L,2 DO BEGIN
		file = path + parameters[par] + '_mdr'
	   	EXPORT_TIF, REFORM(p_rec[par,*,*]), file, Range[par,*]
    ENDFOR


END



