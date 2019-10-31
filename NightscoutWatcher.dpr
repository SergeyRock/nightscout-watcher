program NightscoutWatcher;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

uses
{$IFnDEF FPC}
{$ELSE}
  Interfaces,
{$ENDIF}
  Forms,
  ufMain in 'forms\ufMain.pas' {fMain},
  uNightscout in 'units\uNightscout.pas',
  ufSettings in 'forms\ufSettings.pas' {fSettings},
  uSettings in 'units\uSettings.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Nightscout Wathcer';
  Application.CreateForm(TfMain, fMain);
  Application.Run;
end.
