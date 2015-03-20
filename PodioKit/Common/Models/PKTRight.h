//
//  PKTRight.h
//  PodioKit
//
//  Created by Romain Briche on 20/03/15.
//  Copyright (c) 2015 Citrix Systems, Inc. All rights reserved.
//

#ifndef PodioKit_PKTRight_h
#define PodioKit_PKTRight_h

typedef NS_OPTIONS(NSUInteger, PKTRight) {
  PKTRightNone                  = 0,
  PKTRightView                  = 1 << 0,
  PKTRightUpdate                = 1 << 1,
  PKTRightDelete                = 1 << 2,
  PKTRightSubscribe             = 1 << 3,
  PKTRightComment               = 1 << 4,
  PKTRightRate                  = 1 << 5,
  PKTRightShare                 = 1 << 6,
  PKTRightInstall               = 1 << 7,
  PKTRightAddApp                = 1 << 8,
  PKTRightAddItem               = 1 << 9,
  PKTRightAddFile               = 1 << 10,
  PKTRightAddTask               = 1 << 11,
  PKTRightAddSpace              = 1 << 12,
  PKTRightAddStatus             = 1 << 13,
  PKTRightAddConversation       = 1 << 14,
  PKTRightReply                 = 1 << 15,
  PKTRightAddWidget             = 1 << 16,
  PKTRightStatistics            = 1 << 17,
  PKTRightAddContact            = 1 << 18,
  PKTRightAddHook               = 1 << 19,
  PKTRightAddQuestion           = 1 << 20,
  PKTRightAddAnswer             = 1 << 21,
  PKTRightAddContract           = 1 << 22,
  PKTRightAddUser               = 1 << 23,
  PKTRightAddUserLight          = 1 << 24,
  PKTRightMove                  = 1 << 25,
  PKTRightExport                = 1 << 26,
  PKTRightReference             = 1 << 27,
  PKTRightViewAdmins            = 1 << 28,
  PKTRightDownload              = 1 << 29,
  PKTRightViewMembers           = 1 << 30,
  PKTRightAutoJoin              = 1 << 31,
  PKTRightGrant                 = 1 << 32,
  PKTRightViewStructure         = 1 << 33,
  PKTRightAddFlow               = 1 << 34,
  PKTRightRequestMembership     = 1 << 35,
  PKTRightManagePublicViews     = 1 << 36,
  PKTRightSendPush              = 1 << 37,
  PKTRightAddAdvancedFlow       = 1 << 38,
  PKTRightGrantView             = 1 << 39,
  PKTRightReportVisualization   = 1 << 40,
  PKTRightPrioritySupport       = 1 << 41
};

#endif
