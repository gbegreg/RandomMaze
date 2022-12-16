program Labyrinthe;

uses
  System.StartUpCopy,
  FMX.Forms,
  uMain in 'uMain.pas' {Form7},
  uLabyrinthe in 'uLabyrinthe.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm7, Form7);
  Application.Run;
end.
