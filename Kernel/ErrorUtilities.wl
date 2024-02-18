BeginPackage["Utilities`"];

AbortOnException::usage = UsageString@"AbortOnException[`expr`] aborts the evaluation of `expr` upon an uncaught exception.
AbortOnException[`expr`, `form`] aborts the evaluation of `expr` upon an uncaught exception matched by `form`.";

Begin["`Private`"];

Attributes[AbortOnException] = {HoldFirst};

AbortOnException[expr_] := Catch[expr, _, (Echo[#1]; Abort[]) &];

AbortOnException[expr_, form_] := Catch[expr, form, (Echo[#1]; Abort[]) &];

End[];

EndPackage[];
