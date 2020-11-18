PRO FIT_MEASURED_3D, DataSet, tolerance=tol, Grid_size=grid

	IF N_ELEMENTS(DataSet) EQ 0 THEN DataSet = 'AC51a'
	IF N_ELEMENTS(tol) EQ 0 THEN tol = 0.1
	IF N_ELEMENTS(grid) EQ 0 THEN grid = 1

	DEVICE, Decomposed = 0
	DEVICE, Bypass_Translation = 0

;Display settings

	Parameters = ['FP', 'TP', 'PS', 'TE']
    range = FLTARR(4,2)
    range[0,*] = [0,0.05] ;FP
    range[1,*] = [0,20] ;TP
    range[2,*] = [0,0.01] ;PS
    range[3,*] = [0,300] ;TE

;Export path

	folder = Dataset
	folder += '_[tolerance '+ strcompress(tol,/remove_all) +']'
	folder += '_[gridsize '+ strcompress(grid,/remove_all) +']'
 	path = MDR_PATH('Results') + folder + '\'
	FILE_MKDIR, path

;Load data and export

	LOAD_DATA, DataSet, time=time, Caif=Ca, Data=Source, Baseline=Baseline
	n = Size(Source, /Dimensions)
	Independent = {t:time, ca:Ca, n0:Baseline}

  	file = path + 'Dynamics'
  	EXPORT_GIF, Source, file, [0,max(Source)]

;Fit parameters

	win = {p:[0,0L,0], n:n[1:3]}
    ModelName = 'TwoCompartmentFiltration'

;Perform MDR and export

    current_time = systime(1)
  	MOCOMO, source, ModelName, Independent, GRID_SIZE=grid, TOLERANCE=tol, WINDOW=win, DEFORMATION_FIELD=Def
  	calculation_time = systime(1)-current_time
  	print, 'Calculation time (min)', calculation_time/60.0

  	file = path + 'Dynamics_mdr'
  	EXPORT_GIF, Source, file, [0,max(Source)]

	nd = SIZE(Def, /DIMENSIONS)
  	file = path + 'Deformation_fields_X'
  	EXPORT_GIF, REFORM(Def[*,0,*,*,*]), file, [0,max(Def)]
   	file = path + 'Deformation_fields_Y'
  	EXPORT_GIF, REFORM(Def[*,1,*,*,*]), file, [0,max(Def)]
  	file = path + 'Deformation_fields_Z'
  	EXPORT_GIF, REFORM(Def[*,2,*,*,*]), file, [0,max(Def)]

;Fit MDR and export

	source = MoCoModelFit(Source, ModelName, Independent, PARAMETERS=p_rec)
	IF ModelName EQ 'TwoCompartmentFiltration' THEN p_rec = PHYSICAL_2CFM_PARS(p_rec)

  	file = path + 'Dynamics_mdr_fit'
  	EXPORT_GIF, Source, file, [0,max(Source)]
  	FOR par=0L,3 DO BEGIN
	  file = path + parameters[par] + '_mdr_fit'
	  EXPORT_TIF, REFORM(p_rec[par,*,*,*]), file, Range[par,*]
    ENDFOR


END



