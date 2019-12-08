unit uSettings;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

interface

uses
  Graphics, Types, uNightscout;

const
  cDrawStageSizes : array [1..8, 1..19] of Integer =
    (
      (10, 14, 17, 28, 32, 40, 48, 60, 72, 88, 100, 116, 130, 160, 200, 240, 280, 340, 400), // Font size for dsLastGlucoseLevel
      ( 6,  6,  7,  7,  8,  8,  9,  9, 10, 11,  11,  12,  13,  14,  15,  16,  17,  18,  20), // Font size for dsGlucoseLevel
      ( 7,  7,  8,  8,  9, 10, 11, 12, 13, 14,  15,  18,  22,  26,  32,  42,  52,  60,  72), // Font size for dsLastGlucoseLevelDate
      ( 1,  1,  1,  1,  2,  2,  2,  2,  2,  2,   3,   3,   3,   4,   4,   5,   5,   6,   7), // Line thickness for dsGlucoseLines
      ( 1,  1,  1,  3,  3,  3,  4,  5,  6,  7,   8,   9,  10,  12,  15,  20,  26,  38,  50), // Line thickness for dsGlucoseSlope
      ( 7,  7,  8,  9, 10, 11, 12, 13, 15, 17,  19,  23,  26,  30,  36,  46,  58,  70,  86), // Font size for dsGlucoseAvg
      ( 7,  7,  8,  8,  9, 10, 11, 12, 13, 14,  15,  18,  20,  24,  30,  38,  48,  60,  70), // Font size for dsGlucoseLevelDelta
      ( 7,  7,  8,  9, 10, 11, 12, 13, 15, 17,  19,  23,  26,  30,  36,  46,  58,  70,  86)  // Font size for dsHoursToReceiveData
    );

  cProgressBarHeights: array[1..19]  of Byte =
      ( 3,  3,  3,  3,  3,  5,  5,  5,  5,  6,   6,   7,   8,   9,  10,  11,  12,  13,  14);  // Progress bar height

  cWarningColor = clRed;
  cLastGlucoseLevelColor = clWhite;
  cGlucoseLinesColor = $00FF8000;
  cGlucoseLevelColor = clWhite;
  cGlucoseLevelBrushColor = clGreen;
  cHorzGuideLinesColor = $00161616;
  cVertGuideLinesColor = $00161616;
  cLastGlucoseLevelDateColor = clGreen;
  cGlucoseSlopeColor = clWhite;
  cGlucoseExtremePointsColor = clWhite ;
  cGlucoseExtremePointsBrushColor = clBlue;
  cGlucoseLevelDeltaColor = clWhite;
  cHoursToReceiveDataColor = clWhite;
  cGlucoseAvgColor = clWhite;
  cTrayIconColor = clBlue;
  cTrayIconSnoozedColor = clGray;

  cHighGlucoseColor = clWhite;
  cHighGlucoseBrushColor = clYellow;
  cLowGlucoseColor = clWhite;
  cLowGlucoseBrushColor = clRed;

  cUrgentAlarmColor = clRed;
  cAlarmColor = clYellow;

  cGlucoseLevelPointsColor = $00FF8000;

  cMoveWindowDelta = 10;
  cAlphaBlendValueDelta = 10;

  cHoursToReceiveMin = 1;
  cHoursToReceiveMax = 48;

