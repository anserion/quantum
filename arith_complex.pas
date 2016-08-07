//Copyright 2015 Andrey S. Ionisyan
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

//=====================================================================
//комплексная арифметика
//=====================================================================
unit arith_complex;

interface
uses math;

const sqrt2=1.414213562;
      sqrt3=1.732050808;
      sqrt5=2.236067977;

type
TComplex=record
   re,im:real;
end;

TComplexVector=array of TComplex;
TComplexMatrix=array of TComplexVector;

TIntegerComplex=record
   re,im:integer;
end;
TIntegerComplexVector=array of TIntegerComplex;
TIntegerComplexMatrix=array of TIntegerComplexVector;

function c_complex(re,im:real):TComplex;
function c_vector(n:integer):TComplexVector;
function c_matrix(n,m:integer):TComplexMatrix;
procedure c_matrix_destroy(var M:TComplexMatrix);
function c_zero:TComplex;
function c_one:TComplex;
function c_i:TComplex;
function c_minus_one:TComplex;
function c_minus_i:TComplex;
function c_pi:TComplex;
function c_pi2:TComplex;
function c_pi4:TComplex;
function c_pi8:TComplex;
function c_sqrt2:TComplex;
function c_sqrt3:TComplex;
function c_sqrt5:TComplex;
function c_root_of_one_CCW(k,n:integer):TComplex;
function c_root_of_one_CW(k,n:integer):TComplex;
function c_dup(value:TComplex):TComplex;
function c_conj(value:TComplex):TComplex;
function c_amp(a:TComplex):real;
function c_phi(a:TComplex):real;
function c_amp2(a:TComplex):real;
function c_amp_cmp(a,b:TComplex):integer;
function c_neg(a:TComplex):TComplex;
function c_inv(a:TComplex):TComplex;
function c_add(a,b:TComplex):TComplex;
function c_sub(a,b:TComplex):TComplex;
function c_mul(a,b:TComplex):TComplex;
function c_div(a,b:TComplex):TComplex;
procedure c_AlgToTrig(alg:TComplex; var amp,phi:real);
function c_TrigToAlg(amp,phi:real):TComplex;
function c_sqr(arg:TComplex):TComplex;
function c_exp_ix(x:real):TComplex;
procedure c_sqrt(arg:TComplex; var res1,res2:TComplex);
function c_exp(arg:TComplex):TComplex;
function c_ln(arg:TComplex; k:integer):TComplex;
function c_power(arg,pow:TComplex; k:integer):TComplex;

procedure c_vector_fill(value:TComplex; var V:TComplexVector);
procedure c_vector_copy(var src,dst:TComplexVector);
procedure c_vectors_swap(var V1,V2:TComplexVector);
procedure c_subvector_to_vector_put(k:integer; var subvector,V:TComplexVector);
procedure c_subvector_from_vector_get(k,n:integer; var subvector,V:TComplexVector);
procedure c_matrix_fill(value:TComplex; var A:TComplexMatrix);
procedure c_matrix_copy(var src,dst:TComplexMatrix);
procedure c_matrix_raw_put(k:integer; var A:TComplexMatrix; var V:TComplexVector);
procedure c_matrix_col_put(k:integer; var A:TComplexMatrix; var V:TComplexVector);
procedure c_matrix_raw_get(k:integer; var A:TComplexMatrix; var V:TComplexVector);
procedure c_matrix_col_get(k:integer; var A:TComplexMatrix; var V:TComplexVector);
procedure c_submatrix_to_matrix_put(raw,col:integer; var submatrix,A:TComplexMatrix);
procedure c_submatrix_from_matrix_get(raw,col,n,m:integer; var submatrix,A:TComplexMatrix);

function c_vector_summ(var a:TComplexVector):TComplex;
function c_vector_prod(var a:TComplexVector):TComplex;
function c_vector_dist2(var a:TComplexVector):TComplex;
function c_vector_mean(var a:TComplexVector):TComplex;
function c_vector_dispersion(var a:TComplexVector):TComplex;
procedure c_vector_diff(var a,res:TComplexVector);
procedure c_func_diff(var x,f,res:TComplexVector);

procedure c_vector_neg(var a,neg_a:TComplexVector);
procedure c_vector_add_vector(var a,b,c:TComplexVector);
procedure c_vector_sub_vector(var a,b,c:TComplexVector);

procedure c_matrix_add_matrix(var a,b,c:TComplexMatrix);
procedure c_matrix_sub_matrix(var a,b,c:TComplexMatrix);

procedure c_vector_add_scalar(lambda:TComplex; var a,res:TComplexVector);
procedure c_vector_mul_scalar(lambda:TComplex; var a,res:TComplexVector);
procedure c_matrix_mul_scalar(lambda:TComplex; var a,res:TComplexMatrix);
function c_vectors_scalar_mul(var a,b:TComplexVector):TComplex;
function c_vectors_convolution(var a,b:TComplexVector):TComplex;

