;REQUIRES packages:

; MDR_Library
; Data

PRO DRO_MDR_DATA_NONRIGIDMOTION, path

;Simulation parameters

  Tacq	= 300.0 	;sec
  dt 	= 2.0 		;sec
  NCR 	= 0./100 	;Noise level
  Border = 16		;to remove from image
  Ampl	= 5 		;scaling factor to increase the motion amplitude

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

;Generate deformation field from measured data

  LOAD_DATA, 'Window', time=time_source, Caif=Ca_source, Data=Source, Baseline=Baseline
  Independent = {t:time_source, ca:Ca_source, n0:Baseline}
  MOCOMO, Source, 'TwoCompartmentFiltration', Independent, GRID_SIZE=128, TOLERANCE=1.0, DEFORMATION_FIELD=B
  nB = size(B,/Dimensions)
  Ns = size(Source, /Dimensions)
  B0 = FFD_2D_INIT([0,0], Ns[1:2], nB[2:*], Ns[0])
  dB = Ampl*(B-B0)
  B0 = FFD_2D_INIT([0,0], N[1:2], nB[2:*], N[0])
  B  = B0 + dB[0:N[0]-1,*,*,*]

;Apply deformations

  Simulated =  FLTARR([N[0],5,N[1:2]])
  FOR i=0L, Nt-1 DO BEGIN
    Bi = REFORM(B[i,*,*,*])
    Simulated[i,0,*,*] =  FFD_2D(REFORM(Dynamic_data[i,*,*]), Bi)
  	FOR p=1L,4 DO $
  	  Simulated[i,p,*,*] =  FFD_2D(REFORM(pars[p-1,*,*]), Bi)
  ENDFOR

;Remove image border

  Simulated = Simulated[*,*,Border:N[1]-1-Border,Border:N[2]-1-Border]
  N[1:2] = N[1:2] - 2*Border

;Add noise

 Simulated[*,0,*,*] += NCR*max(Ca)*RANDOMN(seed, N)

;Export data

  FILE_MKDIR, path
  Data = 'NonRigid_Motion'

  PMI__WritePlot, path + Data + '_AIF.txt', Time, Ca
  openw, 1, path + Data + '_DCE.dat'
  writeu, 1, TRANSPOSE(Simulated, [2,3,1,0]) ;x,y,z,t
  close, 1

 END


