type
  TDrawStage = (dsLastGlucoseLevel, dsGlucoseLines, dsGlucoseLevel, dsHorzGuideLines,
    dsVertGuideLines, dsLastGlucoseLevelDate, dsGlucoseSlope, dsGlucoseExtremePoints,
    dsAlertLines, dsGlucoseLevelPoints, dsGlucoseLevelDelta, dsGlucoseAvg, dsWallpaper,
    dsHoursToReceiveData);
  TDrawStages = set of TDrawStage;

  { TSettings }

  TSettings = class
  private
    function GetEntryMinsWithTimeZoneCorrection(DateFirst, DateLast: TDateTime): Integer;
    class function GetOptionDir(): string;
  public
    AlphaBlendValue: Integer;
    AlarmAudioFile: string;
    UrgentAlarmAudioFile: string;
    CheckInterval: Integer;
    DrawStages: TDrawStages;
    EnableGlucoseLevelAlarms: Boolean;
    EnableStaleDataAlarms: Boolean;
    EnableAudioAlarms: Boolean;
    FullScreen: Boolean;
    HighGlucoseAlarm: Integer;
    HoursToReceive: Integer;
    IsMmolL: Boolean;
    LastSnoozeTimePeriod: Integer;
    LowGlucoseAlarm: Integer;
    NightscoutUrl: string;
    OptionsFileName: string;
    ScaleIndex: Integer;
    ShowCheckNewDataProgressBar: Boolean;
    ShowIconInTaskBar: Boolean;
    ShowIconInTray: Boolean;
    ShowWindowBorder: Boolean;
    SnoozeAlarmsEndTime: TDateTime;
    StaleDataAlarm: Integer;
    StayOnTop: Boolean;
    TimeZoneCorrection: Integer;
    UrgentHighGlucoseAlarm: Integer;
    UrgentLowGlucoseAlarm: Integer;
    UrgentStaleDataAlarm: Integer;
    WallpaperFileName: string;
    WindowRect: TRect;
    class function GetOptionFileName(): string;
    class function GetEntriesFileName(): string;
    class function IsPortable(): Boolean;
    constructor Create();
    function Clone(): TSettings;
    function GetAppropriateAlarmFile(Entry: TNightscoutEntry): string;
    function GetColorByGlucoseLevel(Glucose: Integer): TColor;
    function GetEntriesUrlByHours: string;
    function GetGlucoseLevelDateText(DateFirst, DateLast: TDateTime; out OutColor: TColor): string;
    function GetOpacity(): Integer;
    function GetScale(): Integer;
    function GetTimeBetweenDatesText(DateFirst, DateLast: TDateTime): string;
    function IsGlucoseLevelAlarmExists(Entry: TNightscoutEntry): Boolean;
    function IsInDrawStage(ADrawStages: TDrawStages): Boolean; overload;
    function IsInDrawStage(DrawStage: TDrawStage): Boolean; overload;
    function IsSnoozeAlarmsEndTimePassed(): Boolean;
    function IsStaleDataAlarmExists(Entry: TNightscoutEntry): Boolean;
    function IsUrgentGlucoseLevelAlarmExists(Entry: TNightscoutEntry): Boolean;
    function IsUrgentStaleDataAlarmExists(Entry: TNightscoutEntry): Boolean;
    function SetScaleIndex(Index: Integer): Boolean;
    procedure AddDrawStage(DrawStage: TDrawStage);
    procedure Assign(Settings: TSettings);
    procedure LoadOptions();
    procedure RemoveDrawStage(DrawStage: TDrawStage);
    procedure SaveOptions();
    procedure SnoozeAlarms(Seconds: Integer);
    procedure SwitchDrawStage(DrawStage: TDrawStage; IncludeDrawStage: Boolean);
  end;

implementation

uses
  DateUtils, SysUtils, Forms, IniFiles;

{ TSettings }

procedure TSettings.AddDrawStage(DrawStage: TDrawStage);
begin
  DrawStages := DrawStages + [DrawStage];
end;

procedure TSettings.RemoveDrawStage(DrawStage: TDrawStage);
begin
  DrawStages := DrawStages - [DrawStage];
end;

procedure TSettings.SnoozeAlarms(Seconds: Integer);
begin
  SnoozeAlarmsEndTime := Now() + Seconds / SecsPerDay;
  LastSnoozeTimePeriod := Seconds;
end;

function TSettings.IsInDrawStage(DrawStage: TDrawStage): Boolean;
begin
  Result := DrawStage in DrawStages;
end;

function TSettings.IsInDrawStage(ADrawStages: TDrawStages): Boolean;
var
  Intersection: TDrawStages;
  i: TDrawStage;
begin
  Result := True;
  Intersection := ADrawStages * DrawStages;

  for i := Low(TDrawStage) to High(TDrawStage) do
    if not ((i in Intersection) and (i in ADrawStages)) then
    begin
      Result := False;
      Break;
    end;
