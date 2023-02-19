import 'package:location/location.dart';
import 'package:http/http.dart' as http;

class LocationHelper {
  late double latitude;
  late double longitude;

  Future<void> getCurrentLocation() async {
    Location location  = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

      //Location için servis ayaktamı
    _serviceEnabled =await location.serviceEnabled();
     if(!_serviceEnabled)
       {
         _serviceEnabled =await location.requestService();
         if(!_serviceEnabled)
           {
             return;
           }
       }

     // Kullanıcı Konum izini Vermişmi
    _permissionGranted = await location.hasPermission();
     if(_permissionGranted == PermissionStatus.denied)
       {
          _permissionGranted = await location.requestPermission();
          if(_permissionGranted != PermissionStatus.granted)
            {
              return;
            }
       }

     // İzinler Tamamsa ise

     _locationData = await location.getLocation();
     latitude = _locationData.latitude!;
     longitude = _locationData.longitude!;


  }

}