procedure c_matrix_mul_vector(var a:TComplexMatrix; var V,res:TComplexVector);
procedure c_vector_mul_matrix(var v:TComplexVector; var a:TComplexMatrix; var res:TComplexVector);
procedure c_matrix_mul_matrix(var a,b,c:TComplexMatrix);

procedure c_vectorv_kronmul_vectorh(var a,b:TComplexVector; var c:TComplexMatrix);
procedure c_vectorh_kronmul_vectorv(var a,b:TComplexVector; var c:TComplexMatrix);
procedure c_matrix_kronmul_matrix(var a,b,c:TComplexMatrix);

procedure c_matrix_transp(var A,res:TComplexMatrix);
procedure c_marix_hermitian(var A,res:TComplexMatrix);
procedure c_SLAE_zeidel(epsilon:real; var A:TComplexMatrix; var B,X:TComplexVector);
function c_matrix_det(var A:TComplexMatrix):TComplex; //stub
procedure c_matrix_eigen(var A:TComplexMatrix; var eigen:TComplexVector); //stub

function get_bit(n,k:integer):integer;
function get_bits(n,k,nn:integer):integer;
function set_bit(n,k,value:integer):integer;
function insert_bit(n,k,value:integer):integer;
function insert_bits(n,k,value,n_value:integer):integer;
function delete_bit(n,k:integer):integer;
function pow2(n:integer):integer;
function log2(n:integer):integer;
function Power2RoundUp(N:integer):integer; //округление вверх до ближайшей степени двойки

procedure FFT_analys(var FFT_t,FFT_f:TComplexVector); //одномерный БПФ-анализ (по основанию 2)
procedure FFT_syntez(var FFT_f,FFT_t:TComplexVector); //одномерный БПФ-синтез (по основанию 2)

procedure DFT_analys(var DFT_t,DFT_f:TComplexVector); //одномерный спектральный анализ ДПФ
procedure DFT_syntez(t_size:integer; var DFT_f,DFT_t:TComplexVector); //одномерный спектральный синтез ДПФ
procedure DFT_analys_2D(var DFT_t,DFT_f:TComplexMatrix); //двумерный спектральный анализ ДПФ
procedure DFT_syntez_2D(t_width,t_height:integer; var DFT_f,DFT_t:TComplexMatrix); //двумерный спектральный синтез ДПФ

implementation

function c_complex(re,im:real):TComplex;
begin c_complex.re:=re; c_complex.im:=im; end;

function c_vector(n:integer):TComplexVector;
var tmp:TComplexVector; begin setlength(tmp,n); c_vector:=tmp; end;

function c_matrix(n,m:integer):TComplexMatrix;
var i:integer; tmp:TComplexMatrix;
begin
   setlength(tmp,n);
   for i:=0 to n-1 do setlength(tmp[i],m);
   c_matrix:=tmp;
end;

procedure c_matrix_destroy(var M:TComplexMatrix);
var i,n:integer;
begin
   n:=length(M); for i:=0 to n-1 do setlength(M[i],0);
   setlength(M,0);
end;

function c_zero:TComplex; begin c_zero.re:=0; c_zero.im:=0; end;
function c_one:TComplex; begin c_one.re:=1; c_one.im:=0; end;
function c_minus_one:TComplex; begin c_minus_one.re:=-1; c_minus_one.im:=0; end;
function c_i:TComplex; begin c_i.re:=0; c_i.im:=1; end;
function c_minus_i:TComplex; begin c_minus_i.re:=0; c_minus_i.im:=-1; end;
function c_pi:TComplex; begin c_pi.re:=Pi; c_pi.im:=0; end;
function c_pi2:TComplex; begin c_pi2.re:=0.5*Pi; c_pi2.im:=0; end;
function c_pi4:TComplex; begin c_pi4.re:=0.25*Pi; c_pi4.im:=0; end;
function c_pi8:TComplex; begin c_pi8.re:=0.125*Pi; c_pi8.im:=0; end;
function c_sqrt2:TComplex; begin c_sqrt2.re:=sqrt2; c_sqrt2.im:=0; end;
function c_sqrt3:TComplex; begin c_sqrt3.re:=sqrt3; c_sqrt3.im:=0; end;
function c_sqrt5:TComplex; begin c_sqrt5.re:=sqrt5; c_sqrt5.im:=0; end;

function c_root_of_one_CCW(k,n:integer):TComplex;
var phi:real;
begin
     phi:=2*PI*k/n;
     c_root_of_one_CCW.re:=cos(phi);
     c_root_of_one_CCW.im:=sin(phi);
end;

function c_root_of_one_CW(k,n:integer):TComplex;
var phi:real;
begin
     phi:=-2*PI*k/n;
     c_root_of_one_CW.re:=cos(phi);
     c_root_of_one_CW.im:=sin(phi);
end;

function c_dup(value:TComplex):TComplex;
begin c_dup.re:=value.re; c_dup.im:=value.im; end;

function c_conj(value:TComplex):TComplex;
begin c_conj.re:=value.re; c_conj.im:=-value.im; end;

function c_amp2(a:TComplex):real;
begin c_amp2:=sqr(a.re)+sqr(a.im); end;

