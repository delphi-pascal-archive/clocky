program ClockyDBG;

uses
  Forms,
  uMain in 'uMain.pas' {Form1},
  uColorThm in 'uColorThm.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);

  form1.draw(form1.Handle);

  Application.Run;
end.
