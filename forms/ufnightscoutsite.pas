unit ufNightscoutSite;

{$mode Delphi}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ButtonPanel, StdCtrls;

type

  { TfNightscoutSite }

  TfNightscoutSite = class(TForm)
    eNightscoutToken: TEdit;
    eNightscoutUrl: TEdit;
    Label1: TLabel;
    lblNightscoutUrl: TLabel;
    lblDescription1: TLabel;
    pb: TButtonPanel;
    procedure CancelButtonClick(Sender: TObject);
    procedure HelpButtonClick(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
  private

  public
    class function Execute(AOwner: TComponent; var NightscoutUrl: String; var NightscoutToken: String): TModalResult;
  end;


implementation

uses
  LCLIntf;

{$R *.lfm}

{ TfNightscoutSite }

class function TfNightscoutSite.Execute(AOwner: TComponent; var NightscoutUrl: String; var NightscoutToken: String): TModalResult;
var
  F: TfNightscoutSite;
begin
  F := TfNightscoutSite.Create(AOwner);
  try
    F.eNightscoutUrl.Text := NightscoutUrl;
    F.eNightscoutToken.Text := NightscoutToken;
    Result := F.ShowModal();
    if Result = mrOK then
    begin
      NightscoutUrl := F.eNightscoutUrl.Text;
      NightscoutToken := F.eNightscoutToken.Text;
    end;
  finally
    F.Free;
  end;
end;

procedure TfNightscoutSite.OKButtonClick(Sender: TObject);
begin
  ModalResult := mrOK;
end;

procedure TfNightscoutSite.CancelButtonClick(Sender: TObject);
begin
  ModalResult := mrClose;
end;

procedure TfNightscoutSite.HelpButtonClick(Sender: TObject);
begin
  OpenDocument('https://github.com/SergeyRock/nightscout-watcher#nightscout-site-permission');

end;



end.

