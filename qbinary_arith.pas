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
binary arithmetic modules:
bits cutter, bits setter
half_adder,
full_adder,
n-bit adder,
n-bit subtractor,
n-bit multiplier,
n-bit equal compare,
n-bit compare for a greater,
n-bit compare for a equ, greater, lower
n-bit divider
=====================================================================}
unit qbinary_arith;
interface

uses q_defs, qbinary_gates, qbinary_lev2;

function bin_cut_bits(start_pos,end_pos:integer; var x:tbit_vector):tbit_vector;
procedure bin_ins_bits(start_pos,end_pos:integer; var src,dst:tbit_vector);
procedure bin_set_bits(start_pos,end_pos:integer; value:tbit; var x:tbit_vector);
procedure bin_half_adder(a,b:tbit; var s,c:tbit);
procedure bin_full_adder(a,b,c_in:tbit; var s,c_out:tbit);
procedure bin_add(a,b:tbit_vector; var s:tbit_vector);
procedure bin_sub(a,b:tbit_vector; var s:tbit_vector);
procedure bin_mul(a,b:tbit_vector; var s:tbit_vector);
procedure bin_is_equal(a,b:tbit_vector; var res:tbit);
procedure bin_is_greater_than(a,b:tbit_vector; var res:tbit);
procedure bin_cmp(a,b:tbit_vector; var res_equ,res_greater,res_lower:tbit);
procedure bin_div(a,b:tbit_vector; var q,r:tbit_vector);

implementation

function bin_cut_bits(start_pos,end_pos:integer; var x:tbit_vector):tbit_vector;
var tmp:tbit_vector; i:integer;
begin
   setlength(tmp,end_pos-start_pos+1);
   for i:=start_pos to end_pos do tmp[i-start_pos]:=x[i];
   bin_cut_bits:=tmp;
end;

procedure bin_ins_bits(start_pos,end_pos:integer; var src,dst:tbit_vector);
var i:integer;
begin for i:=start_pos to end_pos do dst[i]:=src[i-start_pos]; end;

procedure bin_set_bits(start_pos,end_pos:integer; value:tbit; var x:tbit_vector);
var i:integer; 
begin for i:=start_pos to end_pos do x[i]:=value; end;

{half-adder}
procedure bin_half_adder(a,b:tbit; var s,c:tbit);
begin
    c:=q_and(a,b);
    s:=q_xor(a,b);
end;

{full-adder}
procedure bin_full_adder(a,b,c_in:tbit; var s,c_out:tbit);
var s1,s2,p1,p2:tbit;
begin
    bin_half_adder(a,b,s1,p1);
    bin_half_adder(s1,c_in,s2,p2);
    s:=s2;
    c_out:=q_or(p1,p2);
end;

{n-bit adder}
procedure bin_add(a,b:tbit_vector; var s:tbit_vector);
var i,n:integer; c:tbit_vector;
begin
n:=length(a); setlength(c,n+1);
c[0]:=zero;
for i:=0 to n-1 do bin_full_adder(a[i],b[i],c[i],s[i],c[i+1]);
{s[n]:=c[n];}
setlength(c,0);
end;

{n-bit subtractor}
procedure bin_sub(a,b:tbit_vector; var s:tbit_vector);
var i,n:integer; c:tbit_vector;
begin
n:=length(a); setlength(c,n+1);
c[0]:=one;
for i:=0 to n-1 do bin_full_adder(a[i],q_not(b[i]),c[i],s[i],c[i+1]);
{s[n]:=c[n];}
setlength(c,0);
end;

{n-bit multiplier}
procedure bin_mul(a,b:tbit_vector; var s:tbit_vector);
var i,n:integer;
    tmp_sum,tmp_op1:tbit_table;
begin
n:=length(a);
setlength(tmp_op1,n); for i:=0 to n-1 do setlength(tmp_op1[i],n);
setlength(tmp_sum,n+1); for i:=0 to n do setlength(tmp_sum[i],n+1);
for i:=0 to n-1 do tmp_sum[0,i]:=zero;
for i:=0 to n-1 do
begin
    if b[i]=one then 
    begin
       bin_set_bits(0,i-1,zero,tmp_op1[i]);
       bin_ins_bits(i,n-1,a,tmp_op1[i]);
    end
    else bin_set_bits(0,n-1,zero,tmp_op1[i]);
    bin_add(tmp_op1[i],tmp_sum[i],tmp_sum[i+1]);
end;
bin_ins_bits(0,n-1,tmp_sum[n],s);
for i:=0 to n-1 do setlength(tmp_op1[i],0); setlength(tmp_op1,0);
for i:=0 to n do setlength(tmp_sum[i],0); setlength(tmp_sum,0);
end;

{n-bit equal compare}
procedure bin_is_equal(a,b:tbit_vector; var res:tbit);
var res_tmp:tbit_vector; i,n:integer;
begin
   n:=length(a); setlength(res_tmp,n+1);
   res_tmp[0]:=zero;
   for i:=0 to n-1 do res_tmp[i+1]:=q_or(res_tmp[i],q_xor(a[i],b[i]));
   res:=q_not(res_tmp[n]);
   setlength(res_tmp,0);
