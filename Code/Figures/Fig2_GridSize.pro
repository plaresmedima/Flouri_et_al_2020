PRO Fig2_GridSize

;Fit simulated data in 2D, with different grid sizes

	FIT_SIMULATED_2D, 'NonRigid_Motion', /NOMOCO
	FIT_SIMULATED_2D, 'NonRigid_Motion', tolerance=0.1, Grid_size=128
	FIT_SIMULATED_2D, 'NonRigid_Motion', tolerance=0.1, Grid_size=64
	FIT_SIMULATED_2D, 'NonRigid_Motion', tolerance=0.1, Grid_size=32
	FIT_SIMULATED_2D, 'NonRigid_Motion', tolerance=0.1, Grid_size=16
	FIT_SIMULATED_2D, 'NonRigid_Motion', tolerance=0.1, Grid_size=8
	FIT_SIMULATED_2D, 'NonRigid_Motion', tolerance=0.1, Grid_size=4
	FIT_SIMULATED_2D, 'NonRigid_Motion', tolerance=0.1, Grid_size=2

;Fit measure data in 2D, with different grid sizes

	FIT_MEASURED_2D, 'Vol_E', /NOMOCO
	FIT_MEASURED_2D, 'Vol_E', tolerance=0.1, Grid_size=256
	FIT_MEASURED_2D, 'Vol_E', tolerance=0.1, Grid_size=128
	FIT_MEASURED_2D, 'Vol_E', tolerance=0.1, Grid_size=64
	FIT_MEASURED_2D, 'Vol_E', tolerance=0.1, Grid_size=32


END