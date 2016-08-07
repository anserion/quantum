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
basic binary logic
toffoli (CCNOT) quantum gate used
=====================================================================}

unit qbinary_gates;
interface
uses q_defs, arith_complex, qgates_ttable, qregister, qgates_complex;

function q_not(op1:tbit):tbit;
function q_and(op1,op2:tbit):tbit;
function q_nand(op1,op2:tbit):tbit;
function q_xor(op1,op2:tbit):tbit;
procedure q_fanout(x:tbit; var y1,y2:tbit);
function q_or(op1,op2:tbit):tbit;
function q_nor(op1,op2:tbit):tbit;
function q_and3(x1,x2,x3:tbit):tbit;
function q_and4(x1,x2,x3,x4:tbit):tbit;
function q_nand3(x1,x2,x3:tbit):tbit;
function q_nand4(x1,x2,x3,x4:tbit):tbit;
function q_or4(x1,x2,x3,x4:tbit):tbit;
function q_or8(x1,x2,x3,x4,x5,x6,x7,x8:tbit):tbit;

implementation

procedure CCNOT_gate(x1,x2,x3:tbit; var y1,y2,y3:tbit);
var x_q:tqregister; x_b:tbit_vector;
begin
{1. truth tables method}
//tt_CCNOT_gate(x1,x2,x3);
//y1:=x1; y2:=x2; y3:=x3;
{2. via 3-qbit Toffoli gate}
   setlength(x_b,3);
   x_b[2]:=x1; x_b[1]:=x2; x_b[0]:=x3;
   x_q:=qregister_create(3);
   qregister_set_tbits(x_q,x_b);
   qregister_apply_gate(x_q,CCNOT_gate_matrix);
   qregister_get_tbits(x_q,x_b);
   y1:=x_b[2]; y2:=x_b[1]; y3:=x_b[0];
   setlength(x_b,0);
   setlength(x_q,0);
end;

function q_not(op1:tbit):tbit;
var tmp_res,g1,g2:tbit;
begin CCNOT_gate(one,one,op1,g1,g2,tmp_res); q_not:=tmp_res; end;

function q_and(op1,op2:tbit):tbit;
var tmp_res,g1,g2:tbit;
begin CCNOT_gate(op1,op2,zero,g1,g2,tmp_res); q_and:=tmp_res; end;

function q_nand(op1,op2:tbit):tbit;
var tmp_res,g1,g2:tbit;
begin CCNOT_gate(op1,op2,one,g1,g2,tmp_res); q_nand:=tmp_res; end;

function q_xor(op1,op2:tbit):tbit;
var tmp_res,g1,g2:tbit;
begin CCNOT_gate(op1,one,op2,g1,g2,tmp_res); q_xor:=tmp_res; end;

procedure q_fanout(x:tbit; var y1,y2:tbit);
var g1:tbit;
begin CCNOT_gate(x,one,zero,y1,g1,y2); end;

function q_or(op1,op2:tbit):tbit;
begin q_or:=q_nand(q_not(op1),q_not(op2)); end;

function q_nor(op1,op2:tbit):tbit;
begin q_nor:=q_and(q_not(op1),q_not(op2)); end;

function q_and3(x1,x2,x3:tbit):tbit;
begin q_and3:=q_and(q_and(x1,x2),x3); end;

function q_and4(x1,x2,x3,x4:tbit):tbit;
begin q_and4:=q_and(q_and(x1,x2),q_and(x3,x4)); end;

function q_nand3(x1,x2,x3:tbit):tbit;
begin q_nand3:=q_not(q_and3(x1,x2,x3)); end;

function q_nand4(x1,x2,x3,x4:tbit):tbit;
begin q_nand4:=q_not(q_and4(x1,x2,x3,x4)); end;

function q_or4(x1,x2,x3,x4:tbit):tbit;
begin q_or4:=q_or(q_or(x1,x2),q_or(x3,x4)); end;

function q_or8(x1,x2,x3,x4,x5,x6,x7,x8:tbit):tbit;
begin q_or8:=q_or(q_or4(x1,x2,x3,x4),q_or4(x5,x6,x7,x8)); end;
end.
