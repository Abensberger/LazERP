program project1;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, umain, ukachel, uDatamodul, uAccountDetails
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TfrmERPPrototyp, frmERPPrototyp);
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TfrmAccountDetails, frmAccountDetails);
  Application.Run;
end.

