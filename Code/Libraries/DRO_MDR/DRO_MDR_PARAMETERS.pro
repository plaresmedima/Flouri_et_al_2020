;Description
;-----------
;
;Defines the synthetic kidney tissues:
;The groundtruth values were taken from a recent study on renal
;artery stenosis [Lim et al AJP 2013].
;
;
;Syntax
;------
;
;Parameters = GroundTruths(tissue)
;
;
;Arguments
;---------
;
;tissue: number from 0 to 6 where
;   0 = Left Outline_1
;   1 = Left Outline_2
;   2 = Left Cortex
;   3 = Left Medulla
;   4 = Right Outline
;   5 = Right Cortex
;   6 = Right Medulla
;
;
;Keywords
;--------
;
;None
;
;
;Returns
;-------
;
;parameters
;    A 4-element array which contains
;    the values [FP, TP, PS, TE] for the required tissue
;
;
;Example
;-------
;
;Display the parameter of the left cortex:
;
;IDL> print, GroundTruths(2)
;     0.050000000       6.5000000    0.0060000000       110.00000


 FUNCTION DRO_MDR_PARAMETERS, tissue

; p = [FP/s,TP*s,PS/s,TE*s]

	CASE tissue OF

    1: p = [300D/6000, 	9D,		45D/6000, 90D] 	;Left Cortex
    2: p = [90D/6000,  	6D,  	60D/6000, 150D] ;Left Outer Medulla
    3: p = [30D/6000,  	9D,  	40D/6000, 300D] ;Left Inner Medulla
    4: p = [300D/6000,  9D,  	45D/6000, 90D]  ;Right Cortex
    5: p = [60D/6000,  	6D,  	60D/6000, 150D] ;Right Outer Medulla
    6: p = [30D/6000,  	9D,  	40D/6000, 300D] ;Right Inner Medulla
    7: p = [40D/6000,   4D,  	8D/6000, 120D] ;Background
    8: p = [100D/6000,  4D	,  	1D/6000, 120D] ;Spleen
    9: p = [70D/6000,   20D	,  	1D/6000, 120D] ;Liver

    ENDCASE

    RETURN, p

 END







