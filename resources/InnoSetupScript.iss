; -- Installation script --

#define MyInstallerName "NightscoutWatcher" 
#define MyAppExeName "NightscoutWatcher.exe" 
#define MyAppName "Nightscout Watcher"
#define MyAppVersion "2.5.0"
#define MyGitHubSite "https://github.com/SergeyRock/nightscout-watcher#nightscout-watcher"
#define MyAuthor "Sergey Oleynikov"
#define MyPortableLockFile "Portable.lock"

[Setup]
AppName={#MyAppName}
WizardStyle=modern
DefaultDirName={autopf}\{#MyAppName}
DefaultGroupName={#MyAppName}
Compression=lzma2
SolidCompression=yes
OutputDir=.\
OutputBaseFilename={#MyInstallerName}
PrivilegesRequired=none
Uninstallable=not IsTaskSelected('portable_mode')
DisableReadyPage=True
AppCopyright={#MyAuthor}, 2019
SetupIconFile=NightScoutWatcher.ico
ShowUndisplayableLanguages=True
UninstallDisplayName={#MyAppName}
UninstallDisplayIcon={app}\{#MyAppExeName}
AppVersion={#MyAppVersion}
VersionInfoVersion={#MyAppVersion}
VersionInfoCompany={#MyAuthor}
VersionInfoDescription=Blood Glucose Monitoring app
VersionInfoTextVersion={#MyAppVersion}
VersionInfoCopyright={#MyAuthor}, 2019
VersionInfoProductName={#MyAppName}
AlwaysShowGroupOnReadyPage=True
AlwaysShowDirOnReadyPage=True

[Files]
Source: "..\lib\i386-win32\{#MyAppExeName}"; DestDir: "{app}"; Flags: ignoreversion
Source: "alarm.wav"; DestDir: "{app}"; Flags: ignoreversion
Source: "alarm2.wav"; DestDir: "{app}"; Flags: ignoreversion
Source: "libeay32.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "ssleay32.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "{#MyPortableLockFile}"; DestDir: "{app}"; Flags: ignoreversion; Tasks: "portable_mode"

[Icons]
Name: "{autoprograms}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; IconFilename: "{app}\{#MyAppExeName}"; Tasks: "start_menu_icon"
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; IconFilename: "{app}\{#MyAppExeName}"; Tasks: "desktop_icon"
Name: "{autostartup}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; WorkingDir: "{app}"; Tasks: "startup_icon"

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"; 
Name: "russian"; MessagesFile: "compiler:Languages\Russian.isl";

[Tasks]
Name: "start_menu_icon"; Description: "{cm:AddToStartMenu}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked
Name: "desktop_icon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked
Name: "startup_icon"; Description: "{cm:AutoStartProgram,{cm:AutoStartProgramOption}}"; GroupDescription: "{cm:Options}"; Flags: unchecked
Name: "portable_mode"; Description: "{cm:PortableMode}"; GroupDescription: "{cm:Options}"; Flags: unchecked

[Run]
Filename: "{app}\{#MyAppExeName}"; Flags: nowait postinstall skipifsilent; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"
Filename: "{#MyGitHubSite}"; Flags: nowait postinstall skipifsilent shellexec; Description: "{cm:ProgramOnTheWeb,{#MyGitHubSite}}"

[CustomMessages]
english.AddToStartMenu=Add to shortcut to Start Menu
russian.AddToStartMenu=Добавить ссылку в меню "Пуск"
english.Options=Options:
russian.Options=Опции:
english.PortableMode=Portable Mode
russian.PortableMode=Портативная установка
russian.AutoStartProgramOption=при загрузке операционной системы
english.AutoStartProgramOption=with OS

[InstallDelete]
Type: files; Name: "{app}\{#MyPortableLockFile}"
