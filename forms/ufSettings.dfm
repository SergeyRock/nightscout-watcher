object fSettings: TfSettings
  Left = 475
  Height = 600
  Top = 212
  Width = 330
  Caption = 'Settings'
  ClientHeight = 600
  ClientWidth = 330
  Color = clBtnFace
  Constraints.MinHeight = 600
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Tahoma'
  OnDestroy = FormDestroy
  Position = poScreenCenter
  LCLVersion = '2.0.6.0'
  object btnOK: TButton
    Left = 32
    Height = 36
    Top = 547
    Width = 82
    Anchors = [akLeft, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    OnClick = btnOKClick
    TabOrder = 0
  end
  object btnCancel: TButton
    Left = 216
    Height = 36
    Top = 547
    Width = 82
    Anchors = [akRight, akBottom]
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object pc: TPageControl
    Left = 0
    Height = 528
    Top = 0
    Width = 330
    ActivePage = tsAlerts
    Align = alTop
    TabIndex = 2
    TabOrder = 2
    object tsMain: TTabSheet
      Caption = 'Main'
      ClientHeight = 496
      ClientWidth = 322
      object lblCheckInterval: TLabel
        Left = 13
        Height = 19
        Top = 133
        Width = 178
        AutoSize = False
        Caption = 'Check interval in seconds'
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        ParentColor = False
        ParentFont = False
        WordWrap = True
      end
      object lblCountOfEntriesToRecieve: TLabel
        Left = 13
        Height = 19
        Top = 174
        Width = 186
        AutoSize = False
        Caption = 'Count of entries to recieve'
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        ParentColor = False
        ParentFont = False
        WordWrap = True
      end
      object lblNightscoutSite: TLabel
        Left = 13
        Height = 19
        Top = 15
        Width = 104
        Caption = 'Nightscout site'
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        ParentColor = False
        ParentFont = False
      end
      object lblTimeZoneCorrection: TLabel
        Left = 13
        Height = 35
        Top = 212
        Width = 157
        AutoSize = False
        Caption = 'Time-zone correction in hours'
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        ParentColor = False
        ParentFont = False
        WordWrap = True
      end
      object cbIsMmolL: TCheckBox
        Left = 13
        Height = 23
        Top = 88
        Width = 71
        Caption = 'mmol/l'
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        ParentFont = False
        TabOrder = 0
      end
      object seCheckInterval: TSpinEdit
        Left = 224
        Height = 27
        Top = 128
        Width = 60
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        MaxValue = 86400
        MinValue = 5
        ParentFont = False
        TabOrder = 1
        Value = 5
      end
      object seCountOfEntriesToRecive: TSpinEdit
        Left = 224
        Height = 27
        Top = 170
        Width = 60
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        MaxValue = 500
        MinValue = 2
        ParentFont = False
        TabOrder = 2
        Value = 2
      end
      object eNightscoutSite: TEdit
        Left = 13
        Height = 27
        Top = 40
        Width = 296
        Anchors = [akTop, akLeft, akRight]
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        ParentFont = False
        TabOrder = 3
      end
      object seTimeZoneCorrection: TSpinEdit
        Left = 224
        Height = 27
        Top = 213
        Width = 60
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        MaxValue = 24
        MinValue = -24
        ParentFont = False
        TabOrder = 4
        Value = 3
      end
    end
    object tsVisual: TTabSheet
      Caption = 'Visual'
      ClientHeight = 496
      ClientWidth = 322
      object lblScale: TLabel
        Left = 16
        Height = 19
        Top = 367
        Width = 42
        Caption = 'Scale:'
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        ParentColor = False
        ParentFont = False
      end
      object lblAlphaBlend: TLabel
        Left = 16
        Height = 19
        Top = 427
        Width = 86
        Caption = 'AlphaBlend:'
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        ParentColor = False
        ParentFont = False
      end
      object cbDrawHorzGuideLines: TCheckBox
        Left = 16
        Height = 23
        Top = 8
        Width = 213
        Caption = 'Draw horizontal guide lines'
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        ParentFont = False
        TabOrder = 0
      end
      object cbDrawVertGuideLines: TCheckBox
        Left = 16
        Height = 23
        Top = 36
        Width = 193
        Caption = 'Draw vertical guide lines'
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        ParentFont = False
        TabOrder = 1
      end
      object cbDrawLastSugarLevel: TCheckBox
        Left = 16
        Height = 23
        Top = 64
        Width = 167
        Caption = 'Draw last sugar level'
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        ParentFont = False
        TabOrder = 2
      end
      object cbDrawLastSugarLevelDate: TCheckBox
        Left = 16
        Height = 23
        Top = 92
        Width = 202
        Caption = 'Draw last sugar level date'
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        ParentFont = False
        TabOrder = 3
      end
      object cbDrawSugarExtremePoints: TCheckBox
        Left = 16
        Height = 23
        Top = 120
        Width = 211
        Caption = 'Draw sugar extreme points'
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        ParentFont = False
        TabOrder = 4
      end
      object cbDrawSugarLevel: TCheckBox
        Left = 16
        Height = 23
        Top = 148
        Width = 138
        Caption = 'Draw sugar level'
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        ParentFont = False
        TabOrder = 5
      end
      object cbDrawSugarLines: TCheckBox
        Left = 16
        Height = 23
        Top = 176
        Width = 138
        Caption = 'Draw sugar lines'
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        ParentFont = False
        TabOrder = 6
      end
      object cbDrawSugarSlope: TCheckBox
        Left = 16
        Height = 23
        Top = 204
        Width = 143
        Caption = 'Draw sugar slope'
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        ParentFont = False
        TabOrder = 7
      end
      object cbShowCheckNewDataProgressBar: TCheckBox
        Left = 16
        Height = 23
        Top = 320
        Width = 288
        Caption = 'Show new data checking progress bar'
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        ParentFont = False
        TabOrder = 8
      end
      object cbShowWindowBorder: TCheckBox
        Left = 16
        Height = 23
        Top = 292
        Width = 171
        Caption = 'Show window border'
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        ParentFont = False
        TabOrder = 9
      end
      object sbScale: TScrollBar
        Left = 16
        Height = 17
        Top = 392
        Width = 289
        Anchors = [akTop, akLeft, akRight]
        Max = 15
        Min = 1
        PageSize = 0
        Position = 10
        TabOrder = 10
      end
      object sbAlphaBlend: TScrollBar
        Left = 16
        Height = 17
        Top = 453
        Width = 289
        Anchors = [akTop, akLeft, akRight]
        Max = 255
        Min = 1
        PageSize = 0
        Position = 10
        TabOrder = 11
      end
      object cbDrawAlertLines: TCheckBox
        Left = 16
        Height = 23
        Top = 232
        Width = 130
        Caption = 'Draw alert lines'
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        ParentFont = False
        TabOrder = 12
      end
      object cbDrawSugarLevelPoints: TCheckBox
        Left = 16
        Height = 23
        Top = 262
        Width = 186
        Caption = 'Draw sugar level points'
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        ParentFont = False
        TabOrder = 13
      end
    end
    object tsAlerts: TTabSheet
      Caption = 'Alerts'
      ClientHeight = 496
      ClientWidth = 322
      object gbGlucoseLevelAlarms: TGroupBox
        Left = 8
        Height = 247
        Top = 36
        Width = 304
        ClientHeight = 223
        ClientWidth = 300
        TabOrder = 0
        object lblHighGlucoseAlarm: TLabel
          Left = 16
          Height = 19
          Top = 78
          Width = 78
          AutoSize = False
          Caption = 'High alarm'
          ParentColor = False
          WordWrap = True
        end
        object lblLowGlucoseAlarm: TLabel
          Left = 16
          Height = 19
          Top = 120
          Width = 74
          AutoSize = False
          Caption = 'Low alarm'
          ParentColor = False
          WordWrap = True
        end
        object lblUrgentHighGlucoseAlarm: TLabel
          Left = 16
          Height = 35
          Top = 28
          Width = 91
          AutoSize = False
          Caption = 'Urgent high alarm'
          ParentColor = False
          WordWrap = True
        end
        object lblUrgentLowGlucoseAlarm: TLabel
          Left = 16
          Height = 40
          Top = 160
          Width = 83
          AutoSize = False
          Caption = 'Urgent low alarm'
          ParentColor = False
          WordWrap = True
        end
        object lblMgDl: TLabel
          Left = 121
          Height = 19
          Top = 0
          Width = 42
          Caption = 'mg/dl'
          ParentColor = False
        end
        object lblMmolL: TLabel
          Left = 185
          Height = 19
          Top = 0
          Width = 51
          Caption = 'mmol/l'
          ParentColor = False
        end
        object lblUrgentHighGlucoseAlarmMmolL: TLabel
          Tag = 1
          Left = 185
          Height = 19
          Top = 35
          Width = 59
          Caption = 'UrgentH'
          ParentColor = False
        end
        object lblHighGlucoseAlarmMmolL: TLabel
          Tag = 2
          Left = 185
          Height = 19
          Top = 77
          Width = 33
          Caption = 'High'
          ParentColor = False
        end
        object lblLowGlucoseAlarmMmolL: TLabel
          Tag = 3
          Left = 185
          Height = 19
          Top = 120
          Width = 29
          Caption = 'Low'
          ParentColor = False
        end
        object lblUrgentLowGlucoseAlarmMmolL: TLabel
          Tag = 4
          Left = 185
          Height = 19
          Top = 162
          Width = 56
          Caption = 'UrgentL'
          ParentColor = False
        end
        object seHighGlucoseAlarm: TSpinEdit
          Tag = 2
          Left = 115
          Height = 27
          Top = 74
          Width = 60
          Increment = 2
          MaxValue = 300
          MinValue = 1
          TabOrder = 1
          Value = 1
        end
        object seLowGlucoseAlarm: TSpinEdit
          Tag = 3
          Left = 115
          Height = 27
          Top = 116
          Width = 60
          Increment = 2
          MaxValue = 300
          MinValue = 1
          TabOrder = 2
          Value = 1
        end
        object seUrgentHighGlucoseAlarm: TSpinEdit
          Tag = 1
          Left = 115
          Height = 27
          Top = 32
          Width = 60
          Increment = 2
          MaxValue = 300
          MinValue = 1
          TabOrder = 0
          Value = 1
        end
        object seUrgentLowGlucoseAlarm: TSpinEdit
          Tag = 4
          Left = 115
          Height = 27
          Top = 159
          Width = 60
          Increment = 2
          MaxValue = 300
          MinValue = 1
          TabOrder = 3
          Value = 1
        end
      end
      object GroupBox2: TGroupBox
        Left = 8
        Height = 144
        Top = 325
        Width = 304
        ClientHeight = 120
        ClientWidth = 300
        TabOrder = 1
        object lblUrgentStaleDataAlarm: TLabel
          Left = 13
          Height = 45
          Top = 8
          Width = 139
          AutoSize = False
          Caption = 'Urgent stale data alarm in minutes'
          ParentColor = False
          WordWrap = True
        end
        object lblStaleDataAlarm: TLabel
          Left = 14
          Height = 43
          Top = 61
          Width = 137
          AutoSize = False
          Caption = 'Stale data alarm in minutes'
          ParentColor = False
          WordWrap = True
        end
        object seUrgentStaleDataAlarm: TSpinEdit
          Left = 185
          Height = 27
          Top = 14
          Width = 60
          MaxValue = 999
          MinValue = 1
          TabOrder = 0
          Value = 1
        end
        object seStaleDataAlarm: TSpinEdit
          Left = 185
          Height = 27
          Top = 61
          Width = 60
          MaxValue = 999
          MinValue = 1
          TabOrder = 1
          Value = 1
        end
      end
      object cbEnableGlucoseLevelAlarms: TCheckBox
        Left = 8
        Height = 23
        Top = 15
        Width = 214
        Caption = 'Enable glucose level alarms'
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        ParentFont = False
        TabOrder = 2
      end
      object cbEnableStaleDataAlarms: TCheckBox
        Left = 8
        Height = 23
        Top = 304
        Width = 191
        Caption = 'Enable stale data alarms'
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        ParentFont = False
        TabOrder = 3
      end
    end
    object tsAbout: TTabSheet
      Caption = 'About'
    end
  end
end
