unit ufMain;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

interface

uses
{$IFnDEF FPC}
  Windows, Messages,
{$ELSE}
  LCLIntf, LCLType,
{$ENDIF}
  uSettings, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DateUtils, Contnrs, ExtCtrls, Menus, uNightscout, ComCtrls, ActnList;

type

  TDrawPanel = class(TPanel)
  private
    FOnPaint: TNotifyEvent;
  protected
    procedure Paint; override;
  public
    property OnPaint: TNotifyEvent read FOnPaint write FOnPaint;
    property Canvas;
  end;

  { TfMain }

  TfMain = class(TForm)
    pm: TPopupMenu;
    tmr: TTimer;
    pb: TProgressBar;
    tmrProgressBar: TTimer;
    al: TActionList;
    actDrawSugarLevel: TAction;
    actDrawSugarLines: TAction;
    actDrawLastSugarLevel: TAction;
    miDrawLastSugarLevel: TMenuItem;
    miDrawSugarLevel: TMenuItem;
    miDrawSugarLines: TMenuItem;
    miN1: TMenuItem;
    actVisitNightscoutSite: TAction;
    miVisitNightscoutSite: TMenuItem;
    actShowCheckNewDataProgressBar: TAction;
    miShowCheckNewDataProgressBar: TMenuItem;
    actHelp: TAction;
    miHelp: TMenuItem;
    actDrawLastSugarLevelDate: TAction;
    miDrawLastSugarLevelDate: TMenuItem;
    actSetNightscoutSite: TAction;
    miSetNightscoutSite: TMenuItem;
    miN2: TMenuItem;
    miN3: TMenuItem;
    actExit: TAction;
    miExit: TMenuItem;
    actSetCheckInterval: TAction;
    miSetCheckInterval: TMenuItem;
    actShowWindowBorder: TAction;
    miShowWindowBorder: TMenuItem;
    actSetUnitOfMeasureMmolL: TAction;
    miSetUnitOfMeasureMmolL: TMenuItem;
    actDrawVertGuideLines: TAction;
    actDrawHorzGuideLines: TAction;
    miDrawVertGuideLines: TMenuItem;
    miDrawHorzGuideLines: TMenuItem;
    actDrawSugarSlope: TAction;
    miDrawSugarSlope: TMenuItem;
    actDrawSugarExtremePoints: TAction;
    miDrawSugarExtremePoints: TMenuItem;
    actSetCountOfEntriesToRecive: TAction;
    Setcountofentriestorecive1: TMenuItem;
    actShowSettings: TAction;
    Showsettings1: TMenuItem;
    actDrawAlertLines: TAction;
    Drawalertlines1: TMenuItem;
    actFullScreen: TAction;
    Fullscreen1: TMenuItem;
    actDrawSugarLevelPoints: TAction;
    Drawsugarlevelpoints1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure tmrTimer(Sender: TObject);
    procedure tmrProgressBarTimer(Sender: TObject);
    procedure DoDrawStageExecute(Sender: TObject);
    procedure actVisitNightscoutSiteExecute(Sender: TObject);
    procedure actShowCheckNewDataProgressBarExecute(Sender: TObject);
    procedure actHelpExecute(Sender: TObject);
    procedure actSetNightscoutSiteExecute(Sender: TObject);
    procedure actExitExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure actSetCheckIntervalExecute(Sender: TObject);
    procedure actShowWindowBorderExecute(Sender: TObject);
    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure SetFormBounds(Direction: Integer);
    procedure actSetUnitOfMeasureMmolLExecute(Sender: TObject);
    procedure FormMouseEnter(Sender: TObject);
    procedure FormMouseLeave(Sender: TObject);
    procedure actSetCountOfEntriesToReciveExecute(Sender: TObject);
    procedure actShowSettingsExecute(Sender: TObject);
    procedure actFullScreenExecute(Sender: TObject);
  private
    FPressed : Boolean;
    FPosX : Integer;
    FPosY : Integer;
    Settings: TSettings;
    DrawPanel: TDrawPanel;
    Entries: TNightscoutEntryList;
    HorzLinesEntries: TNightscoutEntryList;
    OptionsFileName: string;
    Connected: Boolean;
    WasAlphaBlend: Boolean;
    procedure CreateDrawPanel();
    procedure SaveOptions();
    procedure LoadOptions();
    function LoadEntriesData: Boolean;
    procedure SetActionCheckProperty(Action: TAction; Checked: Boolean; DrawStage: TDrawStage);
    function GetArrowRect(Slope: string; ArrowAreaRect: TRect; var OutPoints: TRect): Boolean;
    procedure DrawArrow(P1,P2:TPoint; DrawArrowEnd:boolean; Canvas:TCanvas; SugarSlopeColor: TColor);
    procedure UpdateEntriesForHorzSugarLines();
    procedure DoDrawStages(DrawStages: TDrawStages);
    procedure DrawTextInCenter(const Text: string);
    procedure DoDraw(Sender: TObject);
    procedure DoUpdateCallerFormWithSettings;
    function SetNightscoutUrl(Url: string): Boolean;
    function SetCheckIntervalByString(Value: string): Boolean;
    procedure SetAlphaBlendValue(Value: Integer);
    procedure RefreshCheckInterval;
    function GetEntriesUrl: string;
    function GetDrawStageSize(DrawStage: TDrawStage): Integer;
    procedure HardInvalidate();
    procedure ApplyWindowSettings();
  end;

var
  fMain: TfMain;
  {$IFDEF DEBUG}
  DebugMode: Boolean = False; // Set to True to read data from file entries.tsv
  {$ELSE}
  DebugMode: Boolean = False;
  {$ENDIF}

implementation

uses
{$IFnDEF FPC}
  ShellAPI,
{$ELSE}
{$ENDIF}
  ufSettings, UrlMon, Wininet, Math, IniFiles, StrUtils, Types;

const
  cMoveWindowDelta = 10;


{$R *.dfm}

{ TDrawPannel }

procedure TDrawPanel.Paint;
begin
  inherited;
  if Assigned(FOnPaint) then
    FOnPaint(Self);
end;

{ TfMain }

procedure TfMain.DoDrawStageExecute(Sender: TObject);
var
  Action: TAction;
  ActionDrawStage: TDrawStage;
