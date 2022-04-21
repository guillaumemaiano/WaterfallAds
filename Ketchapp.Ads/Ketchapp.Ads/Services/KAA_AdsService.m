//
//  KAA_AdsService.m
//  Ketchapp.Ads
//
//  Created by guillaume MAIANO on 19/04/2022.
//

#import "KAA_AdsService.h"

@implementation KAA_AdsService

#pragma mark - Init
+(id) service {
    KAA_AdsService* service = [[KAA_AdsService alloc] init];
    service.waterfall = [[NSMutableArray alloc] init];
    service.gateway = [[KAA_Gateway alloc] init];
    return service;
}

+(instancetype) serviceWith:(KAA_Gateway *)gateway {
    KAA_AdsService* service = [[KAA_AdsService alloc] init];
    service.waterfall = [[NSMutableArray alloc] init];
    service.gateway = gateway;
    return service;
}

#pragma mark - Configuration
- (void) reconfigureGateway: (KAA_Gateway*) gateway forWaterfall: (WaterfallType) type {
    gateway = [KAA_Gateway gatewayFrom: gateway WithWaterfall: type];
}

#pragma mark - Behavior
- (void) fetchInterstitialWaterfall {
    void (^successBlock)(NSArray*) = ^ (NSArray* interstitials) {
        NSLog(@"Fetch succeeded with %lu elements", (unsigned long)interstitials.count);
        return;
    };
    void (^failureBlock)(NSString*) = ^ (NSString* errorMessage) {
        NSLog(@"Fetch failed with error message %@", errorMessage);
        return;
    };
    [self fetchInterstitialWaterfall: successBlock failsWith: failureBlock];
}

- (void) fetchInterstitialWaterfall: (void (^)(NSArray*)) successBlock {
    void (^failureBlock)(NSString*) = ^ (NSString* errorMessage) {
        NSLog(@"Fetch failed with error message %@", errorMessage);
        return;
    };
    [self fetchInterstitialWaterfall: successBlock failsWith: failureBlock];
}

- (void) fetchInterstitialWaterfall: (void (^)(NSArray*)) successBlock failsWith: (void (^)(NSString*)) failureBlock {
    NSError* error = self.error;

    NSData *data = [NSData dataWithContentsOfURL: self.gateway.url];
    NSMutableArray *json = [NSJSONSerialization JSONObjectWithData: data options:kNilOptions error:&error];
    NSLog(@"json: %@", json);
    // TODO: code me
}

@end
