//
//  PKTItemFieldValueTests.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 28/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PKTStringItemFieldValue.h"
#import "PKTDateItemFieldValue.h"
#import "PKTMoneyItemFieldValue.h"
#import "PKTEmbedItemFieldValue.h"
#import "PKTFileItemFieldValue.h"
#import "PKTAppItemFieldValue.h"
#import "PKTProfileItemFieldValue.h"
#import "PKTCalculationItemFieldValue.h"
#import "PKTCategoryItemFieldValue.h"
#import "PKTDurationItemFieldValue.h"
#import "PKTLocationItemFieldValue.h"
#import "PKTProgressItemFieldValue.h"
#import "PKTEmbed.h"
#import "PKTFile.h"
#import "PKTItem.h"
#import "PKTProfile.h"
#import "PKTDateRange.h"
#import "PKTMoney.h"
#import "PKTDuration.h"
#import "PKTLocation.h"
#import "PKTCategoryOption.h"
#import "PKTNumberItemFieldValue.h"

@interface PKTItemFieldValueTests : XCTestCase

@end

@implementation PKTItemFieldValueTests

- (void)testStringValue {
  NSDictionary *valueDict = @{@"value" : @"This is a title"};
  PKTStringItemFieldValue *value = [[PKTStringItemFieldValue alloc] initFromValueDictionary:valueDict];
  expect(value.valueDictionary).to.equal(valueDict);
  expect(value.unboxedValue).toNot.beNil();
}

- (void)testNumberValue {
  NSDictionary *valueDict = @{@"value" : @"12324.43277"};
  PKTNumberItemFieldValue *value = [[PKTNumberItemFieldValue alloc] initFromValueDictionary:valueDict];
  expect(value.valueDictionary).to.equal(valueDict);
  expect(value.unboxedValue).toNot.beNil();
}

- (void)testProgressValue {
  NSDictionary *valueDict = @{@"value" : @50};
  PKTProgressItemFieldValue *value = [[PKTProgressItemFieldValue alloc] initFromValueDictionary:valueDict];
  expect(value.valueDictionary).to.equal(valueDict);
  expect(value.unboxedValue).toNot.beNil();
}

- (void)testDateValue {
  NSDictionary *valueDict = @{
    @"start_date_utc" : @"2014-07-14",
    @"end" : @"2014-07-15 16:00:00",
    @"end_date" : @"2014-07-15",
    @"end_date_utc" : @"2014-07-15",
    @"start_time_utc" : @"13:00:00",
    @"start_time" : @"15:00:00",
    @"start_date" : @"2014-07-14",
    @"start" : @"2014-07-14 15:00:00",
    @"end_time" : @"16:00:00",
    @"end_time_utc" : @"14:00:00",
    @"end_utc" : @"2014-07-15 14:00:00",
    @"start_utc" : @"2014-07-14 13:00:00"
  };
  
  PKTDateItemFieldValue *value = [[PKTDateItemFieldValue alloc] initFromValueDictionary:valueDict];
  expect(value.valueDictionary).to.equal(@{
                                           @"start_utc" : @"2014-07-14 13:00:00",
                                           @"end_utc" : @"2014-07-15 14:00:00"
                                           });
  expect(value.unboxedValue).toNot.beNil();
}

- (void)testDateValueNoTime {
  NSDictionary *valueDict = @{
                              @"start_date_utc" : @"2014-07-14",
                              @"end" : @"2014-07-15 16:00:00",
                              @"end_date" : @"2014-07-15",
                              @"end_date_utc" : @"2014-07-15",
                              @"start_time_utc" : [NSNull null],
                              @"start_time" : [NSNull null],
                              @"start_date" : @"2014-07-14",
                              @"start" : @"2014-07-14 15:00:00",
                              @"end_time" : [NSNull null],
                              @"end_time_utc" : [NSNull null],
                              @"end_utc" : @"2014-07-15 14:00:00",
                              @"start_utc" : @"2014-07-14 13:00:00"
                              };
  
  PKTDateItemFieldValue *value = [[PKTDateItemFieldValue alloc] initFromValueDictionary:valueDict];
  expect(value.valueDictionary).to.equal(@{
                                           @"start_date" : @"2014-07-14",
                                           @"start_time_utc" : [NSNull null],
                                           @"end_date" : @"2014-07-15",
                                           @"end_time_utc" : [NSNull null]
                                           });
  expect(value.unboxedValue).toNot.beNil();
}

