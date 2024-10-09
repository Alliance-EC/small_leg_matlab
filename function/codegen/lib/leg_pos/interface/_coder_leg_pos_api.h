//
// File: _coder_leg_pos_api.h
//
// MATLAB Coder version            : 23.2
// C/C++ source code generated on  : 09-Oct-2024 20:44:07
//

#ifndef _CODER_LEG_POS_API_H
#define _CODER_LEG_POS_API_H

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
void leg_pos(real_T phi1, real_T phi2, real_T pos[2]);

void leg_pos_api(const mxArray *const prhs[2], const mxArray **plhs);

void leg_pos_atexit();

void leg_pos_initialize();

void leg_pos_terminate();

void leg_pos_xil_shutdown();

void leg_pos_xil_terminate();

#endif
//
// File trailer for _coder_leg_pos_api.h
//
// [EOF]
//
