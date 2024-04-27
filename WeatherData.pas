unit u_WeatherData;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IPPeerClient, Data.Bind.Components,
  Data.Bind.ObjectScope, REST.Client, Vcl.StdCtrls, System.JSON;

type
  TfrmWeatherData = class(TForm)
    btnGetWeatherData: TButton;
    memRestData: TMemo;
    procedure btnGetWeatherDataClick(Sender: TObject);
  private
    { Private declarations }
    procedure CallWeatherAPI;
    procedure DisplayIndiviualDataFromJson(JASONData: string );
  public
    { Public declarations }
  end;

var
  frmWeatherData: TfrmWeatherData;

implementation

{$R *.dfm}

procedure TfrmWeatherData.btnGetWeatherDataClick(Sender: TObject);
begin
  CallWeatherAPI;
end;

procedure TfrmWeatherData.CallWeatherAPI;
var
  RestClient : TRestClient;
  RestRequest : TRestRequest;
  RestResponse : TRestResponse;
  weatherData: string;

begin
  RestClient := TRESTClient.Create(nil);
  RestRequest := TRESTRequest.Create(nil);
  RestResponse := TRESTResponse.Create(nil);

  try
    RestClient.BaseURL := 'https://api.weatherapi.com/v1';
    RestClient.Accept := 'application/jason';

    RestRequest.Client := RestClient;
    RestRequest.Response := RestResponse;
    RestRequest.Resource := '/current.json';
    RestRequest.AddParameter('key', '092f0185652d400bb4d85641242104');
     RestRequest.AddParameter('q','Puma');
     RestRequest.Execute;

     if RestResponse.StatusCode =200 then
     begin
       weatherData := RestResponse.Content;

       memRestData.Lines.Add('Status: '+ RestResponse.StatusText);
     end;

     DisplayIndiviualDataFromJson(weatherData);

  finally
     RestClient.Free;
     RestRequest.Free;
     RestResponse.Free;
  end;
end;

procedure TfrmWeatherData.DisplayIndiviualDataFromJson(JASONData: string);
var
  JSONObject, LocationObject, CurrentObject, ConditionObject: TJSONObject;
begin
  JSONObject := TJSONObject.ParseJSONValue(JASONData) as TJSONObject;

  if JSONObject <> nil  then
  begin
    LocationObject := JSONObject.GetValue('location') as TJSONObject;
    CurrentObject := JSONObject.GetValue('current') as TJSONObject;

    if (LocationObject <> nil) and (CurrentObject <> nil) then
    begin
      memRestData.Lines.Add('Location:');
      memRestData.Lines.Add('  Name: ' + LocationObject.GetValue('name').Value);
      memRestData.Lines.Add('  Region: ' + LocationObject.GetValue('region').Value);
      memRestData.Lines.Add('  Country: ' + LocationObject.GetValue('country').Value);
      memRestData.Lines.Add('  Latitude: ' + LocationObject.GetValue('lat').Value);
      memRestData.Lines.Add('  Longtitude: ' + LocationObject.GetValue('lon').Value);
      memRestData.Lines.Add('  Local Time: ' + LocationObject.GetValue('localtime').Value);
      memRestData.Lines.Add('  Time Zone: ' + LocationObject.GetValue('tz_id').Value);

      memRestData.Lines.Add('');
      memRestData.Lines.Add('Current Weather:');
      memRestData.Lines.Add('  Temperature (C): ' + CurrentObject.GetValue('temp_c').Value);
      memRestData.Lines.Add('  Temperature (F): ' + CurrentObject.GetValue('temp_f').Value);
      memRestData.Lines.Add('  Is Day: ' + CurrentObject.GetValue('is_day').Value);

      ConditionObject := CurrentObject.GetValue('condition') as TJSONObject;
      if(ConditionObject <> nil)  then
      begin
        memRestData.Lines.Add(' Weather Condition: ' + ConditionObject.GetValue('text').Value);
        memRestData.Lines.Add(' Weather Icon : ' + ConditionObject.GetValue('icon').Value);
        memRestData.Lines.Add(' Weather Code : ' + ConditionObject.GetValue('code').Value);
      end;

      memRestData.Lines.Add(' wind Speed (mph): ' + CurrentObject.GetValue('wind_mph').Value);
      memRestData.Lines.Add(' wind Speed (kmph): ' + CurrentObject.GetValue('wind_kph').Value);
      memRestData.Lines.Add(' wind degree: ' + CurrentObject.GetValue('wind_degree').Value);
      memRestData.Lines.Add(' wind direction: ' + CurrentObject.GetValue('wind_dir').Value);
      memRestData.Lines.Add(' pressure (mb): ' + CurrentObject.GetValue('pressure_mb').Value);
      memRestData.Lines.Add(' pressure (in): ' + CurrentObject.GetValue('pressure_in').Value);
      memRestData.Lines.Add(' precipitation (mm): ' + CurrentObject.GetValue('precip_mm').Value);
      memRestData.Lines.Add(' precipitation (in): ' + CurrentObject.GetValue('precip_in').Value);
      memRestData.Lines.Add(' humidity: ' + CurrentObject.GetValue('humidity').Value);
      memRestData.Lines.Add(' cloud: ' + CurrentObject.GetValue('cloud').Value);
      memRestData.Lines.Add(' Feels like (C): ' + CurrentObject.GetValue('feelslike_c').Value);
      memRestData.Lines.Add(' Feels like (F): ' + CurrentObject.GetValue('feelslike_f').Value);
      memRestData.Lines.Add(' Visibility (km): ' + CurrentObject.GetValue('vis_km').Value);
      memRestData.Lines.Add(' Visibility (ml): ' + CurrentObject.GetValue('vis_miles').Value);
      memRestData.Lines.Add(' UV (ml): ' + CurrentObject.GetValue('uv').Value);
      memRestData.Lines.Add(' Gust Speed (mph): ' + CurrentObject.GetValue('gust_mph').Value);
      memRestData.Lines.Add(' Gust Speed (kmh): ' + CurrentObject.GetValue('gust_kph').Value);



    end;

  end;


end;

end.
