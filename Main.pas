unit Main;

interface  //################################################################### Å°

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Types3D,
  FMX.Objects3D, FMX.Controls3D, FMX.Viewport3D,
  System.Math.Vectors,
  FMX.MaterialSources,
  Core;

type
  TForm1 = class(TForm)
    Viewport3D1: TViewport3D;
    Light1: TLight;
    Dummy1: TDummy;
    Dummy2: TDummy;
    Camera1: TCamera;
    Mesh1: TMesh;
    LightMaterialSource1: TLightMaterialSource;
    Grid3D1: TGrid3D;
    procedure FormCreate(Sender: TObject);
    procedure Viewport3D1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure Viewport3D1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single);
    procedure Viewport3D1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
  private
    { private êÈåæ }
    _MouseS :TShiftState;
    _MouseP :TPointF;
  public
    { public êÈåæ }
  end;

var
  Form1: TForm1;

implementation //############################################################### Å°

{$R *.fmx}

procedure TForm1.FormCreate(Sender: TObject);
begin
     _MouseS := [];

     Mesh1.Data.LoadFromBinSTL( '..\..\_DATA\cube-binary.stl' );

     Mesh1.Data.CalcFaceNormals;
end;

////////////////////////////////////////////////////////////////////////////////

procedure TForm1.Viewport3D1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
     _MouseS := Shift;
     _MouseP := TPointF.Create( X, Y );
end;

procedure TForm1.Viewport3D1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single);
var
   P :TPointF;
begin
     if ssLeft in _MouseS then
     begin
          P := TPointF.Create( X, Y );

          with Dummy1.RotationAngle do Y := Y + ( P.X - _MouseP.X );
          with Dummy2.RotationAngle do X := X - ( P.Y - _MouseP.Y );

          _MouseP := P;
     end;
end;

procedure TForm1.Viewport3D1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
     Viewport3D1MouseMove( Sender, Shift, X, Y );

     _MouseS := [];
end;

end. //######################################################################### Å°
