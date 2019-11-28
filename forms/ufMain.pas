unit ufMain;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

// TODO: Trend alarms settings
// TODO: Draw horizontal guide lines

interface

uses
  LCLIntf, LCLType, uSettings, SysUtils, Variants, Classes, Graphics, Controls,
  Forms, Dialogs, DateUtils, Contnrs, ExtCtrls, Menus, uNightscout, ComCtrls,
  ActnList;

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
    actSnoozeAlarmsCustom: TAction;
    actShowIconInTray: TAction;
    actShowIconOnTaskbar: TAction;
    actSnoozeAlarmsReset: TAction;
    actSnoozeAlarms120mins: TAction;
    actSnoozeAlarms90mins: TAction;
    actSnoozeAlarms60mins: TAction;
    actSnoozeAlarms30mins: TAction;
    actSnoozeAlarms10mins: TAction;
    actStayOnTop: TAction;
    miSnoozeAlarmsCustom: TMenuItem;
    miShowIconInTray: TMenuItem;
    miShowIconOnTaskbar: TMenuItem;
    miSnoozeAlarmsSeparator: TMenuItem;
    miSnoozeAlarmsReset: TMenuItem;
    miSnoozeAlarms120mins: TMenuItem;
    miSnoozeAlarms90mins: TMenuItem;
    miSnoozeAlarms60mins: TMenuItem;
    miSnoozeAlarms30mins: TMenuItem;
    miSnoozeAlarms10mins: TMenuItem;
    miSnoozeAlarms: TMenuItem;
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
    actSetHoursToRecive: TAction;
    miSetHoursToRecive: TMenuItem;
    actShowSettings: TAction;
    miShowSettings: TMenuItem;
    actDrawAlertLines: TAction;
    miDrawAlertLines: TMenuItem;
    actFullScreen: TAction;
    miFullScreen: TMenuItem;
    actDrawGlucoseLevelPoints: TAction;
    miDrawGlucoseLevelPoints: TMenuItem;
    TrayIcon: TTrayIcon;
    procedure actShowIconInTrayExecute(Sender: TObject);
    procedure actShowIconOnTaskbarExecute(Sender: TObject);
    procedure alUpdate(AAction: TBasicAction; var Handled: Boolean);
    procedure DoSnoozeAlarmsExecute(Sender: TObject);
    procedure actStayOnTopExecute(Sender: TObject);
    procedure DoScaleIndexClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure CheckStaleDataAlarms;
    procedure DoOpacityPercentClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure pmPopup(Sender: TObject);
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
    procedure actSetHoursToReciveExecute(Sender: TObject);
    procedure DoShowSettingsExecute(Sender: TObject);
    procedure actFullScreenExecute(Sender: TObject);
    procedure TrayIconClick(Sender: TObject);
    procedure DrawTrayIcon();
  private
    StaleAlarmBlinkTrigger: Boolean;
    NeedStaleDataBlink: Boolean;
    NeedGlucoseLevelAlarmBlink: Boolean;
    GlucoseLevelAlarmBlinkTrigger: Boolean;
    FPressed : Boolean;
    Loaded: Boolean;
    FPosX : Integer;
    FPosY : Integer;
    LastAudioFileName: string;
    Settings: TSettings;
    DrawPanel: TDrawPanel;
    Entries: TNightscoutEntryList;
    Connected: Boolean;
    WasAlphaBlend: Boolean;
    Wallpaper: TBitmap;
    WallpaperJPG: TJPEGImage;
    cnv: TCanvas;
    procedure FullScreen(AFullScreen: Boolean);
    procedure CheckGlucoseLevelAlarms;
    procedure CreateDrawPanel();
    procedure DrawApplicationIcon();
    procedure DrawIcon(IconSize: Integer; TargetIcon: Ticon);
    procedure DrawStrokedText(const AText: string; const X, Y: Integer; const TextColor: TColor);
    function GetHintText(): string;
    procedure PlayAlarm();
    procedure Restart(Params: string = '');
    procedure ShowTrayIconBaloonHint;
    procedure ShowIconInTaskbar(AVisible: Boolean);
    function LoadWallpaper(const FileName: string): Boolean;
    procedure ResetWindowBoundsToDefault();
    procedure ResizeWallpaper();
    function LoadEntriesData: Boolean;
    procedure SetActionCheckProperty(Action: TAction; Checked: Boolean; DrawStage: TDrawStage);
    function GetArrowRect(Slope: string; ArrowAreaRect: TRect; var OutPoints: TRect): Boolean;
    procedure DrawArrow(P1, P2: TPoint; DrawArrowEnd: boolean; GlucoseSlopeColor: TColor; ArrowWidth: Integer);
    procedure DoDrawStages(DrawStages: TDrawStages);
    procedure DrawTextInCenter(const AText: string);
    procedure DoDraw(Sender: TObject);
    procedure DoUpdateCallerFormWithSettings;
    function SetNightscoutUrl(Url: string): Boolean;
    function SetCheckIntervalByString(Value: string): Boolean;
    function SetMaximumDrawStageSizeToCanvas(DrawStage: TDrawStage; const AText: string): Byte;
    procedure SetAlphaBlendValue(Value: Integer);
    procedure RefreshCheckInterval;
    function GetDrawStageSize(DrawStage: TDrawStage; ScaleIndex: Integer = -1): Integer;
    procedure HardInvalidate();
    procedure ApplyWindowSettings();
    procedure SetScaleIndex(ScaleIndex: Integer);
    procedure SetSystemStayOnTop(StayOnTop: Boolean);
    procedure ShowIconInTray(AVisible: Boolean);
    procedure ShowWindowBorder(AVisible: Boolean);
    procedure SnoozeAlarms(Seconds: Integer);
    procedure UpdateApplicationTitle();
    procedure UpdateHint();
    procedure UpdateSnoozeActionShortCut(Seconds: Integer);
  end;

