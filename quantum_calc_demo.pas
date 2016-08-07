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

program quantum_calc_demo;
uses arith_complex, q_defs, qgates_complex, qregister, qbinary_gates,qbinary_lev2, qbinary_arith;

var clk_num,sim_time,i,n:integer;
    GCLK:tbit;
    a,b,c,d:tbit_vector;
    a_plus_b,apb_pow2,apb_pow3,b7,apb_pow3_minus_b7,
    apb_pow3_minus_b7_plus_a,seven:tbit_vector;
    
//    j:integer;
//    SuperGATE:TComplexMatrix;
//    q_reg,q1_reg:tqregister;
//    b_reg,b1_reg:tbit_vector;
begin
n:=8;
setlength(a,n); setlength(b,n); setlength(c,n+1); setlength(d,n+1);
//-----------------------------------------
{a="00000011"=3}
a[7]:=zero; a[6]:=zero; a[5]:=zero; a[4]:=zero; a[3]:=zero; a[2]:=zero; a[1]:=one; a[0]:=one;
{b="00000010"=2}
b[7]:=zero; b[6]:=zero; b[5]:=zero; b[4]:=zero; b[3]:=zero; b[2]:=zero; b[1]:=one; b[0]:=zero;
//-----------------------------------------
GCLK:=zero;  clk_num:=0; sim_time:=2;
writeln('--------------------------------------');
writeln('LR3_v000_Ionisyan:');
writeln('c=((a+b)^3-7*b+a) div b');
writeln('d=((a+b)^3-7*b+a) mod b');
writeln('--------------------------------------');
setlength(a_plus_b,n);
setlength(apb_pow2,n);
setlength(apb_pow3,n);
setlength(b7,n);
setlength(apb_pow3_minus_b7,n);
setlength(apb_pow3_minus_b7_plus_a,n);
setlength(seven,n);
seven[0]:=one; seven[1]:=one; seven[2]:=one;
for i:=3 to n-1 do seven[i]:=zero;
while clk_num<sim_time do
begin
//-----------------------------------------
//test formula:
// c = ((a+b)^3 - 7*b + a) div b,
// d = ((a+b)^3 - 7*b + a) mod b
//-----------------------------------------
//1) a_plus_b=a+b
bin_add(a,b,a_plus_b);
//2) apb_pow2=a_plus_b*a_plus_b
bin_mul(a_plus_b,a_plus_b,apb_pow2);
//3) apb_pow3=apb_pow2*a_plus_b
bin_mul(apb_pow2,a_plus_b,apb_pow3);
//4) b7=b*7
bin_mul(b,seven,b7);
//5) apb_pow3_minus_b7=apb_pow3-b7
bin_sub(apb_pow3,b7,apb_pow3_minus_b7);
//6) apb_pow3_minus_b7_plus_a=apb_pow3_minus_b7+a
bin_add(apb_pow3_minus_b7,a,apb_pow3_minus_b7_plus_a);
//7) c=apb_pow3_minus_b7_plus_a div b; d=apb_pow3_minus_b7_plus_a mod b
bin_div(apb_pow3_minus_b7_plus_a,b,c,d);
//-----------------------------------------
writeln('clk_num=',clk_num,' GCLK=',GCLK); 
write('   '); for i:=n-1 downto 0 do write(' ',i:3,' '); writeln;
write('a=('); for i:=n-1 downto 0 do write(' ',a[i]:4); writeln(')');
write('b=('); for i:=n-1 downto 0 do write(' ',b[i]:4); writeln(')');
write('c=('); for i:=n-1 downto 0 do write(' ',c[i]:4); writeln(')');
write('d=('); for i:=n-1 downto 0 do write(' ',d[i]:4); writeln(')');
writeln;
{--------------------------------------------------------------------}
GCLK:=q_not(GCLK); clk_num:=clk_num+1;
end;

{
superGate:=qregister_calc_SWAP_gate(0,2,3);
n:=length(superGate);
for i:=0 to n-1 do
begin
   for j:=0 to n-1 do write(superGate[i,j].re:2:1,'+',superGate[i,j].im:2:1,'i ');
   writeln;
end;
writeln;

q_reg:=qregister_create(3);
setlength(b_reg,3);

b_reg[0]:=zero; b_reg[1]:=one; b_reg[2]:=one;
qregister_set_tbits(q_reg,b_reg);
for i:=0 to length(b_reg)-1 do b_reg[i]:=zero;
qregister_get_tbits(q_reg,b_reg);
for i:=0 to 2 do write(b_reg[i],' '); writeln;

qregister_apply_gate(q_reg,superGate);

for i:=0 to length(b_reg)-1 do b_reg[i]:=zero;
qregister_get_tbits(q_reg,b_reg);
for i:=0 to 2 do write(b_reg[i],' '); writeln;
c_matrix_destroy(superGate);
}
{
q_reg:=qregister_create(5); setlength(b_reg,5);
b_reg[0]:=zero; b_reg[1]:=zero; b_reg[2]:=one; b_reg[3]:=zero; b_reg[4]:=one;
qregister_set_tbits(q_reg,b_reg);
for i:=0 to length(b_reg)-1 do b_reg[i]:=zero;
qregister_get_tbits(q_reg,b_reg);
for i:=0 to length(b_reg)-1 do write(b_reg[i],' '); writeln;

q1_reg:=qregister_create(5); setlength(b1_reg,5);
qregister_erase_qbits(3,0,q_reg,q1_reg);
qregister_get_tbits(q1_reg,b1_reg);

for i:=0 to length(b1_reg)-1 do write(b1_reg[i],' '); writeln;
}
//writeln;

end.
