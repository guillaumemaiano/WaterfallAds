//
//  KAA_AdsService.h
//  Ketchapp.Ads
//
//  Created by guillaume MAIANO on 19/04/2022.
//

#import <Foundation/Foundation.h>
#import "KAA_Gateway.h"

NS_ASSUME_NONNULL_BEGIN

@interface KAA_AdsService : NSObject
+(KAA_AdsService*) serviceWith: (KAA_Gateway*) gateway;
+(KAA_AdsService*) service;

@property (atomic, strong) NSArray* waterfall;
@property (atomic, strong) KAA_Gateway* gateway;
@property (readonly, atomic, strong) NSError* error;

- (void) fetchInterstitialWaterfall;
- (void) reconfigureGateway: (KAA_Gateway*) gateway forWaterfall: (WaterfallType) type;
- (void) fetchInterstitialWaterfall: (void (^)(NSArray*)) successBlock ;
- (void) fetchInterstitialWaterfall: (void (^)(NSArray*)) successBlock failsWith: (void (^)(NSString*)) failureBlock;
@end

NS_ASSUME_NONNULL_END