- (void)testDateValueOnlyStart {
  NSDictionary *valueDict = @{
                              @"start_date_utc" : @"2014-07-14",
                              @"start_time_utc" : @"13:00:00",
                              @"start_time" : @"15:00:00",
                              @"start_date" : @"2014-07-14",
                              @"start" : @"2014-07-14 15:00:00",
                              @"start_utc" : @"2014-07-14 13:00:00"
                              };
  
  PKTDateItemFieldValue *value = [[PKTDateItemFieldValue alloc] initFromValueDictionary:valueDict];
  expect(value.valueDictionary).to.equal(@{@"start_utc" : @"2014-07-14 13:00:00"});
  expect(value.unboxedValue).toNot.beNil();
}

- (void)testMoneyValue {
  NSDictionary *valueDict = @{@"value" : @"125.532",
                              @"currency" : @"DKK"};
  PKTMoneyItemFieldValue *value = [[PKTMoneyItemFieldValue alloc] initFromValueDictionary:valueDict];
  expect(value.valueDictionary).to.equal(valueDict);
  expect(value.unboxedValue).toNot.beNil();
}

- (void)testEmbedValue {
  NSDictionary *valueDict = @{@"embed" : @{@"embed_id" : @1111},
                              @"file" : @{@"file_id" : @2222}};
  PKTEmbedItemFieldValue *value = [[PKTEmbedItemFieldValue alloc] initFromValueDictionary:valueDict];
  expect(value.valueDictionary).to.equal(@{@"embed" : @1111});
  expect(value.unboxedValue).toNot.beNil();
}

- (void)testEmbedURLValue {
  PKTEmbedItemFieldValue *value = [[PKTEmbedItemFieldValue alloc] init];
  value.unboxedValue = @"https://www.google.com";
  expect(value.valueDictionary).to.equal(@{@"url" : @"https://www.google.com"});
  expect(value.unboxedValue).toNot.beNil();
}

- (void)testFileValue {
  NSDictionary *valueDict = @{@"value" : @{@"file_id" : @2222}};
  PKTFileItemFieldValue *value = [[PKTFileItemFieldValue alloc] initFromValueDictionary:valueDict];
  expect(value.valueDictionary).to.equal(@{@"value" : @2222});
  expect(value.unboxedValue).toNot.beNil();
}

- (void)testAppValue {
  NSDictionary *valueDict = @{@"value" : @{@"item_id" : @3333}};
  PKTAppItemFieldValue *value = [[PKTAppItemFieldValue alloc] initFromValueDictionary:valueDict];
  expect(value.valueDictionary).to.equal(@{@"value" : @3333});
  expect(value.unboxedValue).toNot.beNil();
}

- (void)testProfileValue {
  NSDictionary *valueDict = @{@"value" : @{@"profile_id" : @4444}};
  PKTProfileItemFieldValue *value = [[PKTProfileItemFieldValue alloc] initFromValueDictionary:valueDict];
  expect(value.valueDictionary).to.equal(@{@"value" : @4444});
  expect(value.unboxedValue).toNot.beNil();
}

- (void)testCalculationValue {
  NSDictionary *valueDict = @{@"value" : @324};
  PKTCalculationItemFieldValue *value = [[PKTCalculationItemFieldValue alloc] initFromValueDictionary:valueDict];
  expect(value.valueDictionary).to.beNil();
  expect(value.unboxedValue).toNot.beNil();
}

