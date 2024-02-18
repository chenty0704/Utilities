BeginPackage["Utilities`"];

UsageString[value_String] := StringReplace[value, {
    "`" ~~ x : WordCharacter.. ~~ "`" :> TemplateApply["\!\(\*StyleBox[``, \"TI\"]\)", {x}],
    "`" ~~ x : WordCharacter.. ~~ "_" ~~ y : WordCharacter.. ~~ "`" :>
            TemplateApply["\!\(\*SubscriptBox[StyleBox[``, \"TI\"], StyleBox[``, \"TR\"]]\)", {x, y}],
    "`" ~~ x : WordCharacter.. ~~ "^" ~~ y : WordCharacter.. ~~ "`" :>
            TemplateApply["\!\(\*SuperscriptBox[StyleBox[``, \"TI\"], StyleBox[``, \"TR\"]]\)", {x, y}]
}];

UsageString::usage = UsageString@"UsageString[`value`] yields a string formatted as a usage message.";

Begin["`Private`"];

Get["Utilities`CompilerUtilities`"];
Get["Utilities`ErrorUtilities`"];
Get["Utilities`StringUtilities`"];
Get["Utilities`VisualizationUtilities`"];

End[];

EndPackage[];
