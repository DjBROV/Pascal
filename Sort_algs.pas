 //2 8
 const n = 300; high = 100;
 type data = array[1..3] of integer;
 type arr = array[1..n] of data;
 type list = ^node;
	node = record
		elem: integer;
		next: list;
		end;
type mas = array[1..5] of integer;		
var cnt_change: integer=0; i, a, b, c, m, j, sr1, sr2, sr10, sr20: integer; x, x_copy : arr; 
cnt_change_1: integer=0; cnt_sr : integer=0; flag : boolean; ch:char; sr_mas, per_mas, sr_mas0, per_mas0 : mas;


procedure push(var q: list; x:integer);
begin
if q = nil then 
	begin
	new(q);
	q^.elem:=x;
	q^.next:=nil;
	end
else push(q^.next, x)
end;

function pop(var q: list):integer;
begin
if q <> nil then
	if q^.next = nil then 
		begin
		pop:=q^.elem;
		dispose(q^.next);
		q:=nil
		end
	else pop:=pop(q^.next)
else pop:= -1
end;

 
 procedure change(var x: arr; ai, bi : integer);  // a <-> b
	var q: data;
	begin
	q := x[ai];
	x[ai] := x[bi];
	x[bi] := q;
	cnt_change := cnt_change + 1
	end;
	
	
	
function bigger(a, b:data):boolean;  // a > b?
	begin
	cnt_sr := cnt_sr +1;
	if a[1] > b[1] then
		bigger := true
	else if a[1] = b[1] then
		if a[2] > b[2] then
			bigger := true
		else if a[2] = b[2] then
			if a[3] > b[3] then
				bigger := true
			else bigger := false
		else bigger := false
	else bigger := false
	end;
	

/////////////////
procedure bin_sort(var x : arr);
	var i, r, j, h: integer; //k:integer;
	begin
	for i := 2 to n do
		begin

		
		r := i div 2;
		h := i;
		
		// отладки
		{writeln;
		write('x[r]=', x[r][1]); write('.'); write(x[r][2]); write('.');	writeln(x[r][3], '  ');
		writeln;
		write('x[h]=', x[h][1]); write('.'); write(x[h][2]); write('.');	writeln(x[h][3], '  ');
		for k := 1 to n do
			begin write(x[k][1]); write('.'); write(x[k][2]); write('.');	writeln(x[k][3], '  ') end;}
			
			
		if bigger(x[i], x[r]) then
			
			for j := i-1 downto r do
				begin
				if bigger(x[j], x[h]) then
					begin
					while true do begin
						change(x, h, h-1);
						h := h -1;
						if h = j then begin cnt_change_1 := cnt_change_1 +1; break end
						end
					end
				end
		else
			for j := r downto 1  do
				if bigger(x[j], x[h]) then
					begin
					while true do begin
						change(x, h, h-1);
						h := h -1;
						if h = j then begin cnt_change_1 := cnt_change_1 +1; break end
						end
					end
		end;
	end;
	
	
procedure step(var x: arr; r, i, j: integer; var h:integer);
	var fl_i, fl_j: boolean; q: data;
	begin
	fl_i := true; fl_j := true;
	q := x[r]; 
	while true do
	
		begin
		if i = j then begin h := i;break end;
		if fl_i then
			begin

			if not bigger(q, x[i]) then begin
				fl_i := false; i := i -1; end;
			i := i +1;
			end;
		if fl_j then
			begin
			
			if not bigger(x[j], q) then begin
				fl_j := false; j := j+1; end;
			j := j - 1;
			end;
		if not fl_i and not fl_j then
			begin change(x, i, j);  fl_i := true; fl_j := true end;

		end;
	end;
	
	
procedure mini_sort(var x: arr; i, j : integer);
	var h:integer; //g:integer;
	begin
	h := i;
	//for g := i to j do
		//for h := i to j -1 do
			if bigger(x[h], x[h+1]) then change(x, h, h+1);
	cnt_sr := cnt_sr -1;
	end;
	
	
