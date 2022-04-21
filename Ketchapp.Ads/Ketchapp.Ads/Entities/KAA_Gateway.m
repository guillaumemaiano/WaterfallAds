//
//  KAA_Gateway.m
//  Ketchapp.Ads
//
//  Created by guillaume MAIANO on 16/04/2022.
//

#import "KAA_Gateway.h"

@implementation KAA_Gateway
    static NSString *const BASE_URL_STRING = @"api.ketchappgames.com/crosspromo/";
    static NSString *const PATH = @"GetWaterfall/";
    static NSString *const PREFIX = @"https://";
    static NSString *const DEFAULT_BUNDLE_ID = @"com.ketchapps.testads";

+(instancetype)gatewayWithWaterfall: (WaterfallType) waterfallType forDevice: (DeviceType) deviceType andOS: (SupportedOS) operatingSystem {

    KAA_Gateway* gateway = [[KAA_Gateway alloc] init];
    NSString * args = [NSString stringWithFormat:@"os=%@&waterfallType=%@&deviceType=%@&bundleId=%@",
                       [NSObject osToString: operatingSystem],
                       [NSObject waterfallTypeToString: waterfallType],
                       [NSObject deviceTypeToString: deviceType],
                       DEFAULT_BUNDLE_ID
    ];
    NSString * url_string = [NSString stringWithFormat: @"%@%@%@?%@", PREFIX, BASE_URL_STRING, PATH, args];
    gateway.url = [NSURL URLWithString: url_string];
    return gateway;
}

+(instancetype)gatewayWithURLString: (NSString*) urlString withWaterfall: (WaterfallType) waterfallType forDevice: (DeviceType) deviceType andOS: (SupportedOS) operatingSystem forBundleId: (NSString*) bundleId {
    
    KAA_Gateway* gateway = [[KAA_Gateway alloc] init];
    NSString * args = [NSString stringWithFormat:@"os=%@&waterfallType=%@&deviceType=%@&bundleId=%@",
                       [NSObject osToString: operatingSystem],
                       [NSObject waterfallTypeToString: waterfallType],
                       [NSObject deviceTypeToString: deviceType],
                       bundleId
    ];
    NSString * url_string = [NSString stringWithFormat: @"%@%@?%@", PREFIX, urlString, args];
    gateway.url = [NSURL URLWithString: url_string];
    return gateway;
}

+(instancetype) gatewayFrom: (KAA_Gateway*) gateway WithWaterfall: (WaterfallType) waterfallType {
    
    NSString * gatewayUrl = [NSString stringWithFormat: @"%@%@%@", PREFIX, gateway.url.host, gateway.url.path];
    NSURLComponents* urlComponents = [NSURLComponents componentsWithURL:gateway.url resolvingAgainstBaseURL:NO];
    // default values if they can't be extracted
    DeviceType deviceType = Phone;
    NSString* bundleId = DEFAULT_BUNDLE_ID;
    SupportedOS operatingSystem = iOS;
    for (NSURLQueryItem* queryItem in [urlComponents queryItems])
        {
            if (queryItem.value == nil)
            {
                continue;
            }
            if ([queryItem.name isEqualToString:@"bundleId"]) {
                bundleId = queryItem.value;
            }
            // Enum translation t/f
            if ([queryItem.name isEqualToString:@"os"]) {
                NSArray *items = @[@"iOS", @"watchOS"];
                int item = (int)[items indexOfObject:queryItem.value];
                switch (item) {
                    case 0:
                        operatingSystem = iOS;
                        break;
                    case 1:
                        operatingSystem = watchOS;
                        break;
                    default:
                        break;
                }
            }
            if ([queryItem.name isEqualToString:@"deviceType"]) {
                NSArray *items = @[@"Phone"];
                int item = (int)[items indexOfObject:queryItem.value];
                switch (item) {
                    case 0:
                        deviceType = Phone;
                        break;
                    default:
                        break;
                }
            }
        }
    return [KAA_Gateway gatewayWithURLString:gatewayUrl withWaterfall: waterfallType forDevice: deviceType andOS: operatingSystem forBundleId: bundleId];
}

- (instancetype)init {
    self = [super init];
    NSString * args = [NSString stringWithFormat:@"os=%@&waterfallType=%@&deviceType=%@&bundleId=%@",
                       [NSObject osToString:iOS],
                       [NSObject waterfallTypeToString:Square],
                       [NSObject deviceTypeToString:Phone],
                       DEFAULT_BUNDLE_ID
    ];
    NSString * url_string = [NSString stringWithFormat: @"%@%@%@?%@", PREFIX, BASE_URL_STRING, PATH, args];
    self.url = [NSURL URLWithString: url_string];
    return self;
}

@end

@implementation NSObject (WaterfallType)

- (NSString*)waterfallTypeToString:(WaterfallType) waterfallType {

    NSString *result = nil;

    switch(waterfallType) {
        case Square:
            result = @"Square";
            break;
        default:
            [NSException raise:NSGenericException format:@"Unexpected WaterfallType."];
    }

    return result;
}
@end

@implementation NSObject (DeviceType)

- (NSString*) deviceTypeToString:(DeviceType)deviceType {
    NSString *result = nil;

    switch(deviceType) {
        case Phone:
            result = @"Phone";
            break;
        case Tablet:
            result = @"Tablet";
            break;
        default:
            [NSException raise:NSGenericException format:@"Unexpected DeviceType."];
    }

    return result;
}
@end

@implementation NSObject (SupportedOS)

- (NSString*) osToString:(SupportedOS) operatingSystem {
    NSString *result = nil;

    switch(operatingSystem) {
        case iOS:
            result = @"iOS";
            break;
        case watchOS:
            result = @"watchOS";
            break;
        default:
            [NSException raise:NSGenericException format:@"Unexpected SupportedOS."];
    }

    return result;
}
@end
