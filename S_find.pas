{232}
const e = 0.001;
	e1 = e/1000; e2 = e/1000;
type tf = function (x:real):real;
var x1, x2, x3, s1, s2, s3: real; cnt1:integer=0; cnt2:integer=0;

procedure root(f, g, df, dg : tf; a, b: real; var x: real);
	var c : real; flag : boolean = false;
	begin
	
	if f(a)-g(a) <0 then 
		if f((a+b)/2) - g((a+b)/2) < (f(a)-g(a) + f(b)-g(b))/2 then flag := true
	else if f(a)-g(a) >0 then
		if f((a+b)/2) - g((a+b)/2) > (f(a)-g(a) + f(b)-g(b))/2 then flag := true;
		
	if flag then
		while true do
			
			begin
			cnt1 := cnt1 +1;
			c := b - (f(b)-g(b))/(df(b)-dg(b));
			if (f(c-e1)-g(c-e1))*(f(c)-g(c))>0 then b := c
			else begin x := (2*c-e1)/2; break end
			end
	else 
		while true do
			begin
			cnt1 := cnt1 +1;
			c := a - (f(a)-g(a))/(df(a)-dg(a));
			if (f(c+e1)-g(c+e1))*(f(c)-g(c))>0 then a := c
			else begin x := (2*c+e1)/2; break end
			end
		
	end;


function integral(f : tf; a, b:real):real;
	var h, sum1, sum2: real; n: integer = 20; i : integer;
	begin
	h := (b-a)/n; sum1 := 0.5*f(a);
	for i := 1 to n-1 do
		sum1 := sum1 + f(a+i*h);
	sum1 := h*(sum1+0.5*f(b));
	while true do
	begin
		sum2 := sum1/h;
		n := n*2; h := (b-a)/n; 
		cnt2 := cnt2 +1;
		for i := 1 to n-1 do
			if i mod 2 = 1 then
			 sum2 := sum2 + f(a+i*h);
		sum2 := h*(sum2);
		if abs(sum1-sum2)/3 < e2 then
			begin integral := sum2; break end
		else sum1 := sum2
	end
	end;
		
	
	
	


function f1(x:real): real; begin f1:= 3*(0.5/(x+1)+1) end;

function f2(x:real): real; begin f2:= 2.5*x - 9.5 end;
	
function f3(x:real): real; begin f3:= 5/x end;

function df1(x:real): real;begin df1:= -1.5/((x+1)*(x+1)) end;

function df2(x:real): real;begin df2:= 2.5 + x*0 end;

function df3(x:real): real;begin df3:= -5/(x*x) end;



		
		
begin
x1:=0; x2:=0; x3:=0;
root(@f3, @f1, @df3, @df1, 1, 2, x1); 
writeln(' x1 =', x1:10:6);
root(@f1, @f2, @df1, @df2, 5, 6, x2);
writeln(' x2 =', x2:10:6);
root(@f3, @f2, @df3, @df2, 4, 5, x3); 
writeln(' x3 =' , x3:10:6); writeln(' ', cnt1);
s1:= integral(@f1, x1, x2); 
s2:= integral(@f2, x3, x2);
s3:= integral(@f3, x1, x3); 
writeln;
writeln(' s1 = ', s1:10:6); writeln(' s2 = ', s2:9:6); writeln(' s3 = ', s3:9:6); writeln(' ', cnt2);
writeln;
writeln(' My answer: ', s1-s2-s3:9:6)
end.







