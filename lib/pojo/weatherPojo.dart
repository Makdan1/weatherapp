class weather {

  double  minTemp;
  double  maxTemp;
  double windSpeed;
  int day;
  int cloudPercentage;
  int humidity;


  weather({
    this.minTemp,
    this.maxTemp,
    this.windSpeed,
    this.day,
    this.cloudPercentage,
    this.humidity,

  });

  weather.fromJson(Map<String, dynamic> doc):
        minTemp =  doc['temp']['min'],
        maxTemp =  doc['temp']['max'],
        windSpeed =  doc['wind_speed'],
        day =  doc['dt'],
        cloudPercentage = doc['clouds'],
        humidity = doc['humidity'];


}
