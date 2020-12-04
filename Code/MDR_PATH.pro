

FUNCTION MDR_PATH, which

  CASE which OF

    'Data': RETURN, 'C:\Data\' ;path where the data are stored
    'Results': RETURN, 'C:\Results\' ;path where the results will be stored

  ENDCASE

END