begin
  Action := TAction(Sender);
  ActionDrawStage := TDrawStage(Action.Tag);
  if Action.Checked then
    Settings.AddDrawStage(ActionDrawStage)
  else
    Settings.RemoveDrawStage(ActionDrawStage);
  HardInvalidate();
end;

procedure TfMain.actExitExecute(Sender: TObject);
begin
  Close;
end;

procedure TfMain.actFullScreenExecute(Sender: TObject);
var
  Action: TAction;
begin
  Action := TAction(Sender);
  Settings.FullScreen := Action.Checked;
  actShowWindowBorder.Checked := False;
  if Settings.FullScreen then
  begin
    WindowState := wsMaximized;
  end
  else
  begin
    actShowWindowBorder.Checked := Settings.ShowWindowBorder;
    WindowState := wsNormal;
  end;
  actShowWindowBorderExecute(actShowWindowBorder);
end;

procedure TfMain.actHelpExecute(Sender: TObject);
var
  Help: string;
begin
  Help := 'Hot keys:' + #13#10#13#10 +
    'LEFT/RIGHT/UP/DOWN – Move window on the screen' + #13#10 +
    'SHIFT + LEFT/RIGHT/UP/DOWN or MouseWheel – Resize window' + #13#10 +
    'ALT + UP/DOWN/MouseWheel – Increase/Decrease window opacity' + #13#10 +
    'RightClick – Show popup menu' + #13#10#13#10 +
    'S – Set Nightscout site URL' + #13#10 +
    'M – Set unit of measure to mmol/l' + #13#10 +
    'C – Set count of entries to recieve from site' + #13#10 +
    'F9 - Show settings window' + #13#10 +
    'I – Set time interval of new data checking' + #13#10#13#10 +
    '1 – Draw latest blood sugar level' + #13#10 +
    '2 – Draw sugar lines' + #13#10 +
    '3 – Draw sugar level values' + #13#10 +
    '4 – Draw vertical guidelines' + #13#10 +
//    '5 – Draw horizontal guidelines' + #13#10 +
    '6 – Draw time of last sugar level value' + #13#10 +
    '7 – Draw sugar slope' + #13#10 +
    '8 – Draw sugar extreme points' + #13#10 +
    'B – Show window border' + #13#10 +
    'P – Show new data checking progress bar' + #13#10 +
    'F11 – Show in full screen' + #13#10 +
    'V/DoubleClick – Visit your Nightscout site' + #13#10#13#10 +
    'Developer:' + #13#10 +
    'Sergey Oleynikov (D1T for ' + IntToStr(YearOf(Now) - 1995) + '+)' + #13#10;

  MessageDlg(Help, mtInformation, [mbOk], -1);
end;

procedure TfMain.actSetCheckIntervalExecute(Sender: TObject);
var
  CheckIntervalStr, Msg: string;
begin
  al.State := asSuspended;
  CheckIntervalStr := IntToStr(Settings.CheckInterval);
  if InputQuery('Check interval', 'Type in time interval to recieve data from Nightscout site (in seconds)', CheckIntervalStr) then
    if not SetCheckIntervalByString(CheckIntervalStr) then
    begin
      Msg := 'You must type in time interval in seconds (float value)';
      if MessageDlg(Msg, mtWarning, [mbYes, mbCancel], -1) = mrYes then
        actSetCheckIntervalExecute(Sender);
    end;
  al.State := asNormal;
end;

procedure TfMain.actSetCountOfEntriesToReciveExecute(Sender: TObject);
var
  Count, Msg: string;
  CountEntered: Integer;
  CanSetCount: Boolean;
begin
  al.State := asSuspended;
  Count := IntToStr(Settings.CountOfEntriesToRecive);
  if InputQuery('Count of entries', 'Type in the count of sugar entries to recieve from Nightscout site', Count) then
  begin
    CanSetCount := TryStrToInt(Count, CountEntered);
    CanSetCount := CanSetCount and (CountEntered >= 2) and (CountEntered <= 200);
    if CanSetCount then
    begin
      Settings.CountOfEntriesToRecive := CountEntered;
      tmrTimer(tmr);
    end
    else
    begin
      Msg := 'You must type in integer value (between 2 and 200).' + #13#10 + ' Try again?';
      if MessageDlg(Msg, mtWarning, [mbYes, mbCancel], -1) = mrYes then
        actSetCountOfEntriesToReciveExecute(Sender);
    end;
  end;
  al.State := asNormal;
end;

procedure TfMain.actSetNightscoutSiteExecute(Sender: TObject);
var
  Url, Msg: string;
begin
  al.State := asSuspended;
  Connected := False;
  Url := Settings.NightscoutUrl;
  if InputQuery('Nighscout site', 'Type URL of Nightscout site', Url) then
  begin
    if (Url <> '') and (SetNightscoutUrl(Url)) then
      tmrTimer(tmr)
    else
      actSetNightscoutSiteExecute(Sender);
  end
  else
  begin
    Msg := 'To obtain CGM data you have to type full URL of your Nightscout site.' + #13#10 +
      'Only HTTP protocol is supported.' + #13#10 +
      'Do you want to try again?';
    if MessageDlg(Msg, mtWarning, [mbYes, mbCancel], -1) = mrYes then
      actSetNightscoutSiteExecute(Sender);
  end;
  al.State := asNormal;
end;

procedure TfMain.actShowCheckNewDataProgressBarExecute(Sender: TObject);
begin
  Settings.ShowCheckNewDataProgressBar := TAction(Sender).Checked;
  pb.Visible := Settings.ShowCheckNewDataProgressBar;
end;

procedure TfMain.actShowSettingsExecute(Sender: TObject);
begin
  FormStyle := fsNormal;
  try
    TfSettings.ShowForm(Self, Settings, DoUpdateCallerFormWithSettings, LoadEntriesData);
    DoUpdateCallerFormWithSettings();
    tmrTimer(tmr);
  finally
    FormStyle := fsStayOnTop;
  end;
end;

procedure TfMain.actShowWindowBorderExecute(Sender: TObject);
var
  OldWindowRect: TRect;
begin
  Settings.ShowWindowBorder := TAction(Sender).Checked;
  OldWindowRect := BoundsRect;
  if TAction(Sender).Checked then
  begin
    BorderStyle := bsSizeable;
    BorderIcons := [biSystemMenu, biMaximize, biMinimize];
  end
  else
  begin
    BorderIcons := [];
    BorderStyle := bsNone;
  end;
  BoundsRect := OldWindowRect;
