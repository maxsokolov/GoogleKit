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

// API https://developers.google.com/places/documentation/details#PlaceDetailsResponses

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface GKPlaceDetailsQueryResult : NSObject

@property (nonatomic, strong, readonly) NSString *streetNumber;
@property (nonatomic, strong, readonly) NSString *route;
@property (nonatomic, strong, readonly) NSString *locality;
@property (nonatomic, strong, readonly) NSString *administrativeAreaLevel1;
@property (nonatomic, strong, readonly) NSString *administrativeAreaLevel2;
@property (nonatomic, strong, readonly) NSString *country;
@property (nonatomic, strong, readonly) NSString *postalCode;
@property (nonatomic, strong, readonly) NSString *formattedAddress;
@property (nonatomic, strong, readonly) NSString *formattedPhoneNumber;
@property (nonatomic, assign, readonly) CLLocationCoordinate2D location;
@property (nonatomic, strong, readonly) NSString *icon;
@property (nonatomic, strong, readonly) NSString *Id;
@property (nonatomic, strong, readonly) NSString *internationalPhoneNumber;
@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, assign, readonly) CGFloat rating;
@property (nonatomic, strong, readonly) NSString *reference;
@property (nonatomic, strong, readonly) NSURL *url;
@property (nonatomic, strong, readonly) NSString *vicinity;
@property (nonatomic, strong, readonly) NSURL *website;
@property (nonatomic, strong, readonly) NSString *placeId;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end