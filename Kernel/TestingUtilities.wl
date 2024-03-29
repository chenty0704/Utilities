BeginPackage["Utilities`"];

TestReportByOutcome::usage = UsageString@"TestReportByOutcome[`fileName`] gives a report of the test results from a file by outcome.";

Begin["`Private`"];

TestReportByOutcome[fileName_String] := TabView[Column /@ Association@KeyValueMap[
    {outcome, tests} |-> F["``: ``", {outcome, Length[tests]}] -> tests,
    TestReport[fileName]["ResultsByOutcome"]
]];

End[];

EndPackage[];
