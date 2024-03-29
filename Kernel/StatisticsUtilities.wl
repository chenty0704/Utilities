BeginPackage["Utilities`", {"HypothesisTesting`"}];

AroundMeanCI::usage = UsageString@"AroundMeanCI[`list`] gives the population mean estimated from `list` with the confidence interval.";

Begin["`Private`"];

AroundMeanCI = Around@*Interval@*MeanCI;

End[];

EndPackage[];
