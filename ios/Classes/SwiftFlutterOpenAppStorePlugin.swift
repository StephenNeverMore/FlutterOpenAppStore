import Flutter
import UIKit

public class SwiftFlutterOpenAppStorePlugin: NSObject, FlutterPlugin {

  var pass: Bool = false

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_open_app_store", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterOpenAppStorePlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if(call.method == "getPlatformVersion"){
        result("iOS " + UIDevice.current.systemVersion)
    }else if(call.method == "openAppStore"){
        guard let args = call.arguments else {
                        return
                    }
        if let myArgs = args as? [String: Any],
                let uri = myArgs["ios_id"] as? String{
                result(self.openAppStore(id:uri))
           }
    }

  }

  public override init() {
         super.init()
  }

  func openAppStore(id: String)-> String{
          let appStoreLink = "https://itunes.apple.com/kr/app/apple-store/\(id)"

          if let url = URL(string: appStoreLink), UIApplication.shared.canOpenURL(url) {
              self.pass = UIApplication.shared.canOpenURL(url)
              // Attempt to open the URL.
              if #available(iOS 10.0, *) {
                  UIApplication.shared.open(url, options: [:], completionHandler: {(success: Bool) in
                      if success {
                          print("Launching \(url) was successful")
                      }})
              } else {
                  // Fallback on earlier versions
              }
          }
          print(self.pass.description)
          return self.pass.description
      }
}
