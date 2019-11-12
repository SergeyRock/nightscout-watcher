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
  uSettings, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs,
  DateUtils, Contnrs, ExtCtrls, Menus, uNightscout, ComCtrls, ActnList;

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
    actDrawGlucoseLevelDelta: TAction;
    actDrawGlucoseAvg: TAction;
    actDrawWallpaper: TAction;
    actStayOnTop: TAction;
    miStayOnTop: TMenuItem;
    miDrawWallpaper: TMenuItem;
    miDrawGlucoseAvg: TMenuItem;
    miSeparator4: TMenuItem;
    miOpacity15: TMenuItem;
    miOpacity100: TMenuItem;
    miOpacity90: TMenuItem;
    miOpacity75: TMenuItem;
    miOpacity50: TMenuItem;
    miOpacity25: TMenuItem;
    miOpacity: TMenuItem;
    miScale: TMenuItem;
    miScale1: TMenuItem;
    miScale2: TMenuItem;
    miScale3: TMenuItem;
    miScale4: TMenuItem;
    miScale5: TMenuItem;
    miScale6: TMenuItem;
    miScale7: TMenuItem;
    miScale8: TMenuItem;
    miScale9: TMenuItem;
    miScale10: TMenuItem;
    miScale11: TMenuItem;
    miScale12: TMenuItem;
    miScale13: TMenuItem;
    miScale14: TMenuItem;
    miScale15: TMenuItem;
    miScale16: TMenuItem;
    miScale17: TMenuItem;
    miScale18: TMenuItem;
    miDrawGlucoseLevelDelta: TMenuItem;
    miSeparator1: TMenuItem;
    pm: TPopupMenu;
    tmr: TTimer;
    pb: TProgressBar;
    tmrProgressBar: TTimer;
    al: TActionList;
    actDrawGlucoseLevel: TAction;
    actDrawGlucoseLines: TAction;
    actDrawLastGlucoseLevel: TAction;
    miDrawLastGlucoseLevel: TMenuItem;
    miDrawGlucoseLevel: TMenuItem;
    miDrawGlucoseLines: TMenuItem;
    miSeparator2: TMenuItem;
    actVisitNightscoutSite: TAction;
    miVisitNightscoutSite: TMenuItem;
    actShowCheckNewDataProgressBar: TAction;
    miShowCheckNewDataProgressBar: TMenuItem;
    actHelp: TAction;
    miHelp: TMenuItem;
    actDrawLastGlucoseLevelDate: TAction;
    miDrawLastGlucoseLevelDate: TMenuItem;
    actSetNightscoutSite: TAction;
    miSetNightscoutSite: TMenuItem;
    miSeparator3: TMenuItem;
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
    actDrawGlucoseSlope: TAction;
    miDrawGlucoseSlope: TMenuItem;
    actDrawGlucoseExtremePoints: TAction;
    miDrawGlucoseExtremePoints: TMenuItem;
    actSetCountOfEntriesToRecive: TAction;
    miSetCountOfEntriesToRecive: TMenuItem;
    actShowSettings: TAction;
    miShowSettings: TMenuItem;
    actDrawAlertLines: TAction;
    miDrawAlertLines: TMenuItem;
    actFullScreen: TAction;
    miFullScreen: TMenuItem;
    actDrawGlucoseLevelPoints: TAction;
    miDrawGlucoseLevelPoints: TMenuItem;
    procedure actStayOnTopExecute(Sender: TObject);
    procedure DoScaleIndexClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CheckStaleDataAlarms;
    procedure DoOpacityPercentClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure tmrTimer(Sender: TObject);
    procedure tmrProgressBarTimer(Sender: TObject);
    procedure DoDrawStageExecute(Sender: TObject);
    procedure actVisitNightscoutSiteExecute(Sender: TObject);
    procedure actShowCheckNewDataProgressBarExecute(Sender: TObject);
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
    procedure DoShowSettingsExecute(Sender: TObject);
    procedure actFullScreenExecute(Sender: TObject);
  private
    StaleAlarmBlinkTrigger: Boolean;
    NeedStaleDataBlink: Boolean;
    FPressed : Boolean;
    Loaded: Boolean;
    FPosX : Integer;
    FPosY : Integer;
    Settings: TSettings;
    DrawPanel: TDrawPanel;
    Entries: TNightscoutEntryList;
    OptionsFileName: string;
    Connected: Boolean;
    WasAlphaBlend: Boolean;
    BoundsRectLoaded: TRect;
    Wallpaper: TBitmap;
    WallpaperJPG: TJPEGImage;
    cnv: TCanvas;
    procedure CreateDrawPanel();
    procedure DrawStrokedText(const Text: string; const X, Y: Integer; const TextColor: TColor);
    function GetHintText(): string;
    function LoadWallpeper(const FileName: string): Boolean;
    procedure ResetWindowBoundsToDefault();
    procedure SaveOptions();
    procedure LoadOptions();
    function LoadEntriesData: Boolean;
    procedure SetActionCheckProperty(Action: TAction; Checked: Boolean; DrawStage: TDrawStage);
    function GetArrowRect(Slope: string; ArrowAreaRect: TRect; var OutPoints: TRect): Boolean;
    procedure DrawArrow(P1, P2: TPoint; DrawArrowEnd: boolean;
      GlucoseSlopeColor: TColor; ArrowWidth: Integer);
    procedure DoDrawStages(DrawStages: TDrawStages);
    procedure DrawTextInCenter(const Text: string);
    procedure DoDraw(Sender: TObject);
    procedure DoUpdateCallerFormWithSettings;
    function SetNightscoutUrl(Url: string): Boolean;
    function SetCheckIntervalByString(Value: string): Boolean;
    function SetMaximumDrawStageSizeToCanvas(DrawStage: TDrawStage; const Text: string): Byte;
    procedure SetAlphaBlendValue(Value: Integer);
    procedure RefreshCheckInterval;
    function GetEntriesUrl: string;
    function GetDrawStageSize(DrawStage: TDrawStage; ScaleIndex: Integer = -1): Integer;
    procedure HardInvalidate();
    procedure ApplyWindowSettings();
    procedure SetScaleIndex(ScaleIndex: Integer);
    procedure SetSystemStayOnTop(StayOnTop: Boolean);
    procedure UpdateApplicationTitle();
    procedure UpdateHint();
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

