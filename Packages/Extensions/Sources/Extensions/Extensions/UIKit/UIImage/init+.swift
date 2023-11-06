//
//  init+.swift
//
//  Created by Ahmed Yamany on 22/10/2023.
//

import UIKit
// swiftlint:disable all
extension UIImage {
    /**
     Create an image of a solid color with the specified size.

     - Parameters:
       - color: The color to fill the image with.
       - size: The size of the resulting image. Default is 1x1 pixel.

     This convenience initializer creates a `UIImage` object filled with a solid color. You can specify the color and, optionally, the size of the image. If the size is not provided, the default size is 1x1 pixel.

     - Note: To create a `UIColor` object, you can use the `UIColor` initializer, such as `UIColor(red: 0.0, green: 0.5, blue: 1.0, alpha: 1.0)`.

     Example usage:

     ```swift
     let redImage = UIImage(color: UIColor.red, size: CGSize(width: 50, height: 50))
     ```

     - Parameters:
       - color: The color to fill the image with.
       - size: The size of the resulting image.

     - Returns: An instance of `UIImage` filled with the specified color, or `nil` if the image creation fails.
     */
    convenience public init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        // Create a CGRect with the specified size
        let rect = CGRect(origin: .zero, size: size)
        // Begin a graphics context with the specified size and scale
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        // Fill the entire context with the specified color
        color.setFill()
        UIRectFill(rect)
        // Get the image from the current graphics context
        let image = UIGraphicsGetImageFromCurrentImageContext()
        // End the graphics context
        UIGraphicsEndImageContext()
        // Check if the image was successfully created and get its CGImage
        guard let cgImage = image?.cgImage else { return nil }
        // Initialize the UIImage instance with the CGImage
        self.init(cgImage: cgImage)
    }
}
// swiftlint:enable all
