BeginPackage["Utilities`"];

Inch::usage = UsageString@"Inch gives the number of printer's points in one inch.";

DefaultColorFunction::usage = UsageString@"DefaultColorFunction[`n`] gives the `n^th` default color.";

$ThemeLabelStyle::usage = UsageString@"$ThemeLabelStyle gives the label style of the current theme.";

SetPlotTheme::usage = UsageString@"SetPlotTheme[`theme`] sets the default plot theme for graphics functions.";

ShowLegend::usage = UsageString@"ShowLegend[`legend`, `options`] shows a legend with the specified options added.";

ShowPhysicalSize::usage = UsageString@"ShowPhysicalSize[`expr`] displays graphics at physical size.
ShowPhysicalSize[`expr`, `zoom`] displays graphics at zoomed physical size.";

ImageScalingFactors::usage = UsageString@"ImageScalingFactors[`expr`] gives the scaling factors of the displayed form of `expr` due to additional visual elements.";

Begin["`Private`"];

Attributes[Inch] = {Constant};
Inch = 72.;

DefaultColorFunction = ColorData[97];

plotSymbols = {ArrayPlot, ContourPlot, DensityPlot, DiscretePlot, ListContourPlot, ListDensityPlot, ListLinePlot,
    ListLogLinearPlot, ListLogLogPlot, ListLogPlot, ListPlot, ListPolarPlot, ListStepPlot, LogLinearPlot, LogPlot,
    MatrixPlot, ParametricPlot, Plot, PolarPlot, BarChart};
legendSymbols = Symbol /@ Names["System`*Legend"];

themeLabelStyles = <|
    "ACM" -> Sequence[FontFamily -> "Linux Libertine O", Black],
    "Scientific" -> Sequence[FontFamily -> "Cambria Math", Black],
    "Web" -> Sequence[FontFamily -> "DIN 2014", Black]
|>;

SetPlotTheme[theme_String] := (
    $ThemeLabelStyle = themeLabelStyles[theme];
    Do[SetOptions[symbol, Frame -> True, LabelStyle -> {$ThemeLabelStyle}], {symbol, plotSymbols}];
    Do[SetOptions[symbol, LabelStyle -> {$ThemeLabelStyle}], {symbol, legendSymbols}];
);

ShowLegend[legend_[args : Longest[Except[_ -> _]..], legendOptions___], options__] :=
        legend[args, Join[FilterRules[{legendOptions}, Except[Alternatives @@ Keys[options]]], {options}]];

ShowPhysicalSize[expr_] := ShowPhysicalSize[expr, 1.];

ShowPhysicalSize[expr_, zoom_Real] := Magnify[expr, zoom / (Magnification /. Options[$FrontEnd])];

ImageScalingFactors[expr_] := Divide @@ (Rasterize[#, "RasterSize"] & /@ {expr, First[expr]});

End[];

EndPackage[];
