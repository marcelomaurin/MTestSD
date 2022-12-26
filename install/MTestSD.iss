; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "MTestSD"
#define MyAppVersion "0.1"
#define MyAppPublisher "MAURINSOFT"
#define MyAppURL "http://maurinsoft.com.br"
#define MyAppExeName "MTestSD.exe"

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{25E25926-C821-4D48-B273-8916FE92FCD5}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={pf}\{#MyAppName}
DisableProgramGroupPage=yes
OutputBaseFilename=MTestSD_setup_01
Compression=lzma
SolidCompression=yes

 

[Languages]
Name: "brazilianportuguese"; MessagesFile: "compiler:Languages\BrazilianPortuguese.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked


[Types]
Name: "MTestSD"; Description: {cm:T_MTestSD}

[Components]
Name: "MTestSD"; Description: "Arquivos do test"; Types: MTestSD;


[CustomMessages]
T_MTestSD=MTestSD
TD_MTestSD=Install MTestSD


[Code]
//#define MSIDT_CustomType "Whatever"
//#include "DescriptiveTypes.isi"
//procedure InitializeWizard();
//begin
// InitializeDescriptiveTypes();
//end;



[Files]
Source: "D:\projetos\maurinsoft\MTestSD\MTestSD.exe"; DestDir: "{app}"; Flags: ignoreversion
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]
Name: "{commonprograms}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{commondesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent

