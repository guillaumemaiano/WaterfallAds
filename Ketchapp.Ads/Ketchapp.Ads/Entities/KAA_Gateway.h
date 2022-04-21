//
//  KAA_Gateway.h
//  Ketchapp.Ads
//
//  Created by guillaume MAIANO on 16/04/2022.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum {
  Square
} WaterfallType;

typedef enum {
    Phone,
    Tablet
} DeviceType;

typedef enum {
    iOS,
    watchOS
} SupportedOS;

@interface KAA_Gateway : NSObject

@property (nonatomic, strong) NSURL* url;

+(instancetype)gatewayWithWaterfall: (WaterfallType) waterfallType forDevice: (DeviceType) deviceType andOS: (SupportedOS) operatingSystem;

+(instancetype)gatewayWithURLString: (NSString*) urlString withWaterfall: (WaterfallType) waterfallType forDevice: (DeviceType) deviceType andOS: (SupportedOS) operatingSystem forBundleId: (NSString*) bundleId;

+(instancetype) gatewayFrom: (KAA_Gateway*) gateway WithWaterfall: (WaterfallType) waterfallType;
@end

@interface NSObject (WaterfallType)
- (NSString*)waterfallTypeToString:(WaterfallType)waterfallType;
@end

@interface NSObject (DeviceType)
- (NSString*) deviceTypeToString:(DeviceType)deviceType;
@end

@interface NSObject (SupportedOS)
- (NSString*) osToString:(SupportedOS) operatingSystem;
@end

NS_ASSUME_NONNULL_END