end;

procedure TfMain.actSetUnitOfMeasureMmolLExecute(Sender: TObject);
begin
  Settings.IsMmolL := TAction(Sender).Checked;
  HardInvalidate();
end;

procedure TfMain.actVisitNightscoutSiteExecute(Sender: TObject);
//var
//  ExecInfo: TShellExecuteInfo;
begin
  //FillChar(ExecInfo, SizeOf(TShellExecuteInfo), 0);
  //ExecInfo.cbSize := SizeOf(TShellExecuteInfo);
  //ExecInfo.fMask := SEE_MASK_NOCLOSEPROCESS;
  //ExecInfo.Wnd := Handle;
  //ExecInfo.lpFile := PChar(Settings.NightscoutUrl);
  //ExecInfo.nShow := SW_SHOWNORMAL;
  //
  //Win32Check(ShellExecuteEx(@ExecInfo));
end;

procedure TfMain.CreateDrawPanel;
begin
  DrawPanel := TDrawPanel.Create(Self);
  DrawPanel.Parent := Self;
  DrawPanel.ParentColor := True;
  DrawPanel.Caption := '';
  DrawPanel.BevelOuter := bvNone;
  DrawPanel.Align := alClient;
  DrawPanel.PopupMenu := pm;
  DrawPanel.OnPaint := DoDraw;
  DrawPanel.OnMouseDown := FormMouseDown;
  DrawPanel.OnMouseUp := FormMouseUp;
  DrawPanel.OnMouseMove := FormMouseMove;
  DrawPanel.OnMouseEnter := FormMouseEnter;
  DrawPanel.OnMouseLeave := FormMouseLeave;
  DrawPanel.OnDblClick := actVisitNightscoutSite.OnExecute;
end;

procedure TfMain.FormCreate(Sender: TObject);
begin
  Settings := TSettings.Create();

  Connected := False;
  OptionsFileName := ExtractFilePath(ParamStr(0)) +  'Options.ini';
  Entries := TNightscoutEntryList.Create;
  HorzLinesEntries := TNightscoutEntryList.Create;

  CreateDrawPanel();
  LoadOptions();
end;

procedure TfMain.FormDestroy(Sender: TObject);
begin
  SaveOptions();
  FreeAndNil(Entries);
  FreeAndNil(HorzLinesEntries);
  FreeAndNil(Settings);
end;

procedure TfMain.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Shift = [] then
  begin
    // Form position
    case Key of
      VK_ESCAPE: actExit.Execute;
      VK_LEFT:  Left := Left - cMoveWindowDelta;
      VK_RIGHT: Left := Left + cMoveWindowDelta;
      VK_UP:    Top  := Top - cMoveWindowDelta;
      VK_DOWN:  Top  := Top + cMoveWindowDelta;
    end;
  end
  else if Shift = [ssShift] then
  begin
    // Form size
    case Key of
      VK_LEFT:  Width  := Width - cMoveWindowDelta;
      VK_RIGHT: Width  := Width + cMoveWindowDelta;
      VK_UP:    Height := Height - cMoveWindowDelta;
      VK_DOWN:  Height := Height + cMoveWindowDelta;
    end;
  end
  else if Shift = [ssAlt] then
  begin
    // AlphaBlend
    case Key of
      VK_UP:    SetAlphaBlendValue(Settings.AlphaBlendValue + cMoveWindowDelta);
      VK_DOWN:  SetAlphaBlendValue(Settings.AlphaBlendValue - cMoveWindowDelta);
    end;
  end;
end;

procedure TfMain.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  FPressed := True;
  FPosX := X;
  FPosY := Y;
end;

procedure TfMain.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if FPressed then
  begin
    Left := Left - FPosX + X;
    Top := Top - FPosY + Y;
  end;
end;

procedure TfMain.FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  FPressed := False;
end;

procedure TfMain.FormMouseEnter(Sender: TObject);
begin
  WasAlphaBlend := AlphaBlend;
  if AlphaBlend then
    AlphaBlend := False;
end;

procedure TfMain.FormMouseLeave(Sender: TObject);
begin
  if WasAlphaBlend then
    AlphaBlend := True;
end;

procedure TfMain.FormMouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
var
  Direction: Integer;
begin
  Direction := IfThen(WheelDelta > 0, 1, -1);

  if Shift = [ssAlt] then
  begin
    SetAlphaBlendValue(Settings.AlphaBlendValue + cMoveWindowDelta * Direction);
  end
  else if Shift = [] then
  begin
    if Settings.SetScaleIndex(Settings.ScaleIndex + Direction) then
      HardInvalidate;
  end
  else if Shift = [ssShift] then
  begin
    SetFormBounds(Direction);
  end;
end;

procedure TfMain.SetFormBounds(Direction: Integer);
var
  WindowRect: TRect;
begin
  Direction := IfThen(Direction > 0, 1, -1);

  WindowRect := BoundsRect;

  InflateRect(WindowRect, Direction * cMoveWindowDelta, Direction * cMoveWindowDelta);
  if (Direction < 0) then
  begin
    if WindowRect.Right - WindowRect.Left <= Constraints.MinWidth then
    begin
      WindowRect.Right := BoundsRect.Right;
      WindowRect.Left := BoundsRect.Left;
    end;

    if WindowRect.Bottom - WindowRect.Top <= Constraints.MinHeight then
    begin
      WindowRect.Bottom := BoundsRect.Bottom;
      WindowRect.Top := BoundsRect.Top;
    end;
  end;

  BoundsRect := WindowRect;
end;

procedure TfMain.FormShow(Sender: TObject);
begin
  if Settings.NightscoutUrl = '' then
    actSetNightscoutSiteExecute(actSetNightscoutSite)
  else
    tmrTimer(tmr); // Load data from nightscout site and start monitoring
end;

function TfMain.GetEntriesUrl: string;
begin
  Result := Settings.NightscoutUrl + '/api/v1/entries?count=' + IntToStr(Settings.CountOfEntriesToRecive);
end;

function TfMain.GetDrawStageSize(DrawStage: TDrawStage): Integer;
var
  i: Integer;
