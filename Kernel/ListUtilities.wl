BeginPackage["Utilities`"];

ListableMin;
ListableMax;

PartitionInto::usage = UsageString@"PartitionInto[`list`, `n`] partitions `list` into `n` sublists of equal length.";

Begin["`Private`"];

ListableMin[values_List, scalar : _Integer | _Real] := values - Ramp[values - scalar];

ListableMax[values_List, scalar : _Integer | _Real] := values + Ramp[scalar - values];

Options[PartitionInto] = {"StrictMode" -> False};

PartitionInto[list_List, n_Integer, OptionsPattern[]] := If[!OptionValue["StrictMode"],
    Partition[list, UpTo@Ceiling[Length[list] / n]],
    Partition[list, Floor[Length[list] / n]]
];

End[];

EndPackage[];