end;

procedure TSettings.SwitchDrawStage(DrawStage: TDrawStage; IncludeDrawStage: Boolean);
begin
  if IncludeDrawStage then
    AddDrawStage(DrawStage)
  else
    RemoveDrawStage(DrawStage);
end;

procedure TSettings.Assign(Settings: TSettings);
begin
  AlphaBlendValue := Settings.AlphaBlendValue;
  CheckInterval := Settings.CheckInterval;
  HoursToReceive := Settings.HoursToReceive;
  DrawStages := Settings.DrawStages;
  EnableGlucoseLevelAlarms := Settings.EnableGlucoseLevelAlarms;
  EnableStaleDataAlarms := Settings.EnableStaleDataAlarms;
  EnableAudioAlarms := Settings.EnableAudioAlarms;
  FullScreen := Settings.FullScreen;
  HighGlucoseAlarm := Settings.HighGlucoseAlarm;
  IsMmolL := Settings.IsMmolL;
  LowGlucoseAlarm := Settings.LowGlucoseAlarm;
  NightscoutUrl := Settings.NightscoutUrl;
  OptionsFileName := Settings.OptionsFileName;
  ScaleIndex := Settings.ScaleIndex;
  ShowCheckNewDataProgressBar := Settings.ShowCheckNewDataProgressBar;
  ShowWindowBorder := Settings.ShowWindowBorder;
  StayOnTop := Settings.StayOnTop;
  StaleDataAlarm := Settings.StaleDataAlarm;
  UrgentHighGlucoseAlarm := Settings.UrgentHighGlucoseAlarm;
  UrgentLowGlucoseAlarm := Settings.UrgentLowGlucoseAlarm;
  UrgentStaleDataAlarm := Settings.UrgentStaleDataAlarm;
  TimeZoneCorrection := Settings.TimeZoneCorrection;
  WallpaperFileName := Settings.WallpaperFileName;
  ShowIconInTaskBar := Settings.ShowIconInTaskBar;
  ShowIconInTray := Settings.ShowIconInTray;
  LastSnoozeTimePeriod := Settings.LastSnoozeTimePeriod;
end;

function TSettings.Clone(): TSettings;
begin
  Result := TSettings.Create();
  Result.OptionsFileName := OptionsFileName;
  Result.AlarmAudioFile := AlarmAudioFile;
  Result.UrgentAlarmAudioFile := UrgentAlarmAudioFile;
  Result.AlphaBlendValue := AlphaBlendValue;
  Result.CheckInterval := CheckInterval;
  Result.HoursToReceive := HoursToReceive;
  Result.DrawStages := DrawStages;
  Result.EnableGlucoseLevelAlarms := EnableGlucoseLevelAlarms;
  Result.EnableStaleDataAlarms := EnableStaleDataAlarms;
  Result.EnableAudioAlarms := EnableAudioAlarms;
  Result.FullScreen := FullScreen;
  Result.HighGlucoseAlarm := HighGlucoseAlarm;
  Result.IsMmolL := IsMmolL;
  Result.LowGlucoseAlarm := LowGlucoseAlarm;
  Result.NightscoutUrl := NightscoutUrl;
  Result.ScaleIndex := ScaleIndex;
  Result.ShowCheckNewDataProgressBar := ShowCheckNewDataProgressBar;
  Result.ShowWindowBorder := ShowWindowBorder;
  Result.StayOnTop := StayOnTop;
  Result.StaleDataAlarm := StaleDataAlarm;
  Result.UrgentHighGlucoseAlarm := UrgentHighGlucoseAlarm;
  Result.UrgentLowGlucoseAlarm := UrgentLowGlucoseAlarm;
  Result.UrgentStaleDataAlarm := UrgentStaleDataAlarm;
  Result.TimeZoneCorrection := TimeZoneCorrection;
  Result.WallpaperFileName := WallpaperFileName;
  Result.ShowIconInTaskBar := ShowIconInTaskBar;
  Result.ShowIconInTray := ShowIconInTray;
  Result.LastSnoozeTimePeriod := LastSnoozeTimePeriod;
