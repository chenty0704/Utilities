BeginPackage["Utilities`", {"HypothesisTesting`"}];

AroundMeanCI::usage = UsageString@"AroundMeanCI[`values`] gives the mean estimate of `values` with the confidence interval.";

Begin["`Private`"];

AroundMeanCI = Around@*Interval@*MeanCI;

End[];

EndPackage[];
