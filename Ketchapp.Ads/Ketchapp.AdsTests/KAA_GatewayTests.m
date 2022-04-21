//
//  KAA_GatewayTests.m
//  Ketchapp.AdsTests
//
//  Created by guillaume MAIANO on 16/04/2022.
//

#import <XCTest/XCTest.h>
#import "KAA_Gateway.h"

@interface KAA_GatewayTests : XCTestCase

@end

@implementation KAA_GatewayTests

KAA_Gateway * gateway;

- (void)setUp {
    gateway = [[KAA_Gateway alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void) testGatewayDefaultIsValid {
    
    XCTAssertNotNil(gateway, @"Gateway is nil");
    XCTAssertNotNil(gateway.url, @"URL is nil");
    XCTAssertNotEqual(gateway.url.absoluteString.length, 0, @"URL is invalid (length zero)");
    XCTAssertEqualObjects(gateway.url.host, @"api.ketchappgames.com", @"URL is invalid (incorrect url)");
    XCTAssertEqualObjects(gateway.url.query, @"os=iOS&waterfallType=Square&deviceType=Phone&bundleId=com.ketchapps.testads", @"URL is invalid (incorrect default parameters)");
    XCTAssertEqualObjects(gateway.url.absoluteURL.relativePath, @"/crosspromo/GetWaterfall", @"URL is invalid (incorrect relative path)");
}

- (void) testGatewayIsCustomizable {
    gateway = [KAA_Gateway gatewayWithWaterfall: Square forDevice: Phone andOS: watchOS];
    XCTAssertNotNil(gateway, @"Gateway is nil");
    XCTAssertNotNil(gateway.url, @"URL is nil");
    XCTAssertNotEqual(gateway.url.absoluteString.length, 0, @"URL is invalid (length zero)");
    XCTAssertEqualObjects(gateway.url.query, @"os=watchOS&waterfallType=Square&deviceType=Phone&bundleId=com.ketchapps.testads", @"URL is invalid (incorrect parameters)");
    XCTAssertEqualObjects(gateway.url.absoluteURL.relativePath, @"/crosspromo/GetWaterfall", @"URL is invalid (incorrect relative path)");
}

- (void) testGatewayAcceptsDifferentParameters {
    NSString * testBundleId = @"com.test.test";
    NSString * expectedQuery = [NSString stringWithFormat: @"os=watchOS&waterfallType=Square&deviceType=Phone&bundleId=%@", testBundleId];
    gateway = [KAA_Gateway gatewayWithURLString: @"localhost" withWaterfall: Square forDevice: Phone andOS: watchOS forBundleId: testBundleId];
    XCTAssertNotNil(gateway, @"Gateway is nil");
    XCTAssertNotNil(gateway.url, @"URL is nil");
    XCTAssertNotEqual(gateway.url.absoluteString.length, 0, @"URL is invalid (length zero)");
    XCTAssertEqualObjects(gateway.url.query, expectedQuery, @"URL is invalid (incorrect parameters)");
    XCTAssertEqualObjects(gateway.url.absoluteURL.relativePath, @"/crosspromo/GetWaterfall", @"URL is invalid (incorrect relative path)");
}

- (void) testGatewayFromGateway {
    NSString * testBundleId = @"com.test.test";
    NSString * expectedQuery = [NSString stringWithFormat: @"os=watchOS&waterfallType=Square&deviceType=Phone&bundleId=%@", testBundleId];
    KAA_Gateway * initialGateway = [KAA_Gateway gatewayWithURLString: @"localhost" withWaterfall: Square forDevice: Phone andOS: watchOS forBundleId: testBundleId];
    gateway = [KAA_Gateway gatewayFrom:initialGateway WithWaterfall:Square];
    XCTAssertNotNil(gateway, @"Gateway is nil");
    XCTAssertNotNil(gateway.url, @"URL is nil");
    XCTAssertNotEqual(gateway.url.absoluteString.length, 0, @"URL is invalid (length zero)");
    XCTAssertEqualObjects(gateway.url.query, expectedQuery, @"URL is invalid (incorrect parameters)");
 }

- (void)testWaterfallTypeToString {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    // GIVEN
    WaterfallType type = Square;
    // WHEN
    NSString* typeToString = [NSObject waterfallTypeToString: type];
    // THEN
    XCTAssertNotEqualObjects(typeToString, @"square");
    XCTAssertEqualObjects(typeToString, @"Square");
    XCTAssertNotEqualObjects(typeToString, @"IncorrectString");
}

- (void)testSupportedOS_iOS_ToString {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    // GIVEN
    SupportedOS type = iOS;
    // WHEN
    NSString* typeToString = [NSObject osToString: type];
    // THEN
    XCTAssertNotEqualObjects(typeToString, @"IOS");
    XCTAssertEqualObjects(typeToString, @"iOS");
    XCTAssertNotEqualObjects(typeToString, @"IncorrectString");
}

- (void)testSupportedOS_watchOS_ToString {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    // GIVEN
    SupportedOS type = watchOS;
    // WHEN
    NSString* typeToString = [NSObject osToString: type];
    // THEN
    XCTAssertNotEqualObjects(typeToString, @"WATCHOS");
    XCTAssertEqualObjects(typeToString, @"watchOS");
    XCTAssertNotEqualObjects(typeToString, @"IncorrectString");
}

- (void)testDeviceTypeToString {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    // GIVEN
    NSDictionary *deviceTypes =  @{
        @"Phone": @(Phone),
        @"Tablet": @(Tablet),
    };
    // WHEN
    for (NSString *key in deviceTypes.allKeys)
    {
        DeviceType devType = (int)[(NSNumber *)[deviceTypes objectForKey: key] integerValue];
        NSString* typeToString = [NSObject deviceTypeToString: devType];
        // THEN
        XCTAssertNotEqualObjects(typeToString, @"phone");
        XCTAssertEqualObjects(typeToString, key);
        XCTAssertNotEqualObjects(typeToString, @"IncorrectString");
    }
}


@end
