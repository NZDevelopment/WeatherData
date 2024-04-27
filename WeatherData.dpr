program WeatherData;

uses
  Vcl.Forms,
  u_WeatherData in '..\u_WeatherData.pas' {frmWeatherData};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmWeatherData, frmWeatherData);
  Application.Run;
end.
