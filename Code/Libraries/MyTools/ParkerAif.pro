;Description
;-----------
;
;Returns the experimentally derived
;population-averaged AIF as measured by
;Parker et al.(2006) Magn Reson Med 56: 993-1000
;-- extended with a baseline of 20s
;
;
;Syntax
;------
;
;ca = ParkerAif(t, t0)
;
;
;Arguments
;---------
;
;t: an array of time points, in seconds
;   where the function values are to be calculated
;t0: baseline in sec
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
;ca: an arry of the same length as t,
;    containing the plasma concentration in mM
;    at the corresponding times
;
;
;Example
;-------
;
;Plot the AIF for 60s in steps of 2s
;
;IDL> tacq = 60.0 & dt = 2.0
;IDL> nt = 1+floor(tacq/dt)
;IDL> t = findgen(nt)*dt
;IDL> plot, t, ParkerAif(t, 15)


;-----------------------------------------------------------------------------
;    Copyright (C) 2015, Steven Sourbron

;-----------------------------------------------------------------------------

function ParkerAif, t, t0

	A1=0.809 & A2=0.330 & T1=0.17046 & T2=0.365 & s1=0.0563 & s2=0.132
	a=1.050 & b=0.1685 & s=38.078 & tt=0.483

	AIF = exp(-(t/60.-T1)^2/(2*s1^2))*A1/(s1*sqrt(2*!PI)) $
	    + exp(-(t/60.-T2)^2/(2*s2^2))*A2/(s2*sqrt(2*!PI)) $
	    + a*exp(-b*t/60.)/(1+exp(-s*(t/60.-tt)))

	n0 = total(t LT t0)
	AIF = Shift(AIF,n0)
	AIF[0:n0-1]=0

	return, AIF
end