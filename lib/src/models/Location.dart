import 'package:equatable/equatable.dart';

// import 'package:meta/meta.dart';
class LocationCoordinates {
  /// The geographic coordinate that specifies the north–south position of a point on the Earth's surface.
  final double latitude;

  /// The geographic coordinate that specifies the east-west position of a point on the Earth's surface.
  final double longitude;

  LocationCoordinates(this.latitude, this.longitude);

  /// Creates coordinates from a map containing its properties.
  LocationCoordinates.fromMap(Map map)
      : this.latitude = map["latitude"],
        this.longitude = map["longitude"];

  /// Creates a map from the coordinates properties.
  Map toMap() => {
        "latitude": this.latitude,
        "longitude": this.longitude,
      };

  String toString() => "{$latitude,$longitude}";
}

class Location extends Equatable {
  /// The geographic coordinates.
  final LocationCoordinates coordinates;

  /// The formatted address with all lines.
  final String addressLine;

  /// The localized country name of the address.
  final String countryName;

  /// The country code of the address.
  final String countryCode;

  /// The feature name of the address.
  final String featureName;

  /// The postal code.
  final String postalCode;

  /// The administrative area name of the address
  final String adminArea;

  /// The sub-administrative area name of the address
  final String subAdminArea;

  /// The locality of the address
  final String locality;

  /// The sub-locality of the address
  final String subLocality;

  /// The thoroughfare name of the address
  final String thoroughfare;

  /// The sub-thoroughfare name of the address
  final String subThoroughfare;

  Location({
    this.coordinates,
    this.addressLine,
    this.countryName,
    this.countryCode,
    this.featureName,
    this.postalCode,
    this.adminArea,
    this.subAdminArea,
    this.locality,
    this.subLocality,
    this.thoroughfare,
    this.subThoroughfare,
  }) : super([
          coordinates,
          addressLine,
          countryName,
          countryCode,
          featureName,
          postalCode,
          adminArea,
          subAdminArea,
          locality,
          subLocality,
          thoroughfare,
          subThoroughfare,
        ]);

  Location.fromMap(Map map)
      : this.coordinates = new LocationCoordinates.fromMap(map["coordinates"]),
        this.addressLine = map["addressLine"],
        this.countryName = map["countryName"],
        this.countryCode = map["countryCode"],
        this.featureName = map["featureName"],
        this.postalCode = map["postalCode"],
        this.locality = map["locality"],
        this.subLocality = map["subLocality"],
        this.adminArea = map["adminArea"],
        this.subAdminArea = map["subAdminArea"],
        this.thoroughfare = map["thoroughfare"],
        this.subThoroughfare = map["subThoroughfare"];

  /// Creates a map from the address properties.
  Map toMap() => {
        "coordinates": this.coordinates.toMap(),
        "addressLine": this.addressLine,
        "countryName": this.countryName,
        "countryCode": this.countryCode,
        "featureName": this.featureName,
        "postalCode": this.postalCode,
        "locality": this.locality,
        "subLocality": this.subLocality,
        "adminArea": this.adminArea,
        "subAdminArea": this.subAdminArea,
        "thoroughfare": this.thoroughfare,
        "subThoroughfare": this.subThoroughfare,
      };

  String get city {
    return locality != null ? locality : null;
  }

  String get shortAddress {
    if (thoroughfare == null) {
      return null;
    }
    return "$thoroughfare ${subThoroughfare != null ? subThoroughfare : ''}";
  }

  String get cityWithPostal {
    if (locality == null) {
      return null;
    }
    return "$locality ${postalCode != null ? postalCode : ''}";
  }
}
