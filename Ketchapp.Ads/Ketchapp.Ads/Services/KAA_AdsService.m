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

    // Create the request.
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://google.com"]];

    // Create url connection and fire request
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    //TODO: set the blocks for the delegates to use
    //TODO: use NSURLSession
}

#pragma mark NSURLConnection Delegate Methods
    
NSMutableData * _responseData;

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // This method is called each time there is a redirect so reinitializing it
    // also serves to clear it
    _responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [_responseData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    if (_responseData != nil) {
        NSError* error = self.error;
        // The request is complete and data has been received
        NSMutableArray *json = [NSJSONSerialization JSONObjectWithData: _responseData options:kNilOptions error:&error];
        if (json != nil) {
            _waterfall = json;
            NSLog(@"json: %@", json);
        }
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
    NSLog(@"Error on connection: %@", error.description);
    _error = error;
}
@end
