import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let controller = window?.rootViewController as! FlutterViewController
    let channel = FlutterMethodChannel(
      name: "image_download",
      binaryMessenger: controller.binaryMessenger
    )

    channel.setMethodCallHandler { (call, result) in
      if call.method == "downloadAndResizeImage" {
        guard
          let args = call.arguments as? [String: String],
          let imageUrl = args["imageUrl"],
          let outputPath = args["outputPath"]
        else {
          result(
            FlutterError(
              code: "INVALID_ARGS",
              message: "Missing arguments",
              details: nil
            )
          )
          return
        }
        self.downloadAndResizeImage(
          imageUrl: imageUrl,
          outputPath: outputPath,
          result: result
        )
      } else {
        result(FlutterMethodNotImplemented)
      }
    }

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  private func downloadAndResizeImage(
    imageUrl: String,
    outputPath: String,
    result: @escaping FlutterResult
  ) {
    DispatchQueue.global(qos: .userInitiated).async {
      do {
        guard
          let url = URL(string: imageUrl),
          let data = try? Data(contentsOf: url),
          let image = UIImage(data: data)
        else {
          DispatchQueue.main.async {
            result(
              FlutterError(
                code: "DECODE_ERROR",
                message: "Failed to decode image",
                details: nil
              )
            )
          }
          return
        }

        let newSize = CGSize(
          width: image.size.width / 2,
          height: image.size.height / 2
        )
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: CGRect(origin: .zero, size: newSize))
        guard let resizedImage = UIGraphicsGetImageFromCurrentImageContext() else {
          UIGraphicsEndImageContext()
          DispatchQueue.main.async {
            result(
              FlutterError(
                code: "RESIZE_ERROR",
                message: "Failed to resize image",
                details: nil
              )
            )
          }
          return
        }
        UIGraphicsEndImageContext()

        if let jpegData = resizedImage.jpegData(compressionQuality: 0.8) {
          try jpegData.write(to: URL(fileURLWithPath: outputPath))
          DispatchQueue.main.async {
            result(outputPath)
          }
        } else {
          DispatchQueue.main.async {
            result(
              FlutterError(
                code: "SAVE_ERROR",
                message: "Failed to save image as JPEG",
                details: nil
              )
            )
          }
        }
      } catch {
        DispatchQueue.main.async {
          result(
            FlutterError(
              code: "PROCESSING_ERROR",
              message: error.localizedDescription,
              details: nil
            )
          )
        }
      }
    }
  }
}