{$R *.lfm}

{ TDrawPannel }

procedure TDrawPanel.Paint;
begin
  inherited;
  if Assigned(FOnPaint) then
    FOnPaint(Self);
end;

{ TfMain }

procedure TfMain.SetSystemStayOnTop(StayOnTop: Boolean);
begin
  Settings.StayOnTop := StayOnTop;
  if StayOnTop then
    FormStyle := fsSystemStayOnTop
  else
    FormStyle := fsNormal;
  actStayOnTop.Checked := StayOnTop;
end;

procedure TfMain.SetScaleIndex(ScaleIndex: Integer);
var
  i: Integer;
begin
  if Settings.SetScaleIndex(ScaleIndex) then
    HardInvalidate();

  for i := 0 to miScale.Count - 1 do
    miScale.Items[i].Checked := miScale.Items[i].Tag = ScaleIndex;

  miScale.Caption := 'Scale (' + IntToStr(ScaleIndex * 10) + '%)'
end;

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
  if InputQuery('Count of entries', 'Type in the count of glucose entries to recieve from Nightscout site', Count) then
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
  LoadWallpeper(Settings.WallpaperFileName);
end;

procedure TfMain.DoShowSettingsExecute(Sender: TObject);
begin
  FormStyle := fsNormal;
  try
    TfSettings.ShowForm(Self, Settings, DoUpdateCallerFormWithSettings, LoadEntriesData, TAction(Sender).Tag);
    DoUpdateCallerFormWithSettings();
    tmrTimer(tmr);
  finally
    SetSystemStayOnTop(Settings.StayOnTop);
  end;
end;

procedure TfMain.actShowWindowBorderExecute(Sender: TObject);
var
  OldWindowRect: TRect;
begin
  Settings.ShowWindowBorder := TAction(Sender).Checked;
  OldWindowRect := BoundsRect;
  if TAction(Sender).Checked then
    BorderStyle := bsSizeable
  else
    BorderStyle := bsNone;

  if not Settings.FullScreen then
  begin
    // Reset window bounds after FullScreen turning off if window bounds are so big
    if (Abs(OldWindowRect.Right) - Abs(OldWindowRect.Left) + cMoveWindowDelta >= Screen.Width) or
       (Abs(OldWindowRect.Bottom) - Abs(OldWindowRect.Top) + cMoveWindowDelta >= Screen.Height) then
      ResetWindowBoundsToDefault()
    else
      BoundsRect := OldWindowRect;
  end;
end;

procedure TfMain.ResetWindowBoundsToDefault();
var
  WindowRect: TRect;
begin
  WindowRect.Left := Ceil(Screen.Width * 0.75);
  WindowRect.Top := Ceil(Screen.Height * 0.75);
  WindowRect.Right := Screen.Width;
  WindowRect.Bottom := Screen.Height;
  OffsetRect(WindowRect, -cMoveWindowDelta, -Screen.Height div 2);
  BoundsRect := WindowRect;
end;

procedure TfMain.actSetUnitOfMeasureMmolLExecute(Sender: TObject);
begin
  Settings.IsMmolL := TAction(Sender).Checked;
  UpdateHint();
  HardInvalidate();
end;

procedure TfMain.actVisitNightscoutSiteExecute(Sender: TObject);
begin
  OpenDocument(Settings.NightscoutUrl);
end;

procedure TfMain.CreateDrawPanel();
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
  cnv := DrawPanel.Canvas;
  cnv.Font.Quality := fqAntialiased;
end;

procedure TfMain.FormCreate(Sender: TObject);
begin
  Loaded := False;
  Wallpaper := TBitmap.Create();
  WallpaperJPG := TJPEGImage.Create();
  StaleAlarmBlinkTrigger := False;
  Settings := TSettings.Create();

  Connected := False;
  OptionsFileName := ExtractFilePath(ParamStr(0)) +  'Options.ini';
  Entries := TNightscoutEntryList.Create;

  CreateDrawPanel();
  Caption := Caption + '. Ver: ' + GetVersion();
end;

procedure TfMain.FormDestroy(Sender: TObject);
begin
  SaveOptions();
  FreeAndNil(Entries);
  FreeAndNil(Settings);
  FreeAndNil(WallpaperJPG);
  FreeAndNil(Wallpaper);
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
      VK_UP:    SetAlphaBlendValue(Settings.AlphaBlendValue + cAlphaBlendValueDelta);
      VK_DOWN:  SetAlphaBlendValue(Settings.AlphaBlendValue - cAlphaBlendValueDelta);
    end;
  end
  else if Shift = [ssCtrl] then
  begin
    // Scale
    case Key of
      VK_UP:   SetScaleIndex(Settings.ScaleIndex + 1);
      VK_DOWN: SetScaleIndex(Settings.ScaleIndex - 1);
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

