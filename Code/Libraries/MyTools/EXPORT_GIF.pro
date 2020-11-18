
PRO EXPORT_GIF, Image, File, Range

  IF N_ELEMENTS(Range) EQ 0 THEN Range = PERC(Image, [1.,99.])

  file_dat = File + '.dat'

  openw, 1, file_dat
  writeu, 1, Image
  close, 1

  n = SIZE(image,/N_DIMENSIONS)
  d = SIZE(image,/DIMENSIONS)

  CASE n OF

  	3: BEGIN
  	     file_gif = File + '.gif'
  	     FOR t=0L,d[0]-1 DO BEGIN
           im = REFORM(image[t,*,*])
           im = BYTSCL(im, MIN=Range[0], MAX=Range[1])
           write_gif, file_gif, im, /multiple
         ENDFOR
         write_gif, file_gif, /close
  	   END

    4: FOR z=0L,d[3]-1 DO BEGIN
  	     file_gif = File + '_slice[' + strcompress(z) + '].gif'
  	     FOR t=0L,d[0]-1 DO BEGIN
           im = REFORM(image[t,*,*,z])
           im = BYTSCL(im, MIN=Range[0], MAX=Range[1])
           write_gif, file_gif, im, /multiple
         ENDFOR
         write_gif, file_gif, /close
       ENDFOR

  ENDCASE



END