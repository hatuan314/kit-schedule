#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"

@implementation AppDelegate
@import Firebase;

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];
  [FIRApp configure];
  // Override point for customization after application launch.
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
