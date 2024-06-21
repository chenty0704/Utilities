BeginPackage["Utilities`"];

ElementwiseMin;
ElementwiseMax;

PartitionInto::usage = UsageString@"PartitionInto[`list`, `n`] partitions `list` into `n` sublists of equal length.";

Begin["`Private`"];

ElementwiseMin[values1_List, values2 : _Integer | _Real | _List] := values1 - Ramp[values1 - values2];
ElementwiseMax[values1_List, values2 : _Integer | _Real | _List] := values1 + Ramp[values1 - values2];

Options[PartitionInto] = {"StrictMode" -> False};

PartitionInto[list_List, n_Integer, OptionsPattern[]] := If[!OptionValue["StrictMode"],
    Partition[list, UpTo@Ceiling[Length[list] / n]],
    Partition[list, Floor[Length[list] / n]]
];

End[];

EndPackage[];
