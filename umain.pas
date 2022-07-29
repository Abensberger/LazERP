unit umain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Buttons,
  StdCtrls, ComCtrls, XMLPropStorage, DBGrids, BCRoundedImage,
  ukachel,
  uDatamodul,
  uAccountDetails,
  DB;

const
  MenuWidthMin   = 50;
  MenuWidthMax   = 160;
  IndicatorWidth = 5;

  sapico_disconnected = $E20C;
  sapico_connected    = $E20B;

type

  { TfrmERPPrototyp }

  TfrmERPPrototyp = class(TForm)
    BCRoundedImage1: TBCRoundedImage;
    BCRoundedImage2: TBCRoundedImage;
    BCRoundedImage3: TBCRoundedImage;
    BCRoundedImage4: TBCRoundedImage;
    BCRoundedImage5: TBCRoundedImage;
    BCRoundedImage6: TBCRoundedImage;
    BCRoundedImage7: TBCRoundedImage;
    BCRoundedImage8: TBCRoundedImage;
    BCRoundedImage9: TBCRoundedImage;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    edtAcctSearchBox: TEdit;
    FlowPanel1: TFlowPanel;
    ImageList1: TImageList;
    ImageList2: TImageList;
    ImageListMenu: TImageList;
    ImageList_white: TImageList;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label2: TLabel;
    lblConnection: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Notebook1: TNotebook;
    Panel4: TPanel;
    pnlAccountDetails: TPanel;
    pnlAccountSearchBox: TPanel;
    pgAccounts: TPage;
    pgLeads: TPage;
    pgSales: TPage;
    pgMarketing: TPage;
    pgCalendar: TPage;
    pgUsers: TPage;
    pgSettings: TPage;
    pgHelp: TPage;
    pgDashboard: TPage;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    pnlIndicator: TPanel;
    pnlClient: TPanel;
    pnlMenu: TPanel;
    spdbtnAcctExport: TSpeedButton;
    spdbtnAcctUpdate: TSpeedButton;
    SpeedButton1: TSpeedButton;
    SpeedButton10: TSpeedButton;
    SpeedButton11: TSpeedButton;
    SpeedButton12: TSpeedButton;
    spbtnAcctSearchBox: TSpeedButton;
    spdbtnAcctCreate: TSpeedButton;
    spdbtnAcctRemove: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    SpeedButton8: TSpeedButton;
    SpeedButton9: TSpeedButton;
    StatusBar1: TStatusBar;
    XMLPropStorage1: TXMLPropStorage;
    procedure DBGrid1DblClick(Sender: TObject);
    procedure edtAcctSearchBoxExit(Sender: TObject);
    procedure edtAcctSearchBoxKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtAcctSearchBoxMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure MenuButtonClick(Sender: TObject);
    procedure Notebook1Resize(Sender: TObject);
    procedure Panel2Click(Sender: TObject);
    procedure pgAccountsBeforeShow(ASender: TObject; ANewPage: TPage;
      ANewIndex: Integer);
    procedure pgCalendarBeforeShow(ASender: TObject; ANewPage: TPage;
      ANewIndex: Integer);
    procedure pgDashboardBeforeShow(ASender: TObject; ANewPage: TPage;
      ANewIndex: Integer);
    procedure pgUsersBeforeShow(ASender: TObject; ANewPage: TPage;
      ANewIndex: Integer);
    procedure pnlMenuClick(Sender: TObject);
    procedure ProfileButtonClick(Sender: TObject);
    procedure spbtnAcctSearchBoxClick(Sender: TObject);
    procedure spdbtnAcctCreateClick(Sender: TObject);
    procedure spdbtnAcctRemoveClick(Sender: TObject);
    procedure spdbtnAcctUpdateClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    bExpandedMenu : Boolean;
    NewLeads : TfrKachel;
    ActiveLeads : TfrKachel;
    ProposalLeads : TfrKachel;
    ClosedLeads : TfrKachel;
    InactiveLeads : TfrKachel;
    TotalLeads : TfrKachel;
    procedure ShowIndicator(aObject : TObject);
    procedure ExecuteMenuSelection(aObject : TObject);
    procedure RefreshGrid;
    procedure ResizePanel(aPanel : TPanel; bToggle :Boolean);
  public

  end;

var
  frmERPPrototyp: TfrmERPPrototyp;

implementation

{$R *.lfm}

{ TfrmERPPrototyp }

