unit ufTimerDialog;

{$mode delphi}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls, Types;

type

  { TfTimerDialog }

  TfTimerDialog = class(TForm)
    eInputText: TEdit;
    stDescription: TStaticText;
    tmr: TTimer;
  private
    ADescription: string;
    AInputText: string;
    MsgDlgBtns: array of TMsgDlgBtn;
    WindowSize: TSize;
    procedure Build;
  public
    class function Execute(AOwner: TComponent; const ACaption, ADescription: string; var AInputText: string;
      MsgDlgBtn: array of TMsgDlgBtn; WindowSize: TSize): TModalResult;
  end;

implementation

{$R *.lfm}

{ TfTimerDialog }

class function TfTimerDialog.Execute(AOwner: TComponent; const ACaption, ADescription: string;
  var AInputText: string; MsgDlgBtn: array of TMsgDlgBtn; WindowSize: TSize): TModalResult;
var
  F: TfTimerDialog;
begin

  F := TfTimerDialog.Create(AOwner);
  try
    F.Caption := ACaption;
    F.ADescription := ADescription;
    F.AInputText := AInputText;
    F.MsgDlgBtns := MsgDlgBtn;
    F.WindowSize := WindowSize;
    Result := F.ShowModal();
  finally
    F.Free;
  end;
end;

procedure TfTimerDialog.Build);
var
  i: TMsgDlgBtn;
begin
  BoundsRect := Rect(
    (Screen.Width - WindowSize.cx) div 2,
    (Screen.Height - WindowSize.cy) div 2,
    (Screen.Width + WindowSize.cx) div 2,
    (Screen.Height + WindowSize.cy) div 2);

  for i := Low(MsgDlgBtns) to High(MsgDlgBtns) do
  begin
    BuildButton()...
  end;


end;

end.

