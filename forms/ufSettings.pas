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
  uSettings, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin, ComCtrls, ExtCtrls;

type
  TOnUpdateCallerFormWithSettings = procedure of object;
  TOnTryLoadEntriesData = function: Boolean of object;

  { TfSettings }

  TfSettings = class(TForm)
    btnLoadWallpaper: TButton;
    btnOK: TButton;
    btnCancel: TButton;
    cbShowIconInTray: TCheckBox;
    cbStayOnTop: TCheckBox;
    cbDrawGlucoseLevelDelta: TCheckBox;
    cbDrawGlucoseAvg: TCheckBox;
    cbEnableGlucoseLevelAlarms: TCheckBox;
    cbEnableStaleDataAlarms: TCheckBox;
    cbDrawWallpaper: TCheckBox;
    cbShowIconOnTaskbar: TCheckBox;
    eWallpaper: TEdit;
    gbGlucoseLevelAlarms: TGroupBox;
    Image1: TImage;
    lblDeveloper: TLabel;
    lblVersion: TLabel;
    lblGitHubLink: TLabel;
    lblHighGlucoseAlarm: TLabel;
    mHelp: TMemo;
    odWallpaper: TOpenDialog;
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
    seCountOfEntriesToReceive: TSpinEdit;
    lblCheckInterval: TLabel;
    lblCountOfEntriesToReceive: TLabel;
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
    procedure btnLoadWallpaperClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure DoChange(Sender: TObject);
    procedure DoGlucoseAlarmChange(Sender: TObject);
    procedure lblGitHubLinkClick(Sender: TObject);
    procedure pcChange(Sender: TObject);
  private
    SourceSettings: TSettings;
    OldSettings: TSettings;
    NewSettings: TSettings;
    OnUpdateCallerFormWithSettings: TOnUpdateCallerFormWithSettings;
    OnTryLoadEntriesData: TOnTryLoadEntriesData;
    procedure AssignSettingsToComponents();
    procedure AssignComponentsToSettings;
    procedure AssignGlucoseAlertInMmolL(SpinEdit: TSpinEdit);
  public
    class function ShowForm(AOwner: TComponent; Settings: TSettings;
      OnUpdateCallerFormWithSettings: TOnUpdateCallerFormWithSettings;
      OnTryLoadEntriesData: TOnTryLoadEntriesData; ActivePageIndex: Integer=0): Boolean;
    constructor CreateSpecial(AOwner: TComponent; Settings: TSettings; ActivePageIndex: Integer=0);
    procedure AssignComponentsOnChangeEvent;
  end;

  function GetVersion(): string;

implementation

uses
{$IFDEF UNIX}{$IFDEF UseCThreads}
cthreads,
{$ENDIF}{$ENDIF}
  uNightscout
// FPC 3.0 fileinfo reads exe resources as long as you register the appropriate units
  ,fileinfo
  ,winpeimagereader {need this for reading exe info}
  ,elfreader {needed for reading ELF executables}
  ,machoreader {needed for reading MACH-O executables}
  ;

function GetVersion(): string;
var
  FileVerInfo: TFileVersionInfo;
begin
  FileVerInfo := TFileVersionInfo.Create(nil);
  try
    FileVerInfo.ReadFileInfo;
    Result := FileVerInfo.VersionStrings.Values['FileVersion'];
  finally
    FileVerInfo.Free;
  end;
end;
{$R *.lfm}

{ TfSettings }

procedure TfSettings.btnOKClick(Sender: TObject);
begin
  AssignComponentsToSettings();
  SourceSettings.Assign(NewSettings);
  
  if (NewSettings.NightscoutUrl <> SourceSettings.NightscoutUrl) and
    Assigned(OnTryLoadEntriesData) and not OnTryLoadEntriesData then
  begin
    ModalResult := mrNone;
    Exit;
  end;
end;

procedure TfSettings.btnLoadWallpaperClick(Sender: TObject);
begin
  if odWallpaper.Execute then
  begin
    eWallpaper.Text := odWallpaper.FileName;
    DoChange(eWallpaper);
  end;
end;