end;

constructor TSettings.Create();
begin
  Self.OptionsFileName := TSettings.GetOptionFileName();
  DrawStages := [dsLastGlucoseLevel, dsGlucoseLines, dsHorzGuideLines,
    dsLastGlucoseLevelDate, dsGlucoseSlope,
    dsGlucoseExtremePoints, dsGlucoseLevelDelta, dsGlucoseAvg];
  AlphaBlendValue := 200;
  AlarmAudioFile := 'alarm.wav';
  UrgentAlarmAudioFile := 'alarm2.wav';
  CheckInterval := 20;
  EnableGlucoseLevelAlarms := True;
  EnableStaleDataAlarms := True;
  EnableAudioAlarms := False;
  FullScreen := False;
  HighGlucoseAlarm:= 9 * cMmolDenominator;
  HoursToReceive := 24;
  IsMmolL := True;
  LastSnoozeTimePeriod := 600;
  LowGlucoseAlarm:= 4 * cMmolDenominator;
  NightscoutUrl := '';
  NightscoutUrl := '';
  ScaleIndex := 12;
  ShowCheckNewDataProgressBar := True;
  ShowIconInTaskBar := True;
  ShowIconInTray := True;
  ShowWindowBorder := True;
  SnoozeAlarmsEndTime := Now();
  StaleDataAlarm := 20;
  StayOnTop := True;
  TimeZoneCorrection := 0;
  UrgentHighGlucoseAlarm:= 13 * cMmolDenominator;
  UrgentLowGlucoseAlarm := Round(3.3 * cMmolDenominator);
  UrgentStaleDataAlarm := 40;
  WallpaperFileName := '';
  WindowRect := Rect(Screen.Width div 2, Screen.Height div 2, Screen.Width - 100, Screen.Height - 100);
end;

function TSettings.GetColorByGlucoseLevel(Glucose: Integer): TColor;
begin
  if (Glucose >= UrgentHighGlucoseAlarm) or (Glucose <= UrgentLowGlucoseAlarm) then
    Result := cUrgentAlarmColor
  else if (Glucose >= HighGlucoseAlarm) or (Glucose <= LowGlucoseAlarm) then
    Result := cHighGlucoseBrushColor
  else
    Result := cGlucoseLinesColor;
end;

function TSettings.GetEntryMinsWithTimeZoneCorrection(DateFirst, DateLast: TDateTime): Integer;
var
  EntryDateWithCorrection: TDateTime;
begin
  EntryDateWithCorrection := DateFirst + TimeZoneCorrection / HoursPerDay;
  Result := MinutesBetween(DateLast, EntryDateWithCorrection);
end;

function TSettings.IsStaleDataAlarmExists(Entry: TNightscoutEntry): Boolean;
begin
  Result := GetEntryMinsWithTimeZoneCorrection(Entry.Date, Now()) >= StaleDataAlarm;
end;

function TSettings.IsUrgentStaleDataAlarmExists(Entry: TNightscoutEntry): Boolean;
begin
  Result := GetEntryMinsWithTimeZoneCorrection(Entry.Date, Now()) >= UrgentStaleDataAlarm;
end;

function TSettings.IsGlucoseLevelAlarmExists(Entry: TNightscoutEntry): Boolean;
begin
  Result := (Entry.Glucose <= LowGlucoseAlarm) or (Entry.Glucose >= HighGlucoseAlarm);
end;

function TSettings.IsUrgentGlucoseLevelAlarmExists(Entry: TNightscoutEntry): Boolean;
begin
  Result := (Entry.Glucose <= UrgentLowGlucoseAlarm) or (Entry.Glucose >= UrgentHighGlucoseAlarm);
end;

procedure TSettings.SaveOptions();
var
  ini: TIniFile;
