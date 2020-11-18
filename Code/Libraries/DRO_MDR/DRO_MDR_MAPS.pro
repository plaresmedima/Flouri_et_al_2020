
 FUNCTION DRO_MDR_MAPS

 NX = 256 & NY = 256

 Params_maps = fltarr(4,NX,NY)

 x0R = 92. & y0R = 102.
 WR1 = 41. & HR1 = 26.
 WR2 = 33. & HR2 = 18.
 WR3 = 22. & HR3 = 10.

 x0L = 172. & y0L = 102.
 WL1 = 38. & HL1 = 21.
 WL2 = 30. & HL2 = 15.
 WL3 = 18. & HL3 = 6.

 xS = 172. & yS  = 162.
 WS = 20.  & HS	 = 40.

 xL = 72.  & yL  = 172.
 WL = 40.  & HL	 = 50.

 p = DRO_MDR_PARAMETERS(7)
 FOR i=0L, NX-1 DO BEGIN
   FOR j=0L, NY-1 DO BEGIN
  	  Params_maps[0,i,j]= p[0]
  	  Params_maps[1,i,j]= p[1]
  	  Params_maps[2,i,j]= p[2]
  	  Params_maps[3,i,j]= p[3]
   ENDFOR
 ENDFOR

 p = DRO_MDR_PARAMETERS(9)
 FOR i=0L, NX-1 DO BEGIN
   FOR j=0L, NY-1 DO BEGIN
	 IF (j-yL)^2./WL^2+(i-xL)^2./HL^2. LE 1 THEN BEGIN
  	    Params_maps[0,i,j]= p[0]
  	    Params_maps[1,i,j]= p[1]
  	    Params_maps[2,i,j]= p[2]
  	    Params_maps[3,i,j]= p[3]
	 ENDIF
   ENDFOR
 ENDFOR

 p = DRO_MDR_PARAMETERS(8)
 FOR i=0L, NX-1 DO BEGIN
   FOR j=0L, NY-1 DO BEGIN
	 IF (j-yS)^2./WS^2+(i-xS)^2./HS^2. LE 1 THEN BEGIN
  	    Params_maps[0,i,j]= p[0]
  	    Params_maps[1,i,j]= p[1]
  	    Params_maps[2,i,j]= p[2]
  	    Params_maps[3,i,j]= p[3]
	 ENDIF
   ENDFOR
 ENDFOR

 p = DRO_MDR_PARAMETERS(1)
 FOR i=0L, NX-1 DO BEGIN
   FOR j=0L, NY-1 DO BEGIN
	 IF (j-y0L)^2./WL1^2+(i-x0L)^2./HL1^2. LE 1 THEN BEGIN
  	    Params_maps[0,i,j]= p[0]
  	    Params_maps[1,i,j]= p[1]
  	    Params_maps[2,i,j]= p[2]
  	    Params_maps[3,i,j]= p[3]
	 ENDIF
   ENDFOR
 ENDFOR

 p = DRO_MDR_PARAMETERS(2)
 FOR i=0L, NX-1 DO BEGIN
   FOR j=0L, NY-1 DO BEGIN
	 IF (j-y0L)^2./WL2^2+(i-x0L)^2./HL2^2. LE 1 THEN BEGIN
  	    Params_maps[0,i,j]= p[0]
  	    Params_maps[1,i,j]= p[1]
  	    Params_maps[2,i,j]= p[2]
  	    Params_maps[3,i,j]= p[3]
	 ENDIF
   ENDFOR
 ENDFOR

 p = DRO_MDR_PARAMETERS(3)
 FOR i=0L, NX-1 DO BEGIN
   FOR j=0L, NY-1 DO BEGIN
	 IF (j-y0L)^2./WL3^2+(i-x0L)^2./HL3^2. LE 1 THEN BEGIN
  	    Params_maps[0,i,j]= p[0]
  	    Params_maps[1,i,j]= p[1]
  	    Params_maps[2,i,j]= p[2]
  	    Params_maps[3,i,j]= p[3]
	 ENDIF
   ENDFOR
 ENDFOR

 p = DRO_MDR_PARAMETERS(4)
 FOR i=0L, NX-1 DO BEGIN
   FOR j=0L, NY-1 DO BEGIN
	 IF (j-y0R)^2./WR1^2+(i-x0R)^2./HR1^2. LE 1 THEN BEGIN
  	    Params_maps[0,i,j]= p[0]
  	    Params_maps[1,i,j]= p[1]
  	    Params_maps[2,i,j]= p[2]
  	    Params_maps[3,i,j]= p[3]
	 ENDIF
   ENDFOR
 ENDFOR

 p = DRO_MDR_PARAMETERS(5)
 FOR i=0L, NX-1 DO BEGIN
   FOR j=0L, NY-1 DO BEGIN
	 IF (j-y0R)^2./WR2^2.+(i-x0R)^2./HR2^2. LE 1 THEN BEGIN
  	    Params_maps[0,i,j]= p[0]
  	    Params_maps[1,i,j]= p[1]
  	    Params_maps[2,i,j]= p[2]
  	    Params_maps[3,i,j]= p[3]
   	 ENDIF
   ENDFOR
 ENDFOR

 p = DRO_MDR_PARAMETERS(6)
 FOR i=0L, NX-1 DO BEGIN
   FOR j=0L, NY-1 DO BEGIN
     IF (j-y0R)^2./WR3^2.+(i-x0R)^2./HR3^2. LE 1 THEN BEGIN
  	    Params_maps[0,i,j]= p[0]
  	    Params_maps[1,i,j]= p[1]
  	    Params_maps[2,i,j]= p[2]
  	    Params_maps[3,i,j]= p[3]
	 ENDIF
   ENDFOR
 ENDFOR

 RETURN, Params_maps

END