- (void)testCategoryValue {
  NSDictionary *valueDict = @{
      @"value" : @{@"id" : @123,
                   @"status" : @"active",
                   @"text" : @"First option",
                   @"color" : @"ff0000"}};
  PKTCategoryItemFieldValue *value = [[PKTCategoryItemFieldValue alloc] initFromValueDictionary:valueDict];
  expect(value.valueDictionary).to.equal(@{@"value" : @123});
  expect(value.unboxedValue).toNot.beNil();
}

- (void)testCategoryValueWithOptionID {
  PKTCategoryItemFieldValue *value = [[PKTCategoryItemFieldValue alloc] init];
  value.unboxedValue = @123;
  expect(value.valueDictionary).to.equal(@{@"value" : @123});
  expect(value.unboxedValue).toNot.beNil();
}

- (void)testDurationValue {
  NSDictionary *valueDict = @{@"value" : @101010};
  PKTDurationItemFieldValue *value = [[PKTDurationItemFieldValue alloc] initFromValueDictionary:valueDict];
  expect(value.valueDictionary).to.equal(@{@"value" : @101010});
  expect(value.unboxedValue).toNot.beNil();
}

- (void)testLocationValue {
  NSDictionary *valueDict = @{
    @"city": @"Copenhagen",
    @"country": @"Denmark",
    @"street_name": @"Fisketorvet",
    @"formatted": @"Fisketorvet, 1560 Copenhagen, Denmark",
    @"value": @"Fisketorvet, 1560 Copenhagen, Denmark",
    @"postal_code": @"1560",
    @"lat": @55.6646305,
    @"lng": @12.5657289
  };
  
  PKTLocationItemFieldValue *value = [[PKTLocationItemFieldValue alloc] initFromValueDictionary:valueDict];
  expect(value.valueDictionary).to.equal(@{@"value" : @"Fisketorvet, 1560 Copenhagen, Denmark"});
  expect(value.unboxedValue).toNot.beNil();
}

- (void)testLocationValueWithOnlyLatitudeLongitude {
  PKTLocationItemFieldValue *value = [PKTLocationItemFieldValue new];
  value.unboxedValue = [[PKTLocation alloc] initWithLatitude:55.6646305 longitude:12.5657289];
  expect(value.valueDictionary).to.equal(@{@"lat" : @55.6646305, @"lng" : @12.5657289});
  expect(value.unboxedValue).toNot.beNil();
}

- (void)testBoxedValueSupportForValidStringValue {
  expect([PKTStringItemFieldValue supportsBoxingOfValue:@"Some text" error:nil]).to.beTruthy();
}

- (void)testBoxedValueSupportForValidNumberValue {
  expect([PKTNumberItemFieldValue supportsBoxingOfValue:@32123.432 error:nil]).to.beTruthy();
}

- (void)testBoxedValueSupportForValidProgressValue {
  expect([PKTProgressItemFieldValue supportsBoxingOfValue:@23 error:nil]).to.beTruthy();
}

- (void)testBoxedValueSupportForValidDateRangeValue {
  PKTDateRange *value = [[PKTDateRange alloc] initWithStartDate:[NSDate date] endDate:[NSDate date]];
  expect([PKTDateItemFieldValue supportsBoxingOfValue:value error:nil]).to.beTruthy();
}

- (void)testBoxedValueSupportForValidDateValue {
  expect([PKTDateItemFieldValue supportsBoxingOfValue:[NSDate date] error:nil]).to.beTruthy();
}

- (void)testBoxedValueSupportForValidMoneyValue {
  PKTMoney *value = [[PKTMoney alloc] initWithAmount:@125.5 currency:@"DKK"];
  expect([PKTMoneyItemFieldValue supportsBoxingOfValue:value error:nil]).to.beTruthy();
}

- (void)testBoxedValueSupportForValidEmbedValue {
  PKTEmbed *embed = [[PKTEmbed alloc] init];;
  expect([PKTEmbedItemFieldValue supportsBoxingOfValue:embed error:nil]).to.beTruthy();
}

