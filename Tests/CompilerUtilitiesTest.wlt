VerificationTest[ListablePlus[{{1, 2}, {3, 4}}, {1, -1}], {{2, 1}, {4, 3}}];
VerificationTest[ListablePlus[{{{1, 2}, {3, 4}}, {{5, 6}, {7, 8}}}, {{1, -1}, {2, -2}}],
    {{{2, 1}, {5, 2}}, {{6, 5}, {9, 6}}}];

values = RandomReal[{0, 1}, {1000, 1000}];
VerificationTest[ListableMean[values], ArrayReduce[Mean, values, 2]];
