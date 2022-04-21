//
//  KAA_AdsServiceTests.m
//  Ketchapp.AdsTests
//
//  Created by guillaume MAIANO on 19/04/2022.
//

#import <XCTest/XCTest.h>
#import "KAA_AdsService.h"
// Form of JSON response
/*{
  "apps": [
    {
      "id": "3177",
      "repeat": "1",
      "image": "https://cdn-ketchapp.akamaized.net/crosspromo/79/ad_flippy_race_ipad_en.png",
      "appBundle": "com.ketchapp.game80",
      "video": "https://cdn-ketchapp.akamaized.net/crosspromo/79/6/index.mp4",
      "adName": "ios_inter_6",
      "headerImage": "https://cdn-ketchapp.akamaized.net/crosspromo/header/en_white.png",
      "logoImage": "http://www.ketchapp.org/crosspromo/logo/tap_to_start_hand_white.png",
      "playImage": "https://cdn-ketchapp.akamaized.net/crosspromo/header/en_white.png",
      "storeLink": "https://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=1434562378",
      "itunesId": "1434562378"
    }]}*/
@interface KAA_AdsServiceTests : XCTestCase

@end

@implementation KAA_AdsServiceTests

KAA_AdsService* adsService;

- (void)setUp {
    adsService = [KAA_AdsService service];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void) testServiceDefaultIsValid {
    XCTAssertNotNil(adsService, @"Service is nil");
    XCTAssertNotNil(adsService.waterfall, @"Waterfall is nil");
    XCTAssertNotNil(adsService.gateway, @"Gateway is nil");
    XCTAssertNotNil(adsService.error, @"Error is nil");
    XCTAssertEqual(adsService.waterfall.count, 0, @"Waterfall is not empty!");
}

- (void) testServiceFetchesWaterfallWithDefaultBlocks {
    [adsService fetchInterstitialWaterfall];
    XCTFail(@"Code missing");
}

- (void) testServiceFetchesWaterfallWithDefaultFailureBlock {
    void (^successBlock)(NSArray*)  = ^ (NSArray* waterfallArray) {
        return;
    };
    [adsService fetchInterstitialWaterfall: successBlock];
    
    XCTFail(@"Code missing");
}

- (void) testServiceFetchesWaterfallWithCustomSuccessFailureBlocks {
    void (^successBlock)(NSArray*)  = ^ (NSArray* waterfallArray) {
        return;
    };
    void (^failureblock)(NSString*)  = ^ (NSString* errorMessage) {
        return;
    };
    
    [adsService fetchInterstitialWaterfall: successBlock failsWith: failureblock];
    XCTFail(@"Code missing");
}

@end