var
  fMain: TfMain;
  {$IFDEF DEBUG}
  DebugMode: Boolean = True; // Set to True to read data from file entries.tsv
  {$ELSE}
  DebugMode: Boolean = False;
  {$ENDIF}

const
  cSnoozeAlarmsResetTag = 0;

implementation

uses
  ufSettings, ufTimerDialog, UrlMon, Wininet, Math, StrUtils, Types, graphtype,
  intfgraphics, fpimage, process, ButtonPanel, mmsystem;

procedure TfMain.Restart(Params: string = '');
var
  aProcess : TProcess; // TProcess is crossplatform is best way
begin
  aProcess := TProcess.Create(nil);
  try
    aProcess.Executable := Application.ExeName;

    Params := Trim(Params);
    if Params <> '' then
      aProcess.Parameters.Text := Params;
    aProcess.Execute;
  finally
    aProcess.Free;
    Settings.SaveOptions();
    Application.Terminate;
  end;
end;

{$R *.lfm}

{ TDrawPannel }

procedure TDrawPanel.Paint;
begin
  inherited;
  if Assigned(FOnPaint) then
    FOnPaint(Self);
end;

{ TfMain }

procedure TfMain.PlayAlarm();
var
  AudioFileName: string;
begin
  AudioFileName := Settings.GetAppropriateAlarmFile(Entries.Last);
  if (AudioFileName = '')  or not FileExists(AudioFileName) then
  begin
    PlaySound(0, 0, SND_PURGE);
//    sndPlaySound(nil, 0); // Stop playing
    Exit;
  end;

  if LastAudioFileName <> AudioFileName then
    PlaySound(0, 0, SND_PURGE);
  PlaySound(PChar(AudioFileName), 0, SND_ASYNC or SND_LOOP or SND_PURGE or SND_NOSTOP);
  LastAudioFileName := AudioFileName;
//  sndPlaySound(PChar(AudioFileName), SND_ASYNC or SND_LOOP);
//
//  if AudioOut.Status = tosPlaying then
//    Exit;
//
//  if AudioFileIn.FileName <> AudioFileName then
//    AudioFileIn.FileName := AudioFileName;
//  AudioOut.Run();
end;

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
begin
  if Settings.SetScaleIndex(ScaleIndex) then
    HardInvalidate();
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
begin
  FullScreen(TAction(Sender).Checked);
end;

procedure TfMain.TrayIconClick(Sender: TObject);
begin
  Show;
  ShowOnTop;
end;

procedure TfMain.DrawIcon(IconSize: Integer; TargetIcon: TIcon);
var
  TempIntfImg: TLazIntfImage;
  ImgHandle, ImgMaskHandle: HBitmap;
  TempBitmap: TBitmap;
  LastEntry: TNightscoutEntry;
  FontColor, BgColor: TColor;
  TextSize: TSize;
  X, Y: Integer;
  EntryText: String;
  DelimiterPos: SizeInt;
begin
  LastEntry := Entries.Last;
  if LastEntry = nil then
  begin
    TargetIcon.Assign(Application.Icon);
    Exit;
  end;

  TempIntfImg := TLazIntfImage.Create(IconSize, IconSize);
  TempBitmap := TBitmap.Create;
  try
    TempBitmap.SetSize(IconSize, IconSize);

    FontColor := cLastGlucoseLevelColor;
    BgColor := cTrayIconColor;
    // Check blinking according to GlucoseLevelAlarms
    if NeedGlucoseLevelAlarmBlink and GlucoseLevelAlarmBlinkTrigger then
    begin
      if Settings.IsUrgentGlucoseLevelAlarmExists(LastEntry) then
      begin
        BgColor := cUrgentAlarmColor
      end
      else if Settings.IsGlucoseLevelAlarmExists(LastEntry) then
      begin
        BgColor := cAlarmColor;
        FontColor := cWarningColor;
      end;
    end // Check blinking according to SraleDataAlarms
    else if NeedStaleDataBlink and StaleAlarmBlinkTrigger then
    begin
      if Settings.IsUrgentStaleDataAlarmExists(LastEntry) then
      begin
        BgColor := cUrgentAlarmColor
      end
      else if Settings.IsStaleDataAlarmExists(LastEntry) then
      begin
        BgColor := cAlarmColor;
        FontColor := cWarningColor;
      end;
    end
    else // Check blinking according to SnoozeAlarms
    begin
      BgColor := IfThen(Settings.IsSnoozeAlarmsEndTimePassed(), cTrayIconColor, cTrayIconSnoozedColor);
    end;

    TempBitmap.Canvas.Brush.Color := BgColor;
    TempBitMap.Canvas.FillRect(0, 0, IconSize, IconSize);
    TempBitMap.Canvas.Font := Canvas.Font;
    TempBitmap.Canvas.Font.Color := FontColor;
    TempBitmap.Canvas.Font.Quality := fqAntialiased;
    {$ifdef windows}
      TempBitmap.Canvas.Font.Name := 'Tahoma';
      TempBitmap.Canvas.Font.Style := [];
      TempBitmap.Canvas.Font.Size := Floor(7/16 * IconSize);
    {$endif}

    EntryText := LastEntry.GetGlucoseStr(Settings.IsMmolL);
    TextSize := TempBitMap.Canvas.TextExtent(EntryText);

    // Remove decimal part of number, if EntryText doesn`t fit inside icon
    if TextSize.cx > IconSize then
    begin
      EntryText := ReplaceStr(EntryText, ',', '.');
      DelimiterPos := Pos('.', EntryText);
      if DelimiterPos > 0 then
      begin
        EntryText := Copy(EntryText, 1, DelimiterPos - 1);
        TextSize := TempBitMap.Canvas.TextExtent(EntryText);
      end;
    end;

    X := Max(0, (IconSize - TextSize.cx) div 2);
    Y := (IconSize - TextSize.cy) div 2;
    TempBitMap.Canvas.TextOut(X, Y, EntryText);

    TempIntfImg.LoadFromBitmap(TempBitmap.Handle, TempBitmap.MaskHandle);

    // Copy it to a TBitmap
    TempIntfImg.CreateBitmaps(ImgHandle, ImgMaskHandle, False);
    TempBitmap.Handle := ImgHandle;
    TempBitmap.MaskHandle := ImgMaskHandle;

    // And copy the TBitmap to your Icon
    TargetIcon.Assign(TempBitmap);
  finally
    TempIntfImg.Free;
    TempBitmap.Free;
  end;
