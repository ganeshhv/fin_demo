import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    private let CHANNEL = "bluetooth_channel"
    private var enableBluetoothResult: FlutterResult?

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        let channel = FlutterMethodChannel(name: CHANNEL, binaryMessenger: controller.binaryMessenger)
        channel.setMethodCallHandler({
            [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            guard call.method == "enableBluetooth" else {
                result(FlutterMethodNotImplemented)
                return
            }
            self?.enableBluetooth(result: result)
        })

        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    private func enableBluetooth(result: @escaping FlutterResult) {
        enableBluetoothResult = result

        let alertController = UIAlertController(
            title: "Enable Bluetooth",
            message: "Please enable Bluetooth in the device settings.",
            preferredStyle: .alert
        )

        let settingsAction = UIAlertAction(title: "Settings", style: .default) { _ in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: nil)
            }
        }
        alertController.addAction(settingsAction)

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            self.enableBluetoothResult = nil
        }
        alertController.addAction(cancelAction)

        let rootViewController = self.window?.rootViewController
        rootViewController?.present(alertController, animated: true, completion: nil)
    }

    // This method is called when the device's Bluetooth state changes
    override func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn, let result = enableBluetoothResult {
            result(nil)
            enableBluetoothResult = nil
        }
    }
}
