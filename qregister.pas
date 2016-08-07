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
quantum register operations:
create quantum register,
seek procedure for real bits of n-qbit's register,
apply [2**Nx2**N] gate matrix to all qubits of n-qbit register,
calc 1_qbit gate matrix for use to a n-qbit register,
calc 2_qbit CNOT gate matrix for use to a n-qbit register,
=====================================================================}
unit qregister;
interface
uses arith_complex, q_defs;

function qregister_create(n:integer):tqregister;
procedure qregister_get_tbits(var qreg:tqregister; res:tbit_vector);
procedure qregister_get_entanglement(var qreg:tqregister; res:tbit_vector);
procedure qregister_set_tbits(var qreg:tqregister; value:tbit_vector);
procedure qregister_apply_gate(var qreg:tqregister; gate:TComplexMatrix);
function qregister_calc_gate1(k,n:integer; p00,p01,p10,p11:tcomplex):TComplexMatrix;
function qregister_calc_I_gate(n:integer):TComplexMatrix;
function qregister_calc_H_gate(n:integer):TComplexMatrix;
function qregister_calc_X_gate(k,n:integer):TComplexMatrix;
function qregister_calc_Y_gate(k,n:integer):TComplexMatrix;
function qregister_calc_Z_gate(k,n:integer):TComplexMatrix;
function qregister_calc_PHI_gate(k,n:integer; phi:real):TComplexMatrix;
function qregister_calc_NOT_gate(k,n:integer):TComplexMatrix;
function qregister_calc_SWAP_gate(c1_qbit,c2_qbit,n:integer):TComplexMatrix;
function qregister_calc_CNOT_gate(c_qbit,u_qbit,n:integer):TComplexMatrix;
procedure qregister_get_qbits(start_pos,n_res:integer; var qreg,res:tqregister);
procedure qregister_erase_qbits(start_pos,n_erase:integer; var qreg,res:tqregister);
procedure qregister_increase_qbits_num(n:integer; var qreg,res:tqregister);

implementation

function qregister_create(n:integer):tqregister;
var tmp:tqregister;
begin
   setlength(tmp,pow2(n));
   c_vector_fill(c_zero,tmp);
   qregister_create:=tmp;
end;

procedure qregister_set_tbits(var qreg:tqregister; value:tbit_vector);
var i,n,idx:integer;
begin
   c_vector_fill(c_zero,qreg);
   n:=length(value);
   if value[n-1]=one then idx:=1 else idx:=0;
   for i:=n-2 downto 0 do
   begin
      idx:=idx*2;
      if value[i]=one then idx:=idx+1;
   end;
   qreg[idx]:=c_one;
end;

procedure qregister_get_tbits(var qreg:tqregister; res:tbit_vector);
var i,n,nn,max_amp2_idx:integer; amp2,max_amp2:real;
begin
   nn:=length(qreg);
   max_amp2_idx:=0; max_amp2:=c_amp2(qreg[0]); 
   for i:=1 to nn-1 do
   begin
      amp2:=c_amp2(qreg[i]);
      if amp2>max_amp2 then begin max_amp2:=amp2; max_amp2_idx:=i; end;
   end;
   n:=log2(nn);
   for i:=0 to n-1 do
   begin
      if (max_amp2_idx mod 2)=0 then res[i]:=zero else res[i]:=one;
      max_amp2_idx:=max_amp2_idx div 2;
   end;
end;

procedure qregister_get_entanglement(var qreg:tqregister; res:tbit_vector);
var i,n,nn:integer;
begin
   qregister_get_tbits(qreg,res);
   nn:=length(qreg); n:=log2(nn);
   for i:=0 to n-1 do
      if res[i]=zero then res[i]:=one else res[i]:=zero;
end;

procedure qregister_apply_gate(var qreg:tqregister; gate:TComplexMatrix);
var tmp_reg:tqregister;
begin
   tmp_reg:=c_vector(length(qreg));
   c_vector_copy(qreg,tmp_reg);
   c_matrix_mul_vector(gate,qreg,tmp_reg);
   c_vector_copy(tmp_reg,qreg);
   setlength(tmp_reg,0);
end;

function qregister_calc_gate1(k,n:integer; p00,p01,p10,p11:tcomplex):TComplexMatrix;
var i:integer;
   tmp,tmp1,gateP,gateI:TComplexMatrix;
begin
   gateI:=c_matrix(2,2);
   gateI[0,0]:=c_one; gateI[0,1]:=c_zero; gateI[1,0]:=c_zero; gateI[1,1]:=c_one;
   gateP:=c_matrix(2,2);
   gateP[0,0]:=p00; gateP[0,1]:=p01; gateP[1,0]:=p10; gateP[1,1]:=p11;
   tmp:=c_matrix(2,2);
   if k=0 then c_matrix_copy(gateP,tmp) else c_matrix_copy(gateI,tmp);
   for i:=1 to n-1 do
   begin
      c_matrix_destroy(tmp1);
      tmp1:=c_matrix(pow2(i+1),pow2(i+1));
      if i=k then c_matrix_kronmul_matrix(gateP,tmp,tmp1)
             else c_matrix_kronmul_matrix(gateI,tmp,tmp1);
      c_matrix_destroy(tmp);
      tmp:=c_matrix(pow2(i+1),pow2(i+1));
      c_matrix_copy(tmp1,tmp);
   end;
   c_matrix_destroy(tmp1);
   c_matrix_destroy(gateI);
   c_matrix_destroy(gateP);
   qregister_calc_gate1:=tmp;
end;

