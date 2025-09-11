BeginPackage["Utilities`"];

ElementwiseMin;
ElementwiseMax;

PartitionInto::usage = UsageString@"PartitionInto[`values`, `count`] partitions `values` into sublists of equal length.";

Begin["`Private`"];

ElementwiseMin[values1_List, values2 : _Integer | _Real | _List] := values1 - Ramp[values1 - values2];
ElementwiseMax[values1_List, values2 : _Integer | _Real | _List] := values1 + Ramp[values1 - values2];

Options[PartitionInto] = {"AllowTruncation" -> False};

PartitionInto[values_List, count_Integer, OptionsPattern[]] := If[!OptionValue["AllowTruncation"],
    Partition[values, UpTo@Ceiling[Length[values] / count]],
    Partition[values, Floor[Length[values] / count]]
];

End[];

EndPackage[];
