unit uAccountDetails;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  Buttons,
  uDataModul;

type

  { TfrmAccountDetails }

  TfrmAccountDetails = class(TForm)
    edtAccountAddress: TEdit;
    edtAccountRegion: TEdit;
    edtAccountID: TEdit;
    edtAccountPostalCode: TEdit;
    edtAccountCompanyName: TEdit;
    edtAccountCity: TEdit;
    edtAccountCountry: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Shape1: TShape;
    spdBtnAccountSave: TSpeedButton;
    SpeedButton2: TSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure spdBtnAccountSaveClick(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
  private

  public

  end;

var
  frmAccountDetails: TfrmAccountDetails;

implementation

{$R *.lfm}

{ TfrmAccountDetails }

procedure TfrmAccountDetails.FormShow(Sender: TObject);
var
  aID : String;
begin
  aID := Self.Hint;
  if Self.Caption = 'Account Details - Add' then
  begin
    edtAccountID.Color := clDefault;
    edtAccountID.Clear;
    edtAccountCompanyName.Clear;
    edtAccountAddress.Clear;
    edtAccountPostalcode.Clear;
    edtAccountCity.Clear;
    edtAccountRegion.Clear;
    edtAccountCountry.Clear;
  end
  else if Self.Caption = 'Account Details - Update' then
  begin
    with DM.qrySelectAccountDetails do
    begin
      active := false;
      sql.Clear;
      sql.Text := 'SELECT * from Customer WHERE id = "' + aID+'"';
//      ShowMessage(sql.Text);
      active := true;
    end;
    edtAccountID.Color := $00B9FFFF;
    edtAccountID.Text := DM.qrySelectAccountDetails.FieldByName('id').AsString;
    edtAccountCompanyName.Text := DM.qrySelectAccountDetails.FieldByName('companyname').AsString;
    edtAccountAddress.Text := DM.qrySelectAccountDetails.FieldByName('address').AsString;
    edtAccountPostalcode.Text := DM.qrySelectAccountDetails.FieldByName('postalcode').AsString;
    edtAccountCity.Text := DM.qrySelectAccountDetails.FieldByName('city').AsString;
    edtAccountRegion.Text := DM.qrySelectAccountDetails.FieldByName('region').AsString;
    edtAccountCountry.Text := DM.qrySelectAccountDetails.FieldByName('country').AsString;
  end;
end;

procedure TfrmAccountDetails.spdBtnAccountSaveClick(Sender: TObject);
begin
  if Self.Caption = 'Account Details - Add' then
  begin
    if (edtAccountCompanyName.Text <> '') and (edtAccountID.Text <> '') then
    begin
      with DM.qryAccountInsert do
      begin
        Active := false;
        SQL.clear;
        SQL.Text := 'INSERT INTO Customer (ID, CompanyName, Address, PostalCode, City, Region, Country) '+
                    ' VALUES('+quotedStr(edtAccountID.Text)+','+
                               quotedStr(edtAccountCompanyName.Text)+','+
                               quotedStr(edtAccountAddress.Text)+','+
                               quotedStr(edtAccountPostalCode.Text)+','+
                               quotedStr(edtAccountCity.Text)+','+
                               quotedStr(edtAccountRegion.Text)+','+
                               quotedStr(edtAccountCountry.Text) +')';
//        ShowMessage(SQL.Text);
        ExecSQL;
        DM.SQLTransaction1.Commit;
      end;
//      ShowMessage('New record successfully added');
      close;
    end
    else
    begin
      ShowMessage('Unable to add new record. Company Name is empty!');
    end;
  end
  else if Self.Caption = 'Account Details - Update' then
  begin
    if (edtAccountCompanyName.Text <> '') and (edtAccountID.Text <> '') then
    begin
      with DM.qryAccountUpdate do
      begin
        Active := false;
        SQL.clear;
        SQL.Text := 'UPDATE Customer Set '+
                            ' CompanyName = ' + quotedStr(edtAccountCompanyName.Text) + ', '+
                            ' Address     = ' + quotedStr(edtAccountAddress.Text)+', '+
                            ' PostalCode  = ' + quotedStr(edtAccountPostalCode.Text)+', '+
                            ' City        = ' + quotedStr(edtAccountCity.Text)+', '+
                            ' Region      = ' + quotedStr(edtAccountRegion.Text)+', '+
                            ' Country     = ' + quotedStr(edtAccountCountry.Text) +
                            ' WHERE Id = '+quotedStr(edtAccountID.Text);
//        ShowMessage(SQL.Text);
        ExecSQL;
        DM.SQLTransaction1.Commit;
      end;
//      ShowMessage('New record successfully added');
      close;
    end
    else
    begin
      ShowMessage('Unable to update record. Company Name is empty!');
    end;
  end;
end;

procedure TfrmAccountDetails.SpeedButton2Click(Sender: TObject);
begin
  close;
end;

end.

