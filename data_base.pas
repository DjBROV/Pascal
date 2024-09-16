const n = 100;
type socks = record
		sock_id: integer;
        color_id: integer;
        size: integer;
        is_woolen: boolean;
        end;
type fyle = file of socks;
type base = array[1..n] of socks;

var name: string[20]; j, cnt: integer; b: base;

//1\\

procedure input_1;
	var f:fyle; s:socks; i:integer;
	begin
	writeln('Name of file: ');
	read(name); assign(f, name); reset(f);
	i := 1; cnt := 1;
	while not eof(f) do 
		begin
        read(f,s);
        b[i] := s;
        i:=i+1; cnt := cnt + 1;
        end;
    cnt := cnt -1;
    close(f);
	end;

//2\\

procedure print_2;
	var i:integer;
	begin
	for i := 1 to cnt do
		begin
		writeln(i,' socks informstion: ');
		writeln(' Sock id: ', b[i].sock_id);
		writeln(' Color_id: ', b[i].color_id);
		writeln(' Size: ', b[i].size);
		writeln(' Socks are woolen: ', b[i].is_woolen);
		end;
	end;

//3\\

procedure add_3;
	var w : char;
	begin
	if cnt < 100 then begin
	cnt := cnt +1;
	writeln('Write sock id: '); readln(j); 
	b[cnt].sock_id := j;
	writeln('Write color id: '); readln(j); 
	b[cnt].color_id := j;
	writeln('Write sock size: '); readln(j); 
	b[cnt].size := j;
	writeln('Socks are woolen?(  Y  if yes, else  N  )');readln(w); 
	if w = 'Y' then b[cnt].is_woolen := true else b[cnt].is_woolen := false;
	end;
	end;

//4\\

procedure find_4;
	var i, j: integer; flag: string[20];
	begin
	
	writeln('Write flag for search( "color" or "size" or "wool")');
	readln(flag);
	if flag = 'color' then
		begin
		writeln('Write color id: ');
		read(j);
		for i := 1 to cnt do
			if b[i].color_id = j then writeln('Good sock id: ', b[i].sock_id)
		end
	else if flag = 'size' then
		begin
		writeln('Write sock size: ');
		read(j);
		for i := 1 to cnt do
			if b[i].size = j then writeln('Good sock id: ', b[i].sock_id)
		end
	else if flag = 'wool' then
		for i := 1 to cnt do

			if b[i].is_woolen then writeln('Good sock id: ', b[i].sock_id);
	end;

//5\\

procedure save_5;
	var i:integer; f:fyle;
	begin
	writeln('Name of file: ');
	read(name); assign(f, name); rewrite(f);
	for i:=1 to cnt do
		write(f, b[i]);
	close(f);
	end;

//\\

begin

writeln(' Operations:');
writeln(' 1 - read elements;');
writeln(' 2 - print all elements;');
writeln(' 3 - add element;');
writeln(' 4 - search elements;');
writeln(' 5 - save elements in file;');
writeln(' 6 - exit');
while true do
	begin
	writeln('Write number of operation');
	readln(j);
	if j = 1 then input_1
	else if j = 6 then exit
	else if j = 2 then print_2
	else if j = 3 then add_3
	else if j = 4 then find_4
	else if j = 5 then save_5
	end;

end.
	


	
		


	
	
