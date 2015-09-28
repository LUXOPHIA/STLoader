unit Core;

interface //#################################################################### Å°

uses System.RTLConsts, System.Math.Vectors,
     FMX.Types3D;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TTriPoly

     TTriPoly = packed record
       Normal :TPoint3D;
       Point1 :TPoint3D;
       Point2 :TPoint3D;
       Point3 :TPoint3D;
       TEMP   :Word;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% HModel3D

     HMeshData = class helper for TMeshData
     private
     protected
     public
       function LoadFromBinSTL( const FileName_:String ) :String;
     end;

implementation //############################################################### Å°

uses System.Classes, System.SysUtils, System.Types;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% HModel3D

function HMeshData.LoadFromBinSTL( const FileName_:String ) :String;
var
   FS :TFileStream;
   Cs :array [ 0..80-1 ] of AnsiChar;
   N, I, I0, I1, I2 :Integer;
   Ts :array of TTriPoly;
begin
     with Self do
     begin
          try
             FS := TFileStream.Create( FileName_, fmOpenRead );

             FS.ReadBuffer( Cs[0], SizeOf( Cs ) );

             Result := Cs;

             FS.ReadBufferData( N );

             SetLength( Ts, N );

             FS.ReadBuffer( Ts[0], N * SizeOf( TTriPoly ) );

          finally
                 FS.Free;
          end;

          with VertexBuffer do
          begin
               Length := 3 * N;

               I0 := 0;  I1 := 1;  I2 := 2;
               for I := 0 to N - 1 do
               begin
                    with Ts[ I ] do
                    begin
                         Vertices[ I0 ] := Point3;
                         Vertices[ I1 ] := Point2;
                         Vertices[ I2 ] := Point1;

                         Normals[ I0 ] := Normal;
                         Normals[ I1 ] := Normal;
                         Normals[ I2 ] := Normal;

                         TexCoord0[ I0 ] := TPointF.Create( 0, 0 );
                         TexCoord0[ I1 ] := TPointF.Create( 1, 0 );
                         TexCoord0[ I2 ] := TPointF.Create( 0, 1 );
                    end;

                    Inc( I0, 3 );  Inc( I1, 3 );  Inc( I2, 3 );
               end;
          end;

          with IndexBuffer do
          begin
               Length := 3 * N;

               I0 := 0;  I1 := 1;  I2 := 2;
               for I := 0 to N - 1 do
               begin
                    Indices[ I0 ] := I0;
                    Indices[ I1 ] := I1;
                    Indices[ I2 ] := I2;

                    Inc( I0, 3 );  Inc( I1, 3 );  Inc( I2, 3 );
               end;
          end;
     end;
end;

end. //######################################################################### Å°
