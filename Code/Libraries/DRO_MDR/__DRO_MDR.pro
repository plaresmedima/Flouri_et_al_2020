;DESCRIPTION:

;	Use the DRO to generate MRR data with different types of motion

;ARGUMENTS:

;	path = folder where the resulst will be stored



PRO __DRO_MDR, path

;Simulate MRR data without motion

	DRO_MDR_DATA_MOTIONFREE, path

;Simulate MRR data with rigid motion

	DRO_MDR_DATA_RIGIDMOTION, path

;Simulate MRR data with non-rigid motion

	DRO_MDR_DATA_NONRIGIDMOTION, path

END