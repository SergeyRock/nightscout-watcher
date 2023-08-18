; -- Installation script --

#define MyAppVersion "2.15.0"

#define MyInstallerName "NightscoutWatcher" 
#define MyAppExeName "NightscoutWatcher.exe" 
#define MyAppName "Nightscout Watcher"
#define MyAppContact "osp1000@gmail.com"
#define MyGitHubSite "https://github.com/SergeyRock/nightscout-watcher#nightscout-watcher"
#define MyGitHubSupportURL "https://github.com/SergeyRock/nightscout-watcher/issues"
#define MyGitHubLatestReleaseURL "https://github.com/SergeyRock/nightscout-watcher/releases/latest"
#define MyAuthor "Sergey Oleynikov"
#define MyPortableLockFile "Portable.lock"

[Setup]
AllowNoIcons=True
AlwaysShowDirOnReadyPage=True
AlwaysShowGroupOnReadyPage=True
AppComments=Any help in application developing is appreciated
AppContact={#MyAppContact}
AppCopyright={#MyAuthor}, 2019
AppMutex={#MyAppExeName}
AppName={#MyAppName}
AppPublisher={#MyAuthor}
AppPublisherURL={#MyGitHubSite}
AppSupportURL={#MyGitHubSupportURL}
AppUpdatesURL={#MyGitHubLatestReleaseURL}
AppVersion={#MyAppVersion}
Compression=lzma2
DefaultDirName={userdocs}\{#MyAppName}
DefaultGroupName={#MyAppName}
DisableReadyPage=True
OutputBaseFilename={#MyInstallerName}
OutputDir=.\
PrivilegesRequired=none
SetupIconFile=NightscoutWatcher.ico
ShowUndisplayableLanguages=True
SolidCompression=yes
UninstallDisplayIcon={app}\{#MyAppExeName}
UninstallDisplayName={#MyAppName}
Uninstallable=not WizardIsTaskSelected('portable_mode')
VersionInfoCompany={#MyAuthor}
VersionInfoCopyright={#MyAuthor}, 2023
VersionInfoDescription=continuous Glucose Monitoring app
VersionInfoProductName={#MyAppName}
VersionInfoTextVersion={#MyAppVersion}
VersionInfoVersion={#MyAppVersion}
WizardImageFile=InstallerImage.bmp
WizardStyle=classic     
WizardSizePercent=150,130           
InfoAfterFile=ReadMe.rtf

[Files]
Source: "..\lib\x86_64-win64\{#MyAppExeName}"; DestDir: "{app}"; Flags: ignoreversion
Source: "alarm.wav"; DestDir: "{app}"; Flags: ignoreversion
Source: "alarm2.wav"; DestDir: "{app}"; Flags: ignoreversion
Source: "libeay32.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "ssleay32.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "{#MyPortableLockFile}"; DestDir: "{app}"; Flags: ignoreversion; Tasks: "portable_mode"

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; WorkingDir: "{app}"; IconFilename: "{app}\{#MyAppExeName}";
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; WorkingDir: "{app}"; IconFilename: "{app}\{#MyAppExeName}"; Tasks: "desktop_icon"
Name: "{autostartup}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; WorkingDir: "{app}"; Tasks: "startup_icon"

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"; 
Name: "russian"; MessagesFile: "compiler:Languages\Russian.isl";

[Tasks]
Name: "desktop_icon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked; 
Name: "startup_icon"; Description: "{cm:AutoStartProgram,{cm:AutoStartProgramOption}}"; GroupDescription: "{cm:Options}"; Flags: unchecked
Name: "portable_mode"; Description: "{cm:PortableMode}"; GroupDescription: "{cm:Options}"; Flags: unchecked

[Run]
Filename: "{app}\{#MyAppExeName}"; Flags: nowait postinstall skipifsilent; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"
Filename: "{#MyGitHubSite}"; Flags: nowait postinstall skipifsilent shellexec; Description: "{cm:ProgramOnTheWeb,{#MyGitHubSite}}"

[CustomMessages]
english.Options=Options:
russian.Options=Опции:
english.PortableMode=Portable Mode
russian.PortableMode=Портативная установка
russian.AutoStartProgramOption=при загрузке операционной системы
english.AutoStartProgramOption=with OS startup

[InstallDelete]
Type: files; Name: "{app}\{#MyPortableLockFile}"
