BeginPackage["Utilities`"];

F::usage = UsageString@"F[`template`, `args`] applies a string template with formatting, using `args` to fill slots in the template.";

ShortString::usage = UsageString@"ShortString[`value`, `n`] yields a short form of `value` with at most `n` characters.";

ToPascalCase::usage = UsageString@"ToPascalCase[`value`] yields a string in which the first letter of each word is capitalized and all whitespace characters are removed.";

Begin["`Private`"];

F[template_String, arg_] := F[template, {arg}];

F[template_String, args_List] := Module[{formatters},
    formatters = Table[If[MatchQ[format, _String],
        With[{type = StringPart[format, 1], count = FromDigits@StringDrop[format, 1]}, Switch[type,
            "D", If[NonNegative[#],
                StringPadLeft[ToString[#], count, "0"],
                "-" ~~ StringPadLeft[ToString[-#], count, "0"]
            ] &,
            "F", ToString@NumberForm[#, {\[Infinity], count}] &
        ]],
        Identity
    ], {format, Cases[First@StringTemplate[template], TemplateSlot[format_] :> format]}];
    Return@TemplateApply[
        StringReplace[template, Shortest["`" ~~ ___ ~~ "`"] -> "``"],
        MapThread[#1[#2]&, {formatters, args}]
    ];
];

ShortString[value_String, n_Integer] := If[StringLength[value] > n, StringTake[value, n - 3] <> "...", value];

ToPascalCase[value_String] := StringDelete[Capitalize[value, "AllWords"], WhitespaceCharacter];

End[];

EndPackage[];
