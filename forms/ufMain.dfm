object fMain: TfMain
  Left = 529
  Height = 157
  Top = 388
  Width = 301
  AlphaBlend = True
  AlphaBlendValue = 230
  BorderIcons = []
  BorderStyle = bsNone
  Caption = 'NightscoutWatcher'
  ClientHeight = 157
  ClientWidth = 301
  Color = clBlack
  Constraints.MinHeight = 50
  Constraints.MinWidth = 80
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  FormStyle = fsSystemStayOnTop
  KeyPreview = True
  OnCreate = FormCreate
  OnDblClick = actVisitNightscoutSiteExecute
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnMouseDown = FormMouseDown
  OnMouseMove = FormMouseMove
  OnMouseUp = FormMouseUp
  OnMouseWheel = FormMouseWheel
  OnShow = FormShow
  Position = poDefault
  LCLVersion = '2.0.6.0'
  object pb: TProgressBar
    Left = 0
    Height = 5
    Top = 152
    Width = 301
    Align = alBottom
    Position = 10
    Smooth = True
    TabOrder = 0
  end
  object pm: TPopupMenu
    left = 240
    top = 8
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
    left = 8
    top = 8
  end
  object tmrProgressBar: TTimer
    Enabled = False
    OnTimer = tmrProgressBarTimer
    left = 40
    top = 8
  end
  object al: TActionList
    left = 208
    top = 8
    object actDrawLastSugarLevel: TAction
      Category = 'Draw options'
      AutoCheck = True
      Caption = 'Draw last sugar level'
      Checked = True
      OnExecute = DoDrawStageExecute
      ShortCut = 49
    end
    object actDrawSugarLines: TAction
      Tag = 1
      Category = 'Draw options'
      AutoCheck = True
      Caption = 'Draw sugar lines'
      Checked = True
      OnExecute = DoDrawStageExecute
      ShortCut = 50
    end
    object actDrawSugarExtremePoints: TAction
      Tag = 7
      Category = 'Draw options'
      AutoCheck = True
      Caption = 'Draw sugar extreme points'
      Checked = True
      OnExecute = DoDrawStageExecute
      ShortCut = 56
    end
    object actDrawSugarLevel: TAction
      Tag = 2
      Category = 'Draw options'
      AutoCheck = True
      Caption = 'Draw sugar level'
      Checked = True
      OnExecute = DoDrawStageExecute
      ShortCut = 51
    end
    object actDrawHorzGuideLines: TAction
      Tag = 3
      Category = 'Draw options'
      AutoCheck = True
      Caption = 'Draw horizontal guide lines'
      Checked = True
      OnExecute = DoDrawStageExecute
      ShortCut = 53
      Visible = False
    end
    object actDrawVertGuideLines: TAction
      Tag = 4
      Category = 'Draw options'
      AutoCheck = True
      Caption = 'Draw vertical guide lines'
      Checked = True
      OnExecute = DoDrawStageExecute
      ShortCut = 52
    end
    object actDrawSugarSlope: TAction
      Tag = 6
      Category = 'Draw options'
      AutoCheck = True
      Caption = 'Draw sugar slope'
      Checked = True
      OnExecute = DoDrawStageExecute
      ShortCut = 55
    end
    object actDrawLastSugarLevelDate: TAction
      Tag = 5
      Category = 'Draw options'
      AutoCheck = True
      Caption = 'Draw last sugar level date'
      Checked = True
      OnExecute = DoDrawStageExecute
      ShortCut = 54
    end
    object actDrawAlertLines: TAction
      Tag = 8
      Category = 'Draw options'
      AutoCheck = True
      Caption = 'Draw alert lines'
      Checked = True
      OnExecute = DoDrawStageExecute
      ShortCut = 57
    end
    object actDrawSugarLevelPoints: TAction
      Tag = 9
      Category = 'Draw options'
      AutoCheck = True
      Caption = 'Draw sugar level points'
      Checked = True
      OnExecute = DoDrawStageExecute
      ShortCut = 73
    end
    object actVisitNightscoutSite: TAction
      Category = 'Other'
      Caption = 'Visit Nightscout Site'
      OnExecute = actVisitNightscoutSiteExecute
      ShortCut = 86
    end
    object actShowCheckNewDataProgressBar: TAction
      Category = 'Show options'
      AutoCheck = True
      Caption = 'Show new data checking progress bar'
      Checked = True
      OnExecute = actShowCheckNewDataProgressBarExecute
      ShortCut = 80
    end
    object actHelp: TAction
      Category = 'Other'
      Caption = 'Help'
      OnExecute = actHelpExecute
      ShortCut = 112
    end
    object actSetNightscoutSite: TAction
      Category = 'Options'
      Caption = 'Set Nightscout site URL'
      OnExecute = actSetNightscoutSiteExecute
      ShortCut = 83
    end
    object actExit: TAction
      Category = 'Other'
      Caption = 'Exit'
      OnExecute = actExitExecute
      ShortCut = 88
    end
    object actSetCheckInterval: TAction
      Category = 'Options'
      Caption = 'Set time interval to check new data (secs)'
      OnExecute = actSetCheckIntervalExecute
      ShortCut = 73
    end
    object actShowWindowBorder: TAction
      Category = 'Show options'
      AutoCheck = True
      Caption = 'Show window border'
      OnExecute = actShowWindowBorderExecute
      ShortCut = 66
    end
    object actSetUnitOfMeasureMmolL: TAction
      Category = 'Options'
      AutoCheck = True
      Caption = 'Set to mmol/l'
      OnExecute = actSetUnitOfMeasureMmolLExecute
      ShortCut = 77
    end
    object actSetCountOfEntriesToRecive: TAction
      Category = 'Options'
      Caption = 'Set count of entries to recive'
      OnExecute = actSetCountOfEntriesToReciveExecute
      ShortCut = 67
    end
    object actShowSettings: TAction
      Category = 'Other'
      Caption = 'Show settings'
      OnExecute = actShowSettingsExecute
      ShortCut = 120
    end
    object actFullScreen: TAction
      Category = 'Show options'
      AutoCheck = True
      Caption = 'Full screen'
      OnExecute = actFullScreenExecute
      ShortCut = 122
    end
  end
end
