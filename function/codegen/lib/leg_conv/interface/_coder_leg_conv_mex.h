//
// File: _coder_leg_conv_mex.h
//
// MATLAB Coder version            : 23.2
// C/C++ source code generated on  : 09-Oct-2024 20:38:47
//

#ifndef _CODER_LEG_CONV_MEX_H
#define _CODER_LEG_CONV_MEX_H

// Include Files
#include "emlrt.h"
#include "mex.h"
#include "tmwtypes.h"

// Function Declarations
MEXFUNCTION_LINKAGE void mexFunction(int32_T nlhs, mxArray *plhs[],
                                     int32_T nrhs, const mxArray *prhs[]);

emlrtCTX mexFunctionCreateRootTLS();

void unsafe_leg_conv_mexFunction(int32_T nlhs, mxArray *plhs[1], int32_T nrhs,
                                 const mxArray *prhs[4]);

#endif
//
// File trailer for _coder_leg_conv_mex.h
//
// [EOF]
//