function c_amp(a:TComplex):real;
begin c_amp:=sqrt(sqr(a.re)+sqr(a.im)); end;

function c_phi(a:TComplex):real;
var res,amp:real;
begin
     amp:=c_amp(a);
     if amp=0 then res:=0 else res:=arccos(a.re/amp);
     c_phi:=res;
end;

function c_amp_cmp(a,b:TComplex):integer;
var amp2_a,amp2_b:real; res:integer;
begin
     res:=0;
     amp2_a:=sqr(a.re)+sqr(a.im);
     amp2_b:=sqr(b.re)+sqr(b.im);
     if amp2_a>amp2_b then res:=1;
     if amp2_a=amp2_b then res:=0;
     if amp2_a<amp2_b then res:=-1;
     c_amp_cmp:=res;
end;

function c_neg(a:TComplex):TComplex;
begin c_neg.re:=-a.re; c_neg.im:=-a.im; end;

function c_inv(a:TComplex):TComplex;
var amp,inv_phi:real; res:TComplex;
begin
   amp:=c_amp(a);
   if amp=0 then res:=c_zero
      else
      begin
         inv_phi:=-arccos(a.re/amp);
         res:=c_TrigToAlg(1.0/amp,inv_phi);
      end;
   c_inv:=res;
end;

function c_add(a,b:TComplex):TComplex;
begin c_add.re:=a.re+b.re; c_add.im:=a.im+b.im; end;

function c_sub(a,b:TComplex):TComplex;
begin c_sub.re:=a.re-b.re; c_sub.im:=a.im-b.im; end;

function c_mul(a,b:TComplex):TComplex;
begin c_mul.re:=a.re*b.re-a.im*b.im; c_mul.im:=a.re*b.im+a.im*b.re; end;

function c_div(a,b:TComplex):TComplex;
begin
     c_div.re:=(a.re*b.re+a.im*b.im)/(b.re*b.re+b.im*b.im);
     c_div.im:=(a.im*b.re-a.re*b.im)/(b.re*b.re+b.im*b.im);
end;

procedure c_AlgToTrig(alg:TComplex; var amp,phi:real);
begin
     amp:=c_amp(alg);
     phi:=c_phi(alg);
end;

function c_TrigToAlg(amp,phi:real):TComplex;
begin c_TrigToAlg.re:=amp*cos(phi); c_TrigToAlg.im:=amp*sin(phi); end;

function c_sqr(arg:TComplex):TComplex;
begin c_sqr.re:=arg.re*arg.re-arg.im*arg.im; c_sqr.im:=2*arg.re*arg.im; end;

function c_exp_ix(x:real):TComplex;
begin c_exp_ix.re:=cos(x); c_exp_ix.im:=sin(x); end;

procedure c_sqrt(arg:TComplex; var res1,res2:TComplex);
var amp,phi:real;
begin
     amp:=sqrt(c_amp(arg));
     phi:=c_phi(arg);
     res1.re:=amp*cos(phi/2); res1.im:=amp*sin(phi/2);
     res2.re:=amp*cos(phi/2+PI); res2.im:=amp*sin(phi/2+PI);
end;

function c_exp(arg:TComplex):TComplex;
var exp_x:real;
begin
     exp_x:=exp(arg.re);
     c_exp.re:=exp_x*cos(arg.im);
     c_exp.im:=exp_x*sin(arg.im);
end;

function c_ln(arg:TComplex; k:integer):TComplex;
var amp,phi:real;
begin
     amp:=c_amp(arg);
     phi:=c_phi(arg);
     if amp>0 then amp:=ln(amp);
     c_ln.re:=amp;
     c_ln.im:=phi+2*PI*k;
end;

function c_power(arg,pow:TComplex; k:integer):TComplex;
begin
     c_power:=c_exp(c_mul(pow,c_ln(arg,k)));
end;

//-------------------------------------------------------------
procedure c_vector_fill(value:TComplex; var V:TComplexVector);
var i,n:integer;
begin n:=length(V); for i:=0 to n-1 do V[i]:=value; end;

procedure c_vector_copy(var src,dst:TComplexVector);
var i,n:integer;
begin n:=length(src); for i:=0 to n-1 do dst[i]:=src[i]; end;

procedure c_vectors_swap(var V1,V2:TComplexVector);
var i,n:integer; tmp:TComplex;
begin
   n:=length(V1);
   for i:=0 to n-1 do begin tmp:=V1[i]; V1[i]:=V2[i]; V2[i]:=tmp; end;
end;

procedure c_matrix_fill(value:TComplex; var A:TComplexMatrix);
var i,n:integer;
begin
   n:=length(A);
   for i:=0 to n-1 do c_vector_fill(value,A[i]);
end;

procedure c_matrix_copy(var src,dst:TComplexMatrix);
var i,n:integer;
begin n:=length(src); for i:=0 to n-1 do c_vector_copy(src[i],dst[i]); end;

procedure c_subvector_to_vector_put(k:integer; var subvector,V:TComplexVector);
var i,sn,n:integer;
begin
   sn:=length(subvector); n:=length(V);
   if k+sn>n then sn:=n-k;
   for i:=0 to sn-1 do V[i+k]:=subvector[i];
