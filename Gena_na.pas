{4}

const n = 10; p = 15;
	eps = 1/1638400;
	f_max = 30.118994;
type t = file of real;
int = int64;
t_bin = array[1..16] of boolean;
bin_arr = array[1..n] of t_bin;
f_arr = array[1..n] of real;
var cnt_iter, depth, cnt_k, i, index, p1, p2, cnt, limit, mod12: integer;  
a : bin_arr; fmax, fpred, ans_f, ans_x, pred_ans_f, x: real; 
fun : f_arr; sum_iter, cnt_it2 : int64; h: t; flag : boolean; YN: char;



function f(x:real):real;
	begin 
	f:= (x-1)*(x-1)*(x-1)*(x-1)*(x-1)*(x-0.05)*(x-3)*(x-3.5)*(1-exp(x-3.95))*ln(x+0.22) 
	end;

function max(fun: f_arr): real;
	var i : integer; g:real;
	begin 
	g := -10000;
	for i := 1 to n do if fun[i] > g then begin g := fun[i]; index := i end;	
	max := g
	end;
	
function bin(x:integer):t_bin;
	var b : t_bin; i, j, r: integer;
	begin
	i := 1; for j := 1 to 16 do b[j] := false;
	if x < 0 then b[n] := true;
	while x <> 0 do
		begin
		r := x mod 2;
		x := x div 2;
		if r = 1 then b[i] := true;
		i := i+1;
		end;
	bin := b
	end;

	
procedure new_parents(var a : bin_arr);
	var x, i: integer; x_bin: t_bin;
	begin
	for i := 1 to n do 
		begin
		x := random(65536);
		x_bin := bin(x);
		a[i] := x_bin
		end
	end;
	
	
function rebin(b: t_bin):real;
	var x : real=0; i:integer;
	begin
	for i := 16 downto 1 do 
		if b[i] = true then
			x := x + exp((i-15)*ln(2));
	rebin := x;
	end;
	
	
procedure rus_rulet(a : bin_arr; var p1, p2:integer; var fun : f_arr);
	var sum, r: real; i, j: integer; 
	begin 
	sum := 0;
	for i := 1 to n do sum := sum + fun[i];
	r := random();
	for j := 1 to n do 
		begin
		r := r - fun[j]/sum;
		if r < 0 then begin p1 := j; break end
		end;
	r := random(); j :=1;
	for j := 1 to n do 

		begin
		r := r - fun[j]/sum;
		if r < 0 then begin p2 := j; break end
		end;
	end;


procedure mama(var b1, b2: t_bin);
	var i, c:integer;
	begin 
	c := random(15) + 2;
	for i := 1 to c-1 do b2[i] := b1[i];
	for i := c to 16 do b1[i] := b2[i];
	end;


procedure mutant(var b:t_bin);
	var i : integer;
	begin
	for i := 1 to 16 do 
		if p{change} - random(100) - 1 >= 0 then 
			b[i] := not b[i];
	end;		
	
	
	

procedure evolution(p1, p2 : integer; var a: bin_arr);
	var b1, b2 : t_bin; i:integer;
	begin
	b1 := a[p1]; b2 := a[p2];
	mama(b1, b2);
	a[p1] := b1; a[p2] := b2;
	for i := 1 to n do
		mutant(a[i])
	end;


begin
randomize;

{writeln('Write down a change of mutation(1..100): ');
readln(change);}
writeln('Write number of work mod(1 - test or 2 - main): ');
readln(mod12);
if mod12 = 1 then 
	begin
	writeln('Do you need to see all populations in console? ( Y or N ): ');
	readln(YN);
	if YN = 'Y' then flag := true else flag := false
	end;
writeln('Write down a depth of iterations(1..): ');
readln(depth);
writeln('Write down a limit of generating new parents(1..): ');
readln(limit);
{выбор мода, два разных вайл тру, но пока один, для основного режима}
cnt_k := 0; cnt_iter := 0; cnt := 1; 
sum_iter := 0; cnt_it2 := 0;


new_parents(a);



for i := 1 to n do fun[i] := f(rebin(a[i]));
fmax := max(fun); ans_f := fmax; ans_x := rebin(a[index]); pred_ans_f := ans_f;
fpred :=fmax + eps +1;
if mod12 = 1 then 
	begin
	assign(h, 'for_gena_na.bin');
	rewrite(h);
	for i := 1 to n do write(h, fun[i]);
	if flag then begin
		for i := 1 to n do write(fun[i]:10:6, '  '); writeln end;
	end;
while true do
	begin
	if cnt_iter > depth then
		begin
		{writeln('bad');}
		sum_iter := sum_iter + cnt_it2;
		
        cnt_iter := 0;
        cnt_it2 := 0;
		new_parents(a);
		end
	else if 
		abs(fpred - fmax) < eps then 
		begin
		{writeln('good');}
		x := rebin(a[index]);
		if pred_ans_f = ans_f then cnt_k := cnt_k + 1
		else  cnt_k := 0;
		if fmax > ans_f then 
			begin 
			pred_ans_f := ans_f; 
			ans_f := fmax; 
			ans_x := x; 
			end
		else pred_ans_f := ans_f; 
		
        
        if (cnt > limit) or (cnt_k > limit div 2) then
			begin
			if mod12 = 2 then begin
				writeln('ANSWER');
				writeln(ans_x:10:6);
				writeln(ans_f:10:6);
				writeln(sum_iter + cnt_it2);
				 end;
			if mod12 = 1 then 
				close(h);
			break
			end
		else
			begin
			sum_iter := sum_iter + cnt_it2;
			cnt_iter := 0;
			cnt_it2 := 0;

			new_parents(a);
	
			for i := 1 to n do fun[i] := f(rebin(a[i]));
			
			if mod12 = 1 then begin
				for i := 1 to n do write(h, fun[i]);
				if flag then begin
					for i := 1 to n do write(fun[i]:10:6, '  '); writeln end;
				end;
			fmax := max(fun);
			fpred :=fmax + eps +1;
			cnt := cnt + 1;
		end
		

		end
	else
		begin
		cnt_iter := cnt_iter + 1;
		cnt_it2 := cnt_it2 + 1;
		rus_rulet(a, p1, p2, fun);
		evolution(p1, p2, a);
		for i := 1 to n do fun[i] := f(rebin(a[i]));
		
		if mod12 = 1 then begin
			for i := 1 to n do write(h, fun[i]);
			if flag then begin
				for i := 1 to n do write(fun[i]:10:6, '  '); writeln end;
			end;
		fpred := fmax;
		fmax := max(fun);
		
		end
		
	end
		
		
	
	
end.
	
		
