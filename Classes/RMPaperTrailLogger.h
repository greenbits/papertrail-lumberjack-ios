//
//  PaperTrailLumberJack.h
//  PaperTrailLumberJack
//
//  Created by Malayil Philip George on 5/1/14.
//  Copyright (c) 2014 Rogue Monkey Technologies & Systems Private Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CocoaLumberjack/CocoaLumberjack.h>

/**
 RMPaperTrailLogger is a custom logger (for CocoaLumberjack) that directs log output to your account on papertrailapp.com. It can log using TCP and UDP. On OS X, TLS is supported on TCP Connections. Currently, on iOS TCP connections only Plain-Text is supported. The default is UDP (which is always unencrypted). The logs are sent in a syslog format using RMSyslogFormatter. If you are going to provide a custom formatter, make sure that it formats messages that meets the syslog spec.
 */
@interface RMPaperTrailLogger : DDAbstractLogger {
    NSString *_host;
    NSUInteger _port;
    BOOL _useTcp;
    BOOL _useTLS;
}

/**
 The host to which logs should be sent. Ex. logs.papertrailapp.com
 */
@property (nonatomic, copy) NSString *host;

/**
 The port on host to which we should connect. Ex. 9999
 */
@property (nonatomic, assign) NSUInteger port;

/**
 Specifies whether we should connect via TCP. Default is `NO` (uses UDP)
 */
@property (nonatomic, assign) BOOL useTcp;

/**
 Specifies whether we should use TLS. Default is `YES`. This parameter applies only to TCP connections.
 */
@property (nonatomic, assign) BOOL useTLS;

/**
 Specifies whether the logger should emit informational NSLogs
 */
@property (nonatomic, assign) BOOL debug;

/**
 Returns a initialized singleton instance of this logger
 */
+(RMPaperTrailLogger *) sharedInstance;

/**
 Releases network resources (sockets) that were opened. Should be called when we are done with the logger. Any pending writes will be discarded when this method is called.
 */
-(void) disconnect;

@end
