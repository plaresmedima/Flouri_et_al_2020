 PRO LOAD_DATA, dataset, Time=Time, Caif=Caif, Data=Data, Baseline=n0

   CASE dataset OF

	'NonRigid_Motion':begin
	  nx = 224
      ny = 224
      nz = 5
      nt = 151
      n0 = 5E
      Folder = 'DRO_data'
	end

	'Rigid_Motion':begin
	  nx = 224
      ny = 224
      nz = 5
      nt = 151
      n0 = 5E
      Folder = 'DRO_data'
	end

	'Motion_Free':begin
	  nx = 224
      ny = 224
      nz = 5
      nt = 151
      n0 = 5E
      Folder = 'DRO_data'
	end

    'Window':begin
      nx = 251
      ny = 181
      nz = 1
      nt = 181
      n0 = 8E
      Folder = 'Patient_2D'
      slice = 0
    end

    'RIFF_1':begin
      nx = 480
      ny = 480
      nz = 3
      nt = 159
      n0 = 15E
      Folder = 'Patient_2D'
      slice = 1
    end

    'RIFF_C02':begin
      nx = 480
      ny = 480
      nz = 3
      nt = 249
      n0 = 15E
      Folder = 'Patient_2D'
      slice = 1
    end

    'RIFF_C03':begin
      nx = 480
      ny = 480
      nz = 3
      nt = 249
      n0 = 19E
      Folder = 'Patient_2D'
      slice = 1
    end

    'RIFF_C04':begin
      nx = 512
      ny = 512
      nz = 3
      nt = 249
      n0 = 17E
      Folder = 'Patient_2D'
      slice = 1
    end

    'RIFF_C05':begin
      nx = 528
      ny = 528
      nz = 3
      nt = 249
      n0 = 15E
      Folder = 'Patient_2D'
      slice = 1
    end

    'RIFF_F01':begin
      nx = 480
      ny = 480
      nz = 3
      nt = 250
      n0 = 20E
      Folder = 'Patient_2D'
      slice = 1
    end

    'AC51a':BEGIN
      nx = 128
      ny = 128
      nz = 20
      nt = 125
      n0 = 10E
      Folder = 'Patient_3D'
    END

    'BA50a':BEGIN
      nx = 128
      ny = 128
      nz = 20
      nt = 125
      n0 = 15E
      Folder = 'Patient_3D'
    END

    'CH6a':BEGIN
      nx = 128
      ny = 128
      nz = 20
      nt = 125
      n0 = 11E
      Folder = 'Patient_3D'
    END

    'CW8a':BEGIN
      nx = 128
      ny = 128
      nz = 20
      nt = 125
      n0 = 15E
      Folder = 'Patient_3D'
    END

    'EA14a':BEGIN
      nx = 128
      ny = 128
      nz = 20
      nt = 125
      n0 = 4E
      Folder = 'Patient_3D'
    END

    'FJ14a':BEGIN
      nx = 128
      ny = 128
      nz = 20
      nt = 125
      n0 = 12E
      Folder = 'Patient_3D'
    END

    'GD7a':BEGIN
      nx = 128
      ny = 128
      nz = 20
      nt = 125
      n0 = 9E
      Folder = 'Patient_3D'
    END

    'HD3a':BEGIN
      nx = 128
      ny = 128
      nz = 20
      nt = 125
      n0 = 9E
      Folder = 'Patient_3D'
    END

  ENDCASE

  Dir = MDR_PATH('Data') + Folder + '\' + dataset

  img =  Dir + '_DCE.dat'
  aif =  Dir + '_AIF.txt'

  data = FLTARR(nx,ny,nz,nt)
  OPENR, 1, img[0]
  READU, 1, data
  CLOSE, 1

  CASE Folder OF
    'Patient_2D':BEGIN
     	data = REFORM(data[*,*,slice,*])
      	data = TRANSPOSE(data, [2,0,1])
      	END
    'Patient_3D':data = TRANSPOSE(data, [3,0,1,2])
    'DRO_data':data = TRANSPOSE(data, [3,0,1,2])
  ENDCASE

  PMI__ReadPlot, aif[0], time, Sa
  Caif = Sa - total(Sa[0:n0-1])/n0

END