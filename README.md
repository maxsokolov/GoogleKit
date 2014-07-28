Under development

#### Usage

1. Install
2. `#import "GoogleKit.h"` in your controller or .pch file.

#### Google geocoder example

``` objc
GKGeocoderQuery *query = [GKGeocoderQuery query];
query.key = @"your_google_api_key";
query.language = @"lang";
query.location = CLLocationCoordinate2DMake(0.0f, 0.0f);
    
[query lookupLocation:^(NSArray *results, NSError *error) {
        
    for (GKGeocoderQueryResult *result in results) {
    
    }
}];
```