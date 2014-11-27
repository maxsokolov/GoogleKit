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

#import "GKPlaceDetails.h"

@implementation GKPlaceDetails

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
    self = [super init];
    if (self) {

        NSArray *addressComponents = [dictionary objectForKey:@"address_components"];
        for (NSDictionary *addressComponent in addressComponents) {
            
            NSString *type = [[addressComponent objectForKey:@"types"] firstObject];
            NSString *name = [addressComponent objectForKey:@"long_name"];
            if ([type isEqualToString:@"street_number"]) {

                _streetNumber = name;
            }
            else if ([type isEqualToString:@"route"]) {

                _route = name;
            }
            else if ([type isEqualToString:@"locality"]) {

                _locality = name;
            }
            else if ([type isEqualToString:@"administrative_area_level_1"]) {

                _administrativeAreaLevel1 = name;
            }
            else if ([type isEqualToString:@"administrative_area_level_2"]) {

                _administrativeAreaLevel2 = name;
            }
            else if ([type isEqualToString:@"country"]) {

                _country = name;
            }
            else if ([type isEqualToString:@"postal_code"]) {

                _postalCode = name;
            }
        }

        _formattedAddress = [dictionary objectForKey:@"formatted_address"];
        _formattedPhoneNumber = [dictionary objectForKey:@"formatted_phone_number"];
        _internationalPhoneNumber = [dictionary objectForKey:@"international_phone_number"];

        CGFloat lat = [[[[dictionary objectForKey:@"geometry"] objectForKey:@"location"] objectForKey:@"lat"] floatValue];
        CGFloat lng = [[[[dictionary objectForKey:@"geometry"] objectForKey:@"location"] objectForKey:@"lng"] floatValue];
        _coordinate = CLLocationCoordinate2DMake(lat, lng);

        _icon = [dictionary objectForKey:@"icon"];
        _name = [dictionary objectForKey:@"name"];
        _rating = [[dictionary objectForKey:@"rating"] floatValue];
        _vicinity = [dictionary objectForKey:@"vicinity"];
        _url = [NSURL URLWithString:[dictionary objectForKey:@"url"]];
        _website = [NSURL URLWithString:[dictionary objectForKey:@"website"]];
        _placeId = [dictionary objectForKey:@"place_id"];
    }
    return self;
}

#pragma mark - Properties

- (NSString *)phoneNumber {

    NSString *phone = self.internationalPhoneNumber == nil ? self.formattedPhoneNumber : self.internationalPhoneNumber;
    if (!phone)
        return nil;
    return [[phone componentsSeparatedByCharactersInSet:[NSMutableCharacterSet characterSetWithCharactersInString:@"()- "]] componentsJoinedByString:@""];
}

@end