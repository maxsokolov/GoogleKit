# GoogleKit

GoogleKit based on <a href="https://developers.google.com/maps/" target="_blank">Google Maps API</a>.

#### Usage

1. Install
2. `#import "GoogleKit.h"` in your controller or .pch file.

#### Geocoding (Latitude/Longitude Lookup)

Geocoding is the process of converting addresses (like "1600 Amphitheatre Parkway, Mountain View, CA") into geographic coordinates (like latitude 37.423021 and longitude -122.083739), which you can use to place markers or position the map.
<a href="https://developers.google.com/maps/documentation/geocoding/" target="_blank">See the official google documentation</a>.

``` objc
GKGeocoderQuery *query = [GKGeocoderQuery query];

// required parameters
query.key = @"key"; // or client and signature parameters if you are using Maps for Work
query.address = @"some address";

// optional parameters
query.language = @"en";
query.region = @"us";
query.components = @[ @"country:US" ];

// perform query
[query lookupLocation:^(NSArray *results, NSError *error) {

    GKGeocoderPlace *place = [result firstObject];
    //place.formattedAddress;
}];
```
#### Reverse Geocoding (Address Lookup)

The term geocoding generally refers to translating a human-readable address into a location on a map.
<a href="https://developers.google.com/maps/documentation/geocoding/#ReverseGeocoding" target="_blank">See the official google documentation</a>.

``` objc
GKGeocoderQuery *query = [GKGeocoderQuery query];

// required parameters
query.key = @"key";
query.location = CLLocationCoordinate2DMake(0.0f, 0.0f);

// optional parameters
query.language = @"en";
query.resultType = @[ @"street_address" ];
query.locationType = @[ @"ROOFTOP" ];
query.postalCode = @"000000";

// perform query
[query lookupAddress:^(NSArray *results, NSError *error) {

    GKGeocoderPlace *place = [results firstObject];
}];
```
#### Place Autocomplete

The Place Autocomplete service is useful in mobile apps, where you may want to offer users a location-based autocomplete feature.
<a href="https://developers.google.com/maps/documentation/geocoding/#ReverseGeocoding" target="_blank">See the official google documentation</a>.

``` objc
GKPlaceAutocompleteQuery *query = [GKPlaceAutocompleteQuery query];

// required parameters
query.key = @"key";
query.input = @"wall street";

// optional parameters
query.location = CLLocationCoordinate2DMake(55.738407f, 37.612306f); // New York City
query.types = @[ @"geocode" ];
query.components = @[ @"country:us" ];
query.radius = 10000;
query.offset = 3;
query.language = @"en";

// perform query
[query fetchPlaces:^(NSArray *results, NSError *error) {

	GKPlaceAutocomplete *place = [results firstObject];
}];
```
#### Nearby Search

A Nearby Search lets you search for places within a specified area. You can refine your search request by supplying keywords or specifying the type of place you are searching for.
<a href="https://developers.google.com/places/documentation/search#PlaceSearchRequests" target="_blank">See the official google documentation</a>.

``` objc
GKPlacesQuery *query = [GKPlacesQuery query];

// required parameters
query.key = @"key";
query.location = CLLocationCoordinate2DMake(40.71448f, -74.00598f); // New York City
query.rankByDistance = NO; // if rankByDistance sets to YES radius will be ignored
query.radius = 3000;

// optional parameters
query.language = @"en";
query.keyword = @"keyword";
query.minprice = 0;
query.maxprice = 4;
query.name = @"name";
query.opennow = YES;
query.types = @[ @"library" ];
query.nextPageToken = @"token";

// perform query
[query nearbySearch:^(NSArray *results, NSString *nextPageToken, NSError *error) {
        
	GKPlace *place = [results firstObject];
}];
```
#### Text Search

A Nearby Search lets you search for places within a specified area. You can refine your search request by supplying keywords or specifying the type of place you are searching for.
<a href="https://developers.google.com/places/documentation/search#TextSearchRequests" target="_blank">See the official google documentation</a>.

``` objc
GKPlacesQuery *query = [GKPlacesQuery query];

// required parameters
query.key = @"key";
query.text = @"the query string on which to search";

// optional parameters
query.language = @"en";
query.location = CLLocationCoordinate2DMake(40.71448f, -74.00598f);
query.radius = 3000;
query.minprice = 0;
query.maxprice = 4;
query.opennow = YES;
query.types = @[ @"library" ];

// perform query
[query textSearch:^(NSArray *results, NSString *nextPageToken, NSError *error) {
       
        
}];
```
#### Radar Search

The Google Places API Radar Search Service allows you to search for up to 200 places at once, but with less detail than is typically returned from a Text Search or Nearby Search request. With Radar Search, you can create applications that help users identify specific areas of interest within a geographic area.
<a href="https://developers.google.com/places/documentation/search#RadarSearchRequests" target="_blank">See the official google documentation</a>.

``` objc
GKPlacesQuery *query = [GKPlacesQuery query];
    
// required parameters
query.key = @"key";
query.location = CLLocationCoordinate2DMake(40.71448f, -74.00598f); // New York City
query.radius = 3000;

// optional parameters
query.language = @"en";
query.keyword = @"";
query.minprice = 0;
query.maxprice = 4;
query.name = @"";
query.opennow = YES;
query.types = @[ @"library" ];
    
// perform query
[query radarSearch:^(NSArray *results, NSString *nextPageToken, NSError *error) {

	GKPlace *place = [results firstObject];
}];
```
#### Place Details

The Google Places API Radar Search Service allows you to search for up to 200 places at once, but with less detail than is typically returned from a Text Search or Nearby Search request. With Radar Search, you can create applications that help users identify specific areas of interest within a geographic area. 
<a href="https://developers.google.com/places/documentation/details" target="_blank">See the official google documentation</a>.

``` objc
GKPlaceDetailsQuery *query = [GKPlaceDetailsQuery query];

// required parameters
query.placeId = @"id";

// optional parameters
query.language = @"en";
query.extensions = @"review_summary";

// perform query
[query fetchDetails:^(GKPlaceDetails *place, NSError *error) {

}];
```

## License

GoogleKit is available under the MIT license. See the LICENSE file for more information.