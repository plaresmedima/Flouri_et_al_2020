PRO Fig3_Tolerance

;Fit measured data in 2D, with different tolerances

	FIT_MEASURED_2D, 'RIFF_C03_sl0', tolerance=5.0, Grid_size=32 ;4min
	FIT_MEASURED_2D, 'RIFF_C03_sl0', tolerance=2.0, Grid_size=32 ;7min
	FIT_MEASURED_2D, 'RIFF_C03_sl0', tolerance=1.0, Grid_size=32 ;14min
	FIT_MEASURED_2D, 'RIFF_C03_sl0', tolerance=0.9, Grid_size=32 ;22min
	FIT_MEASURED_2D, 'RIFF_C03_sl0', tolerance=0.8, Grid_size=32 ;23min
	FIT_MEASURED_2D, 'RIFF_C03_sl0', tolerance=0.7, Grid_size=32 ;23min
	FIT_MEASURED_2D, 'RIFF_C03_sl0', tolerance=0.6, Grid_size=32 ;60min
	FIT_MEASURED_2D, 'RIFF_C03_sl0', tolerance=0.5, Grid_size=32 ;60min
	FIT_MEASURED_2D, 'RIFF_C03_sl0', tolerance=0.4, Grid_size=32 ;61min
	FIT_MEASURED_2D, 'RIFF_C03_sl0', tolerance=0.3, Grid_size=32 ;77min
	FIT_MEASURED_2D, 'RIFF_C03_sl0', tolerance=0.2, Grid_size=32 ;88min
	FIT_MEASURED_2D, 'RIFF_C03_sl0', tolerance=0.1, Grid_size=32 ;489min

;Fit simulated data in 2D, with different tolerances

    FIT_SIMULATED_2D, 'NonRigid_Motion', tolerance=0.9, Grid_size=32
    FIT_SIMULATED_2D, 'NonRigid_Motion', tolerance=0.8, Grid_size=32
    FIT_SIMULATED_2D, 'NonRigid_Motion', tolerance=0.7, Grid_size=32
    FIT_SIMULATED_2D, 'NonRigid_Motion', tolerance=0.6, Grid_size=32
    FIT_SIMULATED_2D, 'NonRigid_Motion', tolerance=5.0, Grid_size=32
    FIT_SIMULATED_2D, 'NonRigid_Motion', tolerance=1.0, Grid_size=32
    FIT_SIMULATED_2D, 'NonRigid_Motion', tolerance=0.5, Grid_size=32
    FIT_SIMULATED_2D, 'NonRigid_Motion', tolerance=0.4, Grid_size=32
    FIT_SIMULATED_2D, 'NonRigid_Motion', tolerance=0.3, Grid_size=32
    FIT_SIMULATED_2D, 'NonRigid_Motion', tolerance=0.2, Grid_size=32
    FIT_SIMULATED_2D, 'NonRigid_Motion', tolerance=0.1, Grid_size=32


END