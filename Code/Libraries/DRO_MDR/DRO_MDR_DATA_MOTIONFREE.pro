
 PRO DRO_MDR_DATA_MOTIONFREE, path ;for output

;Simulation parameters

  Tacq 	= 300.0 	;sec
  dt 	= 2.0 		;sec
  NCR 	= 0./50 	;Noise level
  Border = 16		;to remove from image

;Display settings

  ParNames = ['FP', 'TP', 'PS', 'TE']
  range = FLTARR(4,2)
  range[0,*] = [0,0.05]  ;FP
  range[1,*] = [0,20]    ;TP
  range[2,*] = [0,0.01]  ;PS
  range[3,*] = [0,300]   ;TE

;Generate AIF

  nt = 1 + Tacq/dt
  time = dt*findgen(nt)
  Ca = ParkerAif(time,30.)

;Generate motion-free data

  Dynamic_data = DRO_MDR_DYNAMICS(Time, Ca, PARAMS=pars)
  N = SIZE(Dynamic_data, /DIMENSIONS)

;Apply deformations (motion-free)

  Simulated = FLTARR([N[0],5,N[1:2]])
  FOR i=0L, Nt-1 DO BEGIN
  	Simulated[i,0,*,*] = Dynamic_Data[i,*,*]
    FOR p=1L,4 DO $
      Simulated[i,p,*,*] = pars[p-1,*,*]
  ENDFOR

;Remove image border

  Simulated = Simulated[*,*,Border:N[1]-1-Border,Border:N[2]-1-Border]
  N[1:2] = N[1:2] - 2*Border

;Add noise

  Simulated[*,0,*,*] += NCR*max(Ca)*RANDOMN(seed, N)

;Export data

  FILE_MKDIR, path
  Data = 'Motion_Free'

  PMI__WritePlot, path + Data + '_AIF.txt', Time, Ca
  openw, 1, path + Data + '_DCE.dat'
  writeu, 1, TRANSPOSE(Simulated, [2,3,1,0]) ;x,y,z,t
  close, 1

 END