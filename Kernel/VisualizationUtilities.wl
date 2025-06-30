BeginPackage["Utilities`"];

Inch::usage = UsageString@"Inch gives the number of printer's points in one inch.";

DefaultMatrixPlotColorFunction::usage = UsageString@"DefaultMatrixPlotColorFunction gives the default color function for matrix plots.";

$LinePlotSymbols::usage = UsageString@"$LinePlotSymbols gives the list of line plot symbols.";
$MeshPlotSymbols::usage = UsageString@"$MeshPlotSymbols gives the list of mesh plot symbols.";
$ChartSymbols::usage = UsageString@"$ChartSymbols gives the list of chart symbols.";
$LegendSymbols::usage = UsageString@"$LegendSymbols gives the list of legend symbols.";

$ThemeLabelStyle::usage = UsageString@"$ThemeLabelStyle gives the label style of the current theme.";

SetPlotTheme::usage = UsageString@"SetPlotTheme[`theme`] sets the default plot theme for graphics functions.";

ShowLegend::usage = UsageString@"ShowLegend[`legend`, `options`] shows a legend with the specified options added.";

DisplayPhysicalSize::usage = UsageString@"DisplayPhysicalSize[`expr`] displays graphics at physical size.";

RasterWidth::usage = UsageString@"RasterWidth[`expr`] gives the width of the rasterized form of `expr`.";

Begin["`Private`"];

Attributes[Inch] = {Constant};
Inch = 72.;

DefaultMatrixPlotColorFunction = Blend[System`PlotThemeDump`$ThemeDefaultMatrix, #] &;

$LinePlotSymbols = {DiscretePlot, ListLinePlot, ListLogLinearPlot, ListLogLogPlot, ListLogPlot, ListPlot, ListPolarPlot, ListStepPlot, LogLinearPlot, LogPlot, ParametricPlot, Plot, PolarPlot};
$MeshPlotSymbols = {ArrayPlot, ContourPlot, DensityPlot, ListContourPlot, ListDensityPlot, MatrixPlot};
$ChartSymbols = Symbol /@ Names["System`*Chart"];
$LegendSymbols = Symbol /@ Names["System`*Legend"];

themeLabelStyles = <|
    "ACM" -> {FontFamily -> "Linux Libertine O", Black},
    "Default" -> {FontFamily -> "Source Sans Pro", Black},
    "Office" -> {FontFamily -> "Aptos", Black},
    "Quip" -> {FontFamily -> "Helvetica Neue", FontWeight -> "Light", Black},
    "Scientific" -> {FontFamily -> "Cambria", Black}
|>;

SetPlotTheme[theme_String] := (
    $ThemeLabelStyle = themeLabelStyles[theme];
    Do[SetOptions[symbol, Frame -> True, LabelStyle -> $ThemeLabelStyle],
        {symbol, Join[$LinePlotSymbols, $MeshPlotSymbols, $ChartSymbols]}];
    Do[SetOptions[symbol, LabelStyle -> $ThemeLabelStyle], {symbol, $LegendSymbols}];
    SetOptions[Labeled, LabelStyle -> $ThemeLabelStyle];
);

ShowLegend[legend_[args : Longest[Except[_ -> _]..], legendOptions___], options__] :=
        legend[args, Sequence @@ Join[FilterRules[{legendOptions}, Except[Alternatives @@ Keys@{options}]], {options}]];

DisplayPhysicalSize[expr_] := Magnify[expr, 1 / (Magnification /. Options[$FrontEnd])];

RasterWidth[expr_] := First@Rasterize[expr, "RasterSize", ImageResolution -> 72];

End[];

EndPackage[];