/////////////////
procedure speed_sort(var x : arr);
	var i, r, j, l, h: integer; stack:list=nil; // h:integer;
	
	begin
	i := 1; j:= n;
	while true do
		begin
		l := j - i + 1;
		if l > 2 then
			begin
			r := (j+i) div 2 ;
			step(x, r, i, j, h);
			push(stack, j);
			{writeln( 'i=',i,' r=',r,' j=',j);
			writeln;
			for h := 1 to n do
				begin write(x[h][1]); write('.'); write(x[h][2]); write('.');	writeln(x[h][3], '  ') end;
			writeln;}
			
			j := h
			end
		else if l <= 2 then
			if j = n then begin mini_sort(x, i, j); break end
			else
				begin
				mini_sort(x, i, j);
				{writeln(' i=',i,' r=',r,' j=',j);
				writeln;
				for h := 1 to n do
					begin write(x[h][1]); write('.'); write(x[h][2]); write('.');	writeln(x[h][3], '  ') end;
				writeln;}
				i := j; j := pop(stack);
				end;	
		end
	end;
	

	
begin
randomize;
writeln('Do you need a table?(1/0): ');
readln(ch);
if ch = '1' then flag := true
else flag := false;
writeln(flag);
m := 5;
if flag then
begin
//writeln('Wr

for j := 1 to m do
	begin
	for i := 1 to n do
		begin
		a := random(high);b:=random(high) ; c := random(high);
		x[i][1] := a; x[i][2] := b; x[i][3] := c;
		x_copy[i][1] := a; x_copy[i][2] := b; x_copy[i][3] := c;
		
		end;
	bin_sort(x); sr_mas[j] := cnt_sr; per_mas[j] := cnt_change_1; cnt_sr := 0; cnt_change_1 := 0; cnt_change := 0;
	speed_sort(x_copy); sr_mas0[j] := cnt_sr; per_mas0[j] := cnt_change; cnt_sr := 0; cnt_change := 0;
	end;

sr1 := (sr_mas[1]+sr_mas[2]+sr_mas[3]+sr_mas[4]+sr_mas[5]) div 5;
sr2 := (per_mas[1]+per_mas[2]+per_mas[3]+per_mas[4]+per_mas[5]) div 5;
writeln('slow', ' n = ', n);
	writeln('srawneniya:', ' num1 ', sr_mas[1], ' num2 ', sr_mas[2],' num3 ', sr_mas[3],' num4 ', sr_mas[4],' num5 ', sr_mas[5], ' sredniy: ', sr1); writeln;
	writeln('perestanovki:', ' num1 ', per_mas[1], ' num2 ', per_mas[2],' num3 ', per_mas[3],' num4 ', per_mas[4],' num5 ', per_mas[5], ' sredniy: ', sr2); writeln;
	
sr10 := (sr_mas0[1]+sr_mas0[2]+sr_mas0[3]+sr_mas0[4]+sr_mas0[5]) div 5;
sr20 := (per_mas0[1]+per_mas0[2]+per_mas0[3]+per_mas0[4]+per_mas0[5]) div 5;
	
writeln('fast', ' n = ', n);
	
	writeln('srawneniya:', ' num1 ', sr_mas0[1], ' num2 ', sr_mas0[2],' num3 ', sr_mas0[3],' num4 ', sr_mas0[4],' num5 ', sr_mas0[5], ' sredniy: ', sr10); writeln;
	writeln('perestanovki:', ' num1 ', per_mas0[1], ' num2 ', per_mas0[2],' num3 ', per_mas0[3],' num4 ', per_mas0[4],' num5 ', per_mas0[5], ' sredniy: ', sr20); writeln;

end
	
else begin
for i := 1 to n do
		begin
		a := random(high);b:=random(high) ; c := random(high);
		x[i][1] := a; x[i][2] := b; x[i][3] := c;
		x_copy[i][1] := a; x_copy[i][2] := b; x_copy[i][3] := c
		end;

writeln;
for i := 1 to n do
	begin write(x[i][1]); write('.'); write(x[i][2]); write('.');	writeln(x[i][3], '  ') end;


speed_sort(x);
writeln;

writeln('Answer for 2: ');
{for i := 1 to n do
	begin write(x[i][1]); write('.'); write(x[i][2]); write('.');	writeln(x[i][3], '  ') end;}
writeln('cnt_change = ', cnt_change, ' cnt_sravn = ', cnt_sr);
cnt_change := 0; cnt_sr := 0;

bin_sort(x_copy);
writeln;
writeln('Answer for 1: ');
{for i := 1 to n do
	begin write(x_copy[i][1]); write('.'); write(x_copy[i][2]); write('.');	writeln(x_copy[i][3], '  ') end;}
writeln;
writeln('cnt_change = ', cnt_change, ' cnt_sravneniy = ', cnt_sr); //' cnt_vstavok= ', cnt_change_1,

end
end.
	


 
