(* ::Package:: *)

(************************************************************************)
(* This file was generated automatically by the Mathematica front end.  *)
(* It contains Initialization cells from a Notebook file, which         *)
(* typically will have the same name as this file except ending in      *)
(* ".nb" instead of ".m".                                               *)
(*                                                                      *)
(* This file is intended to be loaded into the Mathematica kernel using *)
(* the package loading commands Get or Needs.  Doing so is equivalent   *)
(* to using the Evaluate Initialization Cells menu command in the front *)
(* end.                                                                 *)
(*                                                                      *)
(* DO NOT EDIT THIS FILE.  This entire file is regenerated              *)
(* automatically each time the parent Notebook file is saved in the     *)
(* Mathematica front end.  Any changes you make to this file will be    *)
(* overwritten.                                                         *)
(************************************************************************)



(* ::Input::Initialization:: *)
DefConstantSymbol[mass,PrintAs->"m"]


(* ::Input::Initialization:: *)
DefSpinor[phi[-A],M4,PrintAs->"\[Phi]"]
DefSpinor[chi[-A\[Dagger]],M4,PrintAs->"\[Chi]"]


(* ::Input::Initialization:: *)
DefSpinor[lambda[-A],M4,PrintAs->"\[Lambda]"]
DefSpinor[gamma[-A\[Dagger]],M4,PrintAs->"\[Gamma]"]


(* ::Input::Initialization:: *)
DefSpinor[K0Coeff[-A,-B],M4,PrintAs->"K0"]
DefSpinor[L0Coeff[-A,A\[Dagger]],M4,PrintAs->"L0"]
DefSpinor[M0Coeff[-A,A\[Dagger]],M4,PrintAs->"M0"]
DefSpinor[N0Coeff[A\[Dagger],B\[Dagger]],M4,PrintAs->"N0"]
DefSpinor[K1Coeff[-A,-B,-C,-A\[Dagger]],M4,Symmetric[{2,3}],PrintAs->"K1"]
DefSpinor[L1Coeff[-A,-B,-A\[Dagger],-B\[Dagger]],M4,Symmetric[{3,4}],PrintAs->"L1"]
DefSpinor[M1Coeff[-A,-B,-A\[Dagger],-B\[Dagger]],M4,Symmetric[{1,2}],PrintAs->"M1"]
DefSpinor[N1Coeff[-A,-A\[Dagger],-B\[Dagger],-C\[Dagger]],M4,Symmetric[{3,4}],PrintAs->"N1"]


