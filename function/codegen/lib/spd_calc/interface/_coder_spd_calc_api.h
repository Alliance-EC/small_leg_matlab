//
// File: _coder_spd_calc_api.h
//
// MATLAB Coder version            : 23.2
// C/C++ source code generated on  : 09-Oct-2024 21:19:27
//

#ifndef _CODER_SPD_CALC_API_H
#define _CODER_SPD_CALC_API_H

// Include Files
#include "emlrt.h"
#include "mex.h"
#include "tmwtypes.h"
#include <algorithm>
#include <cstring>

// Variable Declarations
extern emlrtCTX emlrtRootTLSGlobal;
extern emlrtContext emlrtContextGlobal;

// Function Declarations
void spd_calc(real_T phi1, real_T phi2, real_T phi_dot_1, real_T phi_dot_2,
              real_T spd[2]);

void spd_calc_api(const mxArray *const prhs[4], const mxArray **plhs);

void spd_calc_atexit();

void spd_calc_initialize();

void spd_calc_terminate();

void spd_calc_xil_shutdown();

void spd_calc_xil_terminate();

#endif
//
// File trailer for _coder_spd_calc_api.h
//
// [EOF]
//
