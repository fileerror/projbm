unit Unit6;

interface

uses inifiles,System.SysUtils;

type
  kolvo = record
    sim:ansichar;
    kol:int64;
    stolb:byte;
  end;
  yaz=array [0..100] of kolvo;


const m: set of ansichar = ['`','.', ',', '?', '!', ':', ';', ' ', '-', '''', ')', '(',
                        #10, #13, #0, #185, #171, #133, #147, #148, #150, #151,
                        #187, #34,#96,#39];

function decryptENG(a,b:ansistring):ansistring;
function encryptENG(a,b:ansistring): ansistring;
function upkeystr(a:ansistring):ansistring;
function kbinstr(a:ansistring): yaz;
procedure totalcleanstr(var a:ansistring);

implementation
uses unit2;

function decryptENG(a,b:ansistring):ansistring;
var i,j,k,ind,posres:integer;
    s,key,f:ansistring;
begin
  f:='';
  s:=a;
  key:=b;
  s:=upkeystr(s);
  key:=upkeystr(key);
  for I := 0 to length(s)-1 do begin
    ind:=i mod length(key);
    posres:=ord(s[i+1])-ord(key[ind+1])+65;
    if posres<64 then posres:=posres+26;
    f:=f+ansichar(posres);
  end;
  decryptENG:=f;
end;

procedure totalcleanstr(var a:ansistring);                //TOTALCLEANSTR
var k:integer;
begin
  k:=1;
  repeat
    if not(a[k] in ['A'..'Z']) and not(a[k] in ['a'..'z'])
      then delete(a,k,1)
      else inc(k);
  until k>length(a);
end;

function upkeys(a:ansichar):ansichar;                //UPKEYS
begin
  if ((ord(a)>=97) and (ord(a)<=122)) or ((ord(a)>=224) and (ord(a)<=255))
    then upkeys:=ansichar(ord(a)-32)
    else upkeys:=a;
end;

function upkeystr(a:ansistring):ansistring;
var i:integer;
    s:ansistring;
begin
  s:=a;
  for I := 1 to length(s) do begin
    s[i]:=upkeys(s[i]);
  end;
  upkeystr:=s;
end;

function nom(a:ansichar; b:yaz):integer;       //NOM
var i:integer;
begin
  nom:=-1;
  for I := 0 to b[0].stolb-1 do if b[i].sim=upkeys(a) then begin
  nom:=i;
  break;
  end;
end;

function kbinstr(a:ansistring): yaz;     //KBINSTR
var i,j,k,q:integer;
    n:set of ansichar;
    w:yaz;
begin
  q:=0;
  n:=[];
  w[0].stolb:=0;
  for I := 1 to length(a) do begin
    if (not (a[i] in m)) and (not(a[i] in n)) then begin
      w[q].sim:=upkeys(a[i]);
      n:=n+[upkeys(a[i]),(ansichar(ord(upkeys(a[i]))+32))];
      w[q].kol:=1;
      inc(q);
      w[0].stolb:=q;
    end else if nom(a[i],w)<>-1 then inc(w[nom(a[i],w)].kol)
  end;
  kbinstr:=w;
end;


function encryptENG(a,b:ansistring):ansistring;
var i,j,k,ind,posres,process:integer;
    s,key,f:ansistring;
begin
  process:=0;
  form_encryptchip1.edit_info.Lines.Append('Процесс шифрования ...');
  f:='';
  s:=a;
  totalcleanstr(s);
  key:=b;
  s:=upkeystr(s);
  key:=upkeystr(key);
  for I := 0 to length(s)-1 do begin
    ind:=i mod length(key);
    posres:=ord(s[i+1])+ord(key[ind+1])-65;
    if posres>=91 then posres:=posres-26;
    f:=f+ansichar(posres);
    inc(process);
    if process>3 then process:=0;
    if (I mod 1000=0) and (process=0) then form_encryptchip1.edit_info.Lines[form_encryptchip1.edit_info.Lines.Count-1]:='Процесс шифрования '
      else if (I mod 1000=0) and (process=1) then form_encryptchip1.edit_info.Lines[form_encryptchip1.edit_info.Lines.Count-1]:='Процесс шифрования .'
        else if (I mod 1000=0) and (process=2) then form_encryptchip1.edit_info.Lines[form_encryptchip1.edit_info.Lines.Count-1]:='Процесс шифрования ..'
          else if (I mod 1000=0) and (process=3) then form_encryptchip1.edit_info.Lines[form_encryptchip1.edit_info.Lines.Count-1]:='Процесс шифрования ...';
  end;
  encryptENG:=f;
  form_encryptchip1.edit_info.Lines.Delete(form_encryptchip1.edit_info.Lines.Count-1);
end;

end.