begin
  case DrawStage of
    dsLastSugarLevel: i :=1;
    dsSugarLevel: i := 2;
    dsLastSugarLevelDate: i := 3;
    dsSugarLines: i := 4;
    dsSugarSlope: i := 5;
  else
    Result:= Font.Size;
    Exit;
  end;

  Result := cDrawStageSizes[i][Settings.ScaleIndex];
end;

function TfMain.LoadEntriesData: Boolean;
var
  FileName, Line: string;
  DataFile: TextFile;
  Entry: TNightscoutEntry;
  IsFileDownloaded: Boolean;
begin
  Result := False;
  FileName := './entries.tsv';
  Entries.Clear;
  if not DebugMode then
  begin
    //{$IF CompilerVersion >= 21.0}  // For DELPHI_2010_UP
    //DeleteUrlCacheEntry(PWideChar(GetEntriesUrl));
    //IsFileDownloaded := URLDownloadToFile(nil, PWideChar(GetEntriesUrl), PWideChar(FileName), 0, nil) = S_OK;
    //{$ELSE}
    DeleteUrlCacheEntry(PAnsiChar(GetEntriesUrl));
    IsFileDownloaded := URLDownloadToFile(nil, PAnsiChar(GetEntriesUrl), PAnsiChar(FileName), 0, nil) = S_OK;
    //{$IFEND}

    if not IsFileDownloaded then
    begin
      ShowMessage('File downloading is failed. URL: ' + GetEntriesUrl);
      Exit;
    end;
  end;

  if not FileExists(FileName) then
  begin
    ShowMessage('File with entries doesn`t exist: ' + FileName);
    Exit;
  end;

  AssignFile(DataFile, FileName);
  FileMode := fmOpenRead;
  Reset(DataFile);

  while not Eof(DataFile) do
  begin
    ReadLn(DataFile, Line);
    Entry := TNightscoutEntry.Create();
    if Entry.ParseRow(Line) then
      Entries.Insert(0, Entry)
    else
      FreeAndNil(Entry);
  end;
  Entries.RemoveDuplicatesWithTheSameDate;
  Entries.LimitEntries(Settings.CountOfEntriesToRecive);
  UpdateEntriesForHorzSugarLines();
  CloseFile(DataFile);

  if not DebugMode then
    DeleteFile(FileName);

  if Entries.Count = 0 then
    ShowMessage('No entries were downloaded. URL: ' + GetEntriesUrl)
  else
    Result := True;
end;

procedure TfMain.SetActionCheckProperty(Action: TAction; Checked: Boolean; DrawStage: TDrawStage);
begin
  if Checked then
    Settings.AddDrawStage(DrawStage)
  else
    Settings.RemoveDrawStage(DrawStage);
  Action.Checked := Checked;
end;

procedure TfMain.LoadOptions;
var
  ini: TIniFile;
  DrawStageChecked: Boolean;
  WindowPosition: TRect;
begin
  ini := TIniFile.Create(OptionsFileName);
  try
    Settings.NightscoutUrl := ini.ReadString('Main', 'NightscoutUrl', '');
    Settings.IsMmolL := ini.ReadBool('Main', 'IsMmolL', Settings.IsMmolL);
    actSetUnitOfMeasureMmolL.Checked := Settings.IsMmolL;
    Settings.CheckInterval := ini.ReadInteger('Main', 'CheckInterval', Settings.CheckInterval);
    Settings.TimeZoneCorrection := ini.ReadInteger('Main', 'TimeZoneCorrection', Settings.TimeZoneCorrection);
    Settings.CountOfEntriesToRecive := ini.ReadInteger('Main', 'CountOfEntriesToRecive', Settings.CountOfEntriesToRecive);

    DrawStageChecked := ini.ReadBool('Visual', 'dsLastSugarLevel', Settings.IsInDrawStage(dsLastSugarLevel));
    SetActionCheckProperty(actDrawLastSugarLevel, DrawStageChecked, dsLastSugarLevel);

    DrawStageChecked := ini.ReadBool('Visual', 'dsSugarLines', Settings.IsInDrawStage(dsSugarLines));
    SetActionCheckProperty(actDrawSugarLines, DrawStageChecked, dsSugarLines);

    DrawStageChecked := ini.ReadBool('Visual', 'dsSugarLevel', Settings.IsInDrawStage(dsSugarLevel));
    SetActionCheckProperty(actDrawSugarLevel, DrawStageChecked, dsSugarLevel);

    DrawStageChecked := ini.ReadBool('Visual', 'dsHorzGuideLines', Settings.IsInDrawStage(dsHorzGuideLines));
    SetActionCheckProperty(actDrawHorzGuideLines, DrawStageChecked, dsHorzGuideLines);

    DrawStageChecked := ini.ReadBool('Visual', 'dsVertGuideLines', Settings.IsInDrawStage(dsVertGuideLines));
    SetActionCheckProperty(actDrawVertGuideLines, DrawStageChecked, dsVertGuideLines);

    DrawStageChecked := ini.ReadBool('Visual', 'dsLastSugarLevelDate', Settings.IsInDrawStage(dsLastSugarLevelDate));
    SetActionCheckProperty(actDrawLastSugarLevelDate, DrawStageChecked, dsLastSugarLevelDate);

    DrawStageChecked := ini.ReadBool('Visual', 'dsSugarSlope', Settings.IsInDrawStage(dsSugarSlope));
    SetActionCheckProperty(actDrawSugarSlope, DrawStageChecked, dsSugarSlope);

    DrawStageChecked := ini.ReadBool('Visual', 'dsSugarExtremePoints', Settings.IsInDrawStage(dsSugarExtremePoints));
    SetActionCheckProperty(actDrawSugarExtremePoints, DrawStageChecked, dsSugarExtremePoints);

    DrawStageChecked := ini.ReadBool('Visual', 'dsAlertLines', Settings.IsInDrawStage(dsAlertLines));
    SetActionCheckProperty(actDrawAlertLines, DrawStageChecked, dsAlertLines);

    DrawStageChecked := ini.ReadBool('Visual', 'dsSugarLevelPoints', Settings.IsInDrawStage(dsSugarLevelPoints));
    SetActionCheckProperty(actDrawSugarLevelPoints, DrawStageChecked, dsSugarLevelPoints);

    Settings.ShowCheckNewDataProgressBar := ini.ReadBool('Visual', 'ShowCheckNewDataProgressBar', Settings.ShowCheckNewDataProgressBar);

    WindowPosition.Right := ini.ReadInteger('Visual', 'WindowWidth', Width);
    WindowPosition.Bottom := ini.ReadInteger('Visual', 'WindowHeight', Height);
    WindowPosition.Left := ini.ReadInteger('Visual', 'WindowLeft', Screen.Width - Width);
    WindowPosition.Top := ini.ReadInteger('Visual', 'WindowTop', Floor((Screen.Height - Height) / 2));
    SetBounds(WindowPosition.Left, WindowPosition.Top, WindowPosition.Right, WindowPosition.Bottom);

    SetAlphaBlendValue(ini.ReadInteger('Visual', 'AlphaBlendValue', Settings.AlphaBlendValue));

    Settings.SetScaleIndex(ini.ReadInteger('Visual', 'ScaleIndex', Settings.ScaleIndex));
    Settings.ShowWindowBorder := ini.ReadBool('Visual', 'ShowWindowBorder', Settings.ShowWindowBorder);
    Settings.FullScreen := ini.ReadBool('Visual', 'FullScreen', Settings.FullScreen);

    Settings.HighGlucoseAlarm := ini.ReadInteger('Alarms', 'HighGlucoseAlarm', Settings.HighGlucoseAlarm);
    Settings.LowGlucoseAlarm := ini.ReadInteger('Alarms', 'LowGlucoseAlarm', Settings.LowGlucoseAlarm);
    Settings.UrgentHighGlucoseAlarm := ini.ReadInteger('Alarms', 'UrgentHighGlucoseAlarm', Settings.UrgentHighGlucoseAlarm);
    Settings.UrgentLowGlucoseAlarm := ini.ReadInteger('Alarms', 'UrgentLowGlucoseAlarm', Settings.UrgentLowGlucoseAlarm);
    Settings.StaleDataAlarm := ini.ReadInteger('Alarms', 'StaleDataAlarm', Settings.StaleDataAlarm);
    Settings.UrgentStaleDataAlarm := ini.ReadInteger('Alarms', 'UrgentStaleDataAlarm', Settings.UrgentStaleDataAlarm);
    Settings.EnableGlucoseLevelAlarms := ini.ReadBool('Alarms', 'EnableGlucoseLevelAlarms', Settings.EnableGlucoseLevelAlarms);
    Settings.EnableStaleDataAlarms := ini.ReadBool('Alarms', 'EnableStaleDataAlarms', Settings.EnableStaleDataAlarms);
  finally
    ini.Free;
  end;

  RefreshCheckInterval();
  ApplyWindowSettings();
  HardInvalidate();
