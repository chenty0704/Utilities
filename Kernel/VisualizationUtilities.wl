BeginPackage["Utilities`"];

Inch::usage = UsageString@"Inch gives the number of printer's points in one inch.";

DefaultColorFunction::usage = UsageString@"DefaultColorFunction[`n`] gives the `n^th` default color.";

$LinePlotSymbols::usage = UsageString@"$LinePlotSymbols gives the list of line plot symbols.";
$MeshPlotSymbols::usage = UsageString@"$MeshPlotSymbols gives the list of mesh plot symbols.";
$ChartSymbols::usage = UsageString@"$ChartSymbols gives the list of chart symbols.";
$LegendSymbols::usage = UsageString@"$LegendSymbols gives the list of legend symbols.";

$ThemeLabelStyle::usage = UsageString@"$ThemeLabelStyle gives the label style of the current theme.";

SetPlotTheme::usage = UsageString@"SetPlotTheme[`theme`] sets the default plot theme for graphics functions.";

ShowLegend::usage = UsageString@"ShowLegend[`legend`, `options`] shows a legend with the specified options added.";

ShowPhysicalSize::usage = UsageString@"ShowPhysicalSize[`expr`] displays graphics at physical size.
ShowPhysicalSize[`expr`, `zoom`] displays graphics at zoomed physical size.";

Begin["`Private`"];

Attributes[Inch] = {Constant};
Inch = 72.;

DefaultColorFunction = ColorData[97];

$LinePlotSymbols = {DiscretePlot, ListLinePlot, ListLogLinearPlot, ListLogLogPlot, ListLogPlot, ListPlot, ListPolarPlot, ListStepPlot, LogLinearPlot, LogPlot, ParametricPlot, Plot, PolarPlot};
$MeshPlotSymbols = {ArrayPlot, ContourPlot, DensityPlot, ListContourPlot, ListDensityPlot, MatrixPlot};
$ChartSymbols = Symbol /@ Names["System`*Chart"];
$LegendSymbols = Symbol /@ Names["System`*Legend"];

themeLabelStyles = <|
    "ACM" -> Sequence[FontFamily -> "Linux Libertine O", Black],
    "Default" -> Sequence[FontFamily -> "Source Sans Pro", Black],
    "Office" -> Sequence[FontFamily -> "Aptos", Black],
    "Quip" -> Sequence[FontFamily -> "Neue Haas Grotesk Text Pro", Black]
|>;

SetPlotTheme[theme_String] := (
    $ThemeLabelStyle = themeLabelStyles[theme];
    Do[SetOptions[symbol, Frame -> True, LabelStyle -> {$ThemeLabelStyle}],
        {symbol, Join[$LinePlotSymbols, $MeshPlotSymbols, $ChartSymbols]}];
    Do[SetOptions[symbol, LabelStyle -> {$ThemeLabelStyle}], {symbol, $LegendSymbols}];
);

ShowLegend[legend_[args : Longest[Except[_ -> _]..], legendOptions___], options__] :=
        legend[args, Sequence @@ Join[FilterRules[{legendOptions}, Except[Alternatives @@ Keys@{options}]], {options}]];

ShowPhysicalSize[expr_] := ShowPhysicalSize[expr, 1.];

ShowPhysicalSize[expr_, zoom_Real] := Magnify[expr, zoom / (Magnification /. Options[$FrontEnd])];

End[];

EndPackage[];
