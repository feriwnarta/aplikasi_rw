import 'package:flutter_bloc/flutter_bloc.dart';

class GoogleMapEvent {
  String address;
  double latitude, longitude;

  GoogleMapEvent({this.latitude, this.longitude, this.address});
}

class GoogleMapState {
  String address;
  double longitude, latitude;
  GoogleMapState({this.latitude, this.longitude, this.address});
}

class GoogleMapBloc extends Bloc<GoogleMapEvent, GoogleMapState> {
  GoogleMapBloc(GoogleMapState initialState) : super(initialState);

  @override
  Stream<GoogleMapState> mapEventToState(GoogleMapEvent event) async* {
    yield GoogleMapState(
        address: event.address,
        latitude: event.latitude,
        longitude: event.longitude);
  }
}
