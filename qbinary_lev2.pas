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
second level binary logic:
multiplexers, buffers, coders. decoders, flip-flops, registers, RAM
=====================================================================}

unit qbinary_lev2;
interface
uses q_defs,qbinary_gates;

{multiplexer's}
function mux_2x1(x0,x1,a0:tbit):tbit;
function mux_4x1(x0,x1,x2,x3,a0,a1:tbit):tbit;
function mux_8x1(x0,x1,x2,x3,x4,x5,x6,x7,a0,a1,a2:tbit):tbit;

{buffers}
procedure BUF(x,en:tbit; var y:tbit);
procedure IBUF(x,en:tbit; var y:tbit);

{encoder's}
procedure CD_2x1(x0,x1:tbit; var y0:tbit);
procedure CD_4x2(x0,x1,x2,x3:tbit; var y0,y1:tbit);
procedure CD_8x3(x0,x1,x2,x3,x4,x5,x6,x7:tbit; var y0,y1,y2:tbit);

{decoder's}
procedure DC_1x2(x0:tbit; var y0,y1:tbit);
procedure DC_2x4(x0,x1:tbit; var y0,y1,y2,y3:tbit);
procedure DC_3x8(x0,x1,x2:tbit; var y0,y1,y2,y3,y4,y5,y6,y7:tbit);

{flip-flop's}
procedure latch_RS(R,S:tbit; var Q,NQ:tbit);
procedure latch_RSC(R,S,C:tbit; var Q,NQ:tbit);
procedure latch_D(D,C:tbit; var Q,NQ:tbit);
procedure FF_D(D,C:tbit; var Q,NQ:tbit);

{register's}
procedure RG2(D0,D1,CLR,CLK:tbit; var Q0,NQ0,Q1,NQ1:tbit);
procedure RG4(D0,D1,D2,D3,CLR,CLK:tbit; var Q0,Q1,Q2,Q3:tbit);
procedure RG8(D0,D1,D2,D3,D4,D5,D6,D7,CLR,CLK:tbit;
              var Q0,Q1,Q2,Q3,Q4,Q5,Q6,Q7:tbit);

{RAM}
procedure RAM_4096x1(a0,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,cs,ce,we,din:tbit; var dout:tbit);
procedure RAM_16384x1(a0,a1,a2,a3,a4,a5,a6,ras,cas,we,din:tbit; var dout:tbit);

implementation
{multiplexer's}
function mux_2x1(x0,x1,a0:tbit):tbit;
begin mux_2x1:=q_or(q_and(x0,q_not(a0)),q_and(x1,a0)); end;

function mux_4x1(x0,x1,x2,x3,a0,a1:tbit):tbit;
var not_a0,not_a1:tbit;
begin
    not_a0:=q_not(a0);
    not_a1:=q_not(a1);
    mux_4x1:=q_or4(q_and3(x0,not_a1,not_a0),
                   q_and3(x1,not_a1,a0),
                   q_and3(x2,a1,not_a0),
                   q_and3(x3,a1,a0));
end;

function mux_8x1(x0,x1,x2,x3,x4,x5,x6,x7,a0,a1,a2:tbit):tbit;
var not_a0,not_a1,not_a2:tbit;
begin
    not_a0:=q_not(a0);
    not_a1:=q_not(a1);
    not_a2:=q_not(a2);
    mux_8x1:=q_or8(q_and4(x0,not_a2,not_a1,not_a0),
                   q_and4(x1,not_a2,not_a1,a0),
                   q_and4(x2,not_a2,a1,not_a0),
                   q_and4(x3,not_a2,a1,a0),
                   q_and4(x4,a2,not_a1,not_a0),
                   q_and4(x5,a2,not_a1,a0),
                   q_and4(x6,a2,a1,not_a0),
                   q_and4(x7,a2,a1,a0));
end;

{buffers}
procedure BUF(x,en:tbit; var y:tbit);
begin y:=MUX_2x1(y,x,en); end;

procedure IBUF(x,en:tbit; var y:tbit);
begin y:=MUX_2x1(x,y,en); end;

{encoder's}
procedure CD_2x1(x0,x1:tbit; var y0:tbit);
begin y0:=x1; end;

procedure CD_4x2(x0,x1,x2,x3:tbit; var y0,y1:tbit);
begin
    y0:=q_or(x1,x3);
    y1:=q_or(x2,x3);
end;

procedure CD_8x3(x0,x1,x2,x3,x4,x5,x6,x7:tbit; var y0,y1,y2:tbit);
begin
    y0:=q_or4(x1,x3,x5,x7);
    y1:=q_or4(x2,x3,x6,x7);
    y2:=q_or4(x4,x5,x6,x7);
end;

{decoder's}
procedure DC_1x2(x0:tbit; var y0,y1:tbit);
begin
    y0:=q_not(x0);
    y1:=x0;
end;

procedure DC_2x4(x0,x1:tbit; var y0,y1,y2,y3:tbit);
var not_x0,not_x1:tbit;
begin
    not_x0:=q_not(x0);
    not_x1:=q_not(x1);
    y0:=q_and(not_x1,not_x0);
    y1:=q_and(not_x1,x0);
    y2:=q_and(x1,not_x0);
    y3:=q_and(x1,x0);
end;

procedure DC_3x8(x0,x1,x2:tbit; var y0,y1,y2,y3,y4,y5,y6,y7:tbit);
var not_x0,not_x1,not_x2:tbit;
begin
    not_x0:=q_not(x0);
    not_x1:=q_not(x1);
    not_x2:=q_not(x2);
    y0:=q_and3(not_x2,not_x1,not_x0);
    y1:=q_and3(not_x2,not_x1,x0);
    y2:=q_and3(not_x2,x1,not_x0);
    y3:=q_and3(not_x2,x1,x0);
    y4:=q_and3(x2,not_x1,not_x0);
    y5:=q_and3(x2,not_x1,x0);
    y6:=q_and3(x2,x1,not_x0);
    y7:=q_and3(x2,x1,x0);
end;

{flip-flop's}
procedure latch_RS(R,S:tbit; var Q,NQ:tbit);
var tmp_Q, tmp_NQ: tbit;
begin
    tmp_Q:=q_nor(R,NQ);
    tmp_NQ:=q_nor(S,Q);
    Q:=q_nor(R,tmp_NQ);
    NQ:=q_nor(S,tmp_Q);
end;

procedure latch_RSC(R,S,C:tbit; var Q,NQ:tbit);
begin latch_RS(q_and(R,C),q_and(S,C),Q,NQ); end;

procedure latch_D(D,C:tbit; var Q,NQ:tbit);
begin latch_RSC(D,q_not(D),C,Q,NQ); end;

procedure FF_D(D,C:tbit; var Q,NQ:tbit);
begin latch_D(D,q_or(C,q_not(C)),Q,NQ); end;

{register's}
procedure RG2(D0,D1,CLR,CLK:tbit; var Q0,NQ0,Q1,NQ1:tbit);
begin
    FF_D(q_and(D0,q_not(CLR)),CLK,Q0,NQ0);
    FF_D(q_and(D1,q_not(CLR)),CLK,Q1,NQ1);
end;

procedure RG4(D0,D1,D2,D3,CLR,CLK:tbit; var Q0,Q1,Q2,Q3:tbit);
var g0,g1,g2,g3:tbit;
begin
    FF_D(q_nand(D0,q_not(CLR)),CLK,Q0,g0);
    FF_D(q_nand(D1,q_not(CLR)),CLK,Q1,g1);
    FF_D(q_nand(D2,q_not(CLR)),CLK,Q2,g2);
    FF_D(q_nand(D3,q_not(CLR)),CLK,Q3,g3);
end;

procedure RG8(D0,D1,D2,D3,D4,D5,D6,D7,CLR,CLK:tbit;
              var Q0,Q1,Q2,Q3,Q4,Q5,Q6,Q7:tbit);
var g0,g1,g2,g3,g4,g5,g6,g7:tbit;
begin
    FF_D(q_and(D0,q_not(CLR)),CLK,Q0,g0);
    FF_D(q_and(D1,q_not(CLR)),CLK,Q1,g1);
    FF_D(q_and(D2,q_not(CLR)),CLK,Q2,g2);
    FF_D(q_and(D3,q_not(CLR)),CLK,Q3,g3);
    FF_D(q_and(D4,q_not(CLR)),CLK,Q4,g4);
    FF_D(q_and(D5,q_not(CLR)),CLK,Q5,g5);
    FF_D(q_and(D6,q_not(CLR)),CLK,Q6,g6);
    FF_D(q_and(D7,q_not(CLR)),CLK,Q7,g7);
end;

{RAM}
procedure RAM_4096x1(a0,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,cs,ce,we,din:tbit; var dout:tbit);
begin
end;

procedure RAM_16384x1(a0,a1,a2,a3,a4,a5,a6,ras,cas,we,din:tbit; var dout:tbit);
begin
end;

end.
