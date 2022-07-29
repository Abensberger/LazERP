unit uDatamodul;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, SQLite3Conn, SQLDB;

type

  { TDM }

  TDM = class(TDataModule)
    qryAccountDelete: TSQLQuery;
    qryAccountUpdate: TSQLQuery;
    SQLite3Connection1: TSQLite3Connection;
    SQLQuery1: TSQLQuery;
    qryAccountInsert: TSQLQuery;
    qrySelectAccountDetails: TSQLQuery;
    SQLQueryUsers: TSQLQuery;
    SQLTransaction1: TSQLTransaction;
    procedure DataModuleCreate(Sender: TObject);
  private

  public

  end;

var
  DM: TDM;

implementation

{$R *.lfm}

{ TDM }

procedure TDM.DataModuleCreate(Sender: TObject);
begin
  SQLite3Connection1.DatabaseName:='database\Northwind_large.sqlite';
  SQLTransaction1.Database:=SQLite3Connection1;
  SQLQuery1.Transaction:=SQLTransaction1;
  SQLQueryUsers.Transaction := SQLTransaction1;
  qryAccountInsert.Transaction := SQLTransaction1;
  qryAccountUpdate.Transaction := SQLTransaction1;
  qryAccountDelete.Transaction := SQLTransaction1;
  qrySelectAccountDetails.Transaction := SQLTransaction1;
  SQLite3Connection1.Open;
end;


end.

