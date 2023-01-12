BeginPackage["Utilities`"];

UsageString[str_String] := StringReplace[str, {
    "..." -> "\[Ellipsis]",
    "`" ~~ x : WordCharacter.. ~~ "`" :> TemplateApply["\!\(\*StyleBox[``, \"TI\"]\)", {x}],
    "`" ~~ x : WordCharacter.. ~~ "_" ~~ y : WordCharacter.. ~~ "`" :>
            TemplateApply["\!\(\*SubscriptBox[StyleBox[``, \"TI\"], StyleBox[``, \"TR\"]]\)", {x, y}],
    "`" ~~ x : WordCharacter.. ~~ "^" ~~ y : WordCharacter.. ~~ "`" :>
            TemplateApply["\!\(\*SuperscriptBox[StyleBox[``, \"TI\"], StyleBox[``, \"TR\"]]\)", {x, y}]
}];

ToPascalCase::usage = UsageString@"ToPascalCase[`string`] yields a string in which the first letter of each word is capitalized and all whitespace characters are removed.";

UsageString::usage = UsageString@"UsageString[`string`] yields a string formatted as a usage message.";

Begin["`Private`"];

ToPascalCase[str_String] := StringDelete[Capitalize[str, "AllWords"], WhitespaceCharacter];

End[];

EndPackage[];