(* ::Input::Initialization:: *)
TensorToZeroRule[T_?xTensorQ]:=T:>ZeroTensor[SlotsOfTensor[T]]
EqToRule[expr_Equal]:=MakeRule[Evaluate[List@@expr]]
EqToCompareRule[expr_Equal]:=MakeCompareRule[Evaluate[List@@expr]]
FlipEquation[LHS_==Times[a_?NumberQ,RHS1_,RHSS2___]]:=Times[RHS1,RHSS2]==(LHS)/a
FlipEquation[LHS_==RHS_]:=RHS==LHS
Isolate[LHS_==RHS_,pattern_]:=Module[{eq=LHS-RHS,pos},
pos=First@First@Position[eq,pattern];
FlipEquation[eq[[pos]]-eq==eq[[pos]]]]
SplitEqIntoIrrDecParts[eq_Equal,irrdecparts_List]:=Module[{indepeqs, coefflists},
coefflists=FindTensorCoefficients[eq[[2]]-eq[[1]],irrdecparts];
If[coefflists[[1,1]]=!=0, Print["Warning! The rest does not vanish. ",coefflists[[1,1]]]];
indepeqs=FlipEquation[0==#[[1]]]&/@Rest@coefflists;
indepeqs=Union[ChangeFreeIndicesToDefault[#,{Spin\[Dagger]}]&/@indepeqs]]


(* ::Input::Initialization:: *)
NameTensors1[struct_List,basename_String,baseprintas_String]:=If[Length@struct==1,{{Symbol[StringJoin[basename,ToString[struct[[1,1]]],ToString[struct[[1,2]]]]]@@Join[DownIndex/@GetIndexRange[struct[[1,1]],Spin],GetIndexRange[struct[[1,2]],Spin\[Dagger]]],struct[[1,3]],StringJoin["\!\(\*UnderscriptBox[\(",baseprintas,"\), \(",ToString[struct[[1,1]]],",", ToString[struct[[1,2]]],"\)]\)"],StringJoin["\\underset{",ToString[struct[[1,1]]],",", ToString[struct[[1,2]]],"}{",Tex[baseprintas],"}{}"]}},
{Symbol[StringJoin[basename,ToString[struct[[#,1]]],ToString[struct[[#,2]]],FromCharacterCode[96+#]]]@@Join[DownIndex/@GetIndexRange[struct[[#,1]],Spin],GetIndexRange[struct[[#,2]],Spin\[Dagger]]],struct[[#,3]],StringJoin["\!\(\*UnderscriptBox[\(",baseprintas,FromCharacterCode[96+#],"\), \(",ToString[struct[[#,1]]],",", ToString[struct[[#,2]]],"\)]\)"],StringJoin["\\underset{",ToString[struct[[#,1]]],",", ToString[struct[[#,2]]],"}{",Tex[baseprintas],FromCharacterCode[96+#],"}{}"]}&/@Range@Length@struct
]
GiveNamesToIrrDecParts[irrdectensors_List,basename_String,baseprintas_String]:=With[{NumOfUnprimedVBundles=Length@Cases[UpIndex/@#,Spin]&,
NumOfPrimedVBundles=Length@Cases[UpIndex/@#,Dagger[Spin]]&},
Module[{sortedtensors=
Sort[{NumOfUnprimedVBundles[VBundleOfIndex/@FindFreeIndices@#],NumOfPrimedVBundles[VBundleOfIndex/@FindFreeIndices@#],#}&/@irrdectensors],numberofkind},
Flatten[NameTensors1[#,basename,baseprintas]&/@GatherBy[sortedtensors,Most],1]
]
]
DefIrrDecTensors[irrdectensors_List,basename_String,baseprintas_String]:=Module[{namestruct=GiveNamesToIrrDecParts[irrdectensors,basename,baseprintas],defcommands},defcommands={First[#],M4,CompatibleSymmetric[IndexList@@First[#]],PrintAs->#[[3]]}&/@namestruct;
DefSpinor@@@defcommands;
(Tex[Head[First[#]]]^=#[[4]])&/@namestruct;
Equal@@@(Take[#,2]&/@namestruct)]


(* ::Input::Initialization:: *)
(* Rule for sorting SymMult products with the free fields to the right. *)
sortFieldsRule=SortSymMultReverse[FreeQ[#,chi]&&FreeQ[#,phi]&];


(* ::Input::Initialization:: *)
(* Function for converting between indexed and index-free notation that also indtifies multiplication with valence 0 spinors as SymMult. *)
ToMyIndexFree[x_]:=(x/.SymHToSymMultRule//ToIndexFree)/.MultScalToSymMultRule[Spin]


(* ::Input::Initialization:: *)
(* We will use symOpCoeffsReducedEqs sa a dict *) 
symOpCoeffsReducedEqs[argument1_,arguments__]:=symOpCoeffsReducedEqs/@{argument1,arguments}


(* ::Input::Initialization:: *)
coeffs={K0Coeff,N0Coeff,K1Coeff,L1Coeff,M1Coeff,N1Coeff};(*L0Coeff and M0Coeff have trivial decompositions *)
coeffNames=SymbolName/@coeffs;
For[i=1,i<=Length@coeffs,i++,
symOpCoeffsReducedEqs[coeffNames[[i]]]=IrrDecompose[GiveIndicesToTensor[coeffs[[i]]],ResultType->"Equation",UseSym->True];
]


(* ::Input::Initialization:: *)
(* Dictionary symOpCoeffsReducedEqs is used in the following way. *)
symOpCoeffsReducedEqs["N1Coeff"]
K0Coeff[-A,A]==K0Coeff[-A,-B]\[Epsilon][A,B]/.EqToCompareRule@symOpCoeffsReducedEqs["K1Coeff"]//ToCanonical


(* ::Input::Initialization:: *)
(* Use the convenient method DefIrrDecTensors to name the irreducible parts of the symmetry operator coefficients. *)
Do[
tmp=FindSpinorsInIrrDec[symOpCoeffsReducedEqs[coeffName][[2]],{\[Epsilon],\[Epsilon]\[Dagger]}];
coeffIrrDecDefs[coeffName]=DefIrrDecTensors[tmp,coeffName,StringTake[coeffName,2]],{coeffName,coeffNames}]


(* ::Input::Initialization:: *)
(* Redefine symOpCoeffsReducedEqs to use these new names of the irreducible parts. *)
Do[
symOpCoeffsReducedEqs[coeffName]=symOpCoeffsReducedEqs[coeffName]/.Flatten[EqToCompareRule/@FlipEquation/@coeffIrrDecDefs[coeffName]],
{coeffName,coeffNames}]


(* ::Input::Initialization:: *)
(* We will use DiracEqs as a dict *) DiracEq[argument1_,arguments__]:=DiracEq/@{argument1,arguments}


(* ::Input::Initialization:: *)
(* Set up the Dirac equation for \[Phi] and \[Chi] using (5.10 .15) in Penrose and Rindler's Spinors and Space-time Vol.2. *)
DiracEq["phi"]=CurlDgCDe@phi==mass~MultScal~chi
DiracEq["chi"]=CurlCDe@chi==(-mass)~MultScal~phi


(* ::Input::Initialization:: *)
lambdaEq=lambda[-A]==K0Coeff[-A,B]phi[-B]+K1Coeff[-A,B,C,A\[Dagger]](TwistCDe@phi)[-B,-C,-A\[Dagger]]+L0Coeff[-A,A\[Dagger]]chi[-A\[Dagger]]+L1Coeff[-A,B,A\[Dagger],B\[Dagger]](TwistCDe@chi)[-B,-A\[Dagger],-B\[Dagger]]//ToCanonical
gammaEq=gamma[-A\[Dagger]]==M0Coeff[A,-A\[Dagger]]phi[-A]+M1Coeff[A,B,-A\[Dagger],B\[Dagger]](TwistCDe@phi)[-A,-B,-B\[Dagger]]+N0Coeff[-A\[Dagger],B\[Dagger]]chi[-B\[Dagger]]+N1Coeff[A,-A\[Dagger],B\[Dagger],C\[Dagger]](TwistCDe@chi)[-A,-B\[Dagger],-C\[Dagger]]//ToCanonical



