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
  drob = array [1..40] of ansistring;
  chast = array [1..40] of real;

function getkey(a:ansistring):ansistring;
function decryptkeyENG(a:ansistring;b:integer):ansistring;
function decryptENG(a,b:ansistring):ansistring;
function encryptENG(a,b:ansistring): ansistring;
function upkeystr(a:ansistring):ansistring;
function kbinstr(a:ansistring): yaz;
procedure totalcleanstr(var a:ansistring);

var ini:tinifile;

implementation
uses unit2,unit4;

function upkeys(a:ansichar):ansichar;                //UPKEYS
begin
  if ((ord(a)>=97) and (ord(a)<=122)) or ((ord(a)>=224) and (ord(a)<=255))
    then upkeys:=ansichar(ord(a)-32)
    else upkeys:=a;
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

function habrkey(a:chast):integer;
var i,j,k:integer;
begin
  k:=0;
  for I := 1 to form_hackchast.spdt_maxlenkey.Value do begin
    for j := 1 to form_hackchast.spdt_maxlenkey.Value do begin
      if a[i]*1.06>a[j] then inc(k)
      else begin
        k:=0;
        break;
      end;
    end;
    if k=form_hackchast.spdt_maxlenkey.Value
    then begin
      break;
    end;

  end;
  habrkey:=i;
end;

function ind(s:ansistring):real;
var i,j,k:integer;
    r:double;
    sk:ansistring;
    q:yaz;
    chast: array [0..50] of double;
begin
  r:=0;
  q:=kbinstr(s);
  for I := 0 to q[0].stolb-1 do begin
    chast[i]:=(q[i].kol*(q[i].kol-1))/(length(s)*(length(s)-1));
    r:=r+chast[i];
  end;
  ind:=r;
end;

function hubind(a:drob;b:integer): real;
var i,j,k:integer;
    l:real;
begin
  l:=0;
  for I := 1 to b do begin
    l:=l+ind(a[i]);
  end;
  l:=l/b;
  hubind:=l;
end;

function drobilka(a:ansistring;b:integer): drob;
var  i,j,k:integer;
     l:drob;
     s:ansistring;
begin
  s:=a;
  for I :=1  to b do l[i]:='';
  k:=1;
  repeat
    if k=b+1 then k:=1
    else begin
      l[k]:=l[k]+copy(s,1,1);
      delete(s,1,1);
      inc(k);
    end;
  until s='';
  drobilka:=l;
end;

function svodhub(a:ansistring): chast;
var i,j,k:integer;
    l:chast;
    s:ansistring;
begin
  s:=a;
  for I := 1 to form_hackchast.spdt_maxlenkey.Value do begin
    l[i]:=hubind(drobilka(s,i),i);
  end;
  svodhub:=l;
end;

function chivalENG(a:ansistring):real;
var i,k,actualcount:integer;
    f,expcount:real;
    s:ansistring;
    textcount:yaz;
begin
  s:=a;
  s:=upkeystr(s);
  f:=0.0;
  textcount:=kbinstr(s);
  for I :=65  to 90 do begin
    k:=nom(ansichar(i),textcount);
    if k<>-1 then actualcount:=textcount[k].kol
    else actualcount:=0;
    expcount:=ini.ReadFloat('ENG',ansichar(i),0)*length(s);
    f:=f+(sqr(actualcount-expcount))/expcount;
  end;
  chivalENG:=f;
end;

function allsdvigsENG(a:ansistring):drob;
var i,j,k:integer;
    s,s1:ansistring;
    resord:integer;
    f:drob;
begin
  s:=a;
  s:=upkeystr(s);
  for I := 0 to 25 do begin
    s1:='';
    for j := 1 to length(s) do begin
      resord:=ord(s[j])-i;
      if resord<65 then resord:=resord+26;
      s1:=s1+chr(resord);
    end;
    f[i+1]:=s1;
  end;
  allsdvigsENG:=f;
end;

function decryptkeyENG(a:ansistring;b:integer):ansistring;
var i,j,k,rotnum:integer;
    f,s,strseq,rotstr,curstr:ansistring;
    dr,allrot:drob;
    max,cuci:extended;
begin
  f:='';
  s:=a;
  dr:=drobilka(s,b);
  for I := 1 to b do begin
    strseq:=dr[i];
    allrot:=allsdvigsENG(strseq);
    rotnum:=0;
    rotstr:='';
    max:=1.1e4931;
    for j := 1 to 26 do begin
      curstr:=allrot[j];
      cuci:=chivalENG(curstr);
      if cuci<max then begin
        rotnum:=j;
        rotstr:=curstr;
        max:=cuci;
      end;
    end;
    f:=f+ansichar(rotnum+96);
  end;
  decryptkeyENG:=f;
end;

function decryptENG(a,b:ansistring):ansistring;
var i,j,k,ind,posres:integer;
    s,key,f:ansistring;
begin
  f:='';
  s:=a;
  key:=b;
  for I := 0 to length(s)-1 do begin
    ind:=i mod length(key);
    posres:=ord(s[i+1])-ord(key[ind+1])+65;
    if posres<64 then posres:=posres+26;
    f:=f+ansichar(posres);
  end;
  decryptENG:=f;
end;

function getkey(a:ansistring):ansistring;
var s:ansistring;
begin
  s:=a;
  getkey:=decryptkeyENG(s,habrkey(svodhub(s)));
end;

procedure totalcleanstr(var a:ansistring);                //TOTALCLEANSTR
var k:integer;
begin
  a:=upkeystr(a);
  k:=1;
  repeat
    if not(a[k] in ['A'..'Z'])
      then delete(a,k,1)
      else inc(k);
  until k>length(a);
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

function kbinstr(a:ansistring): yaz;     //KBINSTR
var i,j,k,q:integer;
    n:set of ansichar;
    w:yaz;
begin
  q:=0;
  n:=[];
  w[0].stolb:=0;
  for I := 1 to length(a) do begin
    if  ((a[i] in ['A'..'Z']) or (a[i] in ['a'..'z']))  and (not(a[i] in n)) then begin
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
  key:=b;
  for I := 0 to length(s)-1 do begin
    ind:=i mod length(key);
    posres:=ord(s[i+1])+ord(key[ind+1])-65;
    if posres>=91 then posres:=posres-26;
    f:=f+ansichar(posres);
  end;
  encryptENG:=f;
  form_encryptchip1.edit_info.Lines.Delete(form_encryptchip1.edit_info.Lines.Count-1);
end;
begin
  ini:=tinifile.Create(getcurrentdir+'\LangInfo.ini');
end.
