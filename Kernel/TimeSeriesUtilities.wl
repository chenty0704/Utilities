BeginPackage["Utilities`"];

TimeSeriesRandomSample::usage = UsageString@"TimeSeriesRandomSample[`data`, `count`] gives a random sample of the temporal data.";

Begin["`Private`"];

TimeSeriesRandomSample[data_TemporalData, count_Integer] := data["Part", RandomSample[Range@data["PathCount"], count]];

End[];

EndPackage[];
