ListableMean;
array = RandomReal[{0, 1}, {1000, 1000, 1000}];
compiledResult = AbsoluteTiming@ListableMean[array];
uncompiledResult = AbsoluteTiming@ArrayReduce[Mean, array, 3];
VerificationTest[Last[compiledResult], Last[uncompiledResult]];
VerificationTest[First[compiledResult] < First[uncompiledResult]];

array1 = RandomReal[{0, 1}, {1000, 1000}];
array2 = RandomReal[{0, 1}, {1000, 1000}];
VerificationTest[Mean@Abs[ListableCorrelation[array1, array2] -
        MapThread[Correlation, {array1, array2}]] < $MachineEpsilon]