end;

procedure c_subvector_from_vector_get(k,n:integer; var subvector,V:TComplexVector);
var i,nn:integer;
begin
   nn:=length(V);
   if k+n>nn then n:=nn-n;
   for i:=0 to n-1 do subvector[i]:=V[k+i];
end;

procedure c_matrix_raw_put(k:integer; var A:TComplexMatrix; var V:TComplexVector);
var i,n:integer;
begin n:=length(V); for i:=0 to n-1 do A[k,i]:=V[i]; end;

procedure c_matrix_col_put(k:integer; var A:TComplexMatrix; var V:TComplexVector);
var i,m:integer;
begin m:=length(V); for i:=0 to m-1 do A[i,k]:=V[i]; end;

procedure c_matrix_raw_get(k:integer; var A:TComplexMatrix; var V:TComplexVector);
var i,n:integer;
begin n:=length(A[k]); for i:=0 to n-1 do V[i]:=A[k,i]; end;

procedure c_matrix_col_get(k:integer; var A:TComplexMatrix; var V:TComplexVector);
var i,m:integer;
begin m:=length(A); for i:=0 to m-1 do V[i]:=A[i,k]; end;

procedure c_submatrix_to_matrix_put(raw,col:integer; var submatrix,A:TComplexMatrix);
var i,j,n,m:integer;
begin
   n:=length(submatrix);  m:=length(submatrix[0]);
   for i:=0 to n-1 do
      for j:=0 to m-1 do
         A[raw+i,col+j]:=submatrix[i,j];
end;

procedure c_submatrix_from_matrix_get(raw,col,n,m:integer; var submatrix,A:TComplexMatrix);
var i,j:integer;
begin
   for i:=0 to n-1 do
      for j:=0 to m-1 do
         submatrix[i,j]:=A[raw+i,col+j];
end;

procedure c_matrix_transp(var A,res:TComplexMatrix);
var i,n,m:integer; tmp:TComplexVector;
begin
   n:=length(A); m:=length(A[0]); setlength(tmp,m);
   for i:=0 to n-1 do
   begin
      c_matrix_raw_get(i,A,tmp);
      c_matrix_col_put(i,res,tmp);
   end;
end;

procedure c_marix_hermitian(var A,res:TComplexMatrix);
var i,j,n,m:integer;
begin
   c_matrix_transp(A,res);
   n:=length(res); m:=length(res[0]);
   for i:=0 to n-1 do
   for j:=0 to m-1 do
      res[i,j].im:=-res[i,j].im;
end;
//-------------------------------------------------------------

function c_vector_summ(var a:TComplexVector):TComplex;
var tmp:TComplex; i,n:integer;
begin
   n:=length(a); tmp:=c_zero;
   for i:=0 to n-1 do tmp:=c_add(a[i],tmp);
   c_vector_summ:=tmp;
end;

function c_vector_prod(var a:TComplexVector):TComplex;
var tmp:TComplex; i,n:integer;
begin
   n:=length(a); tmp:=c_one;
   for i:=0 to n-1 do tmp:=c_mul(a[i],tmp);
   c_vector_prod:=tmp;
end;

function c_vector_dist2(var a:TComplexVector):TComplex;
var tmp:TComplex; i,n:integer;
begin
   n:=length(a); tmp:=c_zero;
   for i:=0 to n-1 do tmp:=c_add(c_mul(a[i],a[i]),tmp);
   c_vector_dist2:=tmp;
end;

function c_vector_mean(var a:TComplexVector):TComplex;
begin c_vector_mean:=c_div(c_vector_summ(a),c_complex(length(a),0)); end;

function c_vector_dispersion(var a:TComplexVector):TComplex;
var i,n:integer; average,tmp:TComplex;
begin
   n:=length(a);
   average:=c_vector_mean(a);
   tmp:=c_zero;
   for i:=0 to n-1 do tmp:=c_add(tmp,c_sqr(c_sub(a[i],average)));
   c_vector_dispersion:=c_div(tmp,c_complex(n,0));
end;

procedure c_vector_diff(var a,res:TComplexVector);
var i,n:integer; c_two:TComplex;
begin
   n:=length(a); c_two:=c_complex(2,0);
   res[0]:=c_sub(a[1],a[0]); res[n-1]:=c_sub(a[n-1],a[n-2]);
   for i:=1 to n-2 do
      res[i]:=c_div(c_sub(a[i+1],a[i-1]),c_two);
end;

procedure c_func_diff(var x,f,res:TComplexVector);
var i,n:integer;
begin
   n:=length(x);
   res[0]:=c_div(c_sub(f[1],f[0]),c_sub(x[1],x[0]));
   res[n-1]:=c_div(c_sub(f[n-1],f[n-2]),c_sub(x[n-1],x[n-2]));
   for i:=1 to n-2 do
      res[i]:=c_div(c_sub(f[i+1],f[i-1]),c_sub(x[i+1],x[i-1]));
end;