procedure TfMain.CheckStaleDataAlarms;
var
  Entry: TNightscoutEntry;
  StaleAlarmReached, UrgentStaleAlarmReached: Boolean;
begin
  StaleAlarmReached := False;
  UrgentStaleAlarmReached := False;

  Entry := Entries.Last();
  if Assigned(Entry) then
  begin
    StaleAlarmReached := Settings.IsStaleDataAlarmExists(Entry);
    UrgentStaleAlarmReached := Settings.IsUrgentStaleDataAlarmExists(Entry);
    StaleAlarmBlinkTrigger := not StaleAlarmBlinkTrigger;
  end;
  NeedStaleDataBlink := Settings.EnableStaleDataAlarms and
    (StaleAlarmReached or UrgentStaleAlarmReached) ;
  Invalidate();
end;

procedure TfMain.DoOpacityPercentClick(Sender: TObject);
begin
  SetAlphaBlendValue(Round(255 * TComponent(Sender).Tag / 100));
end;

procedure TfMain.FormResize(Sender: TObject);
begin
  LoadWallpeper(Settings.WallpaperFileName);
end;

procedure TfMain.DoScaleIndexClick(Sender: TObject);
begin
  SetScaleIndex(TComponent(Sender).Tag);
end;

procedure TfMain.actStayOnTopExecute(Sender: TObject);
begin
  SetSystemStayOnTop(TAction(Sender).Checked);
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

  if Shift = [] then
    SetScaleIndex(Settings.ScaleIndex + Direction)
  else if Shift = [ssShift] then
    SetFormBounds(Direction)
  else if Shift = [ssAlt] then
    SetAlphaBlendValue(Settings.AlphaBlendValue + cAlphaBlendValueDelta * Direction);
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
  if Loaded then
    Exit;

  Loaded := True;

  LoadOptions();

  if Settings.NightscoutUrl = '' then
    actSetNightscoutSiteExecute(actSetNightscoutSite)
  else
    tmrTimer(tmr); // Load data from nightscout site and start monitoring
end;

function TfMain.GetEntriesUrl: string;
begin
  Result := Settings.NightscoutUrl + '/api/v1/entries/sgv?count=' + IntToStr(Settings.CountOfEntriesToRecive);
end;

function TfMain.GetDrawStageSize(DrawStage: TDrawStage; ScaleIndex: Integer = -1): Integer;
var
  i: Integer;
begin
  case DrawStage of
    dsLastGlucoseLevel: i :=1;
    dsGlucoseLevel: i := 2;
    dsLastGlucoseLevelDate: i := 3;
    dsGlucoseLines: i := 4;
    dsGlucoseSlope: i := 5;
    dsGlucoseLevelDelta: i := 6;
    dsGlucoseAvg: i := 7;
  else
    Result:= Font.Size;
    Exit;
  end;

  ScaleIndex := IfThen(ScaleIndex = -1, Settings.ScaleIndex, ScaleIndex);
  Result := cDrawStageSizes[i][ScaleIndex];
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
    DeleteUrlCacheEntry(PAnsiChar(GetEntriesUrl()));
    IsFileDownloaded := URLDownloadToFile(nil, PAnsiChar(GetEntriesUrl()), PAnsiChar(FileName), 0, nil) = S_OK;

    if not IsFileDownloaded then
    begin
      ShowMessage('File downloading is failed. URL: ' + GetEntriesUrl());
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

procedure TfMain.LoadOptions();
var
  ini: TIniFile;
  DrawStageChecked: Boolean;
