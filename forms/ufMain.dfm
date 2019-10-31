object fMain: TfMain
  Left = 0
  Top = 0
  AlphaBlend = True
  AlphaBlendValue = 230
  BorderIcons = []
  BorderStyle = bsNone
  Caption = 'NightscoutWatcher'
  ClientHeight = 157
  ClientWidth = 233
  Color = clBlack
  Constraints.MinHeight = 50
  Constraints.MinWidth = 80
  Ctl3D = False
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  KeyPreview = True
  OldCreateOrder = False
  Position = poDefault
  OnCreate = FormCreate
  OnDblClick = actVisitNightscoutSiteExecute
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnMouseWheel = FormMouseWheel
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pb: TProgressBar
    Left = 0
    Top = 152
    Width = 233
    Height = 5
    Align = alBottom
    Position = 10
    Smooth = True
    TabOrder = 0
  end
  object pm: TPopupMenu
    Left = 152
    Top = 8
    object miSetNightscoutSite: TMenuItem
      Action = actSetNightscoutSite
    end
    object miSetUnitOfMeasureMmolL: TMenuItem
      Action = actSetUnitOfMeasureMmolL
      AutoCheck = True
    end
    object Setcountofentriestorecive1: TMenuItem
      Action = actSetCountOfEntriesToRecive
    end
    object miSetCheckInterval: TMenuItem
      Action = actSetCheckInterval
    end
    object Showsettings1: TMenuItem
      Action = actShowSettings
    end
    object miN2: TMenuItem
      Caption = '-'
    end
    object miDrawLastSugarLevel: TMenuItem
      Action = actDrawLastSugarLevel
      AutoCheck = True
    end
    object miDrawSugarLines: TMenuItem
      Action = actDrawSugarLines
      AutoCheck = True
    end
    object miDrawSugarLevel: TMenuItem
      Action = actDrawSugarLevel
      AutoCheck = True
    end
    object miDrawVertGuideLines: TMenuItem
      Action = actDrawVertGuideLines
      AutoCheck = True
    end
    object miDrawHorzGuideLines: TMenuItem
      Action = actDrawHorzGuideLines
      AutoCheck = True
    end
    object miDrawLastSugarLevelDate: TMenuItem
      Action = actDrawLastSugarLevelDate
      AutoCheck = True
    end
    object miDrawSugarSlope: TMenuItem
      Action = actDrawSugarSlope
      AutoCheck = True
    end
    object miDrawSugarExtremePoints: TMenuItem
      Action = actDrawSugarExtremePoints
      AutoCheck = True
    end
    object Drawalertlines1: TMenuItem
      Action = actDrawAlertLines
      AutoCheck = True
    end
    object Drawsugarlevelpoints1: TMenuItem
      Action = actDrawSugarLevelPoints
      AutoCheck = True
    end
    object miShowWindowBorder: TMenuItem
      Action = actShowWindowBorder
      AutoCheck = True
    end
    object miShowCheckNewDataProgressBar: TMenuItem
      Action = actShowCheckNewDataProgressBar
      AutoCheck = True
    end
    object Fullscreen1: TMenuItem
      Action = actFullScreen
      AutoCheck = True
    end
    object miN1: TMenuItem
      Caption = '-'
    end
    object miVisitNightscoutSite: TMenuItem
      Action = actVisitNightscoutSite
    end
    object miHelp: TMenuItem
      Action = actHelp
    end
    object miN3: TMenuItem
      Caption = '-'
    end
    object miExit: TMenuItem
      Action = actExit
    end
  end
  object tmr: TTimer
    Enabled = False
    Interval = 20000
    OnTimer = tmrTimer
    Left = 8
    Top = 8
  end
  object tmrProgressBar: TTimer
    Enabled = False
    OnTimer = tmrProgressBarTimer
    Left = 40
    Top = 8
  end
  object al: TActionList
    Left = 120
    Top = 8
    object actDrawLastSugarLevel: TAction
      Category = 'Draw options'
      AutoCheck = True
      Caption = 'Draw last sugar level'
      Checked = True
      ShortCut = 49
      OnExecute = DoDrawStageExecute
    end
    object actDrawSugarLines: TAction
      Tag = 1
      Category = 'Draw options'
      AutoCheck = True
      Caption = 'Draw sugar lines'
      Checked = True
      ShortCut = 50
      OnExecute = DoDrawStageExecute
    end
    object actDrawSugarExtremePoints: TAction
      Tag = 7
      Category = 'Draw options'
      AutoCheck = True
      Caption = 'Draw sugar extreme points'
      Checked = True
      ShortCut = 56
      OnExecute = DoDrawStageExecute
    end
    object actDrawSugarLevel: TAction
      Tag = 2
      Category = 'Draw options'
      AutoCheck = True
      Caption = 'Draw sugar level'
      Checked = True
      ShortCut = 51
      OnExecute = DoDrawStageExecute
    end
    object actDrawHorzGuideLines: TAction
      Tag = 3
      Category = 'Draw options'
      AutoCheck = True
      Caption = 'Draw horizontal guide lines'
      Checked = True
      ShortCut = 53
      Visible = False
      OnExecute = DoDrawStageExecute
    end
    object actDrawVertGuideLines: TAction
      Tag = 4
      Category = 'Draw options'
      AutoCheck = True
      Caption = 'Draw vertical guide lines'
      Checked = True
      ShortCut = 52
      OnExecute = DoDrawStageExecute
    end
    object actDrawSugarSlope: TAction
      Tag = 6
      Category = 'Draw options'
      AutoCheck = True
      Caption = 'Draw sugar slope'
      Checked = True
      ShortCut = 55
      OnExecute = DoDrawStageExecute
    end
    object actDrawLastSugarLevelDate: TAction
      Tag = 5
      Category = 'Draw options'
      AutoCheck = True
      Caption = 'Draw last sugar level date'
      Checked = True
      ShortCut = 54
      OnExecute = DoDrawStageExecute
    end
    object actDrawAlertLines: TAction
      Tag = 8
      Category = 'Draw options'
      AutoCheck = True
      Caption = 'Draw alert lines'
      Checked = True
      ShortCut = 57
      OnExecute = DoDrawStageExecute
    end
    object actDrawSugarLevelPoints: TAction
      Tag = 9
      Category = 'Draw options'
      AutoCheck = True
      Caption = 'Draw sugar level points'
      Checked = True
      ShortCut = 73
      OnExecute = DoDrawStageExecute
    end
    object actVisitNightscoutSite: TAction
      Category = 'Other'
      Caption = 'Visit Nightscout Site'
      ShortCut = 86
      OnExecute = actVisitNightscoutSiteExecute
    end
    object actShowCheckNewDataProgressBar: TAction
      Category = 'Show options'
      AutoCheck = True
      Caption = 'Show new data checking progress bar'
      Checked = True
      ShortCut = 80
      OnExecute = actShowCheckNewDataProgressBarExecute
    end
    object actHelp: TAction
      Category = 'Other'
      Caption = 'Help'
      ShortCut = 112
      OnExecute = actHelpExecute
    end
    object actSetNightscoutSite: TAction
      Category = 'Options'
      Caption = 'Set Nightscout site URL'
      ShortCut = 83
      OnExecute = actSetNightscoutSiteExecute
    end
    object actExit: TAction
      Category = 'Other'
      Caption = 'Exit'
      ShortCut = 88
      OnExecute = actExitExecute
    end
    object actSetCheckInterval: TAction
      Category = 'Options'
      Caption = 'Set time interval to check new data (secs)'
      ShortCut = 73
      OnExecute = actSetCheckIntervalExecute
    end
    object actShowWindowBorder: TAction
      Category = 'Show options'
      AutoCheck = True
      Caption = 'Show window border'
      ShortCut = 66
      OnExecute = actShowWindowBorderExecute
    end
    object actSetUnitOfMeasureMmolL: TAction
      Category = 'Options'
      AutoCheck = True
      Caption = 'Set to mmol/l'
      ShortCut = 77
      OnExecute = actSetUnitOfMeasureMmolLExecute
    end
    object actSetCountOfEntriesToRecive: TAction
      Category = 'Options'
      Caption = 'Set count of entries to recive'
      ShortCut = 67
      OnExecute = actSetCountOfEntriesToReciveExecute
    end
    object actShowSettings: TAction
      Category = 'Other'
      Caption = 'Show settings'
      ShortCut = 120
      OnExecute = actShowSettingsExecute
    end
    object actFullScreen: TAction
      Category = 'Show options'
      AutoCheck = True
      Caption = 'Full screen'
      ShortCut = 122
      OnExecute = actFullScreenExecute
    end
  end
end
