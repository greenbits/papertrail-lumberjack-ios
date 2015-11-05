//
//  PaperTrailLumberjackiOSExampleTests.m
//  PaperTrailLumberjackiOSExampleTests
//
//  Created by Malayil Philip George on 5/8/14.
//  Copyright (c) 2014 Rogue Monkey Technologies & Systems Private Limited. All rights reserved.
//

#import <XCTest/XCTest.h>

#import <CocoaLumberjack/CocoaLumberjack.h>

#import "RMPaperTrailLogger.h"

const int ddLogLevel = DDLogLevelVerbose;

@interface PaperTrailLumberjackiOSExampleTests : XCTestCase {
    RMPaperTrailLogger *_paperTrailLogger;
}

@property (nonatomic, strong) RMPaperTrailLogger *paperTrailLogger;

@end

@implementation PaperTrailLumberjackiOSExampleTests

@synthesize paperTrailLogger = _paperTrailLogger;

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    //Add loggers (using CocoaLumberjack framework)
    //Add apple system logger
    [DDLog addLogger:[DDASLLogger sharedInstance]];
    //Add XCode console logger
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    //Add RMPaperTrailLogger
    RMPaperTrailLogger *paperTrailLogger = [RMPaperTrailLogger sharedInstance];
    paperTrailLogger.host = @"logs.papertrailapp.com"; //Enter your hostname here ex. logs.papertrailapp.com
    paperTrailLogger.port = 13619; //Enter port number here
    self.paperTrailLogger = paperTrailLogger;
    [DDLog addLogger:paperTrailLogger];
    
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [NSThread sleepForTimeInterval:10];
    [self.paperTrailLogger disconnect];
    [super tearDown];
}

- (void)testUdpLogging
{
    self.paperTrailLogger.useTcp = NO;
    DDLogVerbose(@"");
    DDLogVerbose(@"Verbose Logging");
    DDLogInfo(@"Info Logging");
    DDLogDebug(@"Debug Logging");
    DDLogWarn(@"Warn Logging");
    DDLogError(@"Error Logging");
}

-(void) testTcpLogging
{
    self.paperTrailLogger.useTcp = YES;
    self.paperTrailLogger.useTLS = NO;
    
    DDLogVerbose(@"");
    DDLogVerbose(@"Verbose Logging");
    DDLogInfo(@"Info Logging");
    DDLogDebug(@"Debug Logging");
    DDLogWarn(@"Warn Logging");
    DDLogError(@"Error Logging");
}

-(void) testTcpSSLLogging
{
    self.paperTrailLogger.useTcp = YES;
    
    DDLogVerbose(@"");
    DDLogVerbose(@"Verbose Logging");
    DDLogInfo(@"Info Logging");
    DDLogDebug(@"Debug Logging");
    DDLogWarn(@"Warn Logging");
    DDLogError(@"Error Logging");
}

@end
