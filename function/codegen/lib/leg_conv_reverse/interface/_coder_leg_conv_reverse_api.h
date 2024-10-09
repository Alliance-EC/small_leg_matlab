//
// File: _coder_leg_conv_reverse_api.h
//
// MATLAB Coder version            : 23.2
// C/C++ source code generated on  : 09-Oct-2024 20:42:39
//

#ifndef _CODER_LEG_CONV_REVERSE_API_H
#define _CODER_LEG_CONV_REVERSE_API_H

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
void leg_conv_reverse(real_T T1, real_T T2, real_T phi1, real_T phi2,
                      real_T T_r[2]);

void leg_conv_reverse_api(const mxArray *const prhs[4], const mxArray **plhs);

void leg_conv_reverse_atexit();

void leg_conv_reverse_initialize();

void leg_conv_reverse_terminate();

void leg_conv_reverse_xil_shutdown();

void leg_conv_reverse_xil_terminate();

#endif
//
// File trailer for _coder_leg_conv_reverse_api.h
//
// [EOF]
//
