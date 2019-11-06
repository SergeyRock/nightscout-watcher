unit ufSettings;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

interface

uses
{$IFnDEF FPC}
  Windows,
{$ELSE}
  LCLIntf, LCLType,
{$ENDIF}
  uSettings, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin, ComCtrls, ExtCtrls;

type
  TOnUpdateCallerFormWithSettings = procedure of object;
  TOnTryLoadEntriesData = function: Boolean of object;

  { TfSettings }

  TfSettings = class(TForm)
    btnOK: TButton;
    btnCancel: TButton;
    cbDrawGlucoseLevelDelta: TCheckBox;
    cbEnableGlucoseLevelAlarms: TCheckBox;
    cbEnableStaleDataAlarms: TCheckBox;
    gbGlucoseLevelAlarms: TGroupBox;
    Image1: TImage;
    lblHighGlucoseAlarm: TLabel;
    Memo1: TMemo;
    pc: TPageControl;
    seHighGlucoseAlarm: TSpinEdit;
    lblLowGlucoseAlarm: TLabel;
    seLowGlucoseAlarm: TSpinEdit;
    lblUrgentHighGlucoseAlarm: TLabel;
    seUrgentHighGlucoseAlarm: TSpinEdit;
    lblUrgentLowGlucoseAlarm: TLabel;
    seUrgentLowGlucoseAlarm: TSpinEdit;
    gbStaleDataAlarms: TGroupBox;
    lblUrgentStaleDataAlarm: TLabel;
    seUrgentStaleDataAlarm: TSpinEdit;
    lblStaleDataAlarm: TLabel;
    seStaleDataAlarm: TSpinEdit;
    cbIsMmolL: TCheckBox;
    cbDrawHorzGuideLines: TCheckBox;
    cbDrawVertGuideLines: TCheckBox;
    cbDrawLastGlucoseLevel: TCheckBox;
    cbDrawLastGlucoseLevelDate: TCheckBox;
    cbDrawGlucoseExtremePoints: TCheckBox;
    cbDrawGlucoseLevel: TCheckBox;
    cbDrawGlucoseLines: TCheckBox;
    cbDrawGlucoseSlope: TCheckBox;
    cbShowCheckNewDataProgressBar: TCheckBox;
    cbShowWindowBorder: TCheckBox;
    seCheckInterval: TSpinEdit;
    seCountOfEntriesToRecive: TSpinEdit;
    lblCheckInterval: TLabel;
    lblCountOfEntriesToRecieve: TLabel;
    eNightscoutSite: TEdit;
    lblNightscoutSite: TLabel;
    sbScale: TScrollBar;
    lblScale: TLabel;
    lblAlphaBlend: TLabel;
    sbAlphaBlend: TScrollBar;
    lblMgDl: TLabel;
    lblMmolL: TLabel;
    lblUrgentHighGlucoseAlarmMmolL: TLabel;
    lblHighGlucoseAlarmMmolL: TLabel;
    lblLowGlucoseAlarmMmolL: TLabel;
    lblUrgentLowGlucoseAlarmMmolL: TLabel;
    cbDrawAlertLines: TCheckBox;
    lblTimeZoneCorrection: TLabel;
    seTimeZoneCorrection: TSpinEdit;
    cbDrawGlucoseLevelPoints: TCheckBox;
    tsHelp: TTabSheet;
    tsAbout: TTabSheet;
    tsMain: TTabSheet;
    tsVisual: TTabSheet;
    tsAlerts: TTabSheet;
    procedure btnOKClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure DoChange(Sender: TObject);
    procedure DoGlucoseAlarmChange(Sender: TObject);
  private
    OldSettings: TSettings;
    TmpSettings: TSettings;
    NewSettings: TSettings;
    OnUpdateCallerFormWithSettings: TOnUpdateCallerFormWithSettings;
    OnTryLoadEntriesData: TOnTryLoadEntriesData;
    procedure AssignSettingsToComponents();
    procedure AssignComponentsToSettings;
    procedure AssignGlucoseAlertInMmolL(SpinEdit: TSpinEdit);
  public
    class function ShowForm(AOwner: TComponent; Settings: TSettings;
      OnUpdateCallerFormWithSettings: TOnUpdateCallerFormWithSettings;
  OnTryLoadEntriesData: TOnTryLoadEntriesData; ActivePageIndex: Integer=0
  ): Boolean;
    constructor CreateSpecial(AOwner: TComponent; Settings: TSettings;
      ActivePageIndex: Integer=0);
    procedure AssignComponentsOnChangeEvent;
  end;

