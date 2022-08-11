import 'package:bloc/bloc.dart';
import 'package:fingerprint/features/finger/finger_cubit/finger_state.dart';
import 'package:fingerprint/features/finger/repositories/finger_repositories.dart';

class FingerCubit extends Cubit<FingerState> {
  FingerCubit({required this.fingerRepositorie}) : super(FingerInitial());
  final FingerRepositorie fingerRepositorie;
  double? locationLon;
  double? locationlat;
  Future getLocation() async {
    emit(GetLocaionLoading());
    try {
      final location = await fingerRepositorie.getLocation();
      locationLon = location.longitude;
      locationlat = location.latitude;
      emit(GetLocaionLoaded());
    } catch (e) {
      emit(GetLocaionError(e.toString()));
    }
  }

  Future fingerSingIn({required double lat, required double long}) async {
    emit(SingFingerLoading());
    try {
      var data = await fingerRepositorie.fingerSingin(lat: lat, long: long);
      emit(SingFingerLoaded(data: data));
    } catch (e) {
      emit(SingFingerError(e.toString()));
    }
  }

  Future fingerSingOut({required double lat, required double long}) async {
    emit(SingFingerLoading());
    try {
      var data = await fingerRepositorie.fingerSingout(lat: lat, log: long);
      emit(SingOutFingerLoaded(data: data));
    } catch (e) {
      emit(SingFingerError(e.toString()));
    }
  }
}
