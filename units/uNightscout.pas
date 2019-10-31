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
  TNightscoutEntry = class
  public
    Date: TDateTime;
    Sugar: Integer;
    Slope: string;
    Device: string;
    procedure SetDate(UnixDateStr: string);
    procedure SetSugar(SugarStr: string); overload;
    procedure SetSugar(Value: Double; IsMmolL: Boolean); overload;
    function ParseRow(Row: string): Boolean;
    function SugarMmol: Double;
    function GetSugar(IsMmolL: Boolean = True): Double;
    function GetSugarStr(IsMmolL: Boolean = True): string; overload;
    class function GetSugarStr(SugarValue: Integer; IsMmolL: Boolean = True): string; overload;
  end;

  TNightscoutEntryList = class (TObjectList)
  protected
    procedure SetItem(Index: Integer; const Value: TNightscoutEntry);
    function GetItem(Index: Integer): TNightscoutEntry;
  public
    function GetMaxSugarDelta(MinValue, MaxValue: Integer): Integer;
    function GetMaxSugar(): Integer;
    function GetMinSugar(): Integer;
    function GetMinSugarMmol(): Double;
    function GetMaxSugarMmol(): Double;
    function Last: TNightscoutEntry;
    procedure RemoveDuplicatesWithTheSameDate();
    procedure LimitEntries(MaxItems: Integer);
    property Items[Index: Integer]: TNightscoutEntry read GetItem write SetItem; default;
  end;

implementation

uses
  Classes, UrlMon, Math, SysUtils, Dialogs;
  
{ TNightscoutEntryList }

function TNightscoutEntryList.GetItem(Index: Integer): TNightscoutEntry;
begin
  Result := TNightscoutEntry(inherited GetItem(Index));
end;

function TNightscoutEntryList.GetMaxSugar: Integer;
var
  i: Integer;
begin
  Result := 0;
  for i := 0 to Count - 1 do
    if Items[i].Sugar > Result then
      Result := Items[i].Sugar;
end;

function TNightscoutEntryList.GetMaxSugarDelta(MinValue, MaxValue: Integer): Integer;
begin
  Result :=
    IfThen(MaxValue = -1, GetMaxSugar, Max(GetMaxSugar, MaxValue)) -
    IfThen(MinValue = -1, GetMinSugar, Min(GetMinSugar, MinValue));
end;

function TNightscoutEntryList.GetMinSugar: Integer;
var
  i: Integer;
begin
  Result := 999;
  for i := 0 to Count - 1 do
    if Items[i].Sugar < Result then
      Result := Items[i].Sugar;
end;

function TNightscoutEntryList.GetMinSugarMmol: Double;
begin
  Result := GetMinSugar / cMmolDenominator;
end;

function TNightscoutEntryList.GetMaxSugarMmol: Double;
begin
  Result := GetMaxSugar / cMmolDenominator;
end;

function TNightscoutEntryList.Last: TNightscoutEntry;
begin
  Result := TNightscoutEntry(inherited Last);
end;


procedure TNightscoutEntryList.RemoveDuplicatesWithTheSameDate;
var
  i: Integer;
  Entry, PrevEntry: TNightscoutEntry;
begin
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

function TNightscoutEntry.GetSugar(IsMmolL: Boolean = True): Double;
begin
  Result := IfThen(IsMmolL, SugarMmol, Sugar);
end;

class function TNightscoutEntry.GetSugarStr(SugarValue: Integer; IsMmolL: Boolean = True): string;
begin
  if IsMmolL then
    Result := FloatToStrF(SugarValue / cMmolDenominator, ffNumber, 3, 1)
  else
    Result := IntToStr(SugarValue);
end;

function TNightscoutEntry.GetSugarStr(IsMmolL: Boolean = True): string;
begin
  Result := GetSugarStr(Sugar, IsMmolL);
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
          2: SetSugar(Value);
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

procedure TNightscoutEntry.SetSugar(Value: Double; IsMmolL: Boolean);
begin
  Sugar := Round(Value);
  if IsMmolL then
    Sugar := Sugar * cMmolDenominator;
end;

procedure TNightscoutEntry.SetSugar(SugarStr: string);
begin
  Sugar := StrToInt(SugarStr);
end;

function TNightscoutEntry.SugarMmol: Double;
begin
  Result := Sugar / cMmolDenominator;
end;

end.
