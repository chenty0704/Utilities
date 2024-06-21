VerificationTest[ListablePlus[{{1, 2}, {3, 4}}, {1, -1}], {{2, 1}, {4, 3}}];
VerificationTest[ListablePlus[{{{1, 2}, {3, 4}}, {{5, 6}, {7, 8}}}, {{1, -1}, {2, -2}}],
    {{{2, 1}, {5, 2}}, {{6, 5}, {9, 6}}}];

values1 = RandomReal[{0, 1}, {1000, 1000}];
values2 = RandomReal[{0, 1}, {1000, 1000}];
VerificationTest[ListableMean[values1], ArrayReduce[Mean, values1, 2]];
VerificationTest[Mean@Abs[ListableCorrelation[values1, values2] -
        MapThread[Correlation, {values1, values2}]] < $MachineEpsilon]
