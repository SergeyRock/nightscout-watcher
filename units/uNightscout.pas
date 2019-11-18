unit uNightscout;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

interface

uses
  DateUtils, Contnrs, ExtCtrls;

const
  cMmolDenominator = 18;

type

  { TNightscoutEntry }

  TNightscoutEntry = class
  public
    Date: TDateTime;
    Glucose: Integer;
    Slope: string;
    Device: string;
    procedure SetDate(UnixDateStr: string);
    procedure SetGlucose(GlucoseStr: string); overload;
    procedure SetGlucose(Value: Double; IsMmolL: Boolean); overload;
    function ParseRow(Row: string): Boolean;
    function GlucoseMmol: Double;
    function GetGlucose(IsMmolL: Boolean = True): Double;
    function GetGlucoseStr(IsMmolL: Boolean = True): string; overload;
    function GetArrowCountOfSlope(): Byte;
    class function GetGlucoseStr(GlucoseValue: Integer; IsMmolL: Boolean = True): string; overload;
  end;

  { TNightscoutEntryList }

  TNightscoutEntryList = class (TObjectList)
  private
  protected
    procedure SetItem(Index: Integer; const Value: TNightscoutEntry);
    function GetItem(Index: Integer): TNightscoutEntry;
  public
    function GetAvgGlucoseStr(IsMmolL: Boolean): string;
    function GetMaxGlucoseDelta(MinValue, MaxValue: Integer): Integer;
    function GetMaxGlucose(): Integer;
    function GetMinGlucose(): Integer;
    function GetMinGlucoseMmol(): Double;
    function GetMaxGlucoseMmol(): Double;
    function GetGlucoseLevelDeltaText(IsMmolL: Boolean): string;
    function First: TNightscoutEntry;
    function Last: TNightscoutEntry;
    function LoadFromFile(const FileName: string): Boolean;
    procedure RemoveDuplicatesWithTheSameDate();
    procedure LimitEntries(MaxItems: Integer);
    property Items[Index: Integer]: TNightscoutEntry read GetItem write SetItem; default;
  end;

implementation

uses
  Classes, strutils, Math, SysUtils, Dialogs;
  
{ TNightscoutEntryList }

function TNightscoutEntryList.GetItem(Index: Integer): TNightscoutEntry;
begin
  Result := TNightscoutEntry(inherited GetItem(Index));
end;

function TNightscoutEntryList.GetMaxGlucose(): Integer;
var
  i: Integer;
begin
  Result := 0;
  for i := 0 to Count - 1 do
    if Items[i].Glucose > Result then
      Result := Items[i].Glucose;
end;

function TNightscoutEntryList.GetMaxGlucoseDelta(MinValue, MaxValue: Integer): Integer;
begin
  Result :=
    IfThen(MaxValue = -1, GetMaxGlucose, Max(GetMaxGlucose, MaxValue)) -
    IfThen(MinValue = -1, GetMinGlucose, Min(GetMinGlucose, MinValue));
end;

function TNightscoutEntryList.GetAvgGlucoseStr(IsMmolL: Boolean): string;
var
  i, GlucoseSum: Integer;
begin
  Result := '';

  if Count = 0 then
    Exit;

  GlucoseSum := 0;
  for i := 0 to Count - 1 do
    Inc(GlucoseSum, Items[i].Glucose);

  Result := TNightscoutEntry.GetGlucoseStr(Round(GlucoseSum / Count), IsMmolL);
end;
function TNightscoutEntryList.GetMinGlucose(): Integer;
var
  i: Integer;
begin
  Result := 999;
  for i := 0 to Count - 1 do
    if Items[i].Glucose < Result then
      Result := Items[i].Glucose;
end;

function TNightscoutEntryList.GetMinGlucoseMmol(): Double;
begin
  Result := GetMinGlucose / cMmolDenominator;
end;

function TNightscoutEntryList.GetMaxGlucoseMmol(): Double;
begin
  Result := GetMaxGlucose / cMmolDenominator;
end;

function TNightscoutEntryList.GetGlucoseLevelDeltaText(IsMmolL: Boolean): string;
var
  LastEntry, PrevLastEntry: TNightscoutEntry;
  GlucoseDelta: Integer;
begin
  Result := '';
  if Count < 2 then
    Exit;

  LastEntry := Last;
  PrevLastEntry := Items[Count - 2];
  GlucoseDelta := LastEntry.Glucose - PrevLastEntry.Glucose;
  Result := Result + ifThen(GlucoseDelta > 0, '+', '');
  Result := Result + TNightscoutEntry.GetGlucoseStr(GlucoseDelta, IsMmolL);
  Result := Result + ifThen(IsMmolL, ' mmol/l', ' mg/dl');