implementation

uses
  uNightscout;

{$R *.lfm}

{ TfSettings }

procedure TfSettings.btnOKClick(Sender: TObject);
begin
  AssignComponentsToSettings();
  OldSettings.Assign(NewSettings);
  
  if (NewSettings.NightscoutUrl <> OldSettings.NightscoutUrl) and
    Assigned(OnTryLoadEntriesData) and not OnTryLoadEntriesData then
  begin
    ModalResult := mrNone;
    Exit;
  end;
end;

constructor TfSettings.CreateSpecial(AOwner: TComponent; Settings: TSettings; ActivePageIndex: Integer = 0);
begin
  inherited Create(AOwner);
  OldSettings := Settings;
  NewSettings := Settings.Clone;
  TmpSettings := Settings.Clone;
  AssignSettingsToComponents();
  AssignComponentsOnChangeEvent();
  pc.ActivePageIndex := ActivePageIndex;
  if Assigned(OnUpdateCallerFormWithSettings) then
    OnUpdateCallerFormWithSettings;
end;

procedure TfSettings.AssignComponentsOnChangeEvent;
begin
  cbEnableGlucoseLevelAlarms.OnClick := DoChange;
  cbEnableStaleDataAlarms.OnClick := DoChange;
  cbIsMmolL.OnClick := DoChange;

  seHighGlucoseAlarm.OnChange := DoGlucoseAlarmChange;
  seLowGlucoseAlarm.OnChange := DoGlucoseAlarmChange;
  seUrgentHighGlucoseAlarm.OnChange := DoGlucoseAlarmChange;
  seUrgentLowGlucoseAlarm.OnChange := DoGlucoseAlarmChange;
  sbScale.OnChange := DoChange;
  sbAlphaBlend.OnChange := DoChange;
  seTimeZoneCorrection.OnChange := DoChange;
  seStaleDataAlarm.OnChange := DoChange;
  seUrgentStaleDataAlarm.OnChange := DoChange;

  cbShowCheckNewDataProgressBar.OnClick := DoChange;
  cbDrawHorzGuideLines.OnClick := DoChange;
  cbDrawLastGlucoseLevel.OnClick := DoChange;
  cbDrawLastGlucoseLevelDate.OnClick := DoChange;
  cbDrawGlucoseExtremePoints.OnClick := DoChange;
  cbDrawGlucoseLevel.OnClick := DoChange;
  cbDrawGlucoseLines.OnClick := DoChange;
  cbDrawGlucoseSlope.OnClick := DoChange;
  cbDrawVertGuideLines.OnClick := DoChange;
  cbShowWindowBorder.OnClick := DoChange;
  cbDrawAlertLines.OnClick := DoChange;
  cbDrawGlucoseLevelPoints.OnClick := DoChange;
  cbDrawGlucoseLevelDelta.OnClick := DoChange;
end;

procedure TfSettings.FormDestroy(Sender: TObject);
begin
  FreeAndNil(NewSettings);
  FreeAndNil(TmpSettings);
end;

procedure TfSettings.AssignGlucoseAlertInMmolL(SpinEdit: TSpinEdit);
var
  i: Integer;
  Component: TControl;