procedure c_vector_neg(var a,neg_a:TComplexVector);
var i,n:integer;
begin n:=length(a); for i:=0 to n-1 do neg_a[i]:=c_neg(a[i]); end;

procedure c_vector_add_vector(var a,b,c:TComplexVector);
var i,n:integer;
begin n:=length(a); for i:=0 to n-1 do c[i]:=c_add(a[i],b[i]); end;

procedure c_vector_sub_vector(var a,b,c:TComplexVector);
var i,n:integer;
begin n:=length(a); for i:=0 to n-1 do c[i]:=c_sub(a[i],b[i]); end;

function c_vectors_scalar_mul(var a,b:TComplexVector):TComplex;
var tmp:TComplex; i,n:integer;
begin
   n:=length(a); tmp:=c_zero;
   for i:=0 to n-1 do tmp:=c_add(c_mul(a[i],b[i]),tmp);
   c_vectors_scalar_mul:=tmp;
end;

function c_vectors_convolution(var a,b:TComplexVector):TComplex;
var tmp:TComplex; i,n:integer;
begin
   n:=length(a); tmp:=c_zero;
   for i:=0 to n-1 do tmp:=c_add(c_mul(a[i],b[n-i-1]),tmp);
   c_vectors_convolution:=tmp;
end;

procedure c_vector_add_scalar(lambda:TComplex; var a,res:TComplexVector);
var i,n:integer;
begin n:=length(a); for i:=0 to n-1 do res[i]:=c_add(lambda,a[i]); end;

procedure c_vector_mul_scalar(lambda:TComplex; var a,res:TComplexVector);
var i,n:integer;
begin n:=length(a); for i:=0 to n-1 do res[i]:=c_mul(lambda,a[i]); end;

procedure c_matrix_mul_scalar(lambda:TComplex; var a,res:TComplexMatrix);
var i,j,n,m:integer;
begin
   n:=length(a); m:=length(a[0]);
   for i:=0 to n-1 do
      for j:=0 to m-1 do
         res[i,j]:=c_mul(lambda,a[i,j]);
end;

procedure c_matrix_add_matrix(var a,b,c:TComplexMatrix);
var i,j,n,m:integer;
begin
   n:=length(a); m:=length(a[0]);
   for i:=0 to n-1 do
      for j:=0 to m-1 do
         c[i,j]:=c_add(a[i,j],b[i,j]);
end;

procedure c_matrix_sub_matrix(var a,b,c:TComplexMatrix);
var i,j,n,m:integer;
begin
   n:=length(a); m:=length(a[0]);
   for i:=0 to n-1 do
      for j:=0 to m-1 do
         c[i,j]:=c_sub(a[i,j],b[i,j]);
end;

procedure c_matrix_mul_vector(var A:TComplexMatrix; var V,res:TComplexVector);
var i,n:integer;
begin
   n:=length(A);
   for i:=0 to n-1 do res[i]:=c_vectors_scalar_mul(A[i],V);
end;

procedure c_vector_mul_matrix(var V:TComplexVector; var A:TComplexMatrix; var res:TComplexVector);
var i,n,m:integer; tmp:TComplexVector;
begin
   m:=length(V); n:=length(A); setlength(tmp,n);
   for i:=0 to m-1 do
   begin
      c_matrix_col_get(i,A,tmp);
      res[i]:=c_vectors_scalar_mul(V,tmp);
   end;
end;

procedure c_matrix_mul_matrix(var A,B,C:TComplexMatrix);
var i,n:integer;
begin
   n:=length(A);
   for i:=0 to n-1 do c_vector_mul_matrix(A[i],B,C[i]);
end;

procedure c_vectorv_kronmul_vectorh(var a,b:TComplexVector; var c:TComplexMatrix);
var i,j,n,m:integer;
begin
   n:=length(a); m:=length(b);
   for i:=0 to n-1 do
      for j:=0 to m-1 do
         c[i,j]:=c_mul(a[i],b[j]);
end;

procedure c_vectorh_kronmul_vectorv(var a,b:TComplexVector; var c:TComplexMatrix);
var i,j,n,m:integer;
begin
   n:=length(b); m:=length(a);
   for i:=0 to n-1 do
      for j:=0 to m-1 do
         c[i,j]:=c_mul(a[j],b[i]);
end;

procedure c_matrix_kronmul_matrix(var a,b,c:TComplexMatrix);
var ia,ja,ib,jb,na,ma,nb,mb:integer;
begin
   na:=length(a); ma:=length(a[0]);
   nb:=length(b); mb:=length(b[0]);
   for ia:=0 to na-1 do
   for ja:=0 to ma-1 do
      for ib:=0 to nb-1 do
      for jb:=0 to mb-1 do
         c[ia*nb+ib,ja*mb+jb]:=c_mul(a[ia,ja],b[ib,jb]);
end;

procedure c_SLAE_zeidel(epsilon:real; var A:TComplexMatrix; var B,X:TComplexVector);
var i,n:integer;
    s:TComplex; AT,ATmA:TComplexMatrix;
    tmp,deltaX,ATmB:TComplexVector;