begin
  ini := TIniFile.Create(OptionsFileName);
  try
    Settings.NightscoutUrl := ini.ReadString('Main', 'NightscoutUrl', '');
    Settings.IsMmolL := ini.ReadBool('Main', 'IsMmolL', Settings.IsMmolL);
    actSetUnitOfMeasureMmolL.Checked := Settings.IsMmolL;
    Settings.CheckInterval := ini.ReadInteger('Main', 'CheckInterval', Settings.CheckInterval);
    Settings.TimeZoneCorrection := ini.ReadInteger('Main', 'TimeZoneCorrection', Settings.TimeZoneCorrection);
    Settings.CountOfEntriesToRecive := ini.ReadInteger('Main', 'CountOfEntriesToRecive', Settings.CountOfEntriesToRecive);

    DrawStageChecked := ini.ReadBool('Visual', 'dsLastGlucoseLevel', Settings.IsInDrawStage(dsLastGlucoseLevel));
    SetActionCheckProperty(actDrawLastGlucoseLevel, DrawStageChecked, dsLastGlucoseLevel);

    DrawStageChecked := ini.ReadBool('Visual', 'dsGlucoseLines', Settings.IsInDrawStage(dsGlucoseLines));
    SetActionCheckProperty(actDrawGlucoseLines, DrawStageChecked, dsGlucoseLines);

    DrawStageChecked := ini.ReadBool('Visual', 'dsGlucoseLevel', Settings.IsInDrawStage(dsGlucoseLevel));
    SetActionCheckProperty(actDrawGlucoseLevel, DrawStageChecked, dsGlucoseLevel);

    DrawStageChecked := ini.ReadBool('Visual', 'dsHorzGuideLines', Settings.IsInDrawStage(dsHorzGuideLines));
    SetActionCheckProperty(actDrawHorzGuideLines, DrawStageChecked, dsHorzGuideLines);

    DrawStageChecked := ini.ReadBool('Visual', 'dsVertGuideLines', Settings.IsInDrawStage(dsVertGuideLines));
    SetActionCheckProperty(actDrawVertGuideLines, DrawStageChecked, dsVertGuideLines);

    DrawStageChecked := ini.ReadBool('Visual', 'dsLastGlucoseLevelDate', Settings.IsInDrawStage(dsLastGlucoseLevelDate));
    SetActionCheckProperty(actDrawLastGlucoseLevelDate, DrawStageChecked, dsLastGlucoseLevelDate);

    DrawStageChecked := ini.ReadBool('Visual', 'dsGlucoseSlope', Settings.IsInDrawStage(dsGlucoseSlope));
    SetActionCheckProperty(actDrawGlucoseSlope, DrawStageChecked, dsGlucoseSlope);

    DrawStageChecked := ini.ReadBool('Visual', 'dsGlucoseExtremePoints', Settings.IsInDrawStage(dsGlucoseExtremePoints));
    SetActionCheckProperty(actDrawGlucoseExtremePoints, DrawStageChecked, dsGlucoseExtremePoints);

    DrawStageChecked := ini.ReadBool('Visual', 'dsAlertLines', Settings.IsInDrawStage(dsAlertLines));
    SetActionCheckProperty(actDrawAlertLines, DrawStageChecked, dsAlertLines);

    DrawStageChecked := ini.ReadBool('Visual', 'dsGlucoseLevelPoints', Settings.IsInDrawStage(dsGlucoseLevelPoints));
    SetActionCheckProperty(actDrawGlucoseLevelPoints, DrawStageChecked, dsGlucoseLevelPoints);

    DrawStageChecked := ini.ReadBool('Visual', 'dsGlucoseLevelDelta', Settings.IsInDrawStage(dsGlucoseLevelDelta));
    SetActionCheckProperty(actDrawGlucoseLevelDelta, DrawStageChecked, dsGlucoseLevelDelta);

    DrawStageChecked := ini.ReadBool('Visual', 'dsGlucoseAvg', Settings.IsInDrawStage(dsGlucoseAvg));
    SetActionCheckProperty(actDrawGlucoseAvg, DrawStageChecked, dsGlucoseAvg);

    DrawStageChecked := ini.ReadBool('Visual', 'dsWallpaper', Settings.IsInDrawStage(dsWallpaper));
    SetActionCheckProperty(actDrawWallpaper, DrawStageChecked, dsWallpaper);
    Settings.WallpaperFileName := ini.ReadString('Main', 'WallpaperFileName', '');

    Settings.ShowCheckNewDataProgressBar := ini.ReadBool('Visual', 'ShowCheckNewDataProgressBar', Settings.ShowCheckNewDataProgressBar);

    BoundsRectLoaded.Left := ini.ReadInteger('Visual', 'WindowLeft', Screen.Width div 2);
    BoundsRectLoaded.Top := ini.ReadInteger('Visual', 'WindowTop', Screen.Height div 2);
    BoundsRectLoaded.Right := ini.ReadInteger('Visual', 'WindowRight', Screen.Width);
    BoundsRectLoaded.Bottom := ini.ReadInteger('Visual', 'WindowBottom', Screen.Height);

    SetAlphaBlendValue(ini.ReadInteger('Visual', 'AlphaBlendValue', Settings.AlphaBlendValue));

    SetScaleIndex(ini.ReadInteger('Visual', 'ScaleIndex', Settings.ScaleIndex));
    Settings.ShowWindowBorder := ini.ReadBool('Visual', 'ShowWindowBorder', Settings.ShowWindowBorder);
    Settings.FullScreen := ini.ReadBool('Visual', 'FullScreen', Settings.FullScreen);
    Settings.StayOnTop := ini.ReadBool('Visual', 'StayOnTop', Settings.StayOnTop);

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
  BoundsRect := BoundsRectLoaded;
  ApplyWindowSettings();
  LoadWallpeper(Settings.WallpaperFileName);
  SetSystemStayOnTop(Settings.StayOnTop);
  HardInvalidate();
end;

procedure TfMain.SaveOptions();
var
  ini: TIniFile;
