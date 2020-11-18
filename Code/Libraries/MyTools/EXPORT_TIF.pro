

PRO EXPORT_TIF, Image, File, Range

  IF N_ELEMENTS(Range) EQ 0 THEN Range = PERC(Image, [1.,99.])

  file_dat = File + '.dat'

  openw, 1, file_dat
  writeu, 1, Image
  close, 1

  n = SIZE(image,/N_DIMENSIONS)
  d = SIZE(image,/DIMENSIONS)

  CASE n OF

  	2: BEGIN
  	     file_tif = File + '.tif'
         im = BYTSCL(Image, MIN=Range[0], MAX=Range[1])
         WRITE_TIFF, file_tif, reverse(im,2)
  	   END

    3: FOR z=0L,d[2]-1 DO BEGIN
  	     file_tif = File + '_slice[' + strcompress(z) + '].gif'
  	     im = REFORM(Image[*,*,z])
  	     im = BYTSCL(im, MIN=Range[0], MAX=Range[1])
         WRITE_TIFF, file_tif, reverse(im,2)
       ENDFOR

  ENDCASE



END