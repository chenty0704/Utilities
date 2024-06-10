BeginPackage["Utilities`", {"HypothesisTesting`"}];

AroundMeanCI::usage = UsageString@"AroundMeanCI[`values`] gives the population mean estimated from `values` with the confidence interval.";

Begin["`Private`"];

AroundMeanCI = Around@*Interval@*MeanCI;

End[];

EndPackage[];
