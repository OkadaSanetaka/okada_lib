function remove_stray_i, iquv_in, line_dep=line_dep, qs_xr=qs_xr, $
                         qs_yr=qs_yr, co_xr=co_xr, co_yr=co_yr 
;--------------------------------------------------------------------------
; Name : 
;     minus_stray_i.pro    
; 
; Explanation : 
;     subtract parastic stray light from stokes I 
;     stray light is estimated by the depth of line. 
; 
; Input :
;     iquv_in = array of stokes IQUV
;
; Keywords :
;     qs_xr    = x-range of quiet sun to measure line depth 
;     qs_yr    = y- ""
;     co_xr    = x-range of quiet sun to measure continuum
;     co_yr    = y- "" 
;     line_dep = the ratio of line intenisty and continuum intensity
;                of the profile without stray light                  
;---------------------------------------------------------------------------  

  I = iquv_in[*, *, 0]  

  ;-estimate stray light
  lcr = line_dep
     
  nx = qs_xr[1]-qs_xr[0] + 1
  line_ints = fltarr(nx)
  for k=0, nx-1 do line_ints[k] = min( I[k+qs_xr[0], qs_yr[0]:qs_yr[1]] )   

  line_int = median( line_ints)
  cont_int = median( I[co_xr[0]:co_xr[1], co_yr[0]:co_yr[1]] )   
     
  stray = (line_int - cont_int * lcr) / (1 - lcr)
     

  ;-output 
  iquv_out = iquv_in  ; intitalize iquv_out 
  iquv_out[*,*,0] = iquv_in[*,*,0] - stray

  return, iquv_out
end

