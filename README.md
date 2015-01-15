# GoogleKit

GoogleKit is an Objective-C wrapper for <a href="https://developers.google.com/maps/" target="_blank">Google Maps API</a>. Are you gonna make an Uber for X? So, GoogleKit is for you!

## Requirements

Supports iOS 7 and higher. ARC is required.

## Installation

GoogleKit is available via CocoaPods. Simply add the following line to your Podfile:

	pod "GoogleKit", "~> 0.3"

## Usage

Simply import `GoogleKit.h` into your controller or .pch file.

## API key

1. Follow <a href="https://code.google.com/apis/console" target="_blank">this link</a>.
2. Check the left menu for `APIs & auth -> Credentials`.
3. Look at the `Public API access` section and click the `Create a new key` button, then select `iOS key`.

Make sure that Geocoding API and Places API are enabled in the `APIs & auth -> APIs` section. If you face some issues with `iOS key` use `Browser key` instead.

## Settings

Provide an API key globally for each request:
``` objc
[GKQuery provideAPIKey:GOOGLE_API_KEY];
```
or use different keys for diffrent requests:
``` objc
GKQuery *query = [GKQuery query];
query.key = @"key";
```
Enable logging to check for raw requests and responses.
``` objc
[GKQuery loggingEnabled:YES];
```

## Geocoding (Latitude/Longitude Lookup)

Geocoding lets you convert addresses like "1600 Amphitheatre Parkway, Mountain View, CA" into geographic coordinates like latitude 37.423021 and longitude -122.083739, which you can use to place markers or position the map.
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

    GKGeocoderPlace *place = [results firstObject];
    //place.formattedAddress;
}];
```
## Reverse Geocoding (Address Lookup)

Reverse Geocoding lets you convert a location on the map into a human-readable address. <a href="https://developers.google.com/maps/documentation/geocoding/#ReverseGeocoding" target="_blank">See the official google documentation</a>.

``` objc
GKGeocoderQuery *query = [GKGeocoderQuery query];

// required parameters
query.key = @"key";
query.coordinate = CLLocationCoordinate2DMake(0.0f, 0.0f);

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
## Place Autocomplete

The Place Autocomplete provides a location-based autocomplete feature.
<a href="https://developers.google.com/places/documentation/autocomplete" target="_blank">See the official google documentation</a>.

``` objc
GKPlaceAutocompleteQuery *query = [GKPlaceAutocompleteQuery query];

// required parameters
query.key = @"key";
query.input = @"wall street";

// optional parameters
query.coordinate = CLLocationCoordinate2DMake(55.738407f, 37.612306f); // New York City
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
`GKPlaceAutocompleteQuery` has built-in cache, so you don't need to worry about queries with same inputs.
## Nearby Search

A Nearby Search lets you search for places within a specified area. You can refine your search request by supplying keywords or specifying the type of place you are searching for.
<a href="https://developers.google.com/places/documentation/search#PlaceSearchRequests" target="_blank">See the official google documentation</a>.

``` objc
GKPlacesNearbySearchQuery *query = [GKPlacesNearbySearchQuery query];

// required parameters
query.key = @"key";
query.coordinate = CLLocationCoordinate2DMake(40.71448f, -74.00598f); // New York City
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
[query searchPlaces:^(NSArray *results, NSString *nextPageToken, NSError *error) {
        
	GKPlace *place = [results firstObject];
}];
```
## Text Search

A Text Search returns information about a set of places based on a string — for example "pizza in New York" or "shoe stores near Ottawa". The service responds with a list of places matching the text string and any location bias that has been set. The search response will include a list of places, you can send a Place Details request for more information about any of the places in the response.
<a href="https://developers.google.com/places/documentation/search#TextSearchRequests" target="_blank">See the official google documentation</a>.

``` objc
GKPlacesTextSearchQuery *query = [GKPlacesTextSearchQuery query];

// required parameters
query.key = @"key";
query.text = @"pizza in New York";

// optional parameters
query.language = @"en";
query.coordinate = CLLocationCoordinate2DMake(40.71448f, -74.00598f);
query.radius = 3000;
query.minprice = 0;
query.maxprice = 4;
query.opennow = YES;
query.types = @[ @"cafe" ];

// perform query
[query searchPlaces:^(NSArray *results, NSError *error) {
       
	GKPlace *place = [results firstObject]; 
}];
```
## Radar Search

A Radar Search allows you to search for up to 200 places at once, but with less detail than is typically returned from a Text Search or Nearby Search request.
<a href="https://developers.google.com/places/documentation/search#RadarSearchRequests" target="_blank">See the official google documentation</a>.

``` objc
GKPlacesRadarSearchQuery *query = [GKPlacesRadarSearchQuery query];
    
// required parameters
query.key = @"key";
query.coordinate = CLLocationCoordinate2DMake(40.71448f, -74.00598f); // New York City
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
[query searchPlaces:^(NSArray *results, NSError *error) {

	GKPlace *place = [results firstObject];
	// place.place_id
}];
```
## Place Details

Once you have a place_id from a Place Search, you can request more details about a particular establishment or point of interest by initiating a Place Details request. A Place Details request returns more comprehensive information about the indicated place such as its complete address, phone number, etc.
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

## Support

Feel free to open an issue if you faced a problem.

## License

GoogleKit is available under the MIT license. See the LICENSE file for more information.