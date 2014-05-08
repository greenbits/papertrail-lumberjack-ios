# PaperTrailLumberjack
PaperTrailLumberjack is a CocoaLumberjack logger that helps log statements to your log destination at [papertrailapp](http://papertrailapp.com).
It can log using TCP and UDP. On OS X, TLS is supported on TCP Connections, while, on iOS, TCP connections are currently only plain-text. 
The default is UDP (which is always unencrypted). 

## Usage

To run the example project; clone the repo, and run `pod install` from the Example directory first.

Example UDP logging:
    RMPaperTrailLogger *paperTrailLogger = [RMPaperTrailLogger sharedInstance];
    paperTrailLogger.host = @"destination.papertrailapp.com"; //Your host here
    paperTrailLogger.port = 9999; //Your port number here
    
    [DDLog addLogger:paperTrailLogger];
    
    DDLogVerbose(@"Hi PaperTrailApp.com);

Example TCP logging (with TLS):
    RMPaperTrailLogger *paperTrailLogger = [RMPaperTrailLogger sharedInstance];
    paperTrailLogger.host = @"destination.papertrailapp.com"; //Your host here
    paperTrailLogger.port = 9999; //Your port number here    
    paperTrailLogger.useTcp = YES; //TLS is on by default on OS X and ignored on iOS
    
    [DDLog addLogger:paperTrailLogger];
    
    DDLogVerbose(@"Hi PaperTrailApp.com");
 
## Installation

PaperTrailLumberjack is available through [CocoaPods](http://cocoapods.org), to install
it simply add the following line to your Podfile:

    pod "PaperTrailLumberjack"

## Author

George Malayil-Philip, george.malayil@roguemonkey.in

## License

PaperTrailLumberjack is available under the MIT license. See the LICENSE file for more info.