- (void)testBoxedValueSupportForValidFileValue {
  PKTFile *file = [[PKTFile alloc] init];
  expect([PKTFileItemFieldValue supportsBoxingOfValue:file error:nil]).to.beTruthy();
}

- (void)testBoxedValueSupportForValidAppValue {
  PKTItem *item = [[PKTItem alloc] init];
  expect([PKTAppItemFieldValue supportsBoxingOfValue:item error:nil]).to.beTruthy();
}

- (void)testBoxedValueSupportForValidProfileValue {
  PKTProfile *profile = [[PKTProfile alloc] init];
  expect([PKTProfileItemFieldValue supportsBoxingOfValue:profile error:nil]).to.beTruthy();
}

- (void)testBoxedValueSupportForValidCategoryValue {
  PKTCategoryOption *option = [PKTCategoryOption new];
  expect([PKTCategoryItemFieldValue supportsBoxingOfValue:option error:nil]).to.beTruthy();
}

- (void)testBoxedValueSupportForValidCategoryNumberValue {
  expect([PKTCategoryItemFieldValue supportsBoxingOfValue:@123 error:nil]).to.beTruthy();
}

- (void)testBoxedValueSupportForValidDurationValue {
  PKTDuration *duration = [[PKTDuration alloc] initWithHours:3 minutes:23 seconds:55];
  expect([PKTDurationItemFieldValue supportsBoxingOfValue:duration error:nil]).to.beTruthy();
}

- (void)testBoxedValueSupportForInvalidStringValue {
  expect([PKTStringItemFieldValue supportsBoxingOfValue:@32123 error:nil]).to.beFalsy();
}

- (void)testBoxedValueSupportForInvalidNumberValue {
  expect([PKTNumberItemFieldValue supportsBoxingOfValue:@"32123.432" error:nil]).to.beFalsy();
}

- (void)testBoxedValueSupportForInvalidProgressValue {
  expect([PKTProgressItemFieldValue supportsBoxingOfValue:@"23" error:nil]).to.beFalsy();
}

- (void)testBoxedValueSupportForInvalidDateValue {
  expect([PKTDateItemFieldValue supportsBoxingOfValue:@"Invalid value" error:nil]).to.beFalsy();
}

- (void)testBoxedValueSupportForInvalidMoneyValue {
  expect([PKTMoneyItemFieldValue supportsBoxingOfValue:@"Invalid value" error:nil]).to.beFalsy();
}

- (void)testBoxedValueSupportForInvalidEmbedValue {
  expect([PKTEmbedItemFieldValue supportsBoxingOfValue:@123 error:nil]).to.beFalsy();
}

- (void)testBoxedValueSupportForInvalidFileValue {
  expect([PKTFileItemFieldValue supportsBoxingOfValue:@"Invalid value" error:nil]).to.beFalsy();
}

- (void)testBoxedValueSupportForInvalidAppValue {
  expect([PKTAppItemFieldValue supportsBoxingOfValue:@"Invalid value" error:nil]).to.beFalsy();
}

- (void)testBoxedValueSupportForInvalidProfileValue {
  expect([PKTProfileItemFieldValue supportsBoxingOfValue:@"Invalid value" error:nil]).to.beFalsy();
}

- (void)testBoxedValueSupportForInvalidCategoryValue {
  expect([PKTCategoryItemFieldValue supportsBoxingOfValue:@"Invalid value" error:nil]).to.beFalsy();
}

- (void)testBoxedValueSupportForInvalidDurationValue {
  expect([PKTDurationItemFieldValue supportsBoxingOfValue:@"Invalid value" error:nil]).to.beFalsy();
}

- (void)testErrorForUnsupportedUnboxedValueClass {
  NSError *error = nil;
  [PKTStringItemFieldValue supportsBoxingOfValue:@123 error:&error];
  expect(error).toNot.beNil();
}

@end
