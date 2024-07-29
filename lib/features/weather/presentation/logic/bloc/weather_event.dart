part of 'weather_bloc.dart';

@immutable
sealed class WeatherEvent {}

class GetWeatherEvent extends WeatherEvent {
  final String location;

  GetWeatherEvent({required this.location});
}