end;

procedure TfMain.DrawTrayIcon();
begin
  if Settings.ShowIconInTray then
  begin
    DrawIcon(16, TrayIcon.Icon);
    TrayIcon.Show;
  end;
end;

procedure TfMain.DrawApplicationIcon();
begin
  if Settings.ShowIconInTaskBar then
    DrawIcon(32, Application.Icon);
end;

procedure TfMain.SnoozeAlarms(Seconds: Integer);
begin
  Settings.SnoozeAlarms(Seconds);
  UpdateSnoozeActionShortCut(Seconds);
end;

procedure TfMain.UpdateSnoozeActionShortCut(Seconds: Integer);
var
  i: Integer;
  SnoozeAction: TAction;
  ActionFound: Boolean;
begin
  if Seconds = cSnoozeAlarmsResetTag then
    Exit;

  ActionFound := False;
  // Reassign shortcut according to chosen snooze period
  for i := 0 to miSnoozeAlarms.Count - 1 do
  begin
    SnoozeAction := TAction(miSnoozeAlarms.Items[i].Action);
    if SnoozeAction = nil then
      Continue;

    if SnoozeAction.Tag = Seconds then
    begin
      SnoozeAction.ShortCut := VK_Z;
      ActionFound := True;
    end
    else
      SnoozeAction.ShortCut := VK_UNKNOWN;
  end;

  if not ActionFound then
    actSnoozeAlarms10mins.ShortCut := VK_Z;
end;

procedure TfMain.actSetCheckIntervalExecute(Sender: TObject);
const
  cMsg = 'Type in time interval to recieve data from Nightscout site (in seconds)';
var
  CheckIntervalStr, Msg: string;
begin
  al.State := asSuspended;
  CheckIntervalStr := IntToStr(Settings.CheckInterval);
  if TfTimerDialog.Execute(Self, 'Check interval', cMsg, CheckIntervalStr, [pbOK, pbCancel]) = mrOK then
    if not SetCheckIntervalByString(CheckIntervalStr) then
    begin
      Msg := 'You must type in time interval in seconds (int value)';
      if MessageDlg(Msg, mtWarning, [mbYes, mbCancel], -1) = mrYes then
        actSetCheckIntervalExecute(Sender);
    end;
  al.State := asNormal;
end;

procedure TfMain.actSetHoursToReciveExecute(Sender: TObject);
var
  Count, Msg: string;
  CountEntered: Integer;
  CanSetCount: Boolean;
