BeginPackage["Utilities`"];

SetTheme::usage = UsageString@"SetTheme[`name`] sets an overall theme for visualization elements and styles.";

Begin["`Private`"];

SetTheme["CACM"] := Do[
    SetOptions[plot,
        Frame -> True, FrameStyle -> Directive[Black, Thickness[Medium]],
        LabelStyle -> {Black, FontFamily -> "DIN 2014"}
    ], {plot, {Plot, ParametricPlot, ContourPlot}}
];

End[];

EndPackage[];
