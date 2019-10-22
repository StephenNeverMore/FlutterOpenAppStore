#import "FlutterOpenAppStorePlugin.h"
#import <flutter_open_app_store/flutter_open_app_store-Swift.h>

@implementation FlutterOpenAppStorePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterOpenAppStorePlugin registerWithRegistrar:registrar];
}
@end
