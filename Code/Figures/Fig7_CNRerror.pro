
PRO Fig7_CNRerror_export, Percent, x_var, file

    window, 1, xsize=300, ysize=250, xpos=0, ypos=0
    window, 2, xsize=1200, ysize=250, xpos=0, ypos=0

	Parameters = ['FP','TP','PS','TE']
    plotrange = fltarr(4,2)
	range = [-100., 100.]
    plotrange[0,*] = range
    plotrange[1,*] = range
   	plotrange[2,*] = range
	plotrange[3,*] = range

	array = strarr(10,1+n_elements(x_var))
	array[1:*,0] = ['1%','5%','10%','25%','50%','75%','90%','95%','99%']
	array[0,1:*] = strcompress(x_var,/remove_all)

    path = MDR_PATH('Results') + file

	pos = 0
    FOR par=0,3 DO BEGIN

	   array[0,0] = Parameters[par]
	   values = REFORM(Percent[par,*,*])
	   array[1:*,1:*] = strcompress(values,/remove_all)
	   PMI__write_csv, path + Parameters[par] + '.csv', array

       WSET, 1
       PLOT,  [min(x_var),max(x_var)], plotrange[par,*], $
           /nodata, color=0, background=255, /YSTYLE, /XSTYLE, $
           XTITLE = 'log10(CNR)', YTITLE = 'Error (%)', $
           TITLE=Parameters[par]
       OPLOT, x_var, Percent[par,4,*], color=0, psym=4
       OPLOT, x_var, x_var*0, color=0, linestyle=1
       ERRPLOT, x_var , Percent[par,4-3,*], Percent[par,4+3,*], color=0
       img = tvrd()

       WSET, 2
       TVSCL, img, pos
       pos = pos+1

    ENDFOR

    WDELETE, 1
    write_tiff, path + '.tif', reverse(tvrd(),2)
END



PRO Fig7_CNRerror

	tolerance = 0.3
	grid_size = 32

	nCNR = 10
	CNRmin = 0.0
	CNRmax = 4.0
    CNR = CNRmin + (CNRmax-CNRmin)*lindgen(nCNR)/(nCNR-1E)
    NCR = 1E/(10E^CNR)

    percentiles = [1.,5, 10, 25, 50, 75, 90, 95, 99]
    Parameters = ['FP','TP','PS','TE']
	Percent = fltarr(4,N_ELEMENTS(percentiles),nCNR) ;(parameters) x (Percentiles) x (noise levels)

	DataSet = ['NonRigid_Motion', 'Rigid_Motion', 'Motion_Free']

	fig7_folder = 'Fig7_CNRerror\'
	FILE_MKDIR, MDR_PATH('Results') + fig7_folder

	nomoco = 1

	FOR data=0,n_elements(DataSet)-1 DO BEGIN
	  FOR i=0L,nCNR-1 DO BEGIN

	  	FIT_SIMULATED_2D, DataSet[data], NCR=NCR[i], ERROR=p_err, NOMOCO=nomoco;, SUBFOLDER=fig7_folder+ 'noMDR\'
		FOR par=0L,3 DO Percent[par,*,i] = PERC(p_err[par,*,*], percentiles)

	  ENDFOR
	  Fig7_CNRerror_export, Percent, CNR, fig7_folder + 'noMDR' + Dataset[data]
	ENDFOR

	nomoco = 0

	FOR data=0,n_elements(DataSet)-1 DO BEGIN
	  FOR i=0L,nCNR-1 DO BEGIN

	  	FIT_SIMULATED_2D, DataSet[data], NCR=NCR[i], ERROR=p_err, NOMOCO=nomoco, TOLERANCE=Tolerance, GRID_SIZE=Grid_size;, SUBFOLDER=fig7_folder+ 'MDR\'
		FOR par=0L,3 DO Percent[par,*,i] = PERC(p_err[par,*,*], percentiles)

	  ENDFOR
	  Fig7_CNRerror_export, Percent, CNR, fig7_folder + 'MDR' + Dataset[data]
	ENDFOR

END



