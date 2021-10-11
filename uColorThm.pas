unit uColorThm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;

type
  TForm2 = class(TForm)
    Button1: TButton;
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    Image1: TImage;
    procedure FormShow(Sender: TObject);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

uses uMain;

{$R *.dfm}
Procedure HSVtoRGB (const zH, zS, zV: integer; var aR, aG, aB: integer);
const
  d = 255*60;
var
  a    : integer;
  hh   : integer;
  p,q,t: integer;
  vs   : integer;
begin
  if (zH = 0) or (zS = 0) or (ZV = 0)  then
  begin
    aR := zV;
    aG := zV;
    aB := zV;
  end
  else
  begin
    if zH = 360 then hh := 0 else hh := zH;
    a  := hh mod 60;
    hh := hh div 60;
    vs := zV * zS;
    p  := zV - vs div 255;
    q  := zV - (vs*a) div d;
    t  := zV - (vs*(60 - a)) div d;
    case hh of
    0: begin aR := zV; aG :=  t ; aB :=  p; end;
    1: begin aR :=  q; aG := zV ; aB :=  p; end;
    2: begin aR :=  p; aG := zV ; aB :=  t; end;
    3: begin aR :=  p; aG :=  q ; aB := zV; end;
    4: begin aR :=  t; aG :=  p ; aB := zV; end;
    5: begin aR := zV; aG :=  p ; aB :=  q; end;
    else begin aR := 0; aG := 0 ; aB := 0; end;
    end;  // case
  end;
end;


procedure TForm2.FormShow(Sender: TObject);
var
  i : integer;
  colo : Tcolor;
  R,G,B : integer;
begin
  for i := 1 to image1.width do 
  begin
    HSVtoRGB(i, 255, 255, R, G, B);
    colo := RGB(R,G,B);
    with image1.canvas do
    begin
      pen.color := colo;
      moveto(i,0);
      lineto(i, image1.height);
    end;
  end; 
end;

procedure TForm2.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  panel2.color := image1.canvas.pixels[X,Y];
  Form1.colorizer(panel1.color);
end;

procedure TForm2.Button1Click(Sender: TObject);
begin
Close;
end;

end.
