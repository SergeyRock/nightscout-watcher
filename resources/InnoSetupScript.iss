; -- Installation script --

#define MyInstallerName "NightscoutWatcher" 
#define MyAppExeName "NightscoutWatcher.exe" 
#define MyAppName "Nightscout Watcher"
#define MyAppVersion "2.3.1"
#define MyGitHubSite "https://github.com/SergeyRock/nightscout-watcher#nightscout-watcher"

[Setup]
AppName=Nightscout Watcher
WizardStyle=modern
DefaultDirName={autopf}\Nightscout Watcher
DefaultGroupName=Nightscout Watcher
Compression=lzma2
SolidCompression=yes
OutputDir=.\
OutputBaseFilename={#MyInstallerName}
PrivilegesRequired=none
Uninstallable=yes
DisableReadyPage=True
AppCopyright=Sergey Oleynikov
SetupIconFile=NightScoutWatcher.ico
ShowUndisplayableLanguages=True
UninstallDisplayName=Nightscout Watcher
UninstallDisplayIcon={app}\{#MyAppExeName}
AppVersion={#MyAppVersion}

[Files]
Source: "..\lib\i386-win32\{#MyAppExeName}"; DestDir: "{app}"; Flags: ignoreversion
Source: "alarm.wav"; DestDir: "{app}"; Flags: ignoreversion
Source: "alarm2.wav"; DestDir: "{app}"; Flags: ignoreversion
Source: "libeay32.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "ssleay32.dll"; DestDir: "{app}"; Flags: ignoreversion

[Icons]
Name: "{commondesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; IconFilename: "{app}\{#MyAppExeName}"; Tasks: "desktopicon"
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; IconFilename: "{app}\{#MyAppExeName}"
Name: "{commonstartup}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; WorkingDir: "{app}"; Tasks: "startupicon"
Name: "{commonstartup}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; WorkingDir: "{app}"; Tasks: "startupicon"

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"; 
Name: "russian"; MessagesFile: "compiler:Languages\Russian.isl";

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked
Name: "startupicon"; Description: "{cm:AutoStartProgram, {#'при загрузке операционной системы'}}"; GroupDescription: "{cm:AdditionalIcons}"; Languages: russian; Flags: unchecked
Name: "startupicon"; Description: "{cm:AutoStartProgram, {#'with OS'}}"; GroupDescription: "{cm:AdditionalIcons}"; Languages: english; Flags: unchecked

[Run]
Filename: "{app}\{#MyAppExeName}"; Flags: nowait postinstall skipifsilent; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"
Filename: "{#MyGitHubSite}"; Flags: nowait postinstall skipifsilent shellexec; Description: "{cm:ProgramOnTheWeb,{#MyGitHubSite}}"
