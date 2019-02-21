//
//  PaperTrailLumberJack.h
//  PaperTrailLumberJack
//
//  Created by Malayil Philip George on 5/1/14.
//  Copyright (c) 2014 Rogue Monkey Technologies & Systems Private Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RMRemoteLogger.h"
#import <CocoaLumberjack/CocoaLumberjack.h>

/**
 RMPaperTrailLogger is a custom logger (for CocoaLumberjack) that directs log output to your account on papertrailapp.com. It can log using TCP and UDP. On OS X, TLS is supported on TCP Connections. Currently, on iOS TCP connections only Plain-Text is supported. The default is UDP (which is always unencrypted). The logs are sent in a syslog format using RMSyslogFormatter. If you are going to provide a custom formatter, make sure that it formats messages that meets the syslog spec.
 */
@interface RMPaperTrailLogger : RMRemoteLogger

/**
 Returns a initialized singleton instance of this logger
 */
+ (RMPaperTrailLogger *)sharedInstance;

@end