begin
   n:=length(a);
   tmp:=c_vector(n); deltaX:=c_vector(n); ATmB:=c_vector(n);
   AT:=c_matrix(n,n); ATmA:=c_matrix(n,n);
   
   c_matrix_transp(A,AT);
   c_matrix_mul_matrix(AT,A,ATmA);
   c_matrix_mul_vector(AT,B,ATmB);
   
   repeat
   c_vector_copy(X,tmp);
   for i:=0 to n-1 do
   begin
      s:=c_sub(c_vectors_scalar_mul(ATmA[i],X),c_mul(ATmA[i,i],X[i]));
      X[i]:=c_div(c_sub(ATmB[i],s),ATmA[i,i]);
   end;
   c_vector_sub_vector(x,tmp,deltaX);
   until sqrt(c_amp(c_vector_dist2(deltaX)))<epsilon;

   setlength(tmp,0); setlength(deltaX,0); setlength(ATmB,0);
   c_matrix_destroy(AT); c_matrix_destroy(ATmA);
end;

function c_matrix_det(var A:TComplexMatrix):TComplex;
begin
c_matrix_det:=c_zero;
end;

procedure c_matrix_eigen(var A:TComplexMatrix; var eigen:TComplexVector);
var i,n:integer;
begin
   n:=length(A);
   for i:=0 to n-1 do eigen[i]:=c_zero;
end;

//================================================================
//быстрое преобразование Фурье с прореживанием по времени (спектральный анализ)
procedure FFT_analys(var FFT_t,FFT_f:TComplexVector);
var fft_tmp,W:TComplexVector;
    i,k,bb,dst_digit,tmp,N,NN,NN2,merge_step,sections,section_base:integer;
begin
   N:=length(FFT_t);
   //bb - число бит от размера входного вектора
   bb:=1; tmp:=N-1;
   while tmp>1 do begin tmp:=tmp>>1; bb:=bb+1; end;
   //двоично-инверсная перестановка
   for i:=0 to N-1 do
   begin
     tmp:=i; dst_digit:=0;
     for k:=1 to bb do
     begin
       dst_digit:=dst_digit<<1+(tmp and 1);
       tmp:=tmp>>1;
     end;
      FFT_f[dst_digit]:=FFT_t[i];
   end;
   //сборка спектра
   SetLength(fft_tmp,N);
   SetLength(W,N);
   NN2:=1;
   for merge_step:=1 to bb do
   begin
     NN:=NN2*2; //число элементов в текущем разбиении 2,4,8,16,...,N
     //формируем массив поворотных коэффициентов для текущего шага сборки коэффициентов
     for k:=0 to NN2-1 do W[k]:=c_root_of_one_CW(k,NN);
     sections:=N div NN; //число двоичных разбиений исходной последовательности на текущем шаге сборки
     //анализируем каждое разбиение
     for i:=0 to sections-1 do
     begin
       section_base:=i*NN;
       //применяем алгоритм "бабочка" для текущего разбиения
       for k:=0 to NN2-1 do
       begin
         fft_tmp[section_base+k]:=c_add(FFT_f[section_base+k],c_mul(FFT_f[section_base+k+NN2],W[k]));
         fft_tmp[section_base+k+NN2]:=c_sub(FFT_f[section_base+k],c_mul(FFT_f[section_base+k+NN2],W[k]));
       end;
     end;
     //подготавливаемся к следующему укрупнению (сборке)
     for k:=0 to N-1 do FFT_f[k]:=fft_tmp[k];
     NN2:=NN;
   end;

   //"уменьшаем" коэффициенты после анализа
   //for k:=0 to N-1 do
   //begin
   //  FFT_f[k].re:=FFT_f[k].re/N;
   //  FFT_f[k].im:=FFT_f[k].im/N;
   //end;
   //высвобождаем память
   SetLength(fft_tmp,0);
   SetLength(W,0);
end;

//быстрое преобразование Фурье с прореживанием по времени (спектральный синтез)
procedure FFT_syntez(var FFT_f,FFT_t:TComplexVector);
var fft_tmp:TComplexVector;
    k,N:integer;
begin
   N:=length(FFT_f);
   SetLength(fft_tmp,N);
   //выполняем комплексное сопряжение и масштабирование входного спектра
   for k:=0 to N-1 do
   begin
     FFT_tmp[k].re:=FFT_f[k].re/N;
     FFT_tmp[k].im:=-FFT_f[k].im/N;
   end;
   //проводим прямое преобразование Фурье над комплексно-сопряженным спектром
   FFT_analys(FFT_tmp,FFT_t);
   //выполняем комплексное сопряжение и масштабирование результата
   for k:=0 to N-1 do
   begin
     FFT_t[k].re:=FFT_t[k].re;//*N;
     FFT_t[k].im:=-FFT_t[k].im;//*N;
   end;
   //высвобождаем промежуточную память
   SetLength(fft_tmp,0);
end;

//битовые операции
function get_bit(n,k:integer):integer;
begin get_bit:=(n shr k) and 1; end;