begin
  al.State := asSuspended;
  Count := IntToStr(Settings.HoursToRecive);
  Msg := 'Type in the hours to recieve data from Nightscout site';
  if InputQuery('Hours to receive', Msg, Count) then
  begin
    CanSetCount := TryStrToInt(Count, CountEntered);
    CanSetCount := CanSetCount and (CountEntered >= cHoursToReceiveMin) and (CountEntered <= cHoursToReceiveMax);
    if CanSetCount then
    begin
      Settings.HoursToRecive := CountEntered;
      tmrTimer(tmr);
    end
    else
    begin
      Msg := Format('You must type in an integer value (between %d and %d).' + #13#10 + 'Try again?', [cHoursToReceiveMin, cHoursToReceiveMax]);
      if MessageDlg(Msg, mtWarning, [mbYes, mbCancel], -1) = mrYes then
        actSetHoursToReciveExecute(Sender);
    end;
  end;
  al.State := asNormal;
end;

procedure TfMain.actSetNightscoutSiteExecute(Sender: TObject);
var
  Url, Msg: string;
  DialogResult: TModalResult;
  WasConnected: Boolean;
  TimerIntervalSecs: Integer;
begin
  al.State := asSuspended;
  WasConnected := Connected;
  Connected := False;
  Url := Settings.NightscoutUrl;
  TimerIntervalSecs := -1;
  if WasConnected then
    TimerIntervalSecs := 20;
  Msg := 'Type in URL of Nightscout site.' + #13#10 +
    'If there is an error appeare try to change protocol to HTTP instead of HTTPS in URL.';
  DialogResult := TfTimerDialog.Execute(Self, 'Nighscout site', Msg, Url, [pbOK, pbCancel], TimerIntervalSecs);
  if DialogResult = mrOK then
  begin
    if (Url <> '') and (SetNightscoutUrl(Url)) then
      tmrTimer(tmr)
    else
    begin
      actSetNightscoutSiteExecute(Sender);
    end;
  end
  else if (DialogResult = mrCancel) and not WasConnected then
  begin
    Msg := 'To obtain CGM data you have to type in full URL of your Nightscout site.' + #13#10 +
      'To support HTTPS you have to download libeay32.dll and ssleay32.dll and put it to the project directory.' + #13#10 +
      'Otherwise only HTTP protocol is supported. Try to change protocol to HTTP instead of HTTPS in URL.' + #13#10#13#10 +
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
  LoadWallpaper(Settings.WallpaperFileName);
end;

procedure TfMain.DoShowSettingsExecute(Sender: TObject);
var
  OldShowIconInTaskbar: Boolean;
begin
  FormStyle := fsNormal;
  try
    OldShowIconInTaskbar := Settings.ShowIconInTaskBar;
    TfSettings.ShowForm(Self, Settings, DoUpdateCallerFormWithSettings, LoadEntriesData, TAction(Sender).Tag);
    DoUpdateCallerFormWithSettings();
    tmrTimer(tmr);
  finally
    if OldShowIconInTaskbar <> Settings.ShowIconInTaskBar  then
    begin
      actShowIconOnTaskbar.Checked := Settings.ShowIconInTaskBar;
      actShowIconOnTaskbarExecute(actShowIconOnTaskbar);
    end;
    ShowWindowBorder(Settings.ShowWindowBorder);
    SetSystemStayOnTop(Settings.StayOnTop);
  end;
end;

procedure TfMain.actShowWindowBorderExecute(Sender: TObject);
begin
  ShowWindowBorder(TAction(Sender).Checked);
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

procedure TfMain.ShowIconInTaskbar(AVisible: Boolean);
var
  EXStyle: Int64;
begin
  Settings.ShowIconInTaskBar := AVisible;
  actShowIconOnTaskbar.Checked := AVisible;

  if not AVisible then
  begin
    EXStyle:= GetWindowLong(Application.Handle, GWL_EXSTYLE);
    SetWindowLong(Application.Handle, GWL_EXSTYLE, EXStyle or WS_EX_TOOLWINDOW and not WS_EX_APPWINDOW);
  end;
end;

procedure TfMain.FormCreate(Sender: TObject);
begin
  Loaded := False;
  Connected := False;
  Settings := TSettings.Create(ExtractFilePath(ParamStr(0)) +  'Options.ini');
  Wallpaper := TBitmap.Create();
  WallpaperJPG := TJPEGImage.Create();
  StaleAlarmBlinkTrigger := False;
  GlucoseLevelAlarmBlinkTrigger := False;
  LastAudioFileName := '';

  Entries := TNightscoutEntryList.Create;

  CreateDrawPanel();
  Settings.LoadOptions();
  actDrawAlertLines.Checked           := Settings.IsInDrawStage(dsAlertLines);
  actDrawGlucoseAvg.Checked           := Settings.IsInDrawStage(dsGlucoseAvg);
  actDrawGlucoseExtremePoints.Checked := Settings.IsInDrawStage(dsGlucoseExtremePoints);
  actDrawGlucoseLevel.Checked         := Settings.IsInDrawStage(dsGlucoseLevel);
  actDrawGlucoseLevelDelta.Checked    := Settings.IsInDrawStage(dsGlucoseLevelDelta);
  actDrawGlucoseLevelPoints.Checked   := Settings.IsInDrawStage(dsGlucoseLevelPoints);
  actDrawGlucoseLines.Checked         := Settings.IsInDrawStage(dsGlucoseLines);
  actDrawGlucoseSlope.Checked         := Settings.IsInDrawStage(dsGlucoseSlope);
  actDrawHorzGuideLines.Checked       := Settings.IsInDrawStage(dsHorzGuideLines);
  actDrawLastGlucoseLevel.Checked     := Settings.IsInDrawStage(dsLastGlucoseLevel);
  actDrawLastGlucoseLevelDate.Checked := Settings.IsInDrawStage(dsLastGlucoseLevelDate);
  actDrawVertGuideLines.Checked       := Settings.IsInDrawStage(dsVertGuideLines);
  actDrawWallpaper.Checked            := Settings.IsInDrawStage(dsWallpaper);
  UpdateSnoozeActionShortCut(Settings.LastSnoozeTimePeriod);

  ShowIconInTray(Settings.ShowIconInTray);
  ShowWindowBorder(Settings.ShowWindowBorder);
  FullScreen(Settings.FullScreen);

  if not Settings.ShowIconInTaskBar then
    ShowIconInTaskbar(False);
end;

procedure TfMain.FormDestroy(Sender: TObject);
begin
  Settings.SaveOptions();
  FreeAndNil(Settings);
  FreeAndNil(Entries);
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
      VK_APPS:  pm.PopUp;
      VK_Z:
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

procedure TfMain.FormMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FPressed := True;
  FPosX := X;
  FPosY := Y;
end;

procedure TfMain.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  // Forbid window draging while FullScreen
  if Settings.FullScreen then
    Exit;

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
  AlarmReached, UrgentAlarmReached: Boolean;
begin
  AlarmReached := False;
  UrgentAlarmReached := False;

  Entry := Entries.Last();
  if Assigned(Entry) then
  begin
    AlarmReached := Settings.IsStaleDataAlarmExists(Entry);
    UrgentAlarmReached := Settings.IsUrgentStaleDataAlarmExists(Entry);
    StaleAlarmBlinkTrigger := not StaleAlarmBlinkTrigger;
  end;
  NeedStaleDataBlink :=
    Settings.EnableStaleDataAlarms and
    Settings.IsSnoozeAlarmsEndTimePassed() and
    (AlarmReached or UrgentAlarmReached) ;
end;

procedure TfMain.CheckGlucoseLevelAlarms;
var
  Entry: TNightscoutEntry;
  AlarmReached, UrgentAlarmReached: Boolean;
begin
  AlarmReached := False;
  UrgentAlarmReached := False;

  Entry := Entries.Last();
  if Assigned(Entry) then
  begin
    AlarmReached := Settings.IsGlucoseLevelAlarmExists(Entry);
    UrgentAlarmReached := Settings.IsUrgentGlucoseLevelAlarmExists(Entry);
    GlucoseLevelAlarmBlinkTrigger := not GlucoseLevelAlarmBlinkTrigger;
  end;
  NeedGlucoseLevelAlarmBlink :=
    Settings.EnableGlucoseLevelAlarms and
    Settings.IsSnoozeAlarmsEndTimePassed() and
    (AlarmReached or UrgentAlarmReached) ;
end;

procedure TfMain.DoOpacityPercentClick(Sender: TObject);
begin
  SetAlphaBlendValue(Round(255 * TComponent(Sender).Tag / 100));
end;

procedure TfMain.FormResize(Sender: TObject);
begin
  LoadWallpaper(Settings.WallpaperFileName);
end;

procedure TfMain.pmPopup(Sender: TObject);
var
  i: Integer;
  Opacity: Integer;
begin
  // Update snooze menu items
  miSnoozeAlarms.Caption := 'Snooze alarms';
  if not Settings.IsSnoozeAlarmsEndTimePassed() then
    miSnoozeAlarms.Caption := Format('%s (%d minutes remain)',
      [miSnoozeAlarms.Caption, MinutesBetween(Settings.SnoozeAlarmsEndTime, Now())]);

  // Update scale menu items
  miScale.Caption := Format('Scale (%d %%)', [Settings.GetScale]);
  for i := 0 to miScale.Count - 1 do
    miScale.Items[i].Checked := miScale.Items[i].Tag = Settings.ScaleIndex;

  // Update opacity menu items
  Opacity := Settings.GetOpacity();
  miOpacity.Caption := Format('Opacity (%d %%)', [Opacity]);
  for i := 0 to miOpacity.Count - 1 do
    miOpacity.Items[i].Checked := miOpacity.Items[i].Tag = Opacity;
end;

procedure TfMain.DoScaleIndexClick(Sender: TObject);
begin
  SetScaleIndex(TComponent(Sender).Tag);
end;

procedure TfMain.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  sndPlaySound(nil, 0); // Stop playing
end;

procedure TfMain.actStayOnTopExecute(Sender: TObject);
begin
  SetSystemStayOnTop(TAction(Sender).Checked);
end;

procedure TfMain.DoSnoozeAlarmsExecute(Sender: TObject);
var
  SnoozeAction: TAction;
  Seconds: Integer;
  MinutesStr, Msg: string;
begin
  SnoozeAction := TAction(Sender);
  Seconds := SnoozeAction.Tag;
  while Seconds = -1 do
  begin
    if TfTimerDialog.Execute(Self, 'Snooze time length', 'Type in snooze time length in minutes', MinutesStr, [pbOK, pbCancel]) = mrCancel then
      Exit;

    if not TryStrToInt(MinutesStr, Seconds) then
    begin
      Seconds := Seconds * 60;
    end
    else
    begin
      Msg := 'You must type in snooze time length in minutes (int value)';
      MessageDlg(Msg, mtError, [mbOK], -1);
    end;
  end;

  SnoozeAlarms(Seconds);
end;

procedure TfMain.actShowIconOnTaskbarExecute(Sender: TObject);
var
  Msg: String;
begin
  ShowIconInTaskbar(TAction(Sender).Checked);
  Msg := 'To apply setting you should restart application.' + #13#10 + 'Restart now?';
  if MessageDlg(Msg, mtConfirmation, mbYesNo, -1) = mrYes then
    Restart();
end;

procedure TfMain.alUpdate(AAction: TBasicAction; var Handled: Boolean);
begin
  actSnoozeAlarmsReset.Enabled := not Settings.IsSnoozeAlarmsEndTimePassed();
  actShowWindowBorder.Enabled := not Settings.FullScreen;
end;

procedure TfMain.ShowIconInTray(AVisible: Boolean);
begin
  Settings.ShowIconInTray := AVisible;
  TrayIcon.Visible := AVisible;
end;

procedure TfMain.actShowIconInTrayExecute(Sender: TObject);
begin
  ShowIconInTray(TAction(Sender).Checked);
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

  InflateRect(WindowRect, Floor(Direction * cMoveWindowDelta * 1.618), Direction * cMoveWindowDelta);
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

  SetScaleIndex(Settings.ScaleIndex);
  SetAlphaBlendValue(Settings.AlphaBlendValue);
  actSetUnitOfMeasureMmolL.Checked := Settings.IsMmolL;
  RefreshCheckInterval();
  BoundsRect := Settings.WindowRect;
  ApplyWindowSettings();
  LoadWallpaper(Settings.WallpaperFileName);
  SetSystemStayOnTop(Settings.StayOnTop);

  if Settings.NightscoutUrl = '' then
    actSetNightscoutSiteExecute(actSetNightscoutSite)
  else
    tmrTimer(tmr); // Load data from nightscout site and start monitoring
end;

procedure TfMain.ShowTrayIconBaloonHint;
var
  BaloonHint: string;
  LastEntry: TNightscoutEntry;
begin
  if not Settings.IsSnoozeAlarmsEndTimePassed() then
    Exit;

  BaloonHint := '';
  LastEntry := Entries.Last;
  TrayIcon.BalloonTitle := 'Alarm!';
  if Settings.IsUrgentGlucoseLevelAlarmExists(LastEntry) then
  begin
    BaloonHint := BaloonHint + 'Urgent dangerous glucose level is reached!' + #13#10;
    TrayIcon.BalloonTitle := 'ALARM!!!';
  end
  else if Settings.IsGlucoseLevelAlarmExists(LastEntry) then
    BaloonHint := BaloonHint + 'Dangerous glucose level is reached!' + #13#10;

  if Settings.IsUrgentStaleDataAlarmExists(LastEntry) then
  begin
    BaloonHint := BaloonHint + 'Glucose data is very stale!' + #13#10;
    TrayIcon.BalloonTitle := 'ALARM!!!';
  end
  else if Settings.IsStaleDataAlarmExists(LastEntry) then
    BaloonHint := BaloonHint + 'Glucose data is stale!' + #13#10;

  TrayIcon.BalloonHint := BaloonHint;
  TrayIcon.BalloonFlags := bfWarning;
  TrayIcon.ShowBalloonHint;
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
  FileName, Msg, DummyText: string;
  IsFileDownloaded: Boolean;
begin
  Result := False;
  FileName := './entries.tsv';
  Entries.Clear;
  if not DebugMode then
  begin
    DeleteUrlCacheEntry(PAnsiChar(Settings.GetEntriesUrlByHours()));
    IsFileDownloaded := URLDownloadToFile(nil, PAnsiChar(Settings.GetEntriesUrlByHours()), PAnsiChar(FileName), 0, nil) = S_OK;

    if not IsFileDownloaded then
    begin
      Msg := 'File downloading is failed. URL: ' + Settings.GetEntriesUrlByHours();
      TfTimerDialog.Execute(Self, 'Connection fail', Msg, DummyText, [pbOK], 20, True);
      Exit;
    end
    else if not FileExists(FileName) then
    begin
      Msg := 'No data to download';
      TfTimerDialog.Execute(Self, 'No data', Msg, DummyText, [pbOK], 20, True);
      Exit;
    end;
  end;

  if not FileExists(FileName) then
  begin
    Msg := 'File with entries doesn`t exist: ' + FileName;
    TfTimerDialog.Execute(Self, 'File error', Msg, DummyText, [pbOK], 20, True);
    Exit;
  end;

  if Entries.LoadFromFile(FileName) then
    if not DebugMode then
      DeleteFile(FileName);

  if Entries.Count = 0 then
  begin
    Msg := 'No entries were downloaded. URL: ' + Settings.GetEntriesUrlByHours();
    TfTimerDialog.Execute(Self, 'File error', Msg, DummyText, [pbOK], 20, True);
    Exit;
  end
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

function TfMain.SetMaximumDrawStageSizeToCanvas(DrawStage: TDrawStage; const AText: string): Byte;
var
  TextSize: TSize;
  ScaleIndex: Integer;
begin
  ScaleIndex := Settings.ScaleIndex;
  repeat
    cnv.Font.Size := GetDrawStageSize(DrawStage, ScaleIndex);
    TextSize := cnv.TextExtent(AText);
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
  if Trim(Url) = '' then
    Exit;

  Settings.NightscoutUrl := Url;
  Result := True;
end;

procedure TfMain.tmrProgressBarTimer(Sender: TObject);
begin
  pb.Position := pb.Position + 1;
  CheckStaleDataAlarms();
  CheckGlucoseLevelAlarms();
  DrawTrayIcon();
  ShowTrayIconBaloonHint();
  DrawApplicationIcon();
  PlayAlarm();
  Invalidate();
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
    GlucoseLevelAlarmBlinkTrigger := False;
  end
  else
    actSetNightscoutSiteExecute(actSetNightscoutSite);

  UpdateHint();
  UpdateApplicationTitle();
  DrawTrayIcon();
  DrawApplicationIcon();
  PlayAlarm();
  HardInvalidate();
end;

function ContainsText(AText: string; SubText: string): Boolean;
begin
  AText := UpperCase(AText);
  SubText := UpperCase(SubText);
  Result := Pos(SubText, AText) > 0;
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

procedure TfMain.DrawTextInCenter(const AText: string);
var
  TextSize: TSize;
  TextPoint: TPoint;
begin
  cnv.Brush.Color := Color;
  SetBkMode(cnv.Handle, TRANSPARENT);
  cnv.Font.Size := GetDrawStageSize(dsLastGlucoseLevel);
  TextSize := cnv.TextExtent(AText);
  TextPoint.X := Floor((DrawPanel.Width - TextSize.cx) / 2);
  TextPoint.Y := Floor((DrawPanel.Height - TextSize.cy - (DrawPanel.Height / 10)) / 2);
  cnv.Font.Color := cLastGlucoseLevelColor;
  cnv.TextOut(TextPoint.X, TextPoint.Y, AText);
end;

procedure TfMain.DoDrawStages(DrawStages: TDrawStages);
const
  cMarginX = 0.85;
  cMarginY = 0.7;
  cSmallMargin = 4;
var
  GlucoseLinesWidths: array [0..1] of Byte;
  i, x, y, EntriesCount, SlopeRectWidth, ArrowCount, ArrowOffsetX, MaxY,
    GlucoseLevelPointRadius, SlopeWidth, j: integer;
  EntryWidth, EntryHeight, MarginX, MarginY: Double;
  Entry, LastEntry: TNightscoutEntry;
  AText, TextWithSlope: string;
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

  // Wallpaper
  if (dsWallpaper in DrawStages) and not Wallpaper.Empty then
  begin
    cnv.Brush.Color := Color;
    cnv.FillRect(cnv.ClipRect);
    ResizeWallpaper();
    cnv.Draw(0, 0, Wallpaper);
  end;

  if dsAlertLines in DrawStages then
  begin
    MaxY := Max(Settings.UrgentHighGlucoseAlarm, Entries.GetMaxGlucose);
    EntryHeight := (DrawPanel.Height * cMarginY) /
      (Entries.GetMaxGlucoseDelta(Settings.UrgentLowGlucoseAlarm, Settings.UrgentHighGlucoseAlarm) + 1);
  end
  else
  begin
    MaxY := Entries.GetMaxGlucose;
    EntryHeight := (DrawPanel.Height * cMarginY) / (Entries.GetMaxGlucoseDelta(-1, -1) + 1);
  end;

  MarginX := DrawPanel.Width * (1 - cMarginX) / 2;
  MarginY := DrawPanel.Height * (1 - cMarginY) / 2;

  // Vert lines
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

  // Alert lines
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

  // Glucose lines
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

      // Glucose level points
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
      AText := Entry.GetGlucoseStr(Settings.IsMmolL);
      TextSize := cnv.TextExtent(AText);
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

      // Glucose level values
      if (dsGlucoseLevel in DrawStages) and not NeedDrawGlucoseExtremePoints then
      begin
        cnv.Brush.Color := cGlucoseLevelBrushColor;
        cnv.Font.Color := cGlucoseLevelColor;
        // Draw glucose level value in the center of graph point
        cnv.Rectangle(TextRect);
        cnv.TextOut(GlucoseMarker.X, GlucoseMarker.Y, AText);
      end;

      // Glucose level extreme values
      if NeedDrawGlucoseExtremePoints then
      begin
        cnv.Brush.Color := cGlucoseExtremePointsBrushColor;
        cnv.Font.Color := cGlucoseExtremePointsColor;
        cnv.Rectangle(TextRect);
        cnv.TextOut(GlucoseMarker.X, GlucoseMarker.Y, AText);
      end;
    end;
  end;

  // Time remains from last reading
  if (NeedStaleDataBlink and StaleAlarmBlinkTrigger) or
    (not NeedStaleDataBlink and (dsLastGlucoseLevelDate in DrawStages)) then
  begin
    cnv.Brush.Color := Color;
    SetBkMode(cnv.Handle, TRANSPARENT);
    AText := Settings.GetGlucoseLevelDateText(LastEntry.Date, Now(), LastGlucoseLevelDateColor);
    SetMaximumDrawStageSizeToCanvas(dsLastGlucoseLevelDate, AText);
    TextSize := cnv.TextExtent(AText);
    DrawStrokedText(AText,
      Floor(DrawPanel.Width - TextSize.cx - cSmallMargin),
      Floor(DrawPanel.Height - TextSize.cy - cSmallMargin),
      LastGlucoseLevelDateColor);
  end;

  // Glucose level delta
  if dsGlucoseLevelDelta in DrawStages then
  begin
    cnv.Brush.Color := Color;
    SetBkMode(cnv.Handle, TRANSPARENT);
    AText := Entries.GetGlucoseLevelDeltaText(Settings.IsMmolL);
    SetMaximumDrawStageSizeToCanvas(dsGlucoseLevelDelta, AText);
    TextSize := cnv.TextExtent(AText);
    DrawStrokedText(AText, (DrawPanel.Width - TextSize.cx) div 2,  0, cGlucoseLevelDeltaColor);
  end;

  // Glucose level average
  if dsGlucoseAvg in DrawStages then
  begin
    cnv.Brush.Color := Color;
    SetBkMode(cnv.Handle, TRANSPARENT);
    AText := 'Avg: ' + Entries.GetAvgGlucoseStr(Settings.IsMmolL);
    SetMaximumDrawStageSizeToCanvas(dsGlucoseAvg, AText);
    TextSize := cnv.TextExtent(AText);
    DrawStrokedText(AText, cSmallMargin, (DrawPanel.Height - TextSize.cy) - cSmallMargin, cGlucoseAvgColor);
  end;

  // Last glucose level value and slope
  if (dsLastGlucoseLevel in DrawStages) or (dsGlucoseSlope in DrawStages)  then
  begin
    cnv.Brush.Color := Color;
    SetBkMode(cnv.Handle, TRANSPARENT);
    AText := LastEntry.GetGlucoseStr(Settings.IsMmolL);

    TextWithSlope := AText;
    if dsGlucoseSlope in DrawStages then
      TextWithSlope := TextWithSlope + '-----';

    GlucoseSlopeScaleIndex := SetMaximumDrawStageSizeToCanvas(dsLastGlucoseLevel, TextWithSlope);
    TextSize := cnv.TextExtent(AText);
    LastGlucoseLevelPoint.X := Floor((DrawPanel.Width - TextSize.cx) / 2);
    if dsGlucoseSlope in DrawStages then
      LastGlucoseLevelPoint.X := LastGlucoseLevelPoint.X - Floor((TextSize.cx / 4));
    LastGlucoseLevelPoint.Y := Floor((DrawPanel.Height - TextSize.cy - (DrawPanel.Height / 10)) / 2);

    if Settings.IsUrgentGlucoseLevelAlarmExists(LastEntry) then
      FontColor := cUrgentAlarmColor
    else if Settings.IsGlucoseLevelAlarmExists(LastEntry) then
      FontColor := cAlarmColor
    else
      FontColor := cLastGlucoseLevelColor;

    // Last glucose level value

    if (NeedGlucoseLevelAlarmBlink and GlucoseLevelAlarmBlinkTrigger) or
    (not NeedGlucoseLevelAlarmBlink and (dsLastGlucoseLevel in DrawStages)) then
      DrawStrokedText(AText, LastGlucoseLevelPoint.X, LastGlucoseLevelPoint.Y, FontColor);

    // Last glucose level slope
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

procedure TfMain.DrawStrokedText(const AText: string; const X, Y: Integer; const TextColor: TColor);
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
  OffsetPoints[12] := Point( 1, -1);
  OffsetPoints[13] := Point( 1,  1);
  OffsetPoints[14] := Point(-1,  1);
  OffsetPoints[15] := Point(-1, -1);
  cnv.Font.Color := Color;

  StartI := IfThen(cnv.Font.Size > 28, 0, 8);

  for i := StartI to High(OffsetPoints) do
  begin
    cnv.TextOut(
      X + OffsetPoints[i].X,
      Y + OffsetPoints[i].Y, AText);
    cnv.MoveTo(X, Y);
  end;

  // Draw main text
  cnv.Font.Color := TextColor;
  cnv.TextOut(X, Y, AText);
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
  LoadWallpaper(Settings.WallpaperFileName);
  ShowIconInTray(Settings.ShowIconInTray);
  PlayAlarm();
  HardInvalidate;
end;

function TfMain.LoadWallpaper(const FileName: string): Boolean;
begin
  try
    if (FileName <> '') and FileExists(FileName) then
      WallpaperJPG.LoadFromFile(FileName)
    else
      WallpaperJPG.Clear;

    ResizeWallpaper();
    Result := True;
  except
    Wallpaper.Clear;
    Result := False;
  end;
end;

procedure TfMain.ResizeWallpaper();
var
  kX, kY, k, NewSizeX, NewSizeY: Double;
  TargetRect: TRect;
begin
  if (WallpaperJPG.Width <= 0) or (WallpaperJPG.Height <= 0) then
    Exit;

  kX := DrawPanel.Width / WallpaperJPG.Width;
  kY := DrawPanel.Height / WallpaperJPG.Height;
  k := Max(kX, kY);

  NewSizeX := k * WallpaperJPG.Width;
  NewSizeY := k * WallpaperJPG.Height;

  TargetRect := Rect(
    Ceil((DrawPanel.Width  - NewSizeX) / 2),
    Ceil((DrawPanel.Height - NewSizeY) / 2),
    Ceil((DrawPanel.Width  + NewSizeX) / 2),
    Ceil((DrawPanel.Height + NewSizey) / 2));

  Wallpaper.SetSize(DrawPanel.Width, DrawPanel.Height);
  Wallpaper.Canvas.StretchDraw(TargetRect, WallpaperJPG);
end;

procedure TfMain.ShowWindowBorder(AVisible: Boolean);
var
  OldWindowRect: TRect;
begin
  Settings.ShowWindowBorder := AVisible;
  actShowWindowBorder.Checked := AVisible;

  OldWindowRect := BoundsRect;
  if AVisible then
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

procedure TfMain.ApplyWindowSettings();
begin
  actShowCheckNewDataProgressBar.Checked := Settings.ShowCheckNewDataProgressBar;
  actShowCheckNewDataProgressBarExecute(actShowCheckNewDataProgressBar);
end;

procedure TfMain.FullScreen(AFullScreen: Boolean);
begin
  Settings.FullScreen := AFullScreen;
  actShowWindowBorder.Checked := AFullScreen;
  if Settings.FullScreen then
  begin
    WindowState := wsMaximized;
    Settings.ShowWindowBorder := False;
  end
  else
  begin
    actShowWindowBorder.Checked := Settings.ShowWindowBorder;
    WindowState := wsNormal;
  end;
  ShowWindowBorder(Settings.ShowWindowBorder);
end;

procedure TfMain.UpdateApplicationTitle();
var
  LastEntryGlucose: String;
begin
  Application.Title := 'Nightscout Watcher';
  if Entries.Count > 0 then
  begin
    LastEntryGlucose := Entries.Last.GetGlucoseStr(Settings.IsMmolL);
    Application.Title := Format('%s (%s) - %s v%s', [LastEntryGlucose, Entries.GetGlucoseLevelDeltaText(Settings.IsMmolL), Application.Title, GetVersion()]);
  end;

  if Settings.NightscoutUrl <> '' then
    Application.Title := Application.Title + ' - ' + Settings.NightscoutUrl;

  Caption := Application.Title;
  TrayIcon.Hint := Application.Title;
end;

procedure TfMain.UpdateHint();
begin
  Hint := GetHintText();
end;

function TfMain.GetHintText(): string;
var
  DummyColor: TColor;
  Lst: TStringList;
begin
  Lst := TStringList.Create();
  try
    Lst.Add(Format('Count of entries with glucose data: %d', [Entries.Count]));
    Lst.Add(Format('Hours to recieve data: %d', [Settings.HoursToRecive]));
    Lst.Add(Format('Glucose average: %s', [Entries.GetAvgGlucoseStr(Settings.IsMmolL)]));
    if Assigned(Entries.First) then
    begin
      Lst.Add(Format('Time of first entry: %s', [DateTimeToStr(Entries.First.Date + Settings.TimeZoneCorrection / HoursPerDay)]));
      Lst.Add(Format('Time of last entry: %s', [DateTimeToStr(Entries.Last.Date + Settings.TimeZoneCorrection / HoursPerDay)]));
      Lst.Add(Format('Time has passed since last entry was received: %s', [Settings.GetGlucoseLevelDateText(Entries.Last.Date, Now(), DummyColor)]));
      Lst.Add(Format('Time between last and first entry: %s', [Settings.GetTimeBetweenDatesText(Entries.Last.Date, Entries.First.Date)]));
    end;
    Result := Trim(Lst.Text);
  finally
    Lst.Free;
  end;
end;

end.
