//
//  PKTPushEventTests.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 30/10/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PKTPushEvent.h"

@interface PKTPushEventTests : XCTestCase

@end

@implementation PKTPushEventTests

- (void)testInitWithDictionary {
  NSDictionary *eventDict = @{
                              @"channel": @"/user/46432",
                              @"data": @{
                                  @"created_by": @{
                                      @"id": @56432,
                                      @"type": @"user",
                                      },
                                  @"created_via": @1,
                                  @"data": @{
                                      @"action": @"message",
                                      @"conversation_id": @860274,
                                      @"created_by": @{
                                          @"avatar": @35507760,
                                          @"avatar_id": @35509960,
                                          @"avatar_type": @"file",
                                          @"id": @56411,
                                          @"image": @{
                                              @"file_id": @35115660,
                                              @"hosted_by": @"podio",
                                              @"hosted_by_humanized_name": @"Podio",
                                              @"link": @"https://d2cmuesa4snpwn.cloudfront.net/public/35115660",
                                              @"link_target": @"_blank",
                                              @"thumbnail_link": @"https://d2cmuesa4snpwn.cloudfront.net/public/35115660",
                                              },
                                          @"last_seen_on": @"2014-10-30 07:43:03",
                                          @"name": @"James Bond",
                                          @"type": @"user",
                                          @"url": @"https://podio.com/users/56432",
                                          @"user_id": @56432,
                                          },
                                      @"created_on": @"2014-10-30 07:43:59",
                                      @"data": @{
                                          @"created_on": @"2014-10-30 07:43:59",
                                          @"embed": @"<null>",
                                          @"embed_file": @"<null>",
                                          @"files": @[],
                                          @"message_id": @18333088,
                                          @"text": @"d",
                                          },
                                      @"event_id": @19227960,
                                      @"settings": @{
                                          @"browser": @1,
                                          @"popup": @1,
                                          @"sound": @1,
                                          },
                                      @"text": @"d",
                                      @"total_unread_count": @1,
                                      @"unread_count": @1,
                                      },
                                  @"event": @"conversation_event",
                                  @"ref": @{
                                      @"id": @46432,
                                      @"type": @"user",
                                      },
                                  },
                              }
;
  PKTPushEvent *event = [[PKTPushEvent alloc] initWithDictionary:eventDict];
  expect(event.eventType).to.equal(PKTPushEventTypeConversationEvent);
  expect(event.referenceType).to.equal(PKTReferenceTypeUser);
  expect(event.referenceID).to.equal(46432);
  expect(event.createdByType).to.equal(PKTReferenceTypeUser);
  expect(event.createdByID).to.equal(56432);
}

@end
