//Copyright 2016 Andrey S. Ionisyan
//
//Licensed under the Apache License, Version 2.0 (the "License");
//you may not use this file except in compliance with the License.
//You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
//Unless required by applicable law or agreed to in writing, software
//distributed under the License is distributed on an "AS IS" BASIS,
//WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//See the License for the specific language governing permissions and
//limitations under the License.

{======================================================================
some operations over complex numbers
======================================================================}

unit complex_arith;
interface
uses q_defs;

function C_ADD(a,b:tcomplex):tcomplex;
function C_SUB(a,b:tcomplex):tcomplex;
function C_MUL(a,b:tcomplex):tcomplex;
function C_DIV(a,b:tcomplex):tcomplex;
function C_EXP_IPHI(phi:real):tcomplex;
function C_EXP(x:tcomplex):tcomplex;
function C_AMP2(a:tcomplex):real;
function C_AMP(a:tcomplex):real;
function C_ARG(a,b:tcomplex):real;

implementation

function C_ADD(a,b:tcomplex):tcomplex;
begin C_ADD.re:=a.re+b.re; C_ADD.im:=a.im+b.im; end;

function C_SUB(a,b:tcomplex):tcomplex;
begin C_SUB.re:=a.re-b.re; C_SUB.im:=a.im-b.im; end;

function C_MUL(a,b:tcomplex):tcomplex;
begin C_MUL.re:=a.re*b.re-a.im*b.im; C_MUL.im:=a.re*b.im+a.im*b.im; end;

function C_DIV(a,b:tcomplex):tcomplex;
begin
   C_DIV.re:=(a.re*b.re+a.im*b.im)/(b.re*b.re+b.im*b.im);
   C_DIV.im:=(a.im*b.re-a.re*b.im)/(b.re*b.re+b.im*b.im);
end;

function C_EXP_IPHI(phi:real):tcomplex;
begin C_EXP_IPHI.re:=cos(phi); C_EXP_IPHI.im:=sin(phi); end;

function C_EXP(x:tcomplex):tcomplex;
begin end;

function C_AMP2(a:tcomplex):real;
begin C_AMP2:=a.re*a.re+a.im*a.im; end;

function C_AMP(a:tcomplex):real;
begin C_AMP:=sqrt(C_AMP2(a)); end;

function C_ARG(a:tcomplex):real;
begin
   if (a.re=0)and(a.im=0) then C_ARG:=0
   else C_ARG:=acos(A.re/C_AMP(a));
end;

end.