begin
  ini := TIniFile.Create(OptionsFileName);
  try
    ini.WriteBool('Main', 'IsMmolL', Settings.IsMmolL);
    ini.WriteString('Main', 'NightscoutUrl', Settings.NightscoutUrl);
    ini.WriteInteger('Main', 'CountOfEntriesToRecive', Settings.CountOfEntriesToRecive);
    ini.WriteInteger('Main', 'TimeZoneCorrection', Settings.TimeZoneCorrection);
    ini.WriteInteger('Main', 'CheckInterval', Settings.CheckInterval);

    ini.WriteBool('Visual', 'dsLastGlucoseLevel',     Settings.IsInDrawStage(dsLastGlucoseLevel));
    ini.WriteBool('Visual', 'dsGlucoseLines',         Settings.IsInDrawStage(dsGlucoseLines));
    ini.WriteBool('Visual', 'dsGlucoseLevel',         Settings.IsInDrawStage(dsGlucoseLevel));
    ini.WriteBool('Visual', 'dsHorzGuideLines',       Settings.IsInDrawStage(dsHorzGuideLines));
    ini.WriteBool('Visual', 'dsVertGuideLines',       Settings.IsInDrawStage(dsVertGuideLines));
    ini.WriteBool('Visual', 'dsLastGlucoseLevelDate', Settings.IsInDrawStage(dsLastGlucoseLevelDate));
    ini.WriteBool('Visual', 'dsGlucoseSlope',         Settings.IsInDrawStage(dsGlucoseSlope));
    ini.WriteBool('Visual', 'dsGlucoseExtremePoints', Settings.IsInDrawStage(dsGlucoseExtremePoints));
    ini.WriteBool('Visual', 'dsAlertLines',           Settings.IsInDrawStage(dsAlertLines));
    ini.WriteBool('Visual', 'dsGlucoseLevelPoints',   Settings.IsInDrawStage(dsGlucoseLevelPoints));
    ini.WriteBool('Visual', 'dsGlucoseLevelDelta',    Settings.IsInDrawStage(dsGlucoseLevelDelta));
    ini.WriteBool('Visual', 'dsGlucoseAvg',           Settings.IsInDrawStage(dsGlucoseAvg));
    ini.WriteBool('Visual', 'dsWallpaper',            Settings.IsInDrawStage(dsWallpaper));

    ini.WriteString('Main', 'WallpaperFileName', Settings.WallpaperFileName);

    ini.WriteBool('Visual', 'ShowCheckNewDataProgressBar', Settings.ShowCheckNewDataProgressBar);
    ini.WriteBool('Visual', 'ShowWindowBorder', Settings.ShowWindowBorder);
    ini.WriteBool('Visual', 'FullScreen', Settings.FullScreen);
    ini.WriteInteger('Visual', 'AlphaBlendValue', Settings.AlphaBlendValue);

    // Save window position and size
    ini.WriteInteger('Visual', 'WindowLeft', BoundsRect.Left);
    ini.WriteInteger('Visual', 'WindowTop', BoundsRect.Top);
    ini.WriteInteger('Visual', 'WindowRight', BoundsRect.Right);
    ini.WriteInteger('Visual', 'WindowBottom', BoundsRect.Bottom);

    ini.WriteInteger('Visual', 'ScaleIndex', Settings.ScaleIndex);
    ini.WriteBool('Visual', 'StayOnTop', Settings.StayOnTop);

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
  if Value >= 255 then
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
  miOpacity.Caption := 'Opacity (' + IntToStr(Round(Settings.AlphaBlendValue / 255 * 100 )) + '%)';
end;

function TfMain.SetCheckIntervalByString(Value: string): Boolean;
begin
  Result := TryStrToInt(Value, Settings.CheckInterval);
  if Result then
  begin
    tmr.Interval := Settings.CheckInterval * 1000;
    pb.Position := 0;
    pb.Max := Floor(tmr.Interval / 1000);
  end;
end;

function TfMain.SetMaximumDrawStageSizeToCanvas(DrawStage: TDrawStage; const Text: string): Byte;
var
  TextSize: TSize;
  ScaleIndex: Integer;
begin
  ScaleIndex := Settings.ScaleIndex;
  repeat
    cnv.Font.Size := GetDrawStageSize(DrawStage, ScaleIndex);
    TextSize := cnv.TextExtent(Text);
    Dec(ScaleIndex);
  until (ScaleIndex < 1) or ((TextSize.cx < ClientWidth) and (TextSize.cy < ClientHeight)) ;
  Result := ScaleIndex + 1;
end;

procedure TfMain.HardInvalidate();
begin
  OnResize := nil;
  // Crutch for Invalidate bug on Win7 and lower
  if WindowState = wsMaximized then
  begin
    AlphaBlend := not AlphaBlend;
    AlphaBlend := not AlphaBlend;
  end
  else
  begin
    Width := Width + 1;
    Width := Width - 1;
  end;
  pb.Height := cProgressBarHeights[Settings.ScaleIndex];
  Invalidate;
  OnResize := FormResize;
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
  CheckStaleDataAlarms;
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
    StaleAlarmBlinkTrigger := False;
  end
  else
    actSetNightscoutSiteExecute(actSetNightscoutSite);

  UpdateHint();
  UpdateApplicationTitle();
  HardInvalidate();
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

procedure TfMain.DrawArrow(P1, P2: TPoint; DrawArrowEnd: boolean; GlucoseSlopeColor: TColor; ArrowWidth: Integer);
var
  Angle, Distance: Double;
  ArrowLength: Integer;
  P3, P4: TPoint;
begin
  cnv.Pen.Color := GlucoseSlopeColor;
  cnv.Pen.Width := ArrowWidth;
  cnv.MoveTo(P1.X, P1.Y);
  cnv.LineTo(P2.X, P2.Y);
  if DrawArrowEnd then
  begin
    Angle:= 180 * ArcTan2(P2.y - P1.y, P2.x - P1.x) / pi;
    Distance := Sqrt(Sqr(P2.X - P1.X) + Sqr(P2.Y - P1.Y));
    ArrowLength := Round(Distance / 3);

    P3 := Point(P2.X + Round(ArrowLength * cos(pi * (Angle + 150) / 180)), P2.y + Round(ArrowLength * sin(pi * (Angle + 150) / 180)));
    P4 := Point(P2.X + Round(ArrowLength * cos(pi * (Angle - 150) / 180)), P2.y + Round(ArrowLength * sin(pi * (Angle - 150) / 180)));

    cnv.MoveTo(P2.X, P2.Y);
    cnv.LineTo(P3.X, P3.y);
    cnv.MoveTo(P2.X, P2.Y);
    cnv.LineTo(P4.X, P4.y);
  end;
