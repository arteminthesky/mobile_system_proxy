import Flutter
import UIKit

public class SwiftMobileSystemProxyPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "mobile_system_proxy", binaryMessenger: registrar.messenger())
    let instance = SwiftMobileSystemProxyPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
      if call.method == "getProxy" {
            result(getProxy()?.encode())
      }
  }

  private func getProxy() -> Proxy?{
      if let url = URL(string: "https://apple.com") {
          let systemProxySettings = CFNetworkCopySystemProxySettings()?.takeUnretainedValue() ?? [:] as CFDictionary
          let proxiesForTargetUrl = CFNetworkCopyProxiesForURL(url as CFURL, systemProxySettings).takeUnretainedValue() as? [[AnyHashable: Any]] ?? []
          if(proxiesForTargetUrl.count != 0) {
              let proxy = proxiesForTargetUrl[0]
              if let proxyHost = proxy[kCFProxyHostNameKey] as? String,
                 let proxyPort = proxy[kCFProxyPortNumberKey] as? Int
              {
                  return Proxy(host: proxyHost, port: proxyPort)
              }
          }
      }
      return nil
  }
}

class Proxy {
    private let host: String?
    private let port: Int?
    init(host: String?, port: Int?) {
        self.host = host
        self.port = port
    }

    public func encode() -> NSArray {
        return [host, port]
    }
}