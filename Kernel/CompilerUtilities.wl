BeginPackage["Utilities`", {"CCompilerDriver`"}];

CompileListable::usage = UsageString@"CompileListable[`fun`, `type`] creates a compiled function that automatically threads over lists.
CompileListable[`fun`, `type_1`, `type_2`, \[Ellipsis]] creates a compiled function with multiple arguments that automatically threads over lists.";

ListableMean;
ListableStandardDeviation;
ListableCorrelation;

Begin["`Private`"];

vsWhere = FileNameJoin@{Environment["ProgramFiles(x86)"], "Microsoft Visual Studio", "Installer", "vswhere.exe"};
$CCompiler = {
    "Compiler" -> CCompilerDriver`VisualStudioCompiler`VisualStudioCompiler,
    "CompilerInstallation" -> StringTrim@RunProcess[
        {vsWhere, "-latest", "-prerelease", "-property", "installationPath"}, "StandardOutput"]
};

typePattern = _Symbol | {_Symbol, _Integer};

TypeSpec[type_] := Blank@If[ListQ[type], First[type], type];
TypeRank[type_] := If[ListQ[type], Last[type], 0];

listableCompilationOptions = Sequence[
    CompilationTarget -> "C", RuntimeOptions -> "Speed",
    CompilationOptions -> {"InlineExternalDefinitions" -> True, "InlineCompiledFunctions" -> True},
    RuntimeAttributes -> {Listable}, Parallelization -> True
];

CompileListable[fun_, type : typePattern] := With[{spec = TypeSpec[type], rank = TypeRank[type]},
    Compile[{{arg, spec, rank}}, fun[arg], Evaluate[listableCompilationOptions]]
];

CompileListable[fun_, type1 : typePattern, type2 : typePattern] := With[{
    spec1 = TypeSpec[type1], rank1 = TypeRank[type1],
    spec2 = TypeSpec[type2], rank2 = TypeRank[type2]},
    Compile[{{arg1, spec1, rank1}, {arg2, spec2, rank2}}, fun[arg1, arg2], Evaluate[listableCompilationOptions]]
];

CompileListable[fun_, type1 : typePattern, type2 : typePattern, type3 : typePattern] := With[{
    spec1 = TypeSpec[type1], rank1 = TypeRank[type1],
    spec2 = TypeSpec[type2], rank2 = TypeRank[type2],
    spec3 = TypeSpec[type3], rank3 = TypeRank[type3]},
    Compile[
        {{arg1, spec1, rank1}, {arg2, spec2, rank2}, {arg3, spec3, rank3}},
        fun[arg1, arg2, arg3], Evaluate[listableCompilationOptions]
    ]
];

ListableMean := ListableMean = CompileListable[Mean, {Real, 1}];
ListableStandardDeviation := ListableStandardDeviation = CompileListable[StandardDeviation, {Real, 1}];

ListableCorrelation := ListableCorrelation = CompileListable[{v1, v2} |->
        (v1 - Mean[v1]).(v2 - Mean[v2]) / (Length[v1] - 1) / (StandardDeviation[v1] StandardDeviation[v2]),
    {Real, 1}, {Real, 1}];

End[];

EndPackage[];