function qregister_calc_I_gate(n:integer):TComplexMatrix;
var i,nn:integer; tmp:TComplexMatrix;
begin
   nn:=pow2(n);
   tmp:=c_matrix(nn,nn);
   for i:=0 to nn-1 do tmp[i,i]:=c_one;
   qregister_calc_I_gate:=tmp;
end;

function qregister_calc_H_gate(n:integer):TComplexMatrix;
var i:integer; tmp,tmp1,gateH:TComplexMatrix;
begin
   gateH:=c_matrix(2,2);
   gateH[0,0]:=c_complex(1.0/sqrt2,0);
   gateH[0,1]:=c_complex(1.0/sqrt2,0);
   gateH[1,0]:=c_complex(1.0/sqrt2,0);
   gateH[1,1]:=c_complex(-1.0/sqrt2,0);
   tmp:=c_matrix(2,2); c_matrix_copy(gateH,tmp);
   for i:=1 to n-1 do
   begin
      c_matrix_destroy(tmp1);
      tmp1:=c_matrix(pow2(i+1),pow2(i+1));
      c_matrix_kronmul_matrix(gateH,tmp,tmp1);
      c_matrix_destroy(tmp);
      tmp:=c_matrix(pow2(i+1),pow2(i+1));
      c_matrix_copy(tmp1,tmp);
   end;
   c_matrix_destroy(tmp1);
   c_matrix_destroy(gateH);
   qregister_calc_H_gate:=tmp;
end;

function qregister_calc_X_gate(k,n:integer):TComplexMatrix;
begin
qregister_calc_X_gate:=qregister_calc_gate1(k,n,c_zero,c_one,c_one,c_zero);
end;

function qregister_calc_Y_gate(k,n:integer):TComplexMatrix;
begin
qregister_calc_Y_gate:=qregister_calc_gate1(k,n,c_zero,c_minus_i,c_i,c_zero);
end;

function qregister_calc_Z_gate(k,n:integer):TComplexMatrix;
begin
qregister_calc_Z_gate:=qregister_calc_gate1(k,n,c_one,c_zero,c_zero,c_minus_one);
end;

function qregister_calc_PHI_gate(k,n:integer; phi:real):TComplexMatrix;
begin
qregister_calc_PHI_gate:=qregister_calc_gate1(k,n,c_one,c_zero,c_zero,c_exp_ix(phi));
end;

function qregister_calc_NOT_gate(k,n:integer):TComplexMatrix;
var i,nn,nn2,idx1,idx2:integer; tmp:TComplexMatrix;
begin 
   nn:=pow2(n); nn2:=nn shr 1;
   tmp:=qregister_calc_I_gate(n);
   for i:=0 to nn2-1 do
   begin
      idx1:=insert_bit(i,k,0);
      idx2:=insert_bit(i,k,1);
      c_vectors_swap(tmp[idx1],tmp[idx2]);
   end;
   qregister_calc_NOT_gate:=tmp;
end;

function qregister_calc_SWAP_gate(c1_qbit,c2_qbit,n:integer):TComplexMatrix;
var i,nn,idx,b1,b2:integer; tmp:TComplexMatrix;
begin
   nn:=pow2(n);
   tmp:=c_matrix(nn,nn); c_matrix_fill(c_zero,tmp);
   for i:=0 to nn-1 do
   begin
      b1:=get_bit(i,c1_qbit); b2:=get_bit(i,c2_qbit);
      idx:=set_bit(i,c1_qbit,b2); idx:=set_bit(idx,c2_qbit,b1);
      tmp[i,idx]:=c_one;
   end;
   qregister_calc_SWAP_gate:=tmp;
end;

function qregister_calc_CNOT_gate(c_qbit,u_qbit,n:integer):TComplexMatrix;
var i,nn,nn2,idx1,idx2:integer; tmp:TComplexMatrix;
begin
   nn:=pow2(n); nn2:=nn shr 1;
   tmp:=qregister_calc_I_gate(n);
   for i:=0 to nn2-1 do
   begin
      idx1:=insert_bit(i,u_qbit,0);
      idx2:=insert_bit(i,u_qbit,1);
      if get_bit(idx1,c_qbit)=1 then c_vectors_swap(tmp[idx1],tmp[idx2]);
   end;
   qregister_calc_CNOT_gate:=tmp;
end;

procedure qregister_get_qbits(start_pos,n_res:integer; var qreg,res:tqregister);
var n,i,idx:integer;
begin
   n:=length(qreg);
   c_vector_fill(c_zero,res);
   for i:=0 to n-1 do
   begin
      idx:=get_bits(i,start_pos,n_res);
      res[idx]:=c_add(res[idx],qreg[i]);
   end;
end;

procedure qregister_erase_qbits(start_pos,n_erase:integer; var qreg,res:tqregister);
var n,nq,i,idx,end_pos,left_part,right_part:integer;
begin
   n:=length(qreg); nq:=log2(n);
   end_pos:=start_pos+n_erase;
   c_vector_fill(c_zero,res);
   for i:=0 to n-1 do
   begin
      left_part:=get_bits(i,end_pos,nq-end_pos);
      right_part:=get_bits(i,0,start_pos);
      idx:=insert_bits(left_part,0,right_part,start_pos);
      res[idx]:=c_add(res[idx],qreg[i]);
   end;
end;

procedure qregister_increase_qbits_num(n:integer; var qreg,res:tqregister);
var i,nn_qreg,nn_res:integer;
begin
   nn_qreg:=length(qreg);
   nn_res:=pow2(log2(nn_qreg)+n);
   for i:=0 to nn_qreg-1 do res[i]:=qreg[i];
   for i:=nn_qreg to nn_res-1 do res[i]:=c_zero;
end;

end.
