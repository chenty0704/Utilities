BeginPackage["Utilities`"];

QuantityDifferences::usage = UsageString@"QuantityDifferences[`list`] gives the successive differences of quantities in `list`.";

QuantityTotal::usage = UsageString@"QuantityTotal[`list`, `unit`] gives the total of the quantities in `list`.";

Begin["`Private`"];

QuantityDifferences[list : {__Quantity} | _QuantityArray] := list[[2 ;;]] - list[[;; -2]];

QuantityTotal[list : {__Quantity} | _QuantityArray, unit_String] := Total[list];

QuantityTotal[{}, unit_String] := Quantity[0, unit];

End[];

EndPackage[];
