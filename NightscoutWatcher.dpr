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
  ufSettings in 'forms\ufSettings.pas' {fSettings},
  uNightscout in 'units\uNightscout.pas',
  uSettings in 'units\uSettings.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title:='Nightscout Watcher';
  Application.CreateForm(TfMain, fMain);
  Application.Run;
end.
