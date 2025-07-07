import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let controller = window?.rootViewController as! FlutterViewController
    let channel = FlutterMethodChannel(name: "image_download", binaryMessenger: controller.binaryMessenger)
    
    channel.setMethodCallHandler { (call, result) in
      if call.method == "downloadAndResizeImage" {
        self.handleDownloadAndResize(call: call, result: result)
      } else {
        result(FlutterMethodNotImplemented)
      }
    }
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  private func handleDownloadAndResize(call: FlutterMethodCall, result: @escaping FlutterResult) {
    guard let args = call.arguments as? [String: Any],
          let urlString = args["url"] as? String,
          let fileName = args["fileName"] as? String,
          let url = URL(string: urlString) else {
      result(FlutterError(code: "BAD_ARGS", message: "Missing or invalid arguments", details: nil))
      return
    }

    DispatchQueue.global().async {
      do {
        let savedPath = try self.downloadResizeAndSaveImage(from: url, fileName: fileName)
        DispatchQueue.main.async {
          result(savedPath)
        }
      } catch {
        DispatchQueue.main.async {
          result(FlutterError(code: "ERROR", message: error.localizedDescription, details: nil))
        }
      }
    }
  }

  private func downloadResizeAndSaveImage(from url: URL, fileName: String) throws -> String {
    let data = try Data(contentsOf: url)
    guard let image = UIImage(data: data) else {
      throw NSError(domain: "decode", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to decode image"])
    }

    let newSize = CGSize(width: image.size.width / 2, height: image.size.height / 2)
    UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
    image.draw(in: CGRect(origin: .zero, size: newSize))
    let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()

    guard let finalImage = resizedImage,
          let imageData = finalImage.jpegData(compressionQuality: 0.9) else {
      throw NSError(domain: "resize", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to resize image"])
    }

    let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    let fileURL = documents.appendingPathComponent(fileName)
    try imageData.write(to: fileURL)
    
    print("Image saved at: \(fileURL.path)")
    return fileURL.path
  }
}