procedure TfrmERPPrototyp.FormCreate(Sender: TObject);
begin
  bExpandedMenu := False;
  pnlMenu.Width := MenuWidthMin;
  pnlIndicator.Width := IndicatorWidth;
  pnlIndicator.Visible := True;
  pnlIndicator.Color := Panel2.Color;

  NewLeads := TfrKachel.Create(Self);
  NewLeads.Label1.Caption := 'New';
  NewLeads.Label3.Caption := IntToStr(Random(39));
  NewLeads.Name := 'NewLeads';
  NewLeads.BCRoundedImage1.Picture.LoadFromFile('media\48x48_blue\newLead.Png');
  NewLeads.Parent := FlowPanel1 ;

  ActiveLeads := TfrKachel.Create(Self);
  ActiveLeads.Label1.Caption := 'Active';
  ActiveLeads.Label3.Caption := IntToStr(Random(39));
  ActiveLeads.Name := 'ActiveLeads';
  ActiveLeads.Parent := FlowPanel1 ;

  ProposalLeads := TfrKachel.Create(Self);
  ProposalLeads.Label1.Caption := 'Proposal Sent';
  ProposalLeads.Label3.Caption := IntToStr(Random(39));
  ProposalLeads.Name := 'ProposalLeads';
  ProposalLeads.BCRoundedImage1.Picture.LoadFromFile('media\48x48_blue\ProposalSent.Png');
  ProposalLeads.Parent := FlowPanel1 ;

  ClosedLeads := TfrKachel.Create(Self);
  ClosedLeads.Label1.Caption := 'Closed';
  ClosedLeads.Label3.Caption := IntToStr(Random(39));
  ClosedLeads.Name := 'ClosedLeads';
  ClosedLeads.BCRoundedImage1.Picture.LoadFromFile('media\48x48_blue\Closed.Png');
  ClosedLeads.Parent := FlowPanel1 ;

  InactiveLeads := TfrKachel.Create(Self);
  InactiveLeads.Label1.Caption := 'Inactive';
  InactiveLeads.Label3.Caption := IntToStr(Random(39));
  InactiveLeads.Name := 'InactiveLeads';
  InactiveLeads.Panel1.Color := clRed;
  InactiveLeads.Parent := FlowPanel1 ;

  TotalLeads := TfrKachel.Create(Self);
  TotalLeads.Label1.Caption := 'Total';
  TotalLeads.Label3.Caption := IntToStr(StrToInt(NewLeads.Label3.Caption)+
                                        StrToInt(ActiveLeads.Label3.Caption)+
                                        StrToInt(ProposalLeads.Label3.Caption)+
                                        StrToInt(ClosedLeads.Label3.Caption)+
                                        StrToInt(InactiveLeads.Label3.Caption));
  TotalLeads.Name := 'TotalLeads';
  TotalLeads.Parent := FlowPanel1 ;

  DM := TDM.Create(Self);
  if DM.SQLite3Connection1.Connected then
     lblConnection.Caption := WideChar(sapico_connected);

  pnlAccountDetails.Width := 0;
end;

procedure TfrmERPPrototyp.FormResize(Sender: TObject);
begin
  Statusbar1.SimpleText:= Format('W:%d x H:%d',[Self.Width,Self.Height]);
end;

procedure TfrmERPPrototyp.edtAcctSearchBoxMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  edtAcctSearchBox.TextHint := '';
end;

procedure TfrmERPPrototyp.edtAcctSearchBoxExit(Sender: TObject);
begin
  edtAcctSearchBox.TextHint := 'Suchbegriff';
end;

procedure TfrmERPPrototyp.DBGrid1DblClick(Sender: TObject);
begin
//  ResizePanel(pnlAccountDetails, True);
end;

procedure TfrmERPPrototyp.edtAcctSearchBoxKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = 13 then
     RefreshGrid;
end;

procedure TfrmERPPrototyp.FormShow(Sender: TObject);
begin
  MenuButtonClick(SpeedButton11);
end;

procedure TfrmERPPrototyp.MenuButtonClick(Sender: TObject);
begin
  ShowIndicator(Sender);
  ExecuteMenuSelection(Sender);
end;

procedure TfrmERPPrototyp.Notebook1Resize(Sender: TObject);
begin
  ResizePanel(pnlAccountDetails,False);
end;

procedure TfrmERPPrototyp.Panel2Click(Sender: TObject);
begin

end;

procedure TfrmERPPrototyp.pgAccountsBeforeShow(ASender: TObject;
  ANewPage: TPage; ANewIndex: Integer);
begin
  DataSource1.DataSet := DM.SQLQuery1;
  RefreshGrid;

  //with DBGrid1 do
  //begin
  //  DBGrid1.AutoAdjustColumns;
  //end;
end;

procedure TfrmERPPrototyp.pgCalendarBeforeShow(ASender: TObject; ANewPage: TPage;
  ANewIndex: Integer);
begin

end;

procedure TfrmERPPrototyp.pgDashboardBeforeShow(ASender: TObject; ANewPage: TPage;
  ANewIndex: Integer);
begin

end;

