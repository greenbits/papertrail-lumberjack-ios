//
//  RMDataDogFormatter.h
//

#import <Foundation/Foundation.h>
#import <CocoaLumberjack/CocoaLumberjack.h>

@interface RMDataDogFormatter : NSObject <DDLogFormatter>

@property (nonatomic, copy) NSString *apiKey;
@property (nonatomic, copy) NSString *programName;
@property (nonatomic, copy) NSString *machineName;
@property (nonatomic, copy) NSDictionary *tags;
@property (nonatomic, copy) NSDictionary *attributes;

- (void)addTag:(NSString *)tag withValue:(id)value;
- (void)addAttribute:(NSString *)attribute withValue:(id)value;


@end
