part of 'weather_bloc.dart';

final class WeatherFailure extends WeatherState {
  final String error;

  WeatherFailure(this.error);
}

final class WeatherInitial extends WeatherState {}

final class WeatherLoading extends WeatherState {}

@immutable
sealed class WeatherState {}

final class WeatherSuccess extends WeatherState {
  final WeatherModel weatherModel;

  WeatherSuccess({required this.weatherModel});
}
