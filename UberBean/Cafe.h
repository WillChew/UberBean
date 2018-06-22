//
//  Cafe.h
//  UberBean
//
//  Created by Will Chew on 2018-06-22.
//  Copyright © 2018 Will Chew. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Cafe : NSObject

@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *imageurl;
@property (nonatomic,strong) NSArray *location;

-(instancetype)initWithDictionary:(NSDictionary*)dict;

@end