function get_bits(n,k,nn:integer):integer;
var mask:integer;
begin mask:=(1 shl nn)-1; get_bits:=(n shr k) and mask; end;

function set_bit(n,k,value:integer):integer;
begin set_bit:=(n and (not (1 shl k))) or (value shl k); end;

function insert_bit(n,k,value:integer):integer;
var mask:integer;
begin
   mask:=(1 shl k)-1;
   insert_bit:=((((n shr k)shl 1)or value) shl k) or (n and mask);
end;

function insert_bits(n,k,value,n_value:integer):integer;
var mask:integer;
begin
   mask:=(1 shl k)-1;
   insert_bits:=((((n shr k)shl n_value)or value) shl k) or (n and mask);
end;

function delete_bit(n,k:integer):integer;
var mask:integer;
begin
   mask:=(1 shl k)-1;
   delete_bit:=((n shr (k+1))shl k) or (n and mask);
end;

//функция вычисляет значение 2^n
function pow2(n:integer):integer; begin pow2:=1 shl n; end;

//функция вычисляет ближайшее меньшее целое значение log_2(n)
function log2(n:integer):integer;
var res:integer;
begin
   res:=0;
   while n>1 do begin n:=n>>1; res:=res+1; end;
   log2:=res;
end;

//функция выполняет округление числа N вверх до ближайшей степени двойки
function Power2RoundUp(N:integer):integer;
var NN:integer;
begin
  NN:=(1<<log2(N)); if N>NN then NN:=NN<<1;
  Power2RoundUp:=NN;
end;

//преобразование Фурье (спектральный анализ)
//число отсчетов входного сигнала - любое натуральное число
//размер выходного спектра будет равен степени двойки (специфика данного алгоритма)
//память для DFT_f должна быть выделена до вызова подпрограммы
procedure DFT_analys(var DFT_t,DFT_f:TComplexVector);
var fft_tmp:TComplexVector;
    k,N,NN:integer;
begin
  N:=length(DFT_t);
  NN:=Power2RoundUp(N);
  SetLength(fft_tmp,NN);
  for k:=0 to N-1 do fft_tmp[k]:=DFT_t[k];
  for k:=N to NN-1 do begin fft_tmp[k].re:=0; fft_tmp[k].im:=0; end;
  FFT_analys(fft_tmp,DFT_f);
  SetLength(fft_tmp,0);
end;

//преобразование Фурье (спектральный синтез)
//размер входного спектра должен быть равен степени двойки (специфика данного алгоритма)
//число отсчетов выходного сигнала - натуральное число, не превышающее размера спектра
//память для DFT_t должна быть выделена до вызова подпрограммы
procedure DFT_syntez(t_size:integer; var DFT_f,DFT_t:TComplexVector);
var fft_tmp:TComplexVector; k,f_size:integer;
begin
  f_size:=length(DFT_f);
  SetLength(fft_tmp,f_size);
  FFT_syntez(DFT_f,fft_tmp);
  if t_size>f_size then t_size:=f_size;
  for k:=0 to t_size-1 do DFT_t[k]:=fft_tmp[k];
  SetLength(fft_tmp,0);
end;

//быстрое двумерное преобразование Фурье (спектральный анализ)
//размеры входного изображения - любые (не обязательно степень двойки)
//размер матрицы выходного спектра будет равен степени двойки
//по числу строк и по числу столбцов (специфика данного алгоритма)
//память для DFT_f должна быть выделена до вызова подпрограммы
procedure DFT_analys_2D(var DFT_t,DFT_f:TComplexMatrix);
var dft_tmp_t,dft_tmp_f:TComplexVector;
    x,y,width,height,p2_width,p2_height:integer;
begin
  height:=length(DFT_t);
  width:=length(DFT_t[0]);
  //округляем размеры вверх до ближайшей степени двойки
  p2_height:=Power2RoundUp(height);
  p2_width:=Power2RoundUp(width);
  //проводим БПФ по строчкам
  for y:=0 to height-1 do DFT_analys(DFT_t[y],DFT_f[y]);
  //выделяем память для хранения содержимого столбцов
  SetLength(dft_tmp_t,height);
  SetLength(dft_tmp_f,p2_height);
  //проводим БПФ по столбцам
  for x:=0 to p2_width-1 do
  begin
    for y:=0 to height-1 do dft_tmp_t[y]:=DFT_f[y,x];
    DFT_analys(dft_tmp_t,dft_tmp_f);
    for y:=0 to p2_height-1 do DFT_f[y,x]:=dft_tmp_f[y];
  end;
  //высвобождаем память
  SetLength(dft_tmp_t,0);
  SetLength(dft_tmp_f,0);
end;

//быстрое двумерное преобразование Фурье (спектральный синтез)
//размер матрицы входного спектра будет равен степени двойки
//по числу строк и по числу столбцов (специфика данного алгоритма)
//размеры выходного изображения - любые (не обязательно степень двойки),
//не превышающие размер матрицы спектра
//память для DFT_t должна быть выделена до вызова подпрограммы
procedure DFT_syntez_2D(t_width,t_height:integer;var DFT_f,DFT_t:TComplexMatrix);
var dft_tmp_t,dft_tmp_f:TComplexMatrix;
    x,y,p2_width,p2_height:integer;
