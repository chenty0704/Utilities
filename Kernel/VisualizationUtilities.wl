BeginPackage["Utilities`"];

Inch::usage = UsageString@"Inch gives the number of printer's points in one inch.";

DefaultColorFunction::usage = UsageString@"DefaultColorFunction[`n`] gives the `n^th` default color.";

$ThemeLabelStyle::usage = UsageString@"$ThemeLabelStyle gives the label style of the current theme.";

SetPlotTheme::usage = UsageString@"SetPlotTheme[`theme`] sets the default plot theme for graphics functions.";

ShowLegend::usage = UsageString@"ShowLegend[`legend`, `options`] shows a legend with the specified options added.";

ShowLegended::usage = UsageString@"ShowLegended[`graphics`, `options`] shows legended graphics with the specified options added.";

ShowPhysicalSize::usage = UsageString@"ShowPhysicalSize[`expr`] displays graphics at physical size.";

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
    "Web" -> Sequence[FontFamily -> "DIN 2014", Black],
    "Scientific" -> Sequence[FontFamily -> "Times", Black]
|>;

SetPlotTheme[theme_String] := (
    $ThemeLabelStyle = themeLabelStyles[theme];
    Do[SetOptions[symbol, Frame -> True, LabelStyle -> {$ThemeLabelStyle}], {symbol, plotSymbols}];
    Do[SetOptions[symbol, LabelStyle -> {$ThemeLabelStyle}], {symbol, legendSymbols}];
);

ShowLegend[legend_[args : Longest[Except[_ -> _]..], legendOptions___], options__] :=
        legend[args, Join[FilterRules[{legendOptions}, Except[Alternatives @@ Keys[options]]], {options}]];

ShowLegended[Legended[expr_, legend_], options__] := Legended[
    Show[expr, Sequence @@ FilterRules[{options}, Except[PlotLegends]]],
    ShowLegend[legend, Sequence @@ FirstCase[{options}, (PlotLegends -> legendOptions_) :> legendOptions]]
];

ShowLegended[Legended[expr_, Placed[legend_, placedArgs__]], options__] := Legended[
    Show[expr, Sequence @@ FilterRules[{options}, Except[PlotLegends]]],
    Placed[ShowLegend[
        legend, Sequence @@ FirstCase[{options}, (PlotLegends -> legendOptions_) :> legendOptions]
    ], placedArgs]
];

ShowPhysicalSize[expr_] := Magnify[expr, 1 / (Magnification /. Options[$FrontEnd])];

ImageScalingFactors[expr_] := Divide @@ (Rasterize[#, "RasterSize"] & /@ {expr, First[expr]});

End[];

EndPackage[];