constructor TfSettings.CreateSpecial(AOwner: TComponent; Settings: TSettings; ActivePageIndex: Integer = 0);
begin
  inherited Create(AOwner);
  SourceSettings := Settings;
  NewSettings := Settings.Clone;
  OldSettings := Settings.Clone;
  AssignSettingsToComponents();
  AssignComponentsOnChangeEvent();
  pc.ActivePageIndex := ActivePageIndex;
  pcChange(pc);
  if Assigned(OnUpdateCallerFormWithSettings) then
    OnUpdateCallerFormWithSettings;
  lblDeveloper.Caption := Format('Developer: Sergey Oleynikov (T1D for %d years)', [CurrentYear - 1995]);
  lblVersion.Caption := 'Version: ' + GetVersion();
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
  cbStayOnTop.OnClick := DoChange;
  cbDrawAlertLines.OnClick := DoChange;
  cbDrawGlucoseLevelPoints.OnClick := DoChange;
  cbDrawGlucoseLevelDelta.OnClick := DoChange;
  cbDrawGlucoseAvg.OnClick := DoChange;
  cbDrawWallpaper.OnClick := DoChange;
  cbShowIconOnTaskbar.OnClick := DoChange;
  cbShowIconInTray.OnClick := DoChange;
end;

procedure TfSettings.FormDestroy(Sender: TObject);
begin
  FreeAndNil(NewSettings);
  FreeAndNil(OldSettings);
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

procedure TfSettings.lblGitHubLinkClick(Sender: TObject);
begin
  OpenDocument(TLabel(Sender).Caption);
end;

procedure TfSettings.pcChange(Sender: TObject);
begin
  Caption := '';
  if pc.ActivePageIndex < 3 then
    Caption := 'Settings. ';
  Caption := Caption + pc.ActivePage.Caption;
end;

procedure TfSettings.DoChange(Sender: TObject);
begin
  AssignComponentsToSettings();
  SourceSettings.Assign(NewSettings);
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
  cbDrawGlucoseAvg.Checked := NewSettings.IsInDrawStage(dsGlucoseAvg);
  cbDrawWallpaper.Checked := NewSettings.IsInDrawStage(dsWallpaper);
  eWallpaper.Text := NewSettings.WallpaperFileName;

  cbEnableGlucoseLevelAlarms.Checked := NewSettings.EnableGlucoseLevelAlarms;
  cbEnableStaleDataAlarms.Checked := NewSettings.EnableStaleDataAlarms;
  cbIsMmolL.Checked := NewSettings.IsMmolL;
  cbShowCheckNewDataProgressBar.Checked := NewSettings.ShowCheckNewDataProgressBar;
  cbShowWindowBorder.Checked := NewSettings.ShowWindowBorder;
  cbStayOnTop.Checked := NewSettings.StayOnTop;
  cbShowIconOnTaskbar.Checked := NewSettings.ShowIconInTaskBar;
  cbShowIconInTray.Checked := NewSettings.ShowIconInTray;
  sbAlphaBlend.Position := NewSettings.AlphaBlendValue;
  sbScale.Max := Length(cDrawStageSizes[1]);
  sbScale.Position := NewSettings.ScaleIndex;
  seCheckInterval.Value := NewSettings.CheckInterval;
  seCountOfEntriesToReceive.Value := NewSettings.CountOfEntriesToRecive;
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
  NewSettings.CountOfEntriesToRecive := seCountOfEntriesToReceive.Value;

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
  NewSettings.SwitchDrawStage(dsGlucoseAvg, cbDrawGlucoseAvg.Checked);
  NewSettings.SwitchDrawStage(dsWallpaper, cbDrawWallpaper.Checked);

  NewSettings.ShowCheckNewDataProgressBar := cbShowCheckNewDataProgressBar.Checked;
  NewSettings.ShowWindowBorder := cbShowWindowBorder.Checked;
  NewSettings.StayOnTop := cbStayOnTop.Checked;
  NewSettings.ShowIconInTaskBar := cbShowIconOnTaskbar.Checked;
  NewSettings.ShowIconInTray := cbShowIconInTray.Checked;
  NewSettings.NightscoutUrl := eNightscoutSite.Text;

  NewSettings.ScaleIndex := sbScale.Position;
  NewSettings.AlphaBlendValue := sbAlphaBlend.Position;
  NewSettings.TimeZoneCorrection := seTimeZoneCorrection.Value;
  NewSettings.WallpaperFileName := eWallpaper.Text;
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
      Settings.Assign(F.OldSettings);
  finally
    FreeAndNil(F);
  end;
end;

end.