end;

procedure TfMain.SaveOptions;
var
  ini: TIniFile;
begin
  ini := TIniFile.Create(OptionsFileName);
  try
    ini.WriteString('Main', 'NightscoutUrl', Settings.NightscoutUrl);
    ini.WriteBool('Main', 'IsMmolL', Settings.IsMmolL);
    ini.WriteInteger('Main', 'CountOfEntriesToRecive', Settings.CountOfEntriesToRecive);
    ini.WriteFloat('Main', 'CheckInterval', Settings.CheckInterval);
    ini.WriteInteger('Main', 'TimeZoneCorrection', Settings.TimeZoneCorrection);

    ini.WriteBool('Visual', 'dsLastSugarLevel',     Settings.IsInDrawStage(dsLastSugarLevel));
    ini.WriteBool('Visual', 'dsSugarLines',         Settings.IsInDrawStage(dsSugarLines));
    ini.WriteBool('Visual', 'dsSugarLevel',         Settings.IsInDrawStage(dsSugarLevel));
    ini.WriteBool('Visual', 'dsHorzGuideLines',     Settings.IsInDrawStage(dsHorzGuideLines));
    ini.WriteBool('Visual', 'dsVertGuideLines',     Settings.IsInDrawStage(dsVertGuideLines));
    ini.WriteBool('Visual', 'dsLastSugarLevelDate', Settings.IsInDrawStage(dsLastSugarLevelDate));
    ini.WriteBool('Visual', 'dsSugarSlope',         Settings.IsInDrawStage(dsSugarSlope));
    ini.WriteBool('Visual', 'dsSugarExtremePoints', Settings.IsInDrawStage(dsSugarExtremePoints));
    ini.WriteBool('Visual', 'dsAlertLines',         Settings.IsInDrawStage(dsAlertLines));
    ini.WriteBool('Visual', 'dsSugarLevelPoints',   Settings.IsInDrawStage(dsSugarLevelPoints));

    ini.WriteBool('Visual', 'ShowCheckNewDataProgressBar', Settings.ShowCheckNewDataProgressBar);
    ini.WriteBool('Visual', 'ShowWindowBorder', Settings.ShowWindowBorder);
    ini.WriteBool('Visual', 'FullScreen', Settings.FullScreen);
    ini.WriteInteger('Visual', 'AlphaBlendValue', Settings.AlphaBlendValue);

    // Save window position and size
    ini.WriteInteger('Visual', 'WindowLeft', Left);
    ini.WriteInteger('Visual', 'WindowTop', Top);
    ini.WriteInteger('Visual', 'WindowWidth', Width);
    ini.WriteInteger('Visual', 'WindowHeight', Height);

    ini.WriteInteger('Visual', 'ScaleIndex', Settings.ScaleIndex);

    ini.WriteInteger('Alarms', 'HighGlucoseAlarm', Settings.HighGlucoseAlarm);
    ini.WriteInteger('Alarms', 'LowGlucoseAlarm', Settings.LowGlucoseAlarm);
    ini.WriteInteger('Alarms', 'UrgentHighGlucoseAlarm', Settings.UrgentHighGlucoseAlarm);
    ini.WriteInteger('Alarms', 'UrgentLowGlucoseAlarm', Settings.UrgentLowGlucoseAlarm);

    ini.WriteInteger('Alarms', 'StaleDataAlarm', Settings.StaleDataAlarm);
    ini.WriteInteger('Alarms', 'UrgentStaleDataAlarm', Settings.UrgentStaleDataAlarm);
    ini.WriteBool('Alarms', 'EnableGlucoseLevelAlarms', Settings.EnableGlucoseLevelAlarms);
    ini.WriteBool('Alarms', 'EnableStaleDataAlarms', Settings.EnableStaleDataAlarms);
  finally
    ini.Free;
  end;
