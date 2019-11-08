unit uSettings;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

interface

uses
  Graphics, uNightscout;

const
  cDrawStageSizes : array [1..7, 1..18] of Integer =
    (
      (14, 17, 28, 32, 40, 48, 60, 72, 88, 100, 116, 130, 160, 200, 240, 280, 340, 400), // Font size for dsLastGlucoseLevel
      ( 6,  7,  7,  8,  8,  9,  9, 10, 11,  11,  12,  13,  14,  15,  16,  17,  18,  20), // Font size for dsGlucoseLevel
      ( 7,  8,  8,  9, 10, 11, 12, 13, 14,  15,  18,  20,  24,  30,  38,  48,  60,  70), // Font size for dsLastGlucoseLevelDate
      ( 1,  1,  1,  2,  2,  2,  2,  2,  2,   3,   3,   3,   4,   4,   5,   5,   6,   7), // Line thickness for dsGlucoseLines
      ( 1,  1,  3,  3,  3,  4,  5,  6,  7,   8,   9,  10,  12,  15,  20,  26,  38,  50), // Line thickness for dsGlucoseSlope
      ( 7,  8,  9, 10, 11, 12, 13, 15, 17,  19,  23,  26,  30,  36,  46,  58,  70,  86), // Font size for dsGlucoseAvg
      ( 7,  8,  8,  9, 10, 11, 12, 13, 14,  15,  18,  20,  24,  30,  38,  48,  60,  70)  // Font size for dsGlucoseLevelDelta
    );

  cProgressBarHeights: array[1..18]  of Byte =
      ( 3,  3,  3,  3,  5,  5,  5,  5,  6,   6,   7,   8,   9,  10,  11,  12,  13,  14);  // Progress bar height

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
  cGlucoseAvgColor = clWhite;

  cHighGlucoseColor = clWhite;
  cHighGlucoseBrushColor = clYellow;
  cLowGlucoseColor = clWhite;
  cLowGlucoseBrushColor = clRed;

  cUrgentAlarmColor = clRed;
  cAlarmColor = clYellow;

  cGlucoseLevelPointsColor = $00FF8000;

  cMoveWindowDelta = 10;
  cAlphaBlendValueDelta = 10;

type
  TDrawStage = (dsLastGlucoseLevel, dsGlucoseLines, dsGlucoseLevel, dsHorzGuideLines,
    dsVertGuideLines, dsLastGlucoseLevelDate, dsGlucoseSlope, dsGlucoseExtremePoints,
    dsAlertLines, dsGlucoseLevelPoints, dsGlucoseLevelDelta, dsGlucoseAvg, dsWallpaper);
  TDrawStages = set of TDrawStage;

  { TSettings }

  TSettings = class
    AlphaBlendValue: Integer;
    CheckInterval: Integer;
    CountOfEntriesToRecive: Integer;
    DrawStages: TDrawStages;
    EnableGlucoseLevelAlarms: Boolean;
    EnableStaleDataAlarms: Boolean;
    FullScreen: Boolean;
    HighGlucoseAlarm: Integer;
    IsMmolL: Boolean;
    LowGlucoseAlarm: Integer;
    NightscoutUrl: string;
    ScaleIndex: Integer;
    ShowCheckNewDataProgressBar: Boolean;
    ShowWindowBorder: Boolean;
    StaleDataAlarm: Integer;
    TimeZoneCorrection: Integer;
    UrgentHighGlucoseAlarm: Integer;
    UrgentLowGlucoseAlarm: Integer;
    UrgentStaleDataAlarm: Integer;
    WallpaperFileName: string;
  private
    function GetEntryMinsWithTimeZoneCorrection(Entry: TNightscoutEntry): Integer;
  public
    constructor Create();
    function GetColorByGlucoseLevel(Glucose: Integer): TColor;
    function IsStaleDataAlarmExists(Entry: TNightscoutEntry): Boolean;
    function IsUrgentStaleDataAlarmExists(Entry: TNightscoutEntry): Boolean;
    function Clone(): TSettings;
    function GetLastGlucoseLevelDateText(Entry: TNightscoutEntry; out OutColor: TColor): string;
    function IsInDrawStage(DrawStage: TDrawStage): Boolean; overload;
    function IsInDrawStage(ADrawStages: TDrawStages): Boolean; overload;
    function SetScaleIndex(Index: Integer): Boolean;
    procedure AddDrawStage(DrawStage: TDrawStage);
    procedure Assign(Settings: TSettings);
    procedure RemoveDrawStage(DrawStage: TDrawStage);
    procedure SwitchDrawStage(DrawStage: TDrawStage; IncludeDrawStage: Boolean);
  end;

implementation

uses
  DateUtils, SysUtils;

{ TSettings }

procedure TSettings.AddDrawStage(DrawStage: TDrawStage);
begin
  DrawStages := DrawStages + [DrawStage];
end;