begin
  p2_height:=length(DFT_f);
  p2_width:=length(DFT_f[0]);
  SetLength(dft_tmp_f,p2_height,p2_width);
  SetLength(dft_tmp_t,p2_height,p2_width);
  //комплексное сопряжение и масштабирование входного спектра
  for y:=0 to p2_height-1 do
  for x:=0 to p2_width-1 do
  begin
    dft_tmp_f[y,x].re:=DFT_f[y,x].re/(p2_width*p2_height);
    dft_tmp_f[y,x].im:=-DFT_f[y,x].im/(p2_width*p2_height);
  end;
  //прямое ДПФ
  DFT_analys_2D(dft_tmp_f,dft_tmp_t);
  //комплексное сопряжение и масштабирование выходного сигнала
  for y:=0 to p2_height-1 do
  for x:=0 to p2_width-1 do
  begin
    dft_tmp_t[y,x].re:=dft_tmp_t[y,x].re;//*p2_width*p2_height;
    dft_tmp_t[y,x].im:=-dft_tmp_t[y,x].im;//*p2_width*p2_height;
  end;
  //усечение результата
  if t_height>p2_height then t_height:=p2_height;
  if t_width>p2_width then t_width:=p2_width;
  for y:=0 to t_height-1 do
  for x:=0 to t_width-1 do
    DFT_t[y,x]:=dft_tmp_t[y,x];
  //высвобождение памяти
  SetLength(dft_tmp_t,0,0);
  SetLength(dft_tmp_f,0,0);
end;

//======================================================================
//преобразование Фурье (спектральный анализ)
//медленный алгоритм со степенью сложности O(N*N)
//память для DFT_t и DFT_f должна быть выделена до вызова подпрограммы
procedure DFT_analys_slow(var DFT_t,DFT_f:TComplexVector);
var k,j,N:integer;
begin
  N:=length(DFT_t);
  for k:=0 to N-1 do
  begin
     DFT_f[k]:=c_zero;
     for j:=0 to N-1 do
        DFT_f[k]:=c_add(DFT_f[k],c_mul(DFT_t[j],c_root_of_one_CW(k*j,N)));
     DFT_f[k].re:=DFT_f[k].re/N;
     DFT_f[k].im:=DFT_f[k].im/N;
  end;
end;

//преобразование Фурье (спектральный синтез)
//медленный алгоритм со степенью сложности O(N*N)
//память для DFT_t и DFT_f должна быть выделена до вызова подпрограммы
procedure DFT_syntez_slow(var DFT_f,DFT_t:TComplexVector);
var k,j,N:integer;
begin
  N:=length(DFT_f);
  for j:=0 to N-1 do
  begin
    DFT_t[j]:=c_zero;
    for k:=0 to N-1 do
      DFT_t[j]:=c_add(DFT_t[j],c_mul(DFT_f[k],c_root_of_one_CCW(k*j,N)));
  end;
end;

//двумерное преобразование Фурье (спектральный анализ) - медленный способ
procedure DFT_analys_2D_slow(var DFT_t,DFT_f:TComplexMatrix);
var k1,k2,j1,j2,img_height,img_width:integer;
begin
  img_height:=length(DFT_t);
  if img_height>0 then
  begin
    img_width:=length(DFT_t[0]);
    for k1:=0 to img_height-1 do
    for k2:=0 to img_width-1 do
    begin
      DFT_f[k1,k2]:=c_zero;
      for j1:=0 to img_height-1 do
      for j2:=0 to img_width-1 do
        DFT_f[k1,k2]:=c_add(DFT_f[k1,k2],
                            c_mul(DFT_t[j1,j2],
                              c_mul(c_root_of_one_CW(k1*j1,img_height),
                                c_root_of_one_CW(k2*j2,img_width)))
                            );
      DFT_f[k1,k2].re:=DFT_f[k1,k2].re/(img_width*img_height);
      DFT_f[k1,k2].im:=DFT_f[k1,k2].im/(img_width*img_height);
    end;
  end;
end;

//двумерное преобразование Фурье (спектральный синтез) - медленный способ
procedure DFT_syntez_2D_slow(var DFT_f,DFT_t:TComplexMatrix);
var k1,k2,j1,j2,img_height,img_width:integer;
begin
  img_height:=length(DFT_f);
  if img_height>0 then
  begin
    img_width:=length(DFT_f[0]);
    for j1:=0 to img_height-1 do
    for j2:=0 to img_width-1 do
    begin
      DFT_t[j1,j2]:=c_zero;
      for k1:=0 to img_height-1 do
      for k2:=0 to img_width-1 do
        DFT_t[j1,j2]:=c_add(DFT_t[j1,j2],
                            c_mul(DFT_f[k1,k2],
                              c_mul(c_root_of_one_CCW(k1*j1,img_height),
                                c_root_of_one_CCW(k2*j2,img_width)))
                            );
    end;
  end;
end;
//================================================================

end.