begin
  ini := TIniFile.Create(OptionsFileName);
  try
    ini.WriteBool   ('Main', 'IsMmolL',            IsMmolL);
    ini.WriteString ('Main', 'NightscoutUrl',      NightscoutUrl);
    ini.WriteInteger('Main', 'HoursToReceive',      HoursToReceive);
    ini.WriteInteger('Main', 'TimeZoneCorrection', TimeZoneCorrection);
    ini.WriteInteger('Main', 'CheckInterval',      CheckInterval);

    ini.WriteBool('Visual', 'dsLastGlucoseLevel',     IsInDrawStage(dsLastGlucoseLevel));
    ini.WriteBool('Visual', 'dsGlucoseLines',         IsInDrawStage(dsGlucoseLines));
    ini.WriteBool('Visual', 'dsGlucoseLevel',         IsInDrawStage(dsGlucoseLevel));
    ini.WriteBool('Visual', 'dsHorzGuideLines',       IsInDrawStage(dsHorzGuideLines));
    ini.WriteBool('Visual', 'dsHoursToReceiveData',   IsInDrawStage(dsHoursToReceiveData));
    ini.WriteBool('Visual', 'dsVertGuideLines',       IsInDrawStage(dsVertGuideLines));
    ini.WriteBool('Visual', 'dsLastGlucoseLevelDate', IsInDrawStage(dsLastGlucoseLevelDate));
    ini.WriteBool('Visual', 'dsGlucoseSlope',         IsInDrawStage(dsGlucoseSlope));
    ini.WriteBool('Visual', 'dsGlucoseExtremePoints', IsInDrawStage(dsGlucoseExtremePoints));
    ini.WriteBool('Visual', 'dsAlertLines',           IsInDrawStage(dsAlertLines));
    ini.WriteBool('Visual', 'dsGlucoseLevelPoints',   IsInDrawStage(dsGlucoseLevelPoints));
    ini.WriteBool('Visual', 'dsGlucoseLevelDelta',    IsInDrawStage(dsGlucoseLevelDelta));
    ini.WriteBool('Visual', 'dsGlucoseAvg',           IsInDrawStage(dsGlucoseAvg));
    ini.WriteBool('Visual', 'dsWallpaper',            IsInDrawStage(dsWallpaper));

    ini.WriteBool   ('Visual', 'ShowCheckNewDataProgressBar', ShowCheckNewDataProgressBar);
    ini.WriteBool   ('Visual', 'ShowWindowBorder',            ShowWindowBorder);
    ini.WriteBool   ('Visual', 'FullScreen',                  FullScreen);
    ini.WriteInteger('Visual', 'AlphaBlendValue',             AlphaBlendValue);
    ini.WriteString ('Visual', 'WallpaperFileName',           WallpaperFileName);

    // Save window position and size
    WindowRect := Application.MainForm.BoundsRect;
    ini.WriteInteger('Visual', 'WindowLeft',   WindowRect.Left);
    ini.WriteInteger('Visual', 'WindowTop',    WindowRect.Top);
    ini.WriteInteger('Visual', 'WindowRight',  WindowRect.Right);
    ini.WriteInteger('Visual', 'WindowBottom', WindowRect.Bottom);

    ini.WriteInteger('Visual', 'ScaleIndex',        ScaleIndex);
    ini.WriteBool   ('Visual', 'StayOnTop',         StayOnTop);
    ini.WriteBool   ('Visual', 'ShowIconInTaskBar', ShowIconInTaskBar);
    ini.WriteBool   ('Visual', 'ShowIconInTray',    ShowIconInTray);

    ini.WriteInteger('Alarms', 'HighGlucoseAlarm',         HighGlucoseAlarm);
    ini.WriteInteger('Alarms', 'LowGlucoseAlarm',          LowGlucoseAlarm);
    ini.WriteInteger('Alarms', 'UrgentHighGlucoseAlarm',   UrgentHighGlucoseAlarm);
    ini.WriteInteger('Alarms', 'UrgentLowGlucoseAlarm',    UrgentLowGlucoseAlarm);
    ini.WriteInteger('Alarms', 'StaleDataAlarm',           StaleDataAlarm);
    ini.WriteInteger('Alarms', 'UrgentStaleDataAlarm',     UrgentStaleDataAlarm);
    ini.WriteBool   ('Alarms', 'EnableGlucoseLevelAlarms', EnableGlucoseLevelAlarms);
    ini.WriteBool   ('Alarms', 'EnableStaleDataAlarms',    EnableStaleDataAlarms);
    ini.WriteBool   ('Alarms', 'EnableAudioAlarms',        EnableAudioAlarms);
    ini.WriteInteger('Alarms', 'LastSnoozeTime',           LastSnoozeTimePeriod);
  finally
    ini.Free;
  end;
