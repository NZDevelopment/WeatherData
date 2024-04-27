object frmWeatherData: TfrmWeatherData
  Left = 0
  Top = 0
  Caption = 'Weather Data'
  ClientHeight = 231
  ClientWidth = 505
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object btnGetWeatherData: TButton
    Left = 384
    Top = 198
    Width = 99
    Height = 25
    Caption = 'Get Data'
    TabOrder = 0
    OnClick = btnGetWeatherDataClick
  end
  object memRestData: TMemo
    Left = 8
    Top = 24
    Width = 489
    Height = 168
    ScrollBars = ssBoth
    TabOrder = 1
  end
end