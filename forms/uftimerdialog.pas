unit ufTimerDialog;

{$mode delphi}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  ButtonPanel, Types;

type

  { TfTimerDialog }

  TfTimerDialog = class(TForm)
    lblDescription: TLabel;
    pb: TButtonPanel;
    eInputText: TEdit;
    tmr: TTimer;
    procedure CancelButtonClick(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
    procedure tmrTimer(Sender: TObject);
  private
    RemainSecs: Integer;
    TimerInterval: Integer;
    InputText: string;
    NativeCaption: string;
  public
    class function Execute(AOwner: TComponent; const ACaption,
      ADescription: string; var AInputText: string; Buttons: TPanelButtons;
  TimerInterval: Integer=-1): TModalResult;
  end;

implementation

{$R *.lfm}

{ TfTimerDialog }

class function TfTimerDialog.Execute(AOwner: TComponent; const ACaption, ADescription: string;
  var AInputText: string; Buttons: TPanelButtons; TimerInterval: Integer = -1): TModalResult;
var
  F: TfTimerDialog;
begin

  F := TfTimerDialog.Create(AOwner);
  try
    F.Caption := ACaption;
    F.NativeCaption := ACaption;
    F.InputText := AInputText;
    F.eInputText.Text := AInputText;
    F.lblDescription.Caption := ADescription;
    F.pb.ShowButtons := Buttons;
    if TimerInterval > 0 then
    begin
      F.RemainSecs := TimerInterval;
      F.TimerInterval := TimerInterval;
      F.tmr.Enabled := True;
    end;

    Result := F.ShowModal();
    if Result = mrOK then
      AInputText := F.eInputText.Text;
  finally
    F.Free;
  end;
end;

procedure TfTimerDialog.OKButtonClick(Sender: TObject);
begin
  ModalResult := mrOK;
end;

procedure TfTimerDialog.tmrTimer(Sender: TObject);
begin
  tmr.Enabled := False;
  Dec(RemainSecs);
  Caption := Format('%s / Remain %d sec ', [NativeCaption, RemainSecs]);
  if RemainSecs < 0 then
    pb.CloseButton.Click()
  else
    tmr.Enabled := True;
end;

procedure TfTimerDialog.CloseButtonClick(Sender: TObject);
begin
  ModalResult := mrClose;
end;

procedure TfTimerDialog.FormCreate(Sender: TObject);
begin
  RemainSecs := -1;
end;

procedure TfTimerDialog.CancelButtonClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

end.