end;

{n-bit greater compare. if a>b then res:=1}
procedure bin_is_greater_than(a,b:tbit_vector; var res:tbit);
var tmp_res,tmp_carry,tmp_cmp,tmp_equ:tbit_vector;
   i,n:integer;
begin
   n:=length(a);
   setlength(tmp_res,n+1); setlength(tmp_carry,n+1);
   setlength(tmp_cmp,n); setlength(tmp_equ,n);
   
   tmp_res[n]:=zero;
   tmp_carry[n]:=one;
   for i:=n-1 downto 0 do
   begin
      tmp_cmp[i]:=q_and(a[i],q_not(b[i]));
      tmp_equ[i]:=q_not(q_xor(a[i],b[i]));
      tmp_carry[i]:=q_and(tmp_carry[i+1],tmp_equ[i]);
      tmp_res[i]:=q_or(tmp_res[i+1],q_and(tmp_carry[i+1],tmp_cmp[i]));
   end;

   res:=tmp_res[0];
   setlength(tmp_res,0); setlength(tmp_carry,0);
   setlength(tmp_cmp,0); setlength(tmp_equ,0);
end;

{n-bit compare for a equ, greater, lower
if a=b then res_equ=1
if a>b then res_greater=1
if a<b then res_lower=1
}
procedure bin_cmp(a,b:tbit_vector; var res_equ,res_greater,res_lower:tbit);
var tmp_res_g,tmp_res_l,tmp_res_e: tbit_vector;
    tmp_greater,tmp_lower,tmp_equ: tbit_vector;
    i,n:integer;
begin
   n:=length(a);
   setlength(tmp_res_g,n+1); setlength(tmp_res_l,n+1); setlength(tmp_res_e,n+1);
   setlength(tmp_greater,n); setlength(tmp_lower,n); setlength(tmp_equ,n);

   tmp_res_g[n]:=zero;
   tmp_res_l[n]:=zero;
   tmp_res_e[n]:=one;
   for i:=n-1 downto 0 do
   begin
      tmp_greater[i]:=q_and(a[i],q_not(b[i]));
      tmp_lower[i]:=q_and(q_not(a[i]),b[i]);
      tmp_equ[i]:=q_xor(q_not(a[i]),b[i]);
      tmp_res_e[i]:=q_and(tmp_res_e[i+1],tmp_equ[i]);
      tmp_res_g[i]:=q_or(tmp_res_g[i+1],q_and(tmp_res_e[i+1],tmp_greater[i]));
      tmp_res_l[i]:=q_or(tmp_res_l[i+1],q_and(tmp_res_e[i+1],tmp_lower[i]));
   end;

   res_greater:=tmp_res_g[0];
   res_lower:=tmp_res_l[0];
   res_equ:=tmp_res_e[0];

   setlength(tmp_res_g,0); setlength(tmp_res_l,0); setlength(tmp_res_e,0);
   setlength(tmp_greater,0); setlength(tmp_lower,0); setlength(tmp_equ,0);
end;

{n-bit divider}
procedure bin_div(a,b:tbit_vector; var q,r:tbit_vector);
var tmp_q,tmp_equal,tmp_greater: tbit_vector;
   tmp_r,tmp_b: tbit_table;
   i,n:integer;
begin
   n:=length(a);
   setlength(tmp_q,n); setlength(tmp_equal,n); setlength(tmp_greater,n);
   setlength(tmp_r,n+1); setlength(tmp_b,n+1);
   for i:=0 to n do
   begin
      setlength(tmp_r[i],2*n-1);
      setlength(tmp_b[i],2*n-1);
   end;

   bin_set_bits(n,2*n-1,zero,tmp_r[0]);
   bin_ins_bits(0,n-1,a,tmp_r[0]);
   for i:=0 to n-1 do
   begin
     bin_is_greater_than(bin_cut_bits(n-i-1,n+n-i-2,tmp_r[i]),b,tmp_greater[n-i-1]);
     bin_is_equal(bin_cut_bits(n-i-1,n+n-i-2,tmp_r[i]),b,tmp_equal[n-i-1]);
     tmp_q[n-i-1]:=q_or(tmp_greater[n-i-1],tmp_equal[n-i-1]);
     bin_set_bits(n+n-i-1,n+n-1,zero,tmp_b[i]);
     bin_set_bits(0,n-i-2,zero,tmp_b[i]);
     if tmp_q[n-i-1]=zero then bin_set_bits(n-i-1,n+n-i-2,zero,tmp_b[i])
                          else bin_ins_bits(n-i-1,n+n-i-2,b,tmp_b[i]);
     bin_sub(tmp_r[i],tmp_b[i],tmp_r[i+1]);
   end;
 
   q:=tmp_q;
   bin_ins_bits(0,n-1,tmp_r[n],r);
   setlength(tmp_q,0); setlength(tmp_equal,0); setlength(tmp_greater,0);
   for i:=0 to n do
   begin
      setlength(tmp_r[i],0);
      setlength(tmp_b[i],0);
   end;
   setlength(tmp_r,0); setlength(tmp_b,0);
end;

end.