end;

procedure TfMain.RefreshCheckInterval;
begin
  SetCheckIntervalByString(IntToStr(Settings.CheckInterval));
end;

procedure TfMain.SetAlphaBlendValue(Value: Integer);
begin     
  if Value > 255 then
  begin
    AlphaBlend := False;
    Settings.AlphaBlendValue := 255;
  end
  else
  begin
    if Value < 10 then
      Settings.AlphaBlendValue := 10
    else
      Settings.AlphaBlendValue := Value;
    AlphaBlend := True;
  end;
  AlphaBlendValue := Settings.AlphaBlendValue;
end;

function TfMain.SetCheckIntervalByString(Value: String): Boolean;
begin
  Result := TryStrToInt(Value, Settings.CheckInterval);
  if Result then
  begin
    tmr.Interval := Settings.CheckInterval * 1000;
    pb.Position := 0;
    pb.Max := Floor(tmr.Interval / 1000);
  end;
end;

procedure TfMain.HardInvalidate();
begin
  // Crutch for Invalidate bug on Win7 and lower
  Width := Width + 1;
  Width := Width - 1;
  if WindowState = wsMaximized then
  begin
    AlphaBlend := not AlphaBlend;
    AlphaBlend := not AlphaBlend;
  end;
  pb.Height := cProgressBarHeights[Settings.ScaleIndex];
  Invalidate;
end;

function TfMain.SetNightscoutUrl(Url: string): Boolean;
begin
  Result := False;
  Url := Trim(Url);
  if Url = '' then
    Exit;

  Url := ReplaceText(Url, 'https://', 'http://');
  Url := ReplaceText(Url, 'http://', 'http://');
  if Url[Length(Url)] = '/' then
    Url := Copy(Url, 1, Length(Url) - 1);

  if Pos('http://', Url) < 1 then
    Url := 'http://' + Url;

  Settings.NightscoutUrl := Url;
  Result := True;
end;

procedure TfMain.tmrProgressBarTimer(Sender: TObject);
begin
  pb.Position := pb.Position + 1;
end;

procedure TfMain.tmrTimer(Sender: TObject);
begin
  tmrProgressBar.Enabled := False;
  tmr.Enabled := False;
  Connected := False;
  if LoadEntriesData() then
  begin
    RefreshCheckInterval();
    tmr.Enabled := True;
    tmrProgressBar.Enabled := True;
    Connected := True;
  end
  else
    actSetNightscoutSiteExecute(actSetNightscoutSite);

  HardInvalidate();
end;


procedure TfMain.UpdateEntriesForHorzSugarLines;
var
  i, MinSugarValue, MaxSugarValue, Delta: Integer;
  Entry: TNightscoutEntry;
begin
  HorzLinesEntries.Clear;

  if Settings.IsMmolL then
  begin
    Delta  := 1;
    MinSugarValue := Floor(Entries.GetMinSugarMmol) - Delta;
    MaxSugarValue := Ceil(Entries.GetMaxSugarMmol) + Delta;
  end
  else
  begin
    Delta  := 10;
    MinSugarValue := Entries.GetMinSugar - Delta;
    MaxSugarValue := Entries.GetMaxSugar + Delta;
  end;

  i := MinSugarValue;
  while i < MaxSugarValue do
  begin
    Entry := TNightscoutEntry.Create();
    Entry.SetSugar(i, Settings.IsMmolL);
    HorzLinesEntries.Add(Entry);
    Inc(i, Delta);
  end;
end;

function ContainsText(Text: string; SubText: string): Boolean;
begin
  Text := UpperCase(Text);
  SubText := UpperCase(SubText);
  Result := Pos(SubText, Text) > 0;
end;

function TfMain.GetArrowRect(Slope: string; ArrowAreaRect: TRect; var OutPoints: TRect): Boolean;
const
  cHeightKoef = 0.54;
  cHeightFix  = 0.26;
  cHeightTopFix  = 0.53;
begin
  Result := False;

  if (Slope = 'Flat') or ContainsText(Slope, 'NOT') then
  begin
    OutPoints := Rect(
      0,
      ArrowAreaRect.Top div 2,
      ArrowAreaRect.Right,
      ArrowAreaRect.Top div 2);
    OffsetRect(OutPoints, 0, Floor(ArrowAreaRect.Bottom * cHeightTopFix));
    Result := not ContainsText(Slope, 'NOT');
  end
  else if Slope = 'FortyFiveDown' then
  begin
    OutPoints := Rect(
      0,
      0,
      ArrowAreaRect.Right,
      Floor(ArrowAreaRect.Bottom * cHeightKoef));
      OffsetRect(OutPoints, 0, Floor(ArrowAreaRect.Bottom * cHeightFix));
    Result := True;
  end
  else if Slope = 'FortyFiveUp' then
  begin
    OutPoints := Rect(
      0,
      Floor(ArrowAreaRect.Bottom * cHeightKoef),
      ArrowAreaRect.Right,
      0);
    OffsetRect(OutPoints, 0, Floor(ArrowAreaRect.Bottom * cHeightFix));
    Result := True;
  end
  else if (Slope = 'SingleDown') or (Slope = 'DoubleDown') then
  begin
    OutPoints := Rect(
      0,
      0,
      0,
      Floor(ArrowAreaRect.Bottom * cHeightKoef));
    OffsetRect(OutPoints, 0, Floor(ArrowAreaRect.Bottom * cHeightFix));
    Result := True;
  end
  else if (Slope = 'SingleUp') or (Slope = 'DoubleUp') then
  begin
    OutPoints := Rect(
      0,
      Floor(ArrowAreaRect.Bottom * cHeightKoef),
      0,
      0);
    OffsetRect(OutPoints, 0, Floor(ArrowAreaRect.Bottom * cHeightFix));
    Result := True;
  end;
end;

procedure TfMain.DrawArrow(P1,P2: TPoint; DrawArrowEnd: Boolean; Canvas: TCanvas; SugarSlopeColor: TColor);
var
  Angle, Distance: Double;
  ArrowLength: Integer;
  p3, p4: TPoint;
