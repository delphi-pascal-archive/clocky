unit uMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, pngimage, ExtCtrls, Menus;

type
  TForm1 = class(TForm)
    Timer1: TTimer;
    PopupMenu1: TPopupMenu;
    Changecolortheme1: TMenuItem;
    N1: TMenuItem;
    About1: TMenuItem;
    Exit1: TMenuItem;
    Procedure BmpColorize(R0,G0,B0 : integer);
    procedure colorizer(acolor : tcolor);
    function draw(handle: HWND) : boolean;

    procedure FormCreate(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Timer1Timer(Sender: TObject);
    procedure Changecolortheme1Click(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

type

  TRGBArray = ARRAY[0..0] OF TRGBTriple;
  pRGBArray = ^TRGBArray;

  AlphaRGB = packed record
    B: Byte;
    G: Byte;
    R: Byte;
    A: Byte;
  end;
  pARGB = ^TARGB;
  TARGB = array [WORD] of AlphaRGB;

var
  Form1: TForm1;
  (**)
  bmp     : tbitmap;
  clock   : TPNGObject;
  clock_c : TPNGObject;
  clock_r : TPNGObject;
  plist   : array [0..28] of TPNGObject;

implementation

uses DateUtils, uColorThm;

Procedure Tform1.BmpColorize(R0,G0,B0 : integer);
var
  x, y : integer;
  Rowa : Prgbarray;
  Rowb : Prgbarray;
  R,G,B : integer;
  H0       : integer;
  H,S,V    : integer;
begin
  For y := 0 to clock_c.height-1 do
  begin
    rowa := clock.Scanline[y];
    rowb := clock_c.Scanline[y];
    for x := 0 to clock_c.width-1 do
    begin
      R := rowa[x].RgbtRed + R0;
      G := rowa[x].Rgbtgreen + G0;
      B := rowa[x].Rgbtblue + B0;

      if R > 255 then R := 255 else if R < 0 then R := 0;
      if G > 255 then G := 255 else if G < 0 then G := 0;
      if B > 255 then B := 255 else if B < 0 then B := 0;

      rowb[x].Rgbtred   := R;
      rowb[x].Rgbtgreen := G;
      rowb[x].Rgbtblue  := B;
    end;
  end;
end;

procedure Tform1.colorizer(acolor : tcolor);
var
  R0,G0,B0 : integer;
begin
  clock_c.Assign(clock_r);
  R0 := GetRValue((acolor)) div 3;
  G0 := GetGValue((acolor)) div 3;
  B0 := GetBValue((acolor)) div 3;
  BmpColorize(R0,G0,B0);
  clock.assign(clock_c);
end;
(******************************************************************************)
procedure LoadFromPNGFileForBG(png: TPNGObject);
var
 i,j:integer;
 pA: pARGB;
 pB: pByteArray;
begin
 bmp.PixelFormat:=pf32bit;
 bmp.Width:=PNG.Width;
 bmp.Height:=PNG.Height;  
 BitBlt(bmp.Canvas.Handle,0,0,bmp.Width,bmp.Height,PNG.Canvas.Handle,0,0,SRCCOPY);
  for i := 0 to png.Height - 1 do
   begin
    pA := bmp.Scanline[i];
    pB := PNG.AlphaScanline[i];
    for j := 0 to png.Width - 1 do
     begin
      pA[j].A := pB[j];
      pA[j].B := (pA[j].B * pB[j]) shr 8;
      pA[j].G := (pA[j].G * pB[j]) shr 8;
      pA[j].R := (pA[j].R * pB[j]) shr 8;
     end;
   end;

end;

function tform1.draw(handle: HWND) : boolean;
var
 BF:TBlendFunction;
 DC:HDC;
 bs:TSize;
 xySrc:TPoint;
 xy:TPoint;
 str: string;
 i:integer;
begin
 xy.x := 0;
 xy.y := 0;
 
 Result:=false;

 bmp.FreeImage;

 clock.Assign(clock_r);
 (*time*)
 str := FormatDateTime('hh:mm:ss',now);
 for i := 1 to length(str) do
 begin
  case str[i] of
    ':' : clock.Canvas.Draw((i*8)+40,22,plist[11]);
    '.' : clock.Canvas.Draw((i*8)+40,22,plist[10]);
    ' ' : ;
    else clock.Canvas.Draw((i*8)+40,22,plist[strtoint(str[i])]);
  end;
 end;
 (*date*)
 str := FormatDateTime('mm.dd.yyyy',now);
 for i := 1 to length(str) do
 begin
  case str[i] of
    ':' : clock.Canvas.Draw((i*8)+33,37,plist[11]);
    '.' : clock.Canvas.Draw((i*8)+33,37,plist[10]);
    ' ' : ;
    else clock.Canvas.Draw((i*8)+33,37,plist[strtoint(str[i])]);
  end;
 end;

 (*day*)
 case DayOfTheWeek(now) of
    1 : clock.Canvas.Draw(60,112,plist[12]);
    2 : clock.Canvas.Draw(60,112,plist[13]);
    3 : clock.Canvas.Draw(60,112,plist[14]);
    4 : clock.Canvas.Draw(60,112,plist[15]);
    5 : clock.Canvas.Draw(60,112,plist[16]);
    6 : clock.Canvas.Draw(60,112,plist[17]);
    7 : clock.Canvas.Draw(60,112,plist[18]);
 end;

 str := FormatDateTime('dd',now);
 for i := 1 to length(str) do
 begin
  case str[i] of
    '0' : clock.Canvas.Draw((i*28)+18,51,plist[19]);
    '1' : clock.Canvas.Draw((i*28)+18,51,plist[20]);
    '2' : clock.Canvas.Draw((i*28)+18,51,plist[21]);
    '3' : clock.Canvas.Draw((i*28)+18,51,plist[22]);
    '4' : clock.Canvas.Draw((i*28)+18,51,plist[23]);
    '5' : clock.Canvas.Draw((i*28)+18,51,plist[24]);
    '6' : clock.Canvas.Draw((i*28)+18,51,plist[25]);
    '7' : clock.Canvas.Draw((i*28)+18,51,plist[26]);
    '8' : clock.Canvas.Draw((i*28)+18,51,plist[27]);
    '9' : clock.Canvas.Draw((i*28)+18,51,plist[28]);
  end;
 end;

 (*end*)
 if form2.Panel2.Color <> clBtnFace then
 form1.colorizer(form2.Panel2.Color);

 LoadFromPNGFileForBG(clock);

 with BF do
  begin
   BlendOp := AC_SRC_OVER;
   BlendFlags := 0;
   SourceConstantAlpha := 255;
   AlphaFormat := AC_SRC_ALPHA;
  end;

 DC:=GetDC(0);

 bs.cx:=bmp.Width;
 bs.cy:=bmp.Height;
 xySrc.X:=0;
 xySrc.Y:=0;
 
 SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_LAYERED);
 Result := UpdateLayeredWindow(Handle,0,nil,@bs,bmp.Canvas.Handle,
  @xySrc,clNone,@BF,ULW_ALPHA);
 ReleaseDC(0,DC);
end;

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
var
i: integer;
begin
  for i := 0 to 28 do begin
    plist[i] := TPNGObject.Create;

    case i of
      12 : plist[i].LoadFromFile('skin\mon.png');
      13 : plist[i].LoadFromFile('skin\tue.png');
      14 : plist[i].LoadFromFile('skin\wed.png');
      15 : plist[i].LoadFromFile('skin\thur.png');
      16 : plist[i].LoadFromFile('skin\fri.png');
      17 : plist[i].LoadFromFile('skin\sat.png');
      18 : plist[i].LoadFromFile('skin\sun.png');

      19 : plist[i].LoadFromFile('skin\00.png');
      20 : plist[i].LoadFromFile('skin\01.png');
      21 : plist[i].LoadFromFile('skin\02.png');
      22 : plist[i].LoadFromFile('skin\03.png');
      23 : plist[i].LoadFromFile('skin\04.png');
      24 : plist[i].LoadFromFile('skin\05.png');
      25 : plist[i].LoadFromFile('skin\06.png');
      26 : plist[i].LoadFromFile('skin\07.png');
      27 : plist[i].LoadFromFile('skin\08.png');
      28 : plist[i].LoadFromFile('skin\09.png');

      else
        if i = 10 then
          plist[i].LoadFromFile('skin\dot.png')
        else
          if i = 11 then
            plist[i].LoadFromFile('skin\dots.png')
          else
            plist[i].LoadFromFile('skin\'+inttostr(i)+'.png');
    end;
  end;

  clock := TPNGObject.Create;
  clock_c := TPNGObject.Create;
  clock_r := TPNGObject.Create;
  clock.LoadFromFile('skin\clock.png');
  clock_r.LoadFromFile('skin\clock.png');
  bmp  := TBitmap.Create;
  //draw(form1.Handle);
end;

procedure TForm1.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
  const SC_DragMove = $F012;
begin
  ReleaseCapture;
  Form1.perform(WM_SysCommand, SC_DragMove, 0);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
draw(form1.Handle);
end;

procedure TForm1.Changecolortheme1Click(Sender: TObject);
begin
Form2.showmodal;
end;

procedure TForm1.About1Click(Sender: TObject);
begin
showmessage('Author: BlackCash');
end;

procedure TForm1.Exit1Click(Sender: TObject);
begin
Close;
end;

end.
