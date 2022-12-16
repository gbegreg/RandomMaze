unit uMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Layouts, FMX.Viewport3D, FMX.Edit, FMX.EditBox,
  FMX.NumberBox, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, uLabyrinthe,
  System.Math.Vectors, FMX.Controls3D, FMX.Objects3D, FMX.MaterialSources,
  FMX.Ani, FMX.Types3D;

type
  TForm7 = class(TForm)
    Layout1: TLayout;
    Rectangle1: TRectangle;
    lblNbCol: TLabel;
    Layout2: TLayout;
    NumberBox1: TNumberBox;
    Layout3: TLayout;
    Label1: TLabel;
    NumberBox2: TNumberBox;
    Layout4: TLayout;
    Label2: TLabel;
    NumberBox3: TNumberBox;
    Button1: TButton;
    CheckBox1: TCheckBox;
    Label3: TLabel;
    Plane1: TPlane;
    FloatAnimation1: TFloatAnimation;
    Dummy1: TDummy;
    Viewport3D1: TViewport3D;
    LightMaterialSource1: TLightMaterialSource;
    Light1: TLight;
    LightMaterialSource2: TLightMaterialSource;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    Dummy2: TDummy;
    FloatAnimation2: TFloatAnimation;
    procedure Button1Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox2Change(Sender: TObject);
    procedure CheckBox3Change(Sender: TObject);
  private
    procedure creerMurs(posX, posY: integer);
    { Déclarations privées }
  public
    { Déclarations publiques }
    niveau : TLabyrinthe;
  end;

var
  Form7: TForm7;

implementation
{$R *.fmx}

procedure TForm7.Button1Click(Sender: TObject);
begin
  randomize;
  plane1.Parent := Viewport3D1;
  FloatAnimation1.Parent := Viewport3D1;
  dummy1.DeleteChildren;
  plane1.Parent := dummy1;
  FloatAnimation1.Parent := dummy1;
  if assigned(niveau) then niveau.Destroy;
  niveau := TLabyrinthe.Create(Round(NumberBox1.value), Round(NumberBox2.value));
  niveau.niveauOuverture := Round(numberBox3.Value);
  niveau.genererLabyrinthe(CheckBox2.IsChecked);
  Plane1.SubdivisionsWidth := 5;
  Plane1.SubdivisionsHeight := 5;
  Plane1.Width := Round(NumberBox1.Value);
  Plane1.Height := Round(NumberBox2.Value);
  for var i := 0 to niveau.tailleX -1 do begin
    for var j := 0 to niveau.tailleY -1 do begin
      case niveau.matrice[i,j] of
        -1: creerMurs(i, j); // Générer un mur
      end;
    end;
  end;
end;

procedure TForm7.CheckBox1Click(Sender: TObject);
begin
  FloatAnimation1.Inverse := CheckBox1.IsChecked;
  FloatAnimation1.Start;
end;

procedure TForm7.CheckBox2Change(Sender: TObject);
begin
  layout4.Enabled := CheckBox2.IsChecked;
end;

procedure TForm7.CheckBox3Change(Sender: TObject);
begin
  floatanimation2.enabled := checkbox3.IsChecked;
end;

procedure TForm7.creerMurs(posX, posY : integer);
begin
  var unCube := TCube.Create(nil);
  unCube.Parent := Dummy1;
  unCube.Name := 'cube' + Plane1.ChildrenCount.ToString;
  unCube.Position.Y := 0;
  unCube.Width := 1;
  unCube.Height := 1;
  unCube.Depth := 1;
  unCube.Position.X := posX - niveau.tailleX * 0.5;
  unCube.Position.Y := posY - niveau.tailleY * 0.5;
  unCube.Position.Z := - 0.5;
  unCube.TwoSide := true;
  unCube.SubdivisionsDepth := 3;
  unCube.SubdivisionsHeight := 3;
  unCube.SubdivisionsWidth := 3;
  unCube.MaterialSource := LightMaterialSource2;
end;

end.