end;

procedure TSettings.LoadOptions();
var
  ini: TIniFile;

  procedure LoadDrawStageOption(const Ident: string; DrawStage: TDrawStage);
  var
    DrawStageChecked: Boolean;
  begin
    DrawStageChecked := ini.ReadBool('Visual', Ident, IsInDrawStage(DrawStage));
    if DrawStageChecked then
      AddDrawStage(DrawStage)
    else
      RemoveDrawStage(DrawStage);
  end;

begin
  ini := TIniFile.Create(OptionsFileName);
  try
    // Main settings
    IsMmolL            := ini.ReadBool   ('Main', 'IsMmolL',            IsMmolL);
    NightscoutUrl      := ini.ReadString ('Main', 'NightscoutUrl',      NightscoutUrl);
    CheckInterval      := ini.ReadInteger('Main', 'CheckInterval',      CheckInterval);
    TimeZoneCorrection := ini.ReadInteger('Main', 'TimeZoneCorrection', TimeZoneCorrection);
    HoursToReceive      := ini.ReadInteger('Main', 'HoursToReceive',      HoursToReceive);

    // Visual settings
    LoadDrawStageOption('dsLastGlucoseLevel',     dsLastGlucoseLevel);
    LoadDrawStageOption('dsGlucoseLines',         dsGlucoseLines);
    LoadDrawStageOption('dsGlucoseLevel',         dsGlucoseLevel);
    LoadDrawStageOption('dsHorzGuideLines',       dsHorzGuideLines);
    LoadDrawStageOption('dsHoursToReceiveData',   dsHoursToReceiveData);
    LoadDrawStageOption('dsVertGuideLines',       dsVertGuideLines);
    LoadDrawStageOption('dsLastGlucoseLevelDate', dsLastGlucoseLevelDate);
    LoadDrawStageOption('dsGlucoseSlope',         dsGlucoseSlope);
    LoadDrawStageOption('dsGlucoseExtremePoints', dsGlucoseExtremePoints);
    LoadDrawStageOption('dsAlertLines',           dsAlertLines);
    LoadDrawStageOption('dsGlucoseLevelPoints',   dsGlucoseLevelPoints);
    LoadDrawStageOption('dsGlucoseLevelDelta',    dsGlucoseLevelDelta);
    LoadDrawStageOption('dsGlucoseAvg',           dsGlucoseAvg);
    LoadDrawStageOption('dsWallpaper',            dsWallpaper);

    WindowRect.Left   := ini.ReadInteger('Visual', 'WindowLeft',   WindowRect.Left);
    WindowRect.Top    := ini.ReadInteger('Visual', 'WindowTop',    WindowRect.Top);
    WindowRect.Right  := ini.ReadInteger('Visual', 'WindowRight',  WindowRect.Right);
    WindowRect.Bottom := ini.ReadInteger('Visual', 'WindowBottom', WindowRect.Bottom);

    ShowCheckNewDataProgressBar := ini.ReadBool('Visual', 'ShowCheckNewDataProgressBar', ShowCheckNewDataProgressBar);
    ShowWindowBorder  := ini.ReadBool   ('Visual', 'ShowWindowBorder',  ShowWindowBorder);
    FullScreen        := ini.ReadBool   ('Visual', 'FullScreen',        FullScreen);
    StayOnTop         := ini.ReadBool   ('Visual', 'StayOnTop',         StayOnTop);
    ShowIconInTaskBar := ini.ReadBool   ('Visual', 'ShowIconInTaskBar', ShowIconInTaskBar);
    ShowIconInTray    := ini.ReadBool   ('Visual', 'ShowIconInTray',    ShowIconInTray);
    WallpaperFileName := ini.ReadString ('Visual', 'WallpaperFileName', WallpaperFileName);
    AlphaBlendValue   := ini.ReadInteger('Visual', 'AlphaBlendValue',   AlphaBlendValue);
    ScaleIndex        := ini.ReadInteger('Visual', 'ScaleIndex',        ScaleIndex);

    // Alarm settings
    EnableGlucoseLevelAlarms := ini.ReadBool   ('Alarms', 'EnableGlucoseLevelAlarms', EnableGlucoseLevelAlarms);
    EnableStaleDataAlarms    := ini.ReadBool   ('Alarms', 'EnableStaleDataAlarms',    EnableStaleDataAlarms);
    EnableAudioAlarms        := ini.ReadBool   ('Alarms', 'EnableAudioAlarms',         EnableAudioAlarms);
    HighGlucoseAlarm         := ini.ReadInteger('Alarms', 'HighGlucoseAlarm',         HighGlucoseAlarm);
    LowGlucoseAlarm          := ini.ReadInteger('Alarms', 'LowGlucoseAlarm',          LowGlucoseAlarm);
    UrgentHighGlucoseAlarm   := ini.ReadInteger('Alarms', 'UrgentHighGlucoseAlarm',   UrgentHighGlucoseAlarm);
    UrgentLowGlucoseAlarm    := ini.ReadInteger('Alarms', 'UrgentLowGlucoseAlarm',    UrgentLowGlucoseAlarm);
    StaleDataAlarm           := ini.ReadInteger('Alarms', 'StaleDataAlarm',           StaleDataAlarm);
    UrgentStaleDataAlarm     := ini.ReadInteger('Alarms', 'UrgentStaleDataAlarm',     UrgentStaleDataAlarm);
    LastSnoozeTimePeriod     := ini.ReadInteger('Alarms', 'LastSnoozeTime',           LastSnoozeTimePeriod);
  finally
    ini.Free;
  end;
