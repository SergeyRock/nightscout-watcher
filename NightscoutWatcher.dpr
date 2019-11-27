(*
 This file is part of NightscoutWatcher.

 NightscoutWatcher is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.

 NightscoutWatcher is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.

 You should have received a copy of the GNU General Public License
 along with TrayTrend. If not, see http://www.gnu.org/licenses/ .

 (c) 2019 Sergey Oleynikov - https://github.com/SergeyRock/nightscout-watcher
*)
program NightscoutWatcher;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

uses
  Interfaces,
  Forms,
  ufMain in 'forms\ufMain.pas' {fMain},                 
  ufSettings in 'forms\ufSettings.pas' {fSettings},
  uNightscout in 'units\uNightscout.pas',
  uSettings in 'units\uSettings.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Nightscout Watcher';
  Application.CreateForm(TfMain, fMain);
  Application.Run;
end.
