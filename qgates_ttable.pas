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

{=====================================================================
This is a bad quantum gates emulation via truth tables:
EQU gate,
Pauli_X gate (NOT),
SWAP gate,
CNOT gate,
Toffoli gate (CCNOT)
Fredkin gate (CSWAP)
=====================================================================}
unit qgates_ttable;
interface
uses q_defs;

procedure tt_EQU_gate(var x:tbit);
procedure tt_NOT_gate(var x:tbit);
procedure tt_SWAP_gate(var x1,x2:tbit);
procedure tt_CNOT_gate(var x1,x2:tbit);
procedure tt_CCNOT_gate(var x1,x2,x3:tbit);
procedure tt_CSWAP_gate(var x1,x2,x3:tbit);

implementation
{equal gate}
procedure tt_EQU_gate(var x:tbit);
begin end;

{Pauli-X gate}
procedure tt_NOT_gate(var x:tbit);
var y:tbit;
begin
   if x=zero then y:=one;
   if x=one then y:=zero;
   x:=y;
end;

{SWAP gate}
procedure tt_SWAP_gate(var x1,x2:tbit);
var y1,y2:tbit;
begin
   if (x1=zero)and(x2=zero) then begin y1:=zero; y2:=zero; end;
   if (x1=zero)and(x2=one) then begin y1:=one; y2:=zero; end;
   if (x1=one)and(x2=zero) then begin y1:=zero; y2:=one; end;
   if (x1=one)and(x2=one) then begin y1:=one; y2:=one; end;
   x1:=y1; x2:=y2;
end;

{CNOT gate}
procedure tt_CNOT_gate(var x1,x2:tbit);
var y1,y2:tbit;
begin
   if (x1=zero)and(x2=zero) then begin y1:=zero; y2:=zero; end;
   if (x1=zero)and(x2=one) then begin y1:=zero; y2:=one; end;
   if (x1=one)and(x2=zero) then begin y1:=one; y2:=one; end;
   if (x1=one)and(x2=one) then begin y1:=one; y2:=zero; end;
   x1:=y1; x2:=y2;
end;

{Toffoli gate}
procedure tt_CCNOT_gate(var x1,x2,x3:tbit);
var y1,y2,y3:tbit;
begin
if (x1=zero)and(x2=zero)and(x3=zero) then begin y1:=zero; y2:=zero; y3:=zero; end;
if (x1=zero)and(x2=zero)and(x3=one) then begin y1:=zero; y2:=zero; y3:=one; end;
if (x1=zero)and(x2=one)and(x3=zero) then begin y1:=zero; y2:=one; y3:=zero; end;
if (x1=zero)and(x2=one)and(x3=one) then begin y1:=zero; y2:=one; y3:=one; end;
if (x1=one)and(x2=zero)and(x3=zero) then begin y1:=one; y2:=zero; y3:=zero; end;
if (x1=one)and(x2=zero)and(x3=one) then begin y1:=one; y2:=zero; y3:=one; end;
if (x1=one)and(x2=one)and(x3=zero) then begin y1:=one; y2:=one; y3:=one; end;
if (x1=one)and(x2=one)and(x3=one) then begin y1:=one; y2:=one; y3:=zero; end;
x1:=y1; x2:=y2; x3:=y3;
end;

{Fredkin gate}
procedure tt_CSWAP_gate(var x1,x2,x3:tbit);
var y1,y2,y3:tbit;
begin
if (x1=zero)and(x2=zero)and(x3=zero) then begin y1:=zero; y2:=zero; y3:=zero; end;
if (x1=zero)and(x2=zero)and(x3=one) then begin y1:=zero; y2:=zero; y3:=one; end;
if (x1=zero)and(x2=one)and(x3=zero) then begin y1:=zero; y2:=one; y3:=zero; end;
if (x1=zero)and(x2=one)and(x3=one) then begin y1:=zero; y2:=one; y3:=one; end;
if (x1=one)and(x2=zero)and(x3=zero) then begin y1:=one; y2:=zero; y3:=zero; end;
if (x1=one)and(x2=zero)and(x3=one) then begin y1:=one; y2:=one; y3:=zero; end;
if (x1=one)and(x2=one)and(x3=zero) then begin y1:=one; y2:=zero; y3:=one; end;
if (x1=one)and(x2=one)and(x3=one) then begin y1:=one; y2:=one; y3:=one; end;
x1:=y1; x2:=y2; x3:=y3;
end;
end.
