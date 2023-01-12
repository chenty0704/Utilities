BeginPackage["Utilities`"];

DefaultColorFunction::usage = UsageString@"DefaultColorFunction[`n`] gives the `n^th` default color.";

SetTheme::usage = UsageString@"SetTheme[`name`] sets an overall theme for visualization elements and styles.";

Begin["`Private`"];

SetTheme["CACM"] := Do[
    SetOptions[plot,
        Frame -> True, FrameStyle -> Directive[Black, Thickness[Medium]],
        LabelStyle -> {Black, FontFamily -> "DIN 2014"}
    ], {plot, {Plot, ParametricPlot, ContourPlot}}
];

defaultColors = {
    RGBColor[0.36841382, 0.50678264, 0.70980392],
    RGBColor[0.88072023, 0.61104753, 0.14204623],
    RGBColor[0.56017395, 0.69156939, 0.19488823],
    RGBColor[0.92252995, 0.385626, 0.20918593],
    RGBColor[0.52848096, 0.47061875, 0.70135042],
    RGBColor[0.77207599, 0.43155566, 10.238804],
    RGBColor[0.36389715, 0.61849393, 0.78234531],
    RGBColor[1, 0.74999619, 0]
};

DefaultColorFunction[n_Integer] := defaultColors[[Mod[n, Length[defaultColors], 1]]];

End[];

EndPackage[];
