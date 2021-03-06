PRO __MAIN_MDR

;Test function at coarse resolution
;Comment this line out to run all other procedures

	FIT_SIMULATED_2D, 'NonRigid_Motion', tolerance=5, Grid_size=65, NCR=1/50. & RETURN

;Create simulated data

	__DRO_MDR, MDR_PATH('Data') + 'DRO_data\'

;Fit simulated data

	FIT_SIMULATED_2D, 'NonRigid_Motion', tolerance=5.0, Grid_size=32, NCR=0

;Fit measured data (2D, 2CFM)

	FIT_MEASURED_2D, 'Vol_E', tolerance=5.0, Grid_size=32

;Fit measured data (2D, ModTofts)

	FIT_MEASURED_2D_ModTofts, 'Vol_E', tolerance=5.0, Grid_size=32

;Fit measured data (3D)

	FIT_MEASURED_3D, 'AC51a', tolerance=5.0, Grid_size=32

;Generate data for Figure 2

	Fig2_GridSize

;Generate data for Figure 3

	Fig3_Tolerance

;Generate data for Figure 7

	Fig7_CNRerror


END