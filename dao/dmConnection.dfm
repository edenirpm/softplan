object DataModule1: TDataModule1
  OnCreate = DataModuleCreate
  Height = 1920
  Width = 2560
  PixelsPerInch = 192
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=:memory:'
      'DriverID=SQLite')
    Connected = True
    LoginPrompt = False
    Left = 192
    Top = 80
  end
  object FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink
    Left = 440
    Top = 80
  end
  object FDQuery1: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'CREATE TABLE IF NOT EXISTS ENDERECOS( '
      'codigo INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,       '
      'cep varchar(9),                   '
      'logradouro varchar(40),                 '
      'complemento varchar(30),                '
      'bairro varchar(30),                     '
      'localidade varchar(40),                 '
      'uf varchar(2))')
    Left = 192
    Top = 224
  end
  object FDQuery2: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      ' Select * from Enderecos')
    Left = 192
    Top = 376
    object FDQuery2codigo: TIntegerField
      FieldName = 'codigo'
    end
    object FDQuery2cep: TStringField
      FieldName = 'cep'
      Size = 9
    end
    object FDQuery2logradouro: TStringField
      FieldName = 'logradouro'
      Size = 40
    end
    object FDQuery2complemento: TStringField
      FieldName = 'complemento'
      Size = 30
    end
    object FDQuery2bairro: TStringField
      FieldName = 'bairro'
      Size = 30
    end
    object FDQuery2localidade: TStringField
      FieldName = 'localidade'
      Size = 40
    end
    object FDQuery2uf: TStringField
      FieldName = 'uf'
      Size = 2
    end
  end
end