begin
  Canvas.Pen.Color := SugarSlopeColor;
  Canvas.Pen.Width := GetDrawStageSize(dsSugarSlope);
  Canvas.MoveTo(p1.X, p1.Y);
  Canvas.LineTo(p2.X, p2.Y);
  if DrawArrowEnd then
  begin
    Angle:= 180 * ArcTan2(p2.y - p1.y, p2.x - p1.x) / pi;
    Distance := Sqrt(Sqr(P2.X - p1.X) + Sqr(p2.Y - p1.Y));
    ArrowLength := Round(Distance / 3);

    p3 := Point(p2.X + Round(ArrowLength * cos(pi * (Angle + 150) / 180)), p2.y + Round(ArrowLength * sin(pi * (Angle + 150) / 180)));
    p4 := Point(p2.X + Round(ArrowLength * cos(pi * (Angle - 150) / 180)), p2.y + Round(ArrowLength * sin(pi * (Angle - 150) / 180)));

    Canvas.MoveTo(p2.X,p2.Y);
    Canvas.LineTo(p3.X,p3.y);
    Canvas.MoveTo(p2.X,p2.Y);
    Canvas.LineTo(p4.X,p4.y);
  end;
end;

procedure TfMain.DrawTextInCenter(const Text: string);
var
  cnv: TCanvas;
  TextSize: TSize;
  TextPoint: TPoint;
begin
  cnv := DrawPanel.Canvas;
  cnv.Brush.Color := Color;
  SetBkMode(cnv.Handle, TRANSPARENT);
  cnv.Font.Size := GetDrawStageSize(dsLastSugarLevel);
  TextSize := cnv.TextExtent(Text);
  TextPoint.X := Floor((DrawPanel.Width - TextSize.cx) / 2);
  TextPoint.Y := Floor((DrawPanel.Height - TextSize.cy - (DrawPanel.Height / 10)) / 2);
  cnv.Font.Color := cLastSugarLevelColor;
  cnv.TextOut(TextPoint.X, TextPoint.Y, Text);
end;

procedure TfMain.DoDrawStages(DrawStages: TDrawStages);
const
  cMarginX = 0.9;
  cMarginY = 0.9;
var
  i, x, y, EntriesCount, SlopeRectWidth, ArrowCount, ArrowOffsetX, MaxY, SugarLevelPointRadius: integer;
  cnv: TCanvas;
  EntryWidth, EntryHeight, MarginX, MarginY: Double;
  Entry: TNightscoutEntry;
  Text: string;
  TextSize: TSize;
  OffsetPoints: array [0..7] of TPoint;
  LastSugarLevelPoint: TPoint;
  SlopeRect, ArrowRect: TRect;
  CanDrawArrow: Boolean;
  LastSugarLevelDateColor, FontColor: TColor;