end;

function TSettings.SetScaleIndex(Index: Integer): Boolean;
var
  OldScaleIndex: Byte;
begin
  OldScaleIndex := ScaleIndex;
  if Index > Length(cDrawStageSizes[1]) then
    ScaleIndex := Length(cDrawStageSizes[1])
  else if Index < 1 then
    ScaleIndex := 1
  else
    ScaleIndex := Index;

  Result := OldScaleIndex <> ScaleIndex;
end;

function TSettings.GetEntriesUrlByHours: string;
var
  DateString: string;
  DateResult: TDateTime;
begin
  DateResult := Now() - HoursToReceive / HoursPerDay;
  DateString :=
    FormatDateTime('yyyy-mm-dd', DateResult) + 'T' +
    FormatDateTime('hh:nn:ss', DateResult);
  Result := Format('%s/api/v1/entries/sgv?count=3000&find[dateString][$gte]=%s', [NightscoutUrl, DateString]);
end;

function TSettings.IsSnoozeAlarmsEndTimePassed(): Boolean;
begin
  Result := SnoozeAlarmsEndTime <= Now();
end;

function TSettings.GetOpacity(): Integer;
begin
  Result := Round(AlphaBlendValue / 255 * 100);
end;

function TSettings.GetAppropriateAlarmFile(Entry: TNightscoutEntry): string;
begin
  Result := '';

  if not EnableAudioAlarms or (Entry = nil) or not IsSnoozeAlarmsEndTimePassed() then
    Exit;

  if IsUrgentGlucoseLevelAlarmExists(Entry) or IsUrgentStaleDataAlarmExists(Entry) then
    Result := UrgentAlarmAudioFile
  else if IsGlucoseLevelAlarmExists(Entry) or IsStaleDataAlarmExists(Entry) then
    Result := AlarmAudioFile;
end;

function TSettings.GetScale(): Integer;
begin
  Result := ScaleIndex * 10;
end;

class function TSettings.IsPortable(): Boolean;
begin
  Result := FileExists('Portable.lock');
