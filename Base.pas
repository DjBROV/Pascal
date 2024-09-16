unit Base;
interface
const N=3;
	  M=8;
type vector = array[1..N] of int64;
	 solution = array[1..8] of integer;
	 matrix = array[1..N,1..M] of integer;
	 combination = array[1..N] of boolean;

function MaxInt(var A:vector):int64;
function MinInt(var A:vector):int64;
procedure InpArray(var A:vector);
procedure OutArray(var A:vector);
procedure OutSolution(var A:solution);
procedure OutBoolean(var A:combination);
procedure Reverse(var A:vector);
Procedure Copy(var A,B:vector);
{
Procedure InpMatrix(var A:matrix);}
Procedure OutMatrix(var A:matrix);



implementation
{
Procedure InpMatrix(var A:matrix);
var i,j:integer;
begin
for i:=1 to N do begin
	for j:=1 to M do 
		readln(A[i][j]);

end;
end;}


Procedure OutMatrix(var A:matrix);
var i,j:integer;
begin
for i:=1 to N do begin
	for j:=1 to M do 
		write(A[i][j],' ');
	writeln;
end;
end;


procedure InpArray(var A:vector);
var
i:integer;
begin
	for i:=1 to N do
		read(A[i]);

end;

procedure OutSolution(var A:solution);
var
i:integer;
begin
	{write('Array: ');}
	for i:=1 to 8 do
		write(A[i],' ');
	writeln;

end;

procedure OutArray(var A:vector);
var
i:integer;
begin
	{write('Array: ');}
	for i:=1 to N do
		write(A[i],' ');
	writeln;

end;

procedure OutBoolean(var A:combination);
var
i:integer;
begin
	{write('Array: ');}
	for i:=1 to N do
		write(A[i],' ');
	writeln;

end;

procedure Reverse(var A:vector);
var
i:integer;
b:int64;
begin
	{write('Reverse array: ');}
	for i:=1 to N div 2 do begin
		b:=A[i];
		A[i]:=A[N-i+1];
		A[N-i+1]:=b;
	end;

end;

function MaxInt(var A:vector):int64;
var
i:integer;
m:int64;
begin
	m:=-1000000;
	for i:=1 to N do begin
		if A[i]>m then
			m:=A[i];
	end;
	MaxInt:=m;
end;

function MinInt(var A:vector):int64;
var
i:integer;
m:int64;
begin
	m:=1000000;
	for i:=1 to N do begin
		if A[i]<m then
			m:=A[i];
	end;
	MinInt:=m;
end;

Procedure Copy(var A,B:vector);
var
i:integer;
begin
	for i:= 1 to N do
		B[i]:=A[i]
end;

end.
