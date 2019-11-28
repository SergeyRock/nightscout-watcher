; -- Installation script --

#define MyInstallerName "NightscoutWatcher" 
#define MyAppExeName "NightscoutWatcher.exe" 
#define MyAppName "Nightscout Watcher"
#define MyAppVersion "2.3.0"

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


[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"; 
Name: "russian"; MessagesFile: "compiler:Languages\Russian.isl";

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked


[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent
