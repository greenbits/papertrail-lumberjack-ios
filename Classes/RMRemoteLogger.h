//
//  RMRemoteLogger.h
//

#import <Foundation/Foundation.h>

#import <CocoaLumberjack/CocoaLumberjack.h>

@interface RMRemoteLogger : DDAbstractLogger {
    NSString *_host;
    NSUInteger _port;
    BOOL _useTcp;
    BOOL _useTLS;
    NSString *_machineName;
    NSString *_programName;
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
 Specifies a custom machine name for the logs. Defaults to vendor identifier UUID.
 */
@property (nonatomic, copy) NSString *machineName;

/**
 Specifies a custom program name for the logs. Defaults to "AppName-AppVersion".
 */
@property (nonatomic, copy) NSString *programName;

/**
 Returns a initialized singleton instance of this logger
 */
+ (RMRemoteLogger *)sharedInstance;

/**
 Releases network resources (sockets) that were opened. Should be called when we are done with the logger. Any pending writes will be discarded when this method is called.
 */
- (void)disconnect;

@end
