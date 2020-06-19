import 'dart:convert';

Weather weatherFromJson(String str) => Weather.fromMap(json.decode(str));

String weatherToJson(Weather data) => json.encode(data.toMap());

class Weather {
    double lat;
    double lon;
    Temp temp;
    Humidity humidity;
    ObservationTime observationTime;

    Weather({
        this.lat,
        this.lon,
        this.temp,
        this.humidity,
        this.observationTime,
    });

    Weather copyWith({
        double lat,
        double lon,
        Humidity temp,
        Humidity humidity,
        ObservationTime observationTime,
    }) => 
        Weather(
            lat: lat ?? this.lat,
            lon: lon ?? this.lon,
            temp: temp ?? this.temp,
            humidity: humidity ?? this.humidity,
            observationTime: observationTime ?? this.observationTime,
        );

    factory Weather.fromMap(Map<String, dynamic> json) => Weather(
        lat: json["lat"] == null ? null : json["lat"].toDouble(),
        lon: json["lon"] == null ? null : json["lon"].toDouble(),
        temp: json["temp"] == null ? null : Temp.fromMap(json["temp"]),
        humidity: json["humidity"] == null ? null : Humidity.fromMap(json["humidity"]),
        observationTime: json["observation_time"] == null ? null : ObservationTime.fromMap(json["observation_time"]),
    );

    Map<String, dynamic> toMap() => {
        "lat": lat == null ? null : lat,
        "lon": lon == null ? null : lon,
        "temp": temp == null ? null : temp.toMap(),
        "humidity": humidity == null ? null : humidity.toMap(),
        "observation_time": observationTime == null ? null : observationTime.toMap(),
    };
}

class Humidity {
    num value;
    String units;

    Humidity({
        this.value,
        this.units,
    });

    Humidity copyWith({
        num value,
        String units,
    }) => 
        Humidity(
            value: value ?? this.value,
            units: units ?? this.units,
        );

    factory Humidity.fromMap(Map<String, dynamic> json) => Humidity(
        value: json["value"] == null ? null : json["value"],
        units: json["units"] == null ? null : json["units"],
    );

    Map<String, dynamic> toMap() => {
        "value": value == null ? null : value,
        "units": units == null ? null : units,
    };
}
class Temp {
    num value;
    String units;

    Temp({
        this.value,
        this.units,
    });

    Temp copyWith({
        num value,
        String units,
    }) => 
        Temp(
            value: value ?? this.value,
            units: units ?? this.units,
        );

    factory Temp.fromMap(Map<String, dynamic> json) => Temp(
        value: json["value"] == null ? null : json["value"],
        units: json["units"] == null ? null : json["units"],
    );

    Map<String, dynamic> toMap() => {
        "value": value == null ? null : value,
        "units": units == null ? null : units,
    };
}

class ObservationTime {
    DateTime value;

    ObservationTime({
        this.value,
    });

    ObservationTime copyWith({
        DateTime value,
    }) => 
        ObservationTime(
            value: value ?? this.value,
        );

    factory ObservationTime.fromMap(Map<String, dynamic> json) => ObservationTime(
        value: json["value"] == null ? null : DateTime.parse(json["value"]),
    );

    Map<String, dynamic> toMap() => {
        "value": value == null ? null : value.toIso8601String(),
    };
}
