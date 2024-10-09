//
// File: _coder_leg_conv_api.h
//
// MATLAB Coder version            : 23.2
// C/C++ source code generated on  : 09-Oct-2024 20:38:47
//

#ifndef _CODER_LEG_CONV_API_H
#define _CODER_LEG_CONV_API_H

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
void leg_conv(real_T F, real_T Tp, real_T phi1, real_T phi2, real_T T[2]);

void leg_conv_api(const mxArray *const prhs[4], const mxArray **plhs);

void leg_conv_atexit();

void leg_conv_initialize();

void leg_conv_terminate();

void leg_conv_xil_shutdown();

void leg_conv_xil_terminate();

#endif
//
// File trailer for _coder_leg_conv_api.h
//
// [EOF]
//
