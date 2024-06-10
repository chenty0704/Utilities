ListableMean;
values = RandomReal[{0, 1}, {1000, 1000, 1000}];
compiledResult = AbsoluteTiming@ListableMean[values];
builtinResult = AbsoluteTiming@ArrayReduce[Mean, values, 3];
VerificationTest[Last[compiledResult], Last[builtinResult]];
VerificationTest[First[compiledResult] < First[builtinResult]];

values1 = RandomReal[{0, 1}, {1000, 1000}];
values2 = RandomReal[{0, 1}, {1000, 1000}];
VerificationTest[Mean@Abs[ListableCorrelation[values1, values2] -
        MapThread[Correlation, {values1, values2}]] < $MachineEpsilon]
