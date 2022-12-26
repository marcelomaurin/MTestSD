unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  ComCtrls, math;

type

  { TForm1 }

  TForm1 = class(TForm)
    btStart: TButton;
    btcancel: TButton;
    cbSD: TComboBox;
    cbSizeBlock: TComboBox;
    edVolume: TEdit;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    lb3: TLabel;
    lbVersion: TLabel;
    lbestimate: TLabel;
    lb2: TLabel;
    lbbloco: TLabel;
    pnTeste: TPanel;
    pnTop: TPanel;
    pbbloco: TProgressBar;
    procedure btcancelClick(Sender: TObject);
    procedure btStartClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure StartBloco();
    procedure EscreveBloco( bloco : int64);
    function LeBloco(bloco : int64 ) : boolean;
    procedure Notifica(Bloco: Int64);
    function FileName(bloco : int64): string;
    function formataleg(bloco : int64) : string;
  public
    info : array[0..1023] of char;
    flgTest : boolean;
    ref : int64;
    inicio : TDatetime;
    SizeBlock : int64;
  end;

var
  Form1: TForm1;

const
  Version = '0.1';

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.btStartClick(Sender: TObject);
begin
  if (cbSD.ItemIndex <> -1) then
  begin
    StartBloco();

  end
  else
  begin
    ShowMessage('Please select your SD SIZE');
    cbSD.SetFocus;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  a : integer;
begin
  lbVersion.caption := version;
  for a := 0 to 1023 do
      info[a] := '1';
end;

procedure TForm1.btcancelClick(Sender: TObject);
begin
  flgTest := false;
end;

procedure TForm1.StartBloco;
var
  bloco : int64;
  base : int64;

begin
  bloco := 0;
  inicio:= now; //Hora atual
  flgTest := true;
  btcancel.Enabled:= true;
  ref := 10;
  base := 1024;
  SizeBlock:= base ** (cbSizeBlock.ItemIndex)*1024; (*Tamanho do bloco de dados*)
  pbbloco.Max := ((strtoint(cbSD.Text) *  (1024 ** 3)) div Sizeblock); //Nro total de blocos
  repeat
  begin
       EscreveBloco(bloco);
       if(LeBloco(bloco)) then
       begin
          bloco := bloco+1;
          lbbloco.Caption:= formataleg(bloco);
          pbbloco.Position:= bloco;
          if ((bloco / ref) = (bloco div ref)) then
             Application.ProcessMessages;
       end
          else
       begin
          flgTest := false;
          Notifica(bloco);
       end;

  end;
  until not flgTest;
  Application.ProcessMessages;
  btcancel.Enabled:=false;
end;

procedure TForm1.EscreveBloco(bloco: int64);
var
   f: Text;
   a : int64;
   b : int64;

begin
  try
   AssignFile(f,FileName(bloco));

   {$I-} // without this, if rewrite fails then a runtime error will be generated
   Rewrite(f);
   {$I+}
   for b:= 1 to (sizeblock div 1024) do
   begin
        for a:= 0 to 1023 do
            write(f,info[a]);

   end;

  except
     on E: EInOutError do
      showmessage('Deu erro no bloco');

  end;

  closefile(f);

end;

function TForm1.LeBloco(bloco: int64): boolean;
var
  f: Text;
  resultado : boolean;
  test : char;
  a : integer;
begin
  resultado := true;
  if ((bloco div ref) = (bloco /ref)) then
  begin
    try
     AssignFile(f,FileName(bloco));
     reset(f);
     for a:= 0 to 1023 do
     begin
       read(f,test);
       if (info[a] <> test) then
       begin
          resultado := false;
       end;

     end;
    finally
     closefile(f);
    end;
  end;
  result := resultado;
end;

procedure TForm1.Notifica(Bloco: Int64);
begin
  showmessage('Stop in '+inttostr(bloco*1024)+' Bytes');
end;

function TForm1.FileName(bloco: int64): string;
begin
  result := edVolume.text +'\'+ 'FL'+inttostr(bloco)+'.dat';
end;

function TForm1.formataleg(bloco: int64): string;
var
  resultado : string;
  agora : TDatetime;
  tamanho : float;

begin
  resultado := '';
  agora := ((now()-inicio)/(bloco*SizeBlock) * (strtoint(cbSD.Caption)*(1024**3)));
  lbestimate.Caption:= FormatDateTime('hh:mm:ss',agora);

  tamanho := (SizeBlock * bloco)/1024; (*Tamanho em K bytes*)
  if(tamanho < (1024**1)) then
  begin
       resultado := floattostr(tamanho)+' K bytes';
       ref := 10;
  end
     else
  begin
      if(tamanho < (1024**2)) then
      begin
        resultado := floattostr(tamanho / (1024))+' M bytes';
        ref := 10;

      end
      else
      begin
        resultado := floattostr(tamanho / (1024))+' G bytes';
        ref := 10;
      end;
  end;

  result := resultado;
end;

end.