begin
  for i := 0 to gbGlucoseLevelAlarms.ControlCount - 1 do
  begin
    Component := gbGlucoseLevelAlarms.Controls[i];
    if not (Component is TLabel) then
      Continue;

    if Component.Tag = SpinEdit.Tag then
    begin
      TLabel(Component).Caption := TNightscoutEntry.GetGlucoseStr(SpinEdit.Value, True);
      Break;
    end;
  end;
end;

procedure TfSettings.DoGlucoseAlarmChange(Sender: TObject);
begin
  AssignGlucoseAlertInMmolL(TSpinEdit(Sender));
  DoChange(Sender);
end;

procedure TfSettings.DoChange(Sender: TObject);
begin
  AssignComponentsToSettings();
  OldSettings.Assign(NewSettings);
  if Assigned(OnUpdateCallerFormWithSettings) then
    OnUpdateCallerFormWithSettings;
end;

procedure TfSettings.AssignSettingsToComponents;
begin
  cbDrawHorzGuideLines.Checked := NewSettings.IsInDrawStage(dsHorzGuideLines);
  cbDrawLastGlucoseLevel.Checked := NewSettings.IsInDrawStage(dsLastGlucoseLevel);
  cbDrawLastGlucoseLevelDate.Checked := NewSettings.IsInDrawStage(dsLastGlucoseLevelDate);
  cbDrawGlucoseExtremePoints.Checked := NewSettings.IsInDrawStage(dsGlucoseExtremePoints);
  cbDrawGlucoseLevel.Checked := NewSettings.IsInDrawStage(dsGlucoseLevel);
  cbDrawGlucoseLines.Checked := NewSettings.IsInDrawStage(dsGlucoseLines);
  cbDrawGlucoseSlope.Checked := NewSettings.IsInDrawStage(dsGlucoseSlope);
  cbDrawVertGuideLines.Checked := NewSettings.IsInDrawStage(dsVertGuideLines);
  cbDrawAlertLines.Checked := NewSettings.IsInDrawStage(dsAlertLines);
  cbDrawGlucoseLevelPoints.Checked := NewSettings.IsInDrawStage(dsGlucoseLevelPoints);
  cbDrawGlucoseLevelDelta.Checked := NewSettings.IsInDrawStage(dsGlucoseLevelDelta);

  cbEnableGlucoseLevelAlarms.Checked := NewSettings.EnableGlucoseLevelAlarms;
  cbEnableStaleDataAlarms.Checked := NewSettings.EnableStaleDataAlarms;
  cbIsMmolL.Checked := NewSettings.IsMmolL;
  cbShowCheckNewDataProgressBar.Checked := NewSettings.ShowCheckNewDataProgressBar;
  cbShowWindowBorder.Checked := NewSettings.ShowWindowBorder;
  sbAlphaBlend.Position := NewSettings.AlphaBlendValue;
  sbScale.Max := Length(cDrawStageSizes[1]);
  sbScale.Position := NewSettings.ScaleIndex;
  seCheckInterval.Value := NewSettings.CheckInterval;
  seCountOfEntriesToRecive.Value := NewSettings.CountOfEntriesToRecive;
  seHighGlucoseAlarm.Value := NewSettings.HighGlucoseAlarm;
  seLowGlucoseAlarm.Value := NewSettings.LowGlucoseAlarm;
  seStaleDataAlarm.Value := NewSettings.StaleDataAlarm;
  seUrgentHighGlucoseAlarm.Value := NewSettings.UrgentHighGlucoseAlarm;
  seUrgentLowGlucoseAlarm.Value := NewSettings.UrgentLowGlucoseAlarm;
  seUrgentStaleDataAlarm.Value := NewSettings.UrgentStaleDataAlarm;
  seTimeZoneCorrection.Value := NewSettings.TimeZoneCorrection;
  eNightscoutSite.Text := NewSettings.NightscoutUrl;

  AssignGlucoseAlertInMmolL(seUrgentHighGlucoseAlarm);
  AssignGlucoseAlertInMmolL(seHighGlucoseAlarm);
  AssignGlucoseAlertInMmolL(seLowGlucoseAlarm);
  AssignGlucoseAlertInMmolL(seUrgentLowGlucoseAlarm);
