(*  Title:      HOL/Hoare/HeapSyntax.thy
    ID:         $Id$
    Author:     Tobias Nipkow
    Copyright   2002 TUM
*)

theory HeapSyntaxAbort imports HoareAbort Heap begin

subsection "Field access and update"

text{* Heap update @{text"p^.h := e"} is now guarded against @{term p}
being Null. However, @{term p} may still be illegal,
e.g. uninitialized or dangling. To guard against that, one needs a
more detailed model of the heap where allocated and free addresses are
distinguished, e.g. by making the heap a map, or by carrying the set
of free addresses around. This is needed anyway as soon as we want to
reason about storage allocation/deallocation. *}

syntax
  "refupdate" :: "('a \<Rightarrow> 'b) \<Rightarrow> 'a ref \<Rightarrow> 'b \<Rightarrow> ('a \<Rightarrow> 'b)"
   ("_/'((_ \<rightarrow> _)')" [1000,0] 900)
  "@fassign"  :: "'a ref => id => 'v => 's com"
   ("(2_^._ :=/ _)" [70,1000,65] 61)
  "@faccess"  :: "'a ref => ('a ref \<Rightarrow> 'v) => 'v"
   ("_^._" [65,1000] 65)
translations
  "refupdate f r v"  ==  "f(addr r := v)"
  "p^.f := e"  =>  "(p \<noteq> Null) \<rightarrow> (f := refupdate f p e)"
  "p^.f"       =>  "f(addr p)"


declare fun_upd_apply[simp del] fun_upd_same[simp] fun_upd_other[simp]


text "An example due to Suzuki:"

lemma "VARS v n
  {w = Ref w0 & x = Ref x0 & y = Ref y0 & z = Ref z0 &
   distinct[w0,x0,y0,z0]}
  w^.v := (1::int); w^.n := x;
  x^.v := 2; x^.n := y;
  y^.v := 3; y^.n := z;
  z^.v := 4; x^.n := z
  {w^.n^.n^.v = 4}"
by vcg_simp

end
