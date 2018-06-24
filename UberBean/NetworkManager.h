//
//  NetworkManager.h
//  UberBean
//
//  Created by Will Chew on 2018-06-22.
//  Copyright © 2018 Will Chew. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Cafe.h"

@interface NetworkManager : NSObject

+(void)getCafesAtLatitude:(NSString*)latitude andLongitude:(NSString*)longitude completion:(void(^)(NSArray<Cafe*>*))completion;


@end