end;

procedure TfMain.DrawTextInCenter(const Text: string);
var
  TextSize: TSize;
  TextPoint: TPoint;
begin
  cnv.Brush.Color := Color;
  SetBkMode(cnv.Handle, TRANSPARENT);
  cnv.Font.Size := GetDrawStageSize(dsLastGlucoseLevel);
  TextSize := cnv.TextExtent(Text);
  TextPoint.X := Floor((DrawPanel.Width - TextSize.cx) / 2);
  TextPoint.Y := Floor((DrawPanel.Height - TextSize.cy - (DrawPanel.Height / 10)) / 2);
  cnv.Font.Color := cLastGlucoseLevelColor;
  cnv.TextOut(TextPoint.X, TextPoint.Y, Text);
end;

procedure TfMain.DoDrawStages(DrawStages: TDrawStages);
const
  cMarginX = 0.85;
  cMarginY = 0.7;
  cSmallMargin = 4;
var
  GlucoseLinesWidths: array [0..1] of Byte;
  i, x, y, EntriesCount, SlopeRectWidth, ArrowCount, ArrowOffsetX, MaxY, GlucoseLevelPointRadius,
    SlopeWidth, j: integer;
  EntryWidth, EntryHeight, MarginX, MarginY: Double;
  Entry, LastEntry: TNightscoutEntry;
  Text, TextWithSlope: string;
  TextSize: TSize;
  LastGlucoseLevelPoint, GlucoseMarker: TPoint;
  SlopeRect, ArrowRect, TextRect: TRect;
  CanDrawArrow, NeedDrawGlucoseExtremePoints: Boolean;
  LastGlucoseLevelDateColor, FontColor: TColor;
  GlucoseSlopeScaleIndex: Byte;
