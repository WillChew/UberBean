//
//  Cafe.m
//  UberBean
//
//  Created by Will Chew on 2018-06-22.
//  Copyright © 2018 Will Chew. All rights reserved.
//

#import "Cafe.h"

@implementation Cafe


- (instancetype)initWithDictionary:(NSDictionary *)dict {
    if (self = [super init]) {
        _name = dict[@"name"];
        _imageurl = dict[@"image_url"];
        _location = dict[@"location"];
    }
    return self;
}

@end