procedure TSettings.RemoveDrawStage(DrawStage: TDrawStage);
begin
  DrawStages := DrawStages - [DrawStage];
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
  // TODO: Do autodefine of last value of TDrawStages
  for i := dsLastGlucoseLevel to dsWallpaper do
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
  CountOfEntriesToRecive := Settings.CountOfEntriesToRecive;
  DrawStages := Settings.DrawStages;
  EnableGlucoseLevelAlarms := Settings.EnableGlucoseLevelAlarms;
  EnableStaleDataAlarms := Settings.EnableStaleDataAlarms;
  FullScreen := Settings.FullScreen;
  HighGlucoseAlarm := Settings.HighGlucoseAlarm;
  IsMmolL := Settings.IsMmolL;
  LowGlucoseAlarm := Settings.LowGlucoseAlarm;
  NightscoutUrl := Settings.NightscoutUrl;
  ScaleIndex := Settings.ScaleIndex;
  ShowCheckNewDataProgressBar := Settings.ShowCheckNewDataProgressBar;
  ShowWindowBorder := Settings.ShowWindowBorder;
  StaleDataAlarm := Settings.StaleDataAlarm;
  UrgentHighGlucoseAlarm := Settings.UrgentHighGlucoseAlarm;
  UrgentLowGlucoseAlarm := Settings.UrgentLowGlucoseAlarm;
  UrgentStaleDataAlarm := Settings.UrgentStaleDataAlarm;
  TimeZoneCorrection := Settings.TimeZoneCorrection;
  WallpaperFileName := Settings.WallpaperFileName;
end;

function TSettings.Clone(): TSettings;
begin
  Result := TSettings.Create;
  Result.AlphaBlendValue := AlphaBlendValue;
  Result.CheckInterval := CheckInterval;
  Result.CountOfEntriesToRecive := CountOfEntriesToRecive;
  Result.DrawStages := DrawStages;
  Result.EnableGlucoseLevelAlarms := EnableGlucoseLevelAlarms;
  Result.EnableStaleDataAlarms := EnableStaleDataAlarms;
  Result.FullScreen := FullScreen;
  Result.HighGlucoseAlarm := HighGlucoseAlarm;
  Result.IsMmolL := IsMmolL;
  Result.LowGlucoseAlarm := LowGlucoseAlarm;
  Result.NightscoutUrl := NightscoutUrl;
  Result.ScaleIndex := ScaleIndex;
  Result.ShowCheckNewDataProgressBar := ShowCheckNewDataProgressBar;
  Result.ShowWindowBorder := ShowWindowBorder;
  Result.StaleDataAlarm := StaleDataAlarm;
  Result.UrgentHighGlucoseAlarm := UrgentHighGlucoseAlarm;
  Result.UrgentLowGlucoseAlarm := UrgentLowGlucoseAlarm;
  Result.UrgentStaleDataAlarm := UrgentStaleDataAlarm;
  Result.TimeZoneCorrection := TimeZoneCorrection;
  Result.WallpaperFileName := WallpaperFileName;
end;

constructor TSettings.Create();
begin
  DrawStages := [dsLastGlucoseLevel, dsGlucoseLines, dsHorzGuideLines,
    dsVertGuideLines, dsLastGlucoseLevelDate, dsGlucoseSlope, dsGlucoseExtremePoints,
    dsGlucoseLevelDelta, dsGlucoseAvg];
  AlphaBlendValue := 200;
  CheckInterval := 20;
  CountOfEntriesToRecive := 40;
  EnableGlucoseLevelAlarms := True;
  EnableStaleDataAlarms := True;
  FullScreen := False;
  HighGlucoseAlarm:= 9 * cMmolDenominator;
  IsMmolL := True;
  LowGlucoseAlarm:= 4 * cMmolDenominator;
  NightscoutUrl := '';
  ScaleIndex := 5;
  ShowCheckNewDataProgressBar := True;
  ShowWindowBorder := True;
  StaleDataAlarm := 20;
  UrgentHighGlucoseAlarm:= 13 * cMmolDenominator;
  UrgentLowGlucoseAlarm:= Round(3.3 * cMmolDenominator);
  UrgentStaleDataAlarm:= 40;
  TimeZoneCorrection := 0;
  WallpaperFileName := '';
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

function TSettings.GetEntryMinsWithTimeZoneCorrection(Entry: TNightscoutEntry): Integer;
var
  EntryDateWithCorrection: TDateTime;
begin
  Result := -1;
  if Entry = nil then
    Exit;

  EntryDateWithCorrection := Entry.Date + TimeZoneCorrection / HoursPerDay;
  Result := MinutesBetween(Now, EntryDateWithCorrection);
end;

function TSettings.IsStaleDataAlarmExists(Entry: TNightscoutEntry): Boolean;
begin
  Result := GetEntryMinsWithTimeZoneCorrection(Entry) >= StaleDataAlarm;
end;

function TSettings.IsUrgentStaleDataAlarmExists(Entry: TNightscoutEntry): Boolean;
begin
  Result := GetEntryMinsWithTimeZoneCorrection(Entry) >= UrgentStaleDataAlarm;
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

function TSettings.GetLastGlucoseLevelDateText(Entry: TNightscoutEntry; out OutColor: TColor): string;
var
  Days, Hours, Mins: Int64;
  DaysStr, HoursStr, MinsStr: string;
  EntryDateWithCorrection: TDateTime;
begin
  Result := '';
  EntryDateWithCorrection := Entry.Date + TimeZoneCorrection / HoursPerDay;
  Mins := GetEntryMinsWithTimeZoneCorrection(Entry);

  if Mins >= StaleDataAlarm then
    OutColor := cWarningColor
  else
    OutColor := cLastGlucoseLevelDateColor;

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

  Hours := HoursBetween(Now, EntryDateWithCorrection);
  HoursStr := IntToStr(Hours);
  case Hours of
    1: Result := HoursStr + ' hour ago';
    2..24: Result := HoursStr + ' hours ago';
  end;

  Days := DaysBetween(Now, EntryDateWithCorrection);
  DaysStr := IntToStr(Days);
  case Days of
    1: Result := DaysStr + ' day ago';
    2..MaxInt: Result := DaysStr + ' days ago';
  end;
end;

end.