begin
  EntriesCount := Entries.Count;
  if EntriesCount < 2 then
    Exit;

  LastEntry := Entries.Last;

  EntryWidth := (DrawPanel.Width * cMarginX) / (EntriesCount - 1);

  if (dsWallpaper in DrawStages) and not Wallpaper.Empty then
    cnv.Draw(0, 0, Wallpaper);

  if dsAlertLines in DrawStages then
  begin
    MaxY := Max(Settings.UrgentHighGlucoseAlarm, Entries.GetMaxGlucose);
    EntryHeight := (DrawPanel.Height * cMarginY) /
      (Entries.GetMaxGlucoseDelta(Settings.UrgentLowGlucoseAlarm, Settings.UrgentHighGlucoseAlarm) + 1);
  end
  else
  begin
    MaxY := Entries.GetMaxGlucose;
    EntryHeight := (DrawPanel.Height * cMarginY) /
      (Entries.GetMaxGlucoseDelta(-1, -1) + 1);
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

  if dsAlertLines in DrawStages then
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

  if dsGlucoseLines in DrawStages then
  begin
    GlucoseLinesWidths[1] := GetDrawStageSize(dsGlucoseLines);
    GlucoseLinesWidths[0] := GlucoseLinesWidths[1] + 4;
    for i := Low(GlucoseLinesWidths) to High(GlucoseLinesWidths) do
    begin
      cnv.Pen.Width := GlucoseLinesWidths[i];
      for j := 0 to EntriesCount - 1 do
      begin
        Entry := Entries[j];
        if i = 0 then
          cnv.Pen.Color := Color // Stroke color
        else
          cnv.Pen.Color := Settings.GetColorByGlucoseLevel(Entry.Glucose);
        x := Floor(EntryWidth * j + MarginX);
        y := Floor(EntryHeight * (MaxY - Entry.Glucose) + MarginY);
        if j = 0 then
          cnv.MoveTo(x, y)
        else
          cnv.LineTo(x, y);
      end;
    end;
  end;

  if (dsGlucoseLevelPoints in DrawStages) or (dsGlucoseLevel in DrawStages) or
    (dsGlucoseExtremePoints in DrawStages) then
  begin
    cnv.Pen.Color := clBlack;
    cnv.Pen.Width := 1;
    for i := 0 to EntriesCount - 1 do
    begin
      Entry := Entries[i];
      x := Floor(EntryWidth * i + MarginX);
      y := Floor(EntryHeight * (MaxY - Entry.Glucose) + MarginY);

      if (dsGlucoseLevelPoints in DrawStages) then
      begin
        GlucoseLevelPointRadius := GetDrawStageSize(dsGlucoseLines) * 2;
        cnv.Brush.Color := Settings.GetColorByGlucoseLevel(Entry.Glucose);
        cnv.Pen.Width := 1;
        cnv.Ellipse(x - GlucoseLevelPointRadius,
                    y - GlucoseLevelPointRadius,
                    x + GlucoseLevelPointRadius,
                    y + GlucoseLevelPointRadius);
      end;

      cnv.Font.Size := GetDrawStageSize(dsGlucoseLevel);
      Text := Entry.GetGlucoseStr(Settings.IsMmolL);
      TextSize := cnv.TextExtent(Text);
      NeedDrawGlucoseExtremePoints :=
        (dsGlucoseExtremePoints in DrawStages) and
        ((i = 0) or
         (i = EntriesCount - 1) or
         (Entry.Glucose = Entries.GetMaxGlucose) or
         (Entry.Glucose = Entries.GetMinGlucose));

      GlucoseMarker.X := Floor(x - TextSize.cx / 2);
      GlucoseMarker.Y := Floor(y - TextSize.cy / 2);
      TextRect := Rect(GlucoseMarker.X, GlucoseMarker.Y, GlucoseMarker.X + TextSize.cx, GlucoseMarker.Y + TextSize.cy);
      InflateRect(TextRect, 2, 1);

      if (dsGlucoseLevel in DrawStages) and not NeedDrawGlucoseExtremePoints then
      begin
        cnv.Brush.Color := cGlucoseLevelBrushColor;
        cnv.Font.Color := cGlucoseLevelColor;
        // Draw glucose level value in the center of graph point
        cnv.Rectangle(TextRect);
        cnv.TextOut(GlucoseMarker.X, GlucoseMarker.Y, Text);
        //cnv.MoveTo(x, y);
      end;

      if NeedDrawGlucoseExtremePoints then
      begin
        cnv.Brush.Color := cGlucoseExtremePointsBrushColor;
        cnv.Font.Color := cGlucoseExtremePointsColor;
        cnv.Rectangle(TextRect);
        cnv.TextOut(GlucoseMarker.X, GlucoseMarker.Y, Text);
        //cnv.MoveTo(x, y);
      end;
    end;
  end;

  if (NeedStaleDataBlink and StaleAlarmBlinkTrigger) or
    (not NeedStaleDataBlink and (dsLastGlucoseLevelDate in DrawStages)) then
  begin
    cnv.Brush.Color := Color;
    SetBkMode(cnv.Handle, TRANSPARENT);
    Text := Settings.GetGlucoseLevelDateText(LastEntry.Date, Now(), LastGlucoseLevelDateColor);
    SetMaximumDrawStageSizeToCanvas(dsLastGlucoseLevelDate, Text);
    TextSize := cnv.TextExtent(Text);
    DrawStrokedText(Text,
      Floor(DrawPanel.Width - TextSize.cx - cSmallMargin),
      Floor(DrawPanel.Height - TextSize.cy - cSmallMargin),
      LastGlucoseLevelDateColor);
  end;

  if dsGlucoseLevelDelta in DrawStages then
  begin
    cnv.Brush.Color := Color;
    SetBkMode(cnv.Handle, TRANSPARENT);
    Text := Entries.GetGlucoseLevelDeltaText(Settings.IsMmolL);
    SetMaximumDrawStageSizeToCanvas(dsGlucoseLevelDelta, Text);
    TextSize := cnv.TextExtent(Text);
    DrawStrokedText(Text, (DrawPanel.Width - TextSize.cx) div 2,  0, cGlucoseLevelDeltaColor);
  end;

  if dsGlucoseAvg in DrawStages then
  begin
    cnv.Brush.Color := Color;
    SetBkMode(cnv.Handle, TRANSPARENT);
    Text := 'Avg: ' + Entries.GetAvgGlucoseStr(Settings.IsMmolL);
    SetMaximumDrawStageSizeToCanvas(dsGlucoseAvg, Text);
    TextSize := cnv.TextExtent(Text);
    DrawStrokedText(Text, cSmallMargin, (DrawPanel.Height - TextSize.cy) - cSmallMargin, cGlucoseAvgColor);
  end;

  if (dsLastGlucoseLevel in DrawStages) or (dsGlucoseSlope in DrawStages)  then
  begin
    cnv.Brush.Color := Color;
    SetBkMode(cnv.Handle, TRANSPARENT);
    Text := LastEntry.GetGlucoseStr(Settings.IsMmolL);

    TextWithSlope := Text;
    if dsGlucoseSlope in DrawStages then
      TextWithSlope := TextWithSlope + '-----';

    GlucoseSlopeScaleIndex := SetMaximumDrawStageSizeToCanvas(dsLastGlucoseLevel, TextWithSlope);
    TextSize := cnv.TextExtent(Text);
    LastGlucoseLevelPoint.X := Floor((DrawPanel.Width - TextSize.cx) / 2);
    if dsGlucoseSlope in DrawStages then
      LastGlucoseLevelPoint.X := LastGlucoseLevelPoint.X - Floor((TextSize.cx / 4));
    LastGlucoseLevelPoint.Y := Floor((DrawPanel.Height - TextSize.cy - (DrawPanel.Height / 10)) / 2);

    if (LastEntry.Glucose <= Settings.UrgentLowGlucoseAlarm) or
      (LastEntry.Glucose >= Settings.UrgentHighGlucoseAlarm) then
      FontColor := cUrgentAlarmColor
    else if (LastEntry.Glucose <= Settings.LowGlucoseAlarm) or
      (LastEntry.Glucose >= Settings.HighGlucoseAlarm) then
      FontColor := cAlarmColor
    else
      FontColor := cLastGlucoseLevelColor;

    if dsLastGlucoseLevel in DrawStages then
      DrawStrokedText(Text, LastGlucoseLevelPoint.X, LastGlucoseLevelPoint.Y, FontColor);

    if dsGlucoseSlope in DrawStages then
    begin
      SlopeRectWidth := TextSize.cx div 2;
      SlopeRect := Rect(0, 0, SlopeRectWidth, TextSize.cy);
      ArrowRect := Rect(0,0,0,0);
      CanDrawArrow := GetArrowRect(LastEntry.Slope, SlopeRect, ArrowRect);

      ArrowCount := LastEntry.GetArrowCountOfSlope;
      ArrowOffsetX := LastGlucoseLevelPoint.X + Floor((TextSize.cx * 1.2));
      OffsetRect(ArrowRect, ArrowOffsetX, LastGlucoseLevelPoint.Y); // Move SlopeRect to the left side of dsLastGlucoseLevel text

      for i := 1 to ArrowCount do
      begin
        SlopeWidth := GetDrawStageSize(dsGlucoseSlope, GlucoseSlopeScaleIndex);
        DrawArrow(ArrowRect.TopLeft, ArrowRect.BottomRight, CanDrawArrow, Color, SlopeWidth + cSmallMargin);
        DrawArrow(ArrowRect.TopLeft, ArrowRect.BottomRight, CanDrawArrow, FontColor, SlopeWidth);
        ArrowOffsetX := Floor((SlopeRect.Right - SlopeRect.Left) / 1.5);
        OffsetRect(ArrowRect, ArrowOffsetX, 0);
      end;
    end;
  end;
