//
//  NetworkManager.m
//  UberBean
//
//  Created by Will Chew on 2018-06-22.
//  Copyright © 2018 Will Chew. All rights reserved.
//

#import "NetworkManager.h"

@implementation NetworkManager

+(void)getCafesAtLatitude:(NSString *)latitude andLongitude:(NSString *)longitude completion:(void (^)(NSArray<Cafe *> *))completion {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.yelp.com/v3/businesses/search?term=cafe&latitude=%@&longitude=%@", latitude, longitude]];
    NSMutableURLRequest *urlRequest= [[NSMutableURLRequest alloc]initWithURL:url];
    NSLog(@"%@", urlRequest);
    
    [urlRequest addValue:@"Bearer QCsxzDpQvN4jHRQjPxszCt55RVndyUZI6sOQZ1xF_sHk_ewwXItiHEOxV3IoKOcsdbfNbnrBZbew8a2PLjf2qe0VRBou758RWt5PYJ5iQz8u3amGTSgQokeug1MtW3Yx" forHTTPHeaderField:@"Authorization"];
    [urlRequest setHTTPMethod:@"GET"];
    
    NSLog(@"%@", urlRequest);
    NSLog(@"Creating Task");
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"getting task: %@", response);
        
        if (error) {
            NSLog(@"Error running request : %@", error.localizedDescription);
            completion(nil);
            return;
        }
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
        if (httpResponse.statusCode != 200) {
            NSLog(@"Bad response from API: %@", httpResponse);
            completion(nil);
            return;
        }
//        NSLog(@"Data : %@", data);
        NSError *err = nil;
        NSDictionary *resultData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&err];
        
        if (err !=nil) {
            NSLog(@"Error passing JSON: %@", err.localizedDescription);
            completion(nil);
            return;
        }
        
        NSArray *cafesJson = resultData[@"businesses"];
        NSMutableArray *cafeData = [@[] mutableCopy];
        for (NSDictionary *cafe in cafesJson) {
            NSLog(@"Cafe: %@", cafe);
            Cafe *c = [[Cafe alloc]initWithDictionary:cafe];
            [cafeData addObject:c];
        }
        NSArray<Cafe*>*result = [cafeData copy];
        completion(result);
        
        
        
    }];
    NSLog(@"Created Task");
    [task resume];
    NSLog(@"Started Task");

    
}

@end
