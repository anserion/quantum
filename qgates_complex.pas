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
quantum gates emulation via complex arith:
=====================================================================}
unit qgates_complex;

interface
uses q_defs, arith_complex;

function I_gate_matrix:TComplexMatrix;
function Hadamard_gate_matrix:TComplexMatrix;
function PauliX_gate_matrix:TComplexMatrix;
function PauliY_gate_matrix:TComplexMatrix;
function PauliZ_gate_matrix:TComplexMatrix;
function PhaseShift_gate_matrix(phi:real):TComplexMatrix;
function NOT_gate_matrix:TComplexMatrix;
function SWAP_gate_matrix:TComplexMatrix;
function SQRT_SWAP_gate_matrix:TComplexMatrix;
function CNOT_gate_matrix:TComplexMatrix;
function CCNOT_gate_matrix:TComplexMatrix;
function CSWAP_gate_matrix:TComplexMatrix;

implementation

//1-qbit gates
function I_gate_matrix:TComplexMatrix;
var q:TComplexMatrix;
begin
   q:=c_matrix(2,2); c_matrix_fill(c_zero,q);
   q[0,0]:=c_one;
   q[1,1]:=c_one;
   I_gate_matrix:=q;
end;

function Hadamard_gate_matrix:TComplexMatrix;
var q:TComplexMatrix;
begin
   q:=c_matrix(2,2);
   q[0,0]:=c_complex(1.0/sqrt2,0);
   q[0,1]:=c_complex(1.0/sqrt2,0);
   q[1,0]:=c_complex(1.0/sqrt2,0);
   q[1,1]:=c_complex(-1.0/sqrt2,0);
   Hadamard_gate_matrix:=q;
end;

function PauliX_gate_matrix:TComplexMatrix;
var q:TComplexMatrix;
begin
   q:=c_matrix(2,2); c_matrix_fill(c_zero,q);
   q[0,1]:=c_one;
   q[1,0]:=c_one;
   PauliX_gate_matrix:=q;
end;

function PauliY_gate_matrix:TComplexMatrix;
var q:TComplexMatrix;
begin
   q:=c_matrix(2,2); c_matrix_fill(c_zero,q);
   q[0,1]:=c_minus_i;
   q[1,0]:=c_i;
   PauliY_gate_matrix:=q;
end;

function PauliZ_gate_matrix:TComplexMatrix;
var q:TComplexMatrix;
begin
   q:=c_matrix(2,2); c_matrix_fill(c_zero,q);
   q[0,0]:=c_one;
   q[1,1]:=c_minus_one;
   PauliZ_gate_matrix:=q;
end;

function PhaseShift_gate_matrix(phi:real):TComplexMatrix;
var q:TComplexMatrix;
begin
   q:=c_matrix(2,2); c_matrix_fill(c_zero,q);
   q[0,0]:=c_one;
   q[1,1]:=c_exp_ix(phi);
   PhaseShift_gate_matrix:=q;
end;

function NOT_gate_matrix:TComplexMatrix;
begin NOT_gate_matrix:=PauliX_gate_matrix; end;

//2-qbit gates
function SWAP_gate_matrix:TComplexMatrix;
var q:TComplexMatrix;
begin
   q:=c_matrix(4,4); c_matrix_fill(c_zero,q);
   q[0,0]:=c_one;
   q[1,2]:=c_one;
   q[2,1]:=c_one;
   q[3,3]:=c_one;
   SWAP_gate_matrix:=q;
end;

function SQRT_SWAP_gate_matrix:TComplexMatrix;
var q:TComplexMatrix;
begin
   q:=c_matrix(4,4); c_matrix_fill(c_zero,q);
   q[0,0]:=c_one;
   q[1,1]:=c_complex(0.5,0.5);
   q[1,2]:=c_complex(0.5,-0.5);
   q[2,1]:=c_complex(0.5,-0.5);
   q[2,2]:=c_complex(0.5,0.5);
   q[3,3]:=c_one;
   SQRT_SWAP_gate_matrix:=q;
end;

function CNOT_gate_matrix:TComplexMatrix;
var q:TComplexMatrix;
begin
   q:=c_matrix(4,4); c_matrix_fill(c_zero,q);
   q[0,0]:=c_one;
   q[1,1]:=c_one;
   q[2,3]:=c_one;
   q[3,2]:=c_one;
   CNOT_gate_matrix:=q;
end;

//3-qbit gates
function CCNOT_gate_matrix:TComplexMatrix;
var q:TComplexMatrix;
begin
   q:=c_matrix(8,8); c_matrix_fill(c_zero,q);
   q[0,0]:=c_one;
   q[1,1]:=c_one;
   q[2,2]:=c_one;
   q[3,3]:=c_one;
   q[4,4]:=c_one;
   q[5,5]:=c_one;
   q[6,7]:=c_one;
   q[7,6]:=c_one;
   CCNOT_gate_matrix:=q;
end;

function CSWAP_gate_matrix:TComplexMatrix;
var q:TComplexMatrix;
begin
   q:=c_matrix(8,8); c_matrix_fill(c_zero,q);
   q[0,0]:=c_one;
   q[1,1]:=c_one;
   q[2,2]:=c_one;
   q[3,3]:=c_one;
   q[4,4]:=c_one;
   q[5,6]:=c_one;
   q[6,5]:=c_one;
   q[7,7]:=c_one;
   CSWAP_gate_matrix:=q;
end;

end.
