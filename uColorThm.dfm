object Form2: TForm2
  Left = 194
  Top = 196
  BorderStyle = bsDialog
  Caption = 'Change color theme'
  ClientHeight = 101
  ClientWidth = 283
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnShow = FormShow
  DesignSize = (
    283
    101)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 16
    Width = 69
    Height = 13
    Caption = 'Clock color:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Button1: TButton
    Left = 194
    Top = 62
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Ok'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Panel1: TPanel
    Left = 40
    Top = 32
    Width = 233
    Height = 17
    BevelOuter = bvLowered
    TabOrder = 1
    object Image1: TImage
      Left = 1
      Top = 1
      Width = 231
      Height = 15
      Align = alClient
      OnMouseDown = Image1MouseDown
    end
  end
  object Panel2: TPanel
    Left = 8
    Top = 32
    Width = 17
    Height = 17
    BevelOuter = bvLowered
    TabOrder = 2
  end
end