end;

function TNightscoutEntryList.Last: TNightscoutEntry;
begin
  Result := TNightscoutEntry(inherited Last);
end;

function TNightscoutEntryList.LoadFromFile(const FileName: string): Boolean;
var
  Line: string;
  DataFile: TextFile;
  Entry: TNightscoutEntry;
begin
  try
    AssignFile(DataFile, FileName);
    FileMode := fmOpenRead;
    Reset(DataFile);

    while not Eof(DataFile) do
    begin
      ReadLn(DataFile, Line);
      Entry := TNightscoutEntry.Create();
      if Entry.ParseRow(Line) then
        Insert(0, Entry)
      else
        FreeAndNil(Entry);
    end;
    RemoveDuplicatesWithTheSameDate;
    //LimitEntries(Settings.HoursToRecive);
    CloseFile(DataFile);
    Result := True;
  except
    Result := False;
  end;
end;

function TNightscoutEntryList.First: TNightscoutEntry;
begin
  Result := TNightscoutEntry(inherited First);
end;

procedure TNightscoutEntryList.RemoveDuplicatesWithTheSameDate();
var
  i: Integer;
  Entry, PrevEntry: TNightscoutEntry;
begin
  // We need to clear duplicate items because of next entries with the same time
  //2019-11-11T21:21:26.955+0400	1573492886955	96	Flat	xDrip-DexbridgeWixel
  //2019-11-11T21:21:26.955+0400	1573492886955	97	Flat	xDrip-DexbridgeWixel
  PrevEntry := Last();
  if PrevEntry = nil then
    Exit;

  for i := Count - 2 downto 0 do
  begin
    Entry := Items[i];
    if Entry.Date = PrevEntry.Date then
      Delete(i)
    else
      PrevEntry := Entry;
  end;
end;

procedure TNightscoutEntryList.LimitEntries(MaxItems: Integer);
var
  i: Integer;
begin
  for i := Count - 1 downto MaxItems do
    Delete(i);
end;

procedure TNightscoutEntryList.SetItem(Index: Integer; const Value: TNightscoutEntry);
begin
  inherited SetItem(Index, Value);
end;

{ TNightscoutEntry }

function TNightscoutEntry.GetGlucose(IsMmolL: Boolean = True): Double;
begin
  Result := IfThen(IsMmolL, GlucoseMmol, Glucose);
end;

class function TNightscoutEntry.GetGlucoseStr(GlucoseValue: Integer; IsMmolL: Boolean = True): string;
begin
  if IsMmolL then
    Result := FloatToStrF(GlucoseValue / cMmolDenominator, ffNumber, 3, 1)
  else
    Result := IntToStr(GlucoseValue);
end;

function TNightscoutEntry.GetGlucoseStr(IsMmolL: Boolean = True): string;
begin
  Result := GetGlucoseStr(Glucose, IsMmolL);
end;

function TNightscoutEntry.GetArrowCountOfSlope(): Byte;
begin
  Result := IfThen((Slope = 'DoubleUp') or (Slope = 'DoubleDown'), 2, 1)
end;

function TNightscoutEntry.ParseRow(Row: string): Boolean;
var
  Columns: TStringList;
  i: Integer;
  Value: string;
begin
  Result := True;
  Columns := TStringList.Create;
  try
    Columns.Delimiter := #9; // Tab char
    Columns.DelimitedText := Row;
    try
      for i := 0 to Columns.Count - 1 do
      begin
        Value := Columns[i];
        case i of
          0: Continue;
          1: SetDate(Value);
          2: SetGlucose(Value);
          3: Slope := Value;
          4: Device := Value;
        end;
      end;
    except
      Result := False;
    end;
  finally
    Columns.Free;
  end;
end;

procedure TNightscoutEntry.SetDate(UnixDateStr: string);
var
  UnixDate: Int64;
begin
  // Remove microsecs
  UnixDateStr := Copy(UnixDateStr, 1, 10);
  UnixDate := StrToInt64(UnixDateStr);
  Date := UnixToDateTime(UnixDate);
end;

procedure TNightscoutEntry.SetGlucose(Value: Double; IsMmolL: Boolean);
begin
  Glucose := Round(Value);
  if IsMmolL then
    Glucose := Glucose * cMmolDenominator;
end;

procedure TNightscoutEntry.SetGlucose(GlucoseStr: string);
begin
  Glucose := StrToInt(GlucoseStr);
end;

function TNightscoutEntry.GlucoseMmol: Double;
begin
  Result := Glucose / cMmolDenominator
end;

end.
