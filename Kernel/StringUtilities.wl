BeginPackage["Utilities`"];

F::usage = UsageString@"F[`template`, `args`] applies a string template with formatting, using `args` to fill slots in the template.";

ToPascalCase::usage = UsageString@"ToPascalCase[`value`] yields a string in which the first letter of each word is capitalized and all whitespace characters are removed.";

Begin["`Private`"];

F[template_String, arg_] := F[template, {arg}];

F[template_String, args_List] := Module[{formatters},
    formatters = Table[If[MatchQ[format, _String],
        With[{type = StringPart[format, 1], count = FromDigits@StringDrop[format, 1]}, Switch[type,
            "D", If[NonNegative[#],
                StringPadLeft[ToString[#], count, "0"],
                "-" ~~ StringPadLeft[ToString[-#], count, "0"]
            ] &
        ]],
        Identity
    ], {format, Cases[First@StringTemplate[template], TemplateSlot[format_] :> format]}];
    Return@TemplateApply[StringReplace[template, "`" ~~ __ ~~ "`" -> "``"], MapThread[#1[#2]&, {formatters, args}]];
];

ToPascalCase[value_String] := StringDelete[Capitalize[value, "AllWords"], WhitespaceCharacter];

End[];

EndPackage[];
