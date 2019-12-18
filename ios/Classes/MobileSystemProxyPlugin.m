#import "MobileSystemProxyPlugin.h"
#if __has_include(<mobile_system_proxy/mobile_system_proxy-Swift.h>)
#import <mobile_system_proxy/mobile_system_proxy-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "mobile_system_proxy-Swift.h"
#endif

@implementation MobileSystemProxyPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftMobileSystemProxyPlugin registerWithRegistrar:registrar];
}
@end