procedure TfrmERPPrototyp.pgUsersBeforeShow(ASender: TObject; ANewPage: TPage;
  ANewIndex: Integer);
begin

end;

procedure TfrmERPPrototyp.pnlMenuClick(Sender: TObject);
begin

end;

procedure TfrmERPPrototyp.ProfileButtonClick(Sender: TObject);
begin
  ExecuteMenuSelection(Sender);
end;

procedure TfrmERPPrototyp.spbtnAcctSearchBoxClick(Sender: TObject);
begin
  RefreshGrid;
end;

procedure TfrmERPPrototyp.spdbtnAcctCreateClick(Sender: TObject);
begin
  frmAccountDetails.Caption := 'Account Details - Add';
  frmAccountDetails.ShowModal;
  RefreshGrid;
end;

procedure TfrmERPPrototyp.spdbtnAcctRemoveClick(Sender: TObject);
begin
  if DM.SQLQuery1.FieldByName('id').AsString = '' then
  begin
    MessageDlg('No records selected!',mtInformation,[mbOK],0);
    exit;
  end;
  if MessageDlg('Are you sure you want to delete this record?',mtConfirmation, [mbYes, mbNo],0) = mrYes then
  begin
    with DM.QryAccountDelete do
    begin
      active := false;
      sql.clear;
      sql.Text := 'DELETE FROM Customer WHERE id = ' +quotedStr(DM.SQLQuery1.FieldByName('id').AsString);
      ExecSQL;
    end;
    RefreshGrid;
  end;


end;

procedure TfrmERPPrototyp.spdbtnAcctUpdateClick(Sender: TObject);
begin
  frmAccountDetails.Caption := 'Account Details - Update';
  frmAccountDetails.Hint    := DM.SQLQuery1.FieldByName('id').AsString;
  frmAccountDetails.ShowModal;
  RefreshGrid;
end;

procedure TfrmERPPrototyp.SpeedButton1Click(Sender: TObject);
begin
  if bExpandedMenu  then
     pnlMenu.Width := MenuWidthMin
  else
     pnlMenu.Width := MenuWidthMax;
  bExpandedMenu := not bExpandedMenu;
  pnlMenu.ShowHint := not bExpandedMenu;
end;

procedure TfrmERPPrototyp.ShowIndicator(aObject: TObject);
begin
//  pnlIndicator.Hide;
  pnlIndicator.SetBounds((aObject as TSpeedButton).Left,
                         (aObject as TSpeedButton).Top,
                          IndicatorWidth,
                         (aObject as TSpeedButton).Height - 1);
  pnlIndicator.AnchorParallel(akTop,0,(aObject as TSpeedButton));
//  (aObject as TSpeedButton).AnchorToNeighbour(akTop,0,pnlIndicator);
//  pnlIndicator.Show;
end;

procedure TfrmERPPrototyp.ExecuteMenuSelection(aObject: TObject);
begin
  if aObject is TSpeedButton then
  begin
     NoteBook1.PageIndex := TSpeedButton(aObject).Tag - 1;
     case TSpeedButton(aObject).Tag of
       99: close;
       else
       begin
         Statusbar1.SimpleText := 'Menu: '+IntToStr(TSpeedButton(aObject).Tag)+' selected';
       end;
     end;  // case
  end; // if
end;

procedure TfrmERPPrototyp.RefreshGrid;
begin
  with DM.SQLQuery1  do
  begin
    active := false;
    SQL.clear;
    SQL.Text := ' SELECT id, companyname, ContactName, phone, fax FROM CUSTOMER '+
                ' WHERE companyname LIKE '+ quotedStr('%' + edtAcctSearchBox.Text+'%')+ ' '+
                ' ORDER BY ID';
    active := true;
  end;
  DBGrid1.Columns[0].Width:= 100;;
  DBGrid1.Columns[0].SizePriority:= 0;
  DBGrid1.Columns[1].SizePriority:= 1;
  DBGrid1.AutoAdjustColumns;
end;

procedure TfrmERPPrototyp.ResizePanel(aPanel: TPanel; bToggle : Boolean);
begin

  with aPanel do
  begin
    if bToggle then
    begin
      if aPanel.Width = aPanel.Constraints.MinWidth then
         aPanel.Width := (TPanel(aPanel.Parent).Width * 2) div 5
      else
         aPanel.Width := aPanel.Constraints.MinWidth;
    end
    else
    begin
      if aPanel.Width <> 0 then
         aPanel.Width := (TPanel(aPanel.Parent).Width * 2) div 5
    end;

  end;
  frmAccountDetails.Parent := aPanel;
  frmAccountDetails.BorderStyle := bsNone;
  frmAccountDetails.Align := alClient;
  frmAccountDetails.Show;

end;

end.

