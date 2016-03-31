//
//    Copyright (c) 2014 Max Sokolov (http://maxsokolov.net)
//
//    Permission is hereby granted, free of charge, to any person obtaining a copy of
//    this software and associated documentation files (the "Software"), to deal in
//    the Software without restriction, including without limitation the rights to
//    use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
//    the Software, and to permit persons to whom the Software is furnished to do so,
//    subject to the following conditions:
//
//    The above copyright notice and this permission notice shall be included in all
//    copies or substantial portions of the Software.
//
//    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
//    FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
//    COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
//    IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//    CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#import "GKGeocoderPlace.h"

@implementation GKGeocoderPlace

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {

    self = [super init];
    if (self) {
        
        NSArray *addressComponents = [dictionary objectForKey:@"address_components"];
        for (NSDictionary *addressComponent in addressComponents) {
            
            NSString *type = [[addressComponent objectForKey:@"types"] firstObject];
            NSString *name = [addressComponent objectForKey:@"long_name"];
            if ([type isEqualToString:@"street_address"]) {
                
                _streetAddress = name;
            }
            else if ([type isEqualToString:@"route"]) {
                
                _route = name;
            }
            else if ([type isEqualToString:@"intersection"]) {
                
                _intersection = name;
            }
            else if ([type isEqualToString:@"political"]) {
                
                _political = name;
            }
            else if ([type isEqualToString:@"country"]) {
                
                _country = name;
            }
            else if ([type isEqualToString:@"administrative_area_level_1"]) {
                
                _administrativeAreaLevel1 = name;
            }
            else if ([type isEqualToString:@"administrative_area_level_2"]) {
                
                _administrativeAreaLevel2 = name;
            }
            else if ([type isEqualToString:@"administrative_area_level_3"]) {
                
                _administrativeAreaLevel3 = name;
            }
            else if ([type isEqualToString:@"colloquial_area"]) {
                
                _colloquialArea = name;
            }
            else if ([type isEqualToString:@"locality"]) {
                
                _locality = name;
            }
            else if ([type isEqualToString:@"sublocality"]) {
                
                _sublocality = name;
            }
            else if ([type isEqualToString:@"neighborhood"]) {
                
                _neighborhood = name;
            }
            else if ([type isEqualToString:@"premise"]) {
                
                _premise = name;
            }
            else if ([type isEqualToString:@"subpremise"]) {
                
                _subpremise = name;
            }
            else if ([type isEqualToString:@"postal_code"]) {
                
                _postalCode = name;
            }
            else if ([type isEqualToString:@"natural_feature"]) {
                
                _naturalFeature = name;
            }
            else if ([type isEqualToString:@"airport"]) {
                
                _airport = name;
            }
            else if ([type isEqualToString:@"park"]) {
                
                _park = name;
            }
            else if ([type isEqualToString:@"point_of_interest"]) {
                
                _pointOfInterest = name;
            }
            else if ([type isEqualToString:@"post_box"]) {
                
                _postBox = name;
            }
            else if ([type isEqualToString:@"street_number"]) {
                
                _streetNumber = name;
            }
            else if ([type isEqualToString:@"floor"]) {
                
                _floor = name;
            }
            else if ([type isEqualToString:@"room"]) {
                
                _room = name;
            }
        }
        
        _placeId = [dictionary objectForKey:@"place_id"];
        _formattedAddress = [dictionary objectForKey:@"formatted_address"];
        _name = [dictionary objectForKey:@"name"];
        
        CGFloat lat = [[[[dictionary objectForKey:@"geometry"] objectForKey:@"location"] objectForKey:@"lat"] floatValue];
        CGFloat lng = [[[[dictionary objectForKey:@"geometry"] objectForKey:@"location"] objectForKey:@"lng"] floatValue];
        
        _coordinate = CLLocationCoordinate2DMake(lat, lng);
    }
    return self;
}

@end