begin
  EntriesCount := Entries.Count;
  if EntriesCount < 1 then
    Exit;

  cnv := DrawPanel.Canvas;
  EntryWidth := (DrawPanel.Width * cMarginX) / (EntriesCount - 1);
  if Settings.IsInDrawStage(dsAlertLines) then
  begin
    MaxY := Max(Settings.UrgentHighGlucoseAlarm, Entries.GetMaxSugar);
    EntryHeight := (DrawPanel.Height * cMarginY) /
      (Entries.GetMaxSugarDelta(Settings.UrgentLowGlucoseAlarm, Settings.UrgentHighGlucoseAlarm) + 1);
  end
  else
  begin
    MaxY := Entries.GetMaxSugar;
    EntryHeight := (DrawPanel.Height * cMarginY) /
      (Entries.GetMaxSugarDelta(-1, -1) + 1);
  end;

  MarginX := DrawPanel.Width * (1 - cMarginX) / 2;
  MarginY := DrawPanel.Height * (1 - cMarginY) / 2;

  if dsVertGuideLines in DrawStages then
  begin
    cnv.Pen.Color := cVertGuideLinesColor;
    cnv.Pen.Width := 1;

    for i := 0 to EntriesCount - 1 do
    begin
      x := Floor(EntryWidth * i + MarginX);
      cnv.MoveTo(x, 0);
      cnv.LineTo(x, DrawPanel.Height);
    end;
  end;

  if Settings.IsInDrawStage(dsAlertLines) then
  begin
    cnv.Pen.Width := 1;
    cnv.Pen.Color := cUrgentAlarmColor;

    y := Floor(EntryHeight * (MaxY - Settings.UrgentHighGlucoseAlarm) + MarginY);
    cnv.MoveTo(0, y);
    cnv.LineTo(DrawPanel.Width, y);

    y := Floor(EntryHeight * (MaxY - Settings.UrgentLowGlucoseAlarm) + MarginY);
    cnv.MoveTo(0, y);
    cnv.LineTo(DrawPanel.Width, y);

    cnv.Pen.Color := cAlarmColor;
    y := Floor(EntryHeight * (MaxY - Settings.HighGlucoseAlarm) + MarginY);
    cnv.MoveTo(0, y);
    cnv.LineTo(DrawPanel.Width, y);

    y := Floor(EntryHeight * (MaxY - Settings.LowGlucoseAlarm) + MarginY);
    cnv.MoveTo(0, y);
    cnv.LineTo(DrawPanel.Width, y);
  end;

  if dsSugarLines in DrawStages then
  begin
    for i := 0 to EntriesCount - 1 do
    begin
      Entry := Entries[i];
      x := Floor(EntryWidth * i + MarginX);
      y := Floor(EntryHeight * (MaxY - Entry.Sugar) + MarginY);

      cnv.Pen.Color := cSugarLinesColor;
      cnv.Pen.Width := GetDrawStageSize(dsSugarLines);

      if i = 0 then
        cnv.MoveTo(x, y)
      else
        cnv.LineTo(x, y);
    end;
  end;

  if (dsSugarLevelPoints in DrawStages) or (dsSugarLevel in DrawStages) or (dsSugarExtremePoints in DrawStages) then
  begin
    for i := 0 to EntriesCount - 1 do
    begin
      Entry := Entries[i];
      x := Floor(EntryWidth * i + MarginX);
      y := Floor(EntryHeight * (MaxY - Entry.Sugar) + MarginY);

      if (dsSugarLevelPoints in DrawStages) then
      begin
        SugarLevelPointRadius := GetDrawStageSize(dsSugarLines) * 2;
        cnv.Brush.Color := cSugarLevelPointsColor;
        cnv.Pen.Color := cSugarLevelPointsColor;
        cnv.Pen.Width := 1;
        cnv.Ellipse(x - SugarLevelPointRadius, y - SugarLevelPointRadius, x + SugarLevelPointRadius, y + SugarLevelPointRadius);
      end;

      cnv.Brush.Color := cSugarLevelBrushColor;
      cnv.Font.Color := cSugarLevelColor;
      cnv.Font.Size := GetDrawStageSize(dsSugarLevel);
      Text := ' ' + Entry.GetSugarStr(Settings.IsMmolL) + ' ';
      TextSize := cnv.TextExtent(Text);

      if dsSugarExtremePoints in DrawStages then
      begin
        if (i = 0) or (i = EntriesCount - 1) or
          (Entry.Sugar = Entries.GetMaxSugar) or
          (Entry.Sugar = Entries.GetMinSugar) then
        begin
          cnv.Brush.Color := cSugarExtremePointsBrushColor;
          cnv.Font.Color := cSugarExtremePointsColor;
        end
        else if not (dsSugarLevel in DrawStages) then
        begin
          Continue;
        end;
      end;

      // Draw sugar level value in the center of graph point
      cnv.TextOut(
        Floor(x - TextSize.cx / 2),
        Floor(y - TextSize.cy / 2),
        Text);
      cnv.MoveTo(x, y);
    end;
  end;

  if (dsLastSugarLevel in DrawStages) or (dsSugarSlope in DrawStages)  then
  begin
    Entry := Entries.Last;
    cnv.Brush.Color := Color;
    SetBkMode(cnv.Handle, TRANSPARENT);
    cnv.Font.Size := GetDrawStageSize(dsLastSugarLevel);
    Text := Entry.GetSugarStr(Settings.IsMmolL);
    TextSize := cnv.TextExtent(Text);
    LastSugarLevelPoint.X := Floor((DrawPanel.Width - TextSize.cx) / 2);
    if dsSugarSlope in DrawStages then
      LastSugarLevelPoint.X := LastSugarLevelPoint.X - Floor((TextSize.cx / 4));
    LastSugarLevelPoint.Y := Floor((DrawPanel.Height - TextSize.cy - (DrawPanel.Height / 10)) / 2);

    if (Entry.Sugar <= Settings.UrgentLowGlucoseAlarm) or
      (Entry.Sugar >= Settings.UrgentHighGlucoseAlarm) then
      FontColor := cUrgentAlarmColor
    else if (Entry.Sugar <= Settings.LowGlucoseAlarm) or
      (Entry.Sugar >= Settings.HighGlucoseAlarm) then
      FontColor := cAlarmColor
    else
      FontColor := cLastSugarLevelColor;

    if dsLastSugarLevel in DrawStages then
    begin
      // Draw sugar level value in the center of graph point
      OffsetPoints[0] := Point( 0, -3);
      OffsetPoints[1] := Point( 2, -2);
      OffsetPoints[2] := Point( 3,  0);
      OffsetPoints[3] := Point( 2,  2);
      OffsetPoints[4] := Point( 0,  3);
      OffsetPoints[5] := Point(-2,  2);
      OffsetPoints[6] := Point(-3,  0);
      OffsetPoints[7] := Point(-2, -2);
      // Draw stroke
      cnv.Font.Color := Color;
      for i := 0 to High(OffsetPoints) do
        cnv.TextOut(
          LastSugarLevelPoint.X + OffsetPoints[i].X,
          LastSugarLevelPoint.Y + OffsetPoints[i].Y, Text);

      // Draw main text
      cnv.Font.Color := FontColor;
      cnv.TextOut(LastSugarLevelPoint.X, LastSugarLevelPoint.Y, Text);
    end;

    if dsSugarSlope in DrawStages then
    begin
      SlopeRectWidth := TextSize.cy div 3;
      SlopeRect := Rect(0, 0, SlopeRectWidth, TextSize.cy);
      ArrowRect := Rect(0,0,0,0);
      CanDrawArrow := GetArrowRect(Entry.Slope, SlopeRect, ArrowRect);

      ArrowCount := Entry.GetArrowCountOfSlope;
      ArrowOffsetX := LastSugarLevelPoint.X + Floor((TextSize.cx * 1.2));
      OffsetRect(ArrowRect, ArrowOffsetX, LastSugarLevelPoint.Y); // Move SlopeRect to the left side of dsLastSugarLevel text

      for i := 1 to ArrowCount do
      begin
        DrawArrow(ArrowRect.TopLeft, ArrowRect.BottomRight, CanDrawArrow, cnv, FontColor);
        ArrowOffsetX := Floor((SlopeRect.Right - SlopeRect.Left) / 1.5);
        OffsetRect(ArrowRect, ArrowOffsetX, 0);
      end;
    end;
  end;

  if dsLastSugarLevelDate in DrawStages then
  begin
    Entry := Entries.Last;
    cnv.Brush.Color := Color;
    SetBkMode(cnv.Handle, TRANSPARENT);
    cnv.Font.Size := GetDrawStageSize(dsLastSugarLevelDate);
    Text := Settings.GetLastSugarLevelDateText(Entry, LastSugarLevelDateColor);
    cnv.Font.Color := LastSugarLevelDateColor;
    TextSize := cnv.TextExtent(Text);
    cnv.TextOut(
      Floor(DrawPanel.Width - TextSize.cx - 5),
      Floor(DrawPanel.Height - TextSize.cy),
      Text);
  end;
end;

procedure TfMain.DoDraw(Sender: TObject);
begin
  if Entries.Count = 0 then
    DrawTextInCenter('No data');

  DoDrawStages(Settings.DrawStages);
end;

procedure TfMain.DoUpdateCallerFormWithSettings;
begin
  HardInvalidate;
  ApplyWindowSettings;
  Settings.SetScaleIndex(Settings.ScaleIndex);
  SetAlphaBlendValue(Settings.AlphaBlendValue);
end;

procedure TfMain.ApplyWindowSettings();
begin
  actShowCheckNewDataProgressBar.Checked := Settings.ShowCheckNewDataProgressBar;
  actShowCheckNewDataProgressBarExecute(actShowCheckNewDataProgressBar);
  actShowWindowBorder.Checked := Settings.ShowWindowBorder;
  actShowWindowBorderExecute(actShowWindowBorder);
  actFullScreen.Checked := Settings.FullScreen;
  actFullScreenExecute(actFullScreen);
end;


end.
