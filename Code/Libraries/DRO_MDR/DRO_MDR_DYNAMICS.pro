
FUNCTION DRO_MDR_DYNAMICS, Time, Ca, PARAMS=p

  p = DRO_MDR_MAPS()
  N = SIZE(p, /DIMENSIONS)

  NX = N[1]
  NY = N[2]
  NT = N_ELEMENTS(time)

  x = findgen(NX)/(NX-1.0)
  y = findgen(NY)/(NY-1.0)

  R10 = 0.5 + x ## (1-(2*y-1)^2) ;/s
  relaxivity = 5.0 ;Hz/mM
  TR = 0.004 ;s
  S0 = 1.0/(TR*relaxivity) ;chosen to give a scale factor of 1
  S0fat = 1

  Dynamic_data = fltarr(NT,NX,NY)

  FOR x=0L,NX-1 DO BEGIN
 	 FOR y=0L,NY-1 DO BEGIN
    	CONC_2CFM, [time,ca], P[*,x,y], conc
    	Dynamic_data[*,x,y] = S0fat + S0*TR*(R10[x,y] + relaxivity*conc)
	 ENDFOR
  ENDFOR

  RETURN, Dynamic_data
END
