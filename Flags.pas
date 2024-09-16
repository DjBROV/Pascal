
var a, b, c, aw, bw, cw, zf, cf, sf, of_, i, oper:integer;

begin
writeln('Write down op1 and op2 and type of operation(1 for +; 0 for -): ');
for i :=1 to 10 do
	begin
	zf := 0; cf:= 0; sf:= 0; of_ := 0;
	
	read(a); read(b); readln(oper);
	writeln(a, b, oper);
	if oper = 1 then
		begin
		writeln('a  + b = |c|  c   zf sf of cf');
		if a < 0 then
			aw := 256 + a
		else aw := a;	
		if b < 0 then
			bw := 256 + b
		else bw := b;
		
		cw := (aw+bw);
		if cw > 255 then cf := 1;
		cw:= cw mod 256;
		if cw > 127 then
			c := cw - 256
		else c := cw;
		
		if c = 0 then zf := 1;
		if c < 0 then sf := 1;
		if ( ((a>=0) and (b>=0)) and (c<0) ) or ( ((a<0) and (b<0)) and (c>=0) ) then
			of_ := 1;
		writeln(a:3, '+', b:3, '=', cw:4, c:4, zf:3, sf:3, of_:3, cf:3)
		end
		
	else if oper = 0 then
		begin
		writeln('a  - b = |c|  c   zf sf of cf');
		c := a - b;
		if ( ((a>=0) and (b>=0)) and (a < b) ) or ( ((a<0) and (b<0)) and (a < b) ) or ( (a >= 0) and (b < 0) ) then
			cf := 1;
		if a < 0 then
			aw := 256 + a
		else aw := a;	
		if b < 0 then
			bw := 256 + b
		else bw := b;
		cw := aw - bw;
		if cw < 0 then cw := 256 + cw;	
		if c = 0 then zf := 1;
		if c < -128 then c := 256 + c;
		if a > 127 then a := a - 256;
		if b > 127 then b := b - 256;

		if c < 0 then begin sf := 1;end;
		if ( ((a>=0) and (b<0)) and (c<0) ) or ( ((a<0) and (b>=0)) and (c>=0) ) then
			of_ := 1;
		writeln(a:3, '-', b:3, '=', cw:4, c:4, zf:3, sf:3, of_:3, cf:3)
		end
	end;	
end.		
