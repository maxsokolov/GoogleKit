# GoogleKit

GoogleKit based on [a link](https://developers.google.com/maps/ "Google Maps API") 

#### Usage

1. Install
2. `#import "GoogleKit.h"` in your controller or .pch file.

#### Geocoder

Geocoding is the process of converting addresses (like "1600 Amphitheatre Parkway, Mountain View, CA") into geographic coordinates (like latitude 37.423021 and longitude -122.083739), which you can use to place markers or position the map.
See [a link](https://developers.google.com/maps/documentation/geocoding/ "Docs") 

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

## License

GoogleKit is available under the MIT license. See the LICENSE file for more information.