end;

class function TSettings.GetOptionFileName(): string;
const
  cOptionFileName = 'Options.ini';
begin
  Result := IncludeTrailingBackslash(GetOptionDir) + cOptionFileName;
end;

class function TSettings.GetEntriesFileName(): string;
const
  cEntriesFileName = 'entries.tsv';
begin
  Result := IncludeTrailingBackslash(GetOptionDir) + cEntriesFileName;
end;

// Search Option dir in the next order:
// 1) \Users\<user>\AppData\Local\Nightscout Watcher\
// 2) \ProgramData\Nightscout Watcher\
// 3) \<current app dir>\
// The first one is default
class function TSettings.GetOptionDir(): string;
var
  UserLocalAppDataDir, ProgramDataDir, AppDir: String;
begin
  UserLocalAppDataDir := ExcludeTrailingBackslash(GetAppConfigDir(False));
  ProgramDataDir := ExcludeTrailingBackslash(GetAppConfigDir(True));
  AppDir := ExcludeTrailingBackslash(ExtractFilePath(ParamStr(0)));

  if IsPortable() then
  begin
    Result := AppDir;
    Exit;
  end;

  Result := UserLocalAppDataDir;
  if DirectoryExists(ProgramDataDir) then
    Result := ProgramDataDir
  else if DirectoryExists(AppDir) then
    Result := AppDir;
end;

function TSettings.GetGlucoseLevelDateText(DateFirst, DateLast: TDateTime; out OutColor: TColor): string;
var
  Days, Hours, Mins: Int64;
  DaysStr, HoursStr, MinsStr: string;
  EntryDateWithCorrection: TDateTime;
begin
  Result := '';
  Mins := GetEntryMinsWithTimeZoneCorrection(DateFirst, DateLast);

  OutColor := cLastGlucoseLevelDateColor;
  if EnableStaleDataAlarms then
  begin
    if Mins >= UrgentStaleDataAlarm then
      OutColor := cUrgentAlarmColor
    else if Mins >= StaleDataAlarm then
      OutColor := cAlarmColor;
  end;

  if Mins < 1 then
  begin
    Result := 'now';
    Exit;
  end;

  if Mins < MinsPerHour then
  begin
    MinsStr := IntToStr(Mins);
    case Mins of
      1: Result := MinsStr + ' minute ago';
      2..59: Result := MinsStr + ' minutes ago';
    end;
    Exit;
  end;

  EntryDateWithCorrection := DateFirst + TimeZoneCorrection / HoursPerDay;
  Hours := HoursBetween(DateLast, EntryDateWithCorrection);
  HoursStr := IntToStr(Hours);
  case Hours of
    1: Result := HoursStr + ' hour ago';
    2..24: Result := HoursStr + ' hours ago';
  end;

  Days := DaysBetween(DateLast, EntryDateWithCorrection);
  DaysStr := IntToStr(Days);
  case Days of
    1: Result := DaysStr + ' day ago';
    2..MaxInt: Result := DaysStr + ' days ago';
  end;
end;

function TSettings.GetTimeBetweenDatesText(DateFirst, DateLast: TDateTime): string;
var
  Days, Hours, Mins: Int64;
  DaysStr, HoursStr, MinsStr: string;
begin
  Result := '';
  Mins := MinutesBetween(DateLast, DateFirst);

  if Mins < MinsPerHour then
  begin
    MinsStr := IntToStr(Mins);
    case Mins of
      1: Result := MinsStr + ' minute';
      2..59: Result := MinsStr + ' minutes';
    end;
    Exit;
  end;

  Hours := HoursBetween(DateLast, DateFirst);
  HoursStr := IntToStr(Hours);
  case Hours of
    1: Result := HoursStr + ' hour';
    2..24: Result := HoursStr + ' hours';
  end;

  Days := DaysBetween(DateLast, DateFirst);
  DaysStr := IntToStr(Days);
  case Days of
    1: Result := DaysStr + ' day';
    2..MaxInt: Result := DaysStr + ' days';
  end;
end;

end.
