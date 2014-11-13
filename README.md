# GoogleKit

GoogleKit based on [Google Maps API](https://developers.google.com/maps/).

#### Usage

1. Install
2. `#import "GoogleKit.h"` in your controller or .pch file.

#### Geocoding

Geocoding is the process of converting addresses (like "1600 Amphitheatre Parkway, Mountain View, CA") into geographic coordinates (like latitude 37.423021 and longitude -122.083739), which you can use to place markers or position the map.
See [docs](https://developers.google.com/maps/documentation/geocoding/).

``` objc
GKGeocoderQuery *query = [GKGeocoderQuery query];
query.key = @"your_google_api_key";
query.language = @"lang";
query.location = CLLocationCoordinate2DMake(0.0f, 0.0f);
    
[query lookupLocation:^(NSArray *result, NSError *error) {
        
    GKGeocoderPlace *place = [result firstObject];
    //place.formattedAddress;
}];
```
#### Reverse Geocoding

The term geocoding generally refers to translating a human-readable address into a location on a map
See [docs](https://developers.google.com/maps/documentation/geocoding/#ReverseGeocoding).

``` objc
GKGeocoderQuery *query = [GKGeocoderQuery query];
query.address = address;
[query lookupAddress:^(NSArray *results, NSError *error) {

    GKGeocoderPlace *place = [results firstObject];
}];
```
#### Place Autocomplete

The Place Autocomplete service is useful in mobile apps, where you may want to offer users a location-based autocomplete feature.
See [docs](https://developers.google.com/maps/documentation/geocoding/#ReverseGeocoding).

``` objc
GKPlaceAutocompleteQuery *query = [GKPlaceAutocompleteQuery query];
query.input = @"wall street";
query.location = CLLocationCoordinate2DMake(55.738407f, 37.612306f); // New York City
query.types = @[ @"geocode" ];
query.radius = 10000;
[query fetchPlaces:^(NSArray *results, NSError *error) {

	GKPlaceAutocomplete *place = [results firstObject];
}];
```
#### Nearby Search

A Nearby Search lets you search for places within a specified area. You can refine your search request by supplying keywords or specifying the type of place you are searching for.
See [docs](https://developers.google.com/places/documentation/search#PlaceSearchRequests).

``` objc
GKPlacesQuery *placesQuery = [GKPlacesQuery query];
placesQuery.language = @"en";
placesQuery.radius = 3000;
placesQuery.types = @[ @"library" ];
placesQuery.rankByDistance = NO;
placesQuery.location = CLLocationCoordinate2DMake(40.71448f, -74.00598f); // New York City
placesQuery.nextPageToken = self.nextPageToken;
    
[placesQuery nearbySearch:^(NSArray *results, NSString *nextPageToken, NSError *error) {
        
	
}];
```
#### Text Search

A Nearby Search lets you search for places within a specified area. You can refine your search request by supplying keywords or specifying the type of place you are searching for.
See [docs](https://developers.google.com/places/documentation/search#TextSearchRequests).

``` objc
GKPlacesQuery *placesQuery = [GKPlacesQuery query];

[placesQuery textSearch:^(NSArray *results, NSString *nextPageToken, NSError *error) {
       
        
}];
```
#### Radar Search

The Google Places API Radar Search Service allows you to search for up to 200 places at once, but with less detail than is typically returned from a Text Search or Nearby Search request. With Radar Search, you can create applications that help users identify specific areas of interest within a geographic area.
See [docs](https://developers.google.com/places/documentation/search#RadarSearchRequests).

``` objc
GKPlacesQuery *query = [GKPlacesQuery query];
    
// Required parameters
query.key = @"key";
query.location = CLLocationCoordinate2DMake(40.71448f, -74.00598f); // New York City
query.radius = 3000;
    
// Optional parameters
query.keyword = @"";
query.minprice = 0;
query.maxprice = 4;
query.name = @"";
query.opennow = YES;
query.types = @[ @"library" ];
    
// Perform query
[query radarSearch:^(NSArray *results, NSString *nextPageToken, NSError *error) {
       
	GKPlace *place = [results firstObject];
}];
```
#### Place Details

The Google Places API Radar Search Service allows you to search for up to 200 places at once, but with less detail than is typically returned from a Text Search or Nearby Search request. With Radar Search, you can create applications that help users identify specific areas of interest within a geographic area.
See [docs](https://developers.google.com/places/documentation/details).

``` objc
GKPlaceDetailsQuery *query = [GKPlaceDetailsQuery query];
query.placeId = @"id";
[query fetchDetails:^(GKPlaceDetails *place, NSError *error) {

}];
```

## License

GoogleKit is available under the MIT license. See the LICENSE file for more information.