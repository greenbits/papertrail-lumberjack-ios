//
//  PaperTrailLumberJack.m
//  PaperTrailLumberJack
//
//  Created by Malayil Philip George on 5/1/14.
//  Copyright (c) 2014 Rogue Monkey Technologies & Systems Private Limited. All rights reserved.
//

#import "RMPaperTrailLogger.h"
#import "RMSyslogFormatter.h"

@implementation RMPaperTrailLogger

+ (RMPaperTrailLogger *)sharedInstance {
    static dispatch_once_t pred = 0;
    static RMPaperTrailLogger *_sharedInstance = nil;

    dispatch_once(&pred, ^{
        _sharedInstance = [[self alloc] init];
        RMSyslogFormatter *logFormatter = [[RMSyslogFormatter alloc] init];
        _sharedInstance.logFormatter = logFormatter;
        _sharedInstance.useTLS = YES;
        _sharedInstance.debug = YES;
    });

    return _sharedInstance;
}

@end
