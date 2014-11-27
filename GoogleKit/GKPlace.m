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

#import "GKPlace.h"

@implementation GKPlace

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {

    self = [super init];
    if (self) {

        _formattedAddress = [dictionary objectForKey:@"formatted_address"];

        CGFloat lat = [[[[dictionary objectForKey:@"geometry"] objectForKey:@"location"] objectForKey:@"lat"] floatValue];
        CGFloat lng = [[[[dictionary objectForKey:@"geometry"] objectForKey:@"location"] objectForKey:@"lng"] floatValue];
        
        _coordinate = CLLocationCoordinate2DMake(lat, lng);

        _icon = [dictionary objectForKey:@"icon"];
        _name = [dictionary objectForKey:@"name"];
        _rating = [[dictionary objectForKey:@"rating"] floatValue];
        _types = [dictionary objectForKey:@"types"];
        _scope = [dictionary objectForKey:@"scope"];

        _openNow = [[[dictionary objectForKey:@"opening_hours"] objectForKey:@"open_now"] boolValue];
        _priceLevel = [[dictionary objectForKey:@"price_level"] integerValue];
        _placeId = [dictionary objectForKey:@"place_id"];
        _vicinity = [dictionary objectForKey:@"vicinity"];
    }
    return self;
}

@end