end;

procedure TfMain.DrawStrokedText(const Text: string; const X, Y: Integer; const TextColor: TColor);
var
  OffsetPoints: array [0..15] of TPoint;
  i, StartI: Integer;
begin
  // Bold stroke
  OffsetPoints[0] := Point( 0, -3);
  OffsetPoints[1] := Point( 2, -2);
  OffsetPoints[2] := Point( 3,  0);
  OffsetPoints[3] := Point( 2,  2);
  OffsetPoints[4] := Point( 0,  3);
  OffsetPoints[5] := Point(-2,  2);
  OffsetPoints[6] := Point(-3,  0);
  OffsetPoints[7] := Point(-2, -2);

  // Stroke width 1 px
  OffsetPoints[8]  := Point( 0, -1);
  OffsetPoints[9]  := Point( 1,  0);
  OffsetPoints[10] := Point( 0,  1);
  OffsetPoints[11] := Point(-1,  0);

  OffsetPoints[8]  := Point( 1, -1);
  OffsetPoints[9]  := Point( 1,  1);
  OffsetPoints[10] := Point(-1,  1);
  OffsetPoints[11] := Point(-1, -1);
  cnv.Font.Color := Color;

  StartI := IfThen(cnv.Font.Size > 20, 0, 8);

  for i := StartI to High(OffsetPoints) do
  begin
    cnv.TextOut(
      X + OffsetPoints[i].X,
      Y + OffsetPoints[i].Y, Text);
    cnv.MoveTo(X, Y);
  end;

  // Draw main text
  cnv.Font.Color := TextColor;
  cnv.TextOut(X, Y, Text);
end;

procedure TfMain.DoDraw(Sender: TObject);
begin
  if Entries.Count = 0 then
    DrawTextInCenter('No data');

  DoDrawStages(Settings.DrawStages);
end;

procedure TfMain.DoUpdateCallerFormWithSettings;
begin
  ApplyWindowSettings;
  SetScaleIndex(Settings.ScaleIndex);
  SetAlphaBlendValue(Settings.AlphaBlendValue);
  LoadWallpeper(Settings.WallpaperFileName);
  HardInvalidate;
end;

function TfMain.LoadWallpeper(const FileName: string): Boolean;
begin
  try
    if (FileName <> '') and FileExists(FileName) then
      WallpaperJPG.LoadFromFile(FileName)
    else
      WallpaperJPG.Clear;

    Wallpaper.Clear;
    Wallpaper.Width  := DrawPanel.Width;
    Wallpaper.Height := DrawPanel.Height;
    Wallpaper.Canvas.StretchDraw(Rect(0, 0, DrawPanel.Width, DrawPanel.Height), WallpaperJPG);

    Result := True;
  except
    Wallpaper.Clear;
    Result := False;
  end;
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

procedure TfMain.UpdateApplicationTitle();
var
  LastEntryGlucose: String;
begin
  Application.Title := 'Nightscout Watcher';
  if Entries.Count < 1 then
    Exit;

  LastEntryGlucose := Entries.Last.GetGlucoseStr(Settings.IsMmolL);
  Application.Title := Format('%s (%s) - %s', [LastEntryGlucose, Entries.GetGlucoseLevelDeltaText(Settings.IsMmolL), Application.Title]);
end;

procedure TfMain.UpdateHint();
begin
  DrawPanel.Hint := GetHintText();
end;

function TfMain.GetHintText(): string;
var
  DummyColor: TColor;
  Lst: TStringList;
begin
  Lst := TStringList.Create();
  try
    Lst.Add(Format('Count of entries with glucose data: %d', [Entries.Count]));
    Lst.Add(Format('Count of entries to recieve: %d', [Settings.CountOfEntriesToRecive]));
    Lst.Add(Format('Glucose average: %s', [Entries.GetAvgGlucoseStr(Settings.IsMmolL)]));
    if Assigned(Entries.First) then
    begin
      Lst.Add(Format('Time of first entry: %s', [DateTimeToStr(Entries.First.Date + Settings.TimeZoneCorrection)]));
      Lst.Add(Format('Time of last entry: %s', [DateTimeToStr(Entries.Last.Date + Settings.TimeZoneCorrection)]));
      Lst.Add(Format('Time has passed since last entry was received: %s', [Settings.GetGlucoseLevelDateText(Entries.Last.Date, Now(), DummyColor)]));
      Lst.Add(Format('Time between last and first entry: %s', [Settings.GetTimeBetweenDatesText(Entries.Last.Date, Entries.First.Date)]));
    end;
    Result := Trim(Lst.Text);
  finally
    Lst.Free;
  end;
end;

end.
