BeginPackage["Utilities`", {"CCompilerDriver`"}];

CompileListable::usage = UsageString@"CompileListable[`function`, `type`] creates a compiled function that automatically threads over lists.
CompileListable[`function`, `type_1`, `type_2`, \[Ellipsis]] creates a compiled function with multiple arguments that automatically threads over lists.";

ListablePlus;
ListableMinus;
ListableTimes;
ListableDivide;

ListableMean;
ListableStandardDeviation;

Begin["`Private`"];

If[$OperatingSystem == "Windows",
    vsWhere = FileNameJoin[Environment["ProgramFiles(x86)"], "Microsoft Visual Studio", "Installer", "vswhere.exe"];
    $CCompiler = {
        "Compiler" -> CCompilerDriver`VisualStudioCompiler`VisualStudioCompiler,
        "CompilerInstallation" -> StringTrim@RunProcess[
            {vsWhere, "-latest", "-prerelease", "-property", "installationPath"}, "StandardOutput"]
    };
];

TypePattern = _Symbol | {_Symbol, _Integer};

TypeSpec[type_] := Blank@If[ListQ[type], type[[1]], type];
TypeRank[type_] := If[ListQ[type], type[[2]], 0];

compileOpts = Sequence[
    CompilationTarget -> "C", RuntimeOptions -> "Speed",
    CompilationOptions -> {"InlineExternalDefinitions" -> True, "InlineCompiledFunctions" -> True},
    RuntimeAttributes -> {Listable}, Parallelization -> True
];

CompileListable[function_, type : TypePattern] := With[{spec = TypeSpec[type], rank = TypeRank[type]},
    Compile[{{arg, spec, rank}}, function[arg], Evaluate[compileOpts]]
];

CompileListable[function_, type1 : TypePattern, type2 : TypePattern] := With[{
    spec1 = TypeSpec[type1], rank1 = TypeRank[type1],
    spec2 = TypeSpec[type2], rank2 = TypeRank[type2]},
    Compile[{{arg1, spec1, rank1}, {arg2, spec2, rank2}}, function[arg1, arg2], Evaluate[compileOpts]]
];

CompileListable[function_, type1 : TypePattern, type2 : TypePattern, type3 : TypePattern] := With[{
    spec1 = TypeSpec[type1], rank1 = TypeRank[type1],
    spec2 = TypeSpec[type2], rank2 = TypeRank[type2],
    spec3 = TypeSpec[type3], rank3 = TypeRank[type3]},
    Compile[
        {{arg1, spec1, rank1}, {arg2, spec2, rank2}, {arg3, spec3, rank3}},
        function[arg1, arg2, arg3], Evaluate[compileOpts]
    ]
];

ListablePlusImpl[type_, rank_] := ListablePlusImpl[type, rank] = CompileListable[Plus, {type, rank}, {type, rank}];
ListableMinusImpl[type_, rank_] := ListableMinusImpl[type, rank] = CompileListable[Minus, {type, rank}, {type, rank}];
ListableTimesImpl[type_, rank_] := ListableTimesImpl[type, rank] = CompileListable[Times, {type, rank}, {type, rank}];
ListableDivideImpl[type_, rank_] := ListableDivideImpl[type, rank] = CompileListable[Divide, {type, rank}, {type, rank}];

ListablePlus[values1_List, values2_List] := With[{
    type = If[ArrayQ[values1, _, IntegerQ], Integer, Real],
    rank = Min[ArrayDepth[values1], ArrayDepth[values2]]},
    ListablePlusImpl[type, rank][values1, values2]
];

ListableMinus[values1_List, values2_List] := With[{
    type = If[ArrayQ[values1, _, IntegerQ], Integer, Real],
    rank = Min[ArrayDepth[values1], ArrayDepth[values2]]},
    ListableMinusImpl[type, rank][values1, values2]
];

ListableTimes[values1_List, values2_List] := With[{
    type = If[ArrayQ[values1, _, IntegerQ], Integer, Real],
    rank = Min[ArrayDepth[values1], ArrayDepth[values2]]},
    ListableTimesImpl[type, rank][values1, values2]
];

ListableDivide[values1_List, values2_List] := With[{
    type = If[ArrayQ[values1, _, IntegerQ], Integer, Real],
    rank = Min[ArrayDepth[values1], ArrayDepth[values2]]},
    ListableDivideImpl[type, rank][values1, values2]
];

ListableMean := ListableMean = CompileListable[Mean, {Real, 1}];
ListableStandardDeviation := ListableStandardDeviation = CompileListable[StandardDeviation, {Real, 1}];

End[];

EndPackage[];