end;

procedure TfSettings.AssignComponentsToSettings;
begin
  NewSettings.CheckInterval := seCheckInterval.Value;
  NewSettings.CountOfEntriesToRecive := seCountOfEntriesToRecive.Value;

  NewSettings.HighGlucoseAlarm := seHighGlucoseAlarm.Value;
  NewSettings.LowGlucoseAlarm := seLowGlucoseAlarm.Value;
  NewSettings.UrgentHighGlucoseAlarm := seUrgentHighGlucoseAlarm.Value;
  NewSettings.UrgentLowGlucoseAlarm := seUrgentLowGlucoseAlarm.Value;
  NewSettings.IsMmolL := cbIsMmolL.Checked;
  NewSettings.StaleDataAlarm := seStaleDataAlarm.Value;
  NewSettings.UrgentStaleDataAlarm := seUrgentStaleDataAlarm.Value;
  NewSettings.EnableGlucoseLevelAlarms := cbEnableGlucoseLevelAlarms.Checked;
  NewSettings.EnableStaleDataAlarms := cbEnableStaleDataAlarms.Checked;

  NewSettings.SwitchDrawStage(dsHorzGuideLines, cbDrawHorzGuideLines.Checked);
  NewSettings.SwitchDrawStage(dsLastGlucoseLevel, cbDrawLastGlucoseLevel.Checked);
  NewSettings.SwitchDrawStage(dsLastGlucoseLevelDate, cbDrawLastGlucoseLevelDate.Checked);
  NewSettings.SwitchDrawStage(dsGlucoseExtremePoints, cbDrawGlucoseExtremePoints.Checked);
  NewSettings.SwitchDrawStage(dsGlucoseLevel, cbDrawGlucoseLevel.Checked);
  NewSettings.SwitchDrawStage(dsGlucoseLines, cbDrawGlucoseLines.Checked);
  NewSettings.SwitchDrawStage(dsGlucoseSlope, cbDrawGlucoseSlope.Checked);
  NewSettings.SwitchDrawStage(dsVertGuideLines, cbDrawVertGuideLines.Checked);
  NewSettings.SwitchDrawStage(dsAlertLines, cbDrawAlertLines.Checked);
  NewSettings.SwitchDrawStage(dsGlucoseLevelPoints, cbDrawGlucoseLevelPoints.Checked);
  NewSettings.SwitchDrawStage(dsGlucoseLevelDelta, cbDrawGlucoseLevelDelta.Checked);

  NewSettings.ShowCheckNewDataProgressBar := cbShowCheckNewDataProgressBar.Checked;
  NewSettings.ShowWindowBorder := cbShowWindowBorder.Checked;
  NewSettings.NightscoutUrl := eNightscoutSite.Text;

  NewSettings.ScaleIndex := sbScale.Position;
  NewSettings.AlphaBlendValue := sbAlphaBlend.Position;
  NewSettings.TimeZoneCorrection := seTimeZoneCorrection.Value;
end;

class function TfSettings.ShowForm(AOwner: TComponent; Settings: TSettings;
  OnUpdateCallerFormWithSettings: TOnUpdateCallerFormWithSettings;
  OnTryLoadEntriesData: TOnTryLoadEntriesData; ActivePageIndex: Integer = 0): Boolean;
var
  F: TfSettings;
begin
  F := TfSettings.CreateSpecial(AOwner, Settings, ActivePageIndex);
  try
    F.OnUpdateCallerFormWithSettings := OnUpdateCallerFormWithSettings;
    F.OnTryLoadEntriesData := OnTryLoadEntriesData;
    Result := F.ShowModal = mrOk;
    if not Result then
      Settings.Assign(F.TmpSettings);
  finally
    FreeAndNil(F);
  end;
end;

end.
