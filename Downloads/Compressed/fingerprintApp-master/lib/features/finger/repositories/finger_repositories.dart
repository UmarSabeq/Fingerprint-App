import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fingerprint/data/remote/dio_helper.dart';
import 'package:geolocator/geolocator.dart';

import '../../../core/constant/apis.dart';
import '../../../core/location/location.dart';

class FingerRepositorie {
  final DioHelper dioHelper;
  FingerRepositorie({required this.dioHelper});

  // get location
  Future<Position> getLocation() async {
    try {
      final Position position = await Location.getPosition();
      return position;
    } catch (e) {
      throw "location Error : :  $e";
    }
  }

//finger Singin
  Future<Map<String, dynamic>> fingerSingin(
      {required double lat, required double long}) async {
    try {
      final Response response = await dioHelper.postData(
        needAuth: true,
        url: FingerPrint.fingerin,
        data: {
          "lat": lat,
          "long": long,
        },
      );
      log(lat.toString() + "," + long.toString());
      log(response.statusCode.toString());
      var data = jsonDecode(response.data) as Map<String, dynamic>;
      return data;
    } on DioError catch (dioError) {
      var error = jsonDecode(dioError.response!.data) as Map<String, dynamic>;
      throw error['error'];
    } catch (error) {
      throw '..Oops $error';
    }
  }

//finger Singin
  Future<Map<String, dynamic>> fingerSingout(
      {required double lat, required double log}) async {
    try {
      final Response response = await dioHelper.postData(
        needAuth: true,
        url: FingerPrint.fingerout,
        data: {
          "lat": lat,
          "long": log,
        },
      );

      var data = jsonDecode(response.data) as Map<String, dynamic>;
      return data;
    } on DioError catch (dioError) {
      var error = jsonDecode(dioError.response!.data) as Map<String, dynamic>;
      throw error['error'];
    } catch (error) {
      throw '..Oops $error';
    }
  }
}
