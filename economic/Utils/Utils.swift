//
//  Utils.swift
//  economic
//
//  Created by José Rodrigues on 01/08/2022.
//

import Foundation
import UIKit

class Utils{
    static func savePNGImage(image: UIImage, filename: String = (UUID().uuidString + ".png"))-> String{
        
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        
        let fileURL = URL(fileURLWithPath: documentDirectory).appendingPathComponent(filename)
        
        let data = image.pngData()
        
        do{
            try data?.write(to: fileURL)
        }catch{
            return String()
        }
        
        return filename
    }
    
    static func loadPNGImage(filename: String)-> UIImage?{
        
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        
        let fileURL = URL(fileURLWithPath: documentDirectory).appendingPathComponent(filename)
        
        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: fileURL.path) {
            NSLog("FILE NOT AVAILABLE")
            return nil
        }
        
        return UIImage(contentsOfFile: fileURL.path)
    }
    
    static func fixRotation(image: UIImage) -> UIImage {
        if (image.imageOrientation == .up) {
            return image
        }
        
        var transform = CGAffineTransform.identity
        switch (image.imageOrientation) {
        case .down, .downMirrored:
            transform = transform.translatedBy(x: image.size.width, y: image.size.height)
            transform = transform.rotated(by: .pi)
            
        case .left, .leftMirrored:
            transform = transform.translatedBy(x: image.size.width, y: 0)
            transform = transform.rotated(by: .pi / 2)
            
        case .right, .rightMirrored:
            transform = transform.translatedBy(x: 0, y: image.size.height)
            transform = transform.rotated(by: -(.pi / 2))
            
        default:
            break
        }
        
        switch (image.imageOrientation) {
        case .upMirrored, .downMirrored:
            transform = transform.translatedBy(x: image.size.width, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
            
        case .leftMirrored, .rightMirrored:
            transform = transform.translatedBy(x: image.size.height, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
            
        default:
            break
        }
        
        let ctx = CGContext(data: nil, width: Int(image.size.width),
                            height: Int(image.size.height),
                            bitsPerComponent: image.cgImage!.bitsPerComponent,
                            bytesPerRow: 0,
                            space: image.cgImage!.colorSpace!,
                            bitmapInfo: image.cgImage!.bitmapInfo.rawValue)
        ctx!.concatenate(transform)
        switch image.imageOrientation {
        case .left, .leftMirrored, .right, .rightMirrored:
            ctx!.draw(image.cgImage!, in: CGRect(x: 0, y: 0, width: image.size.height, height: image.size.width))
        default:
            ctx!.draw(image.cgImage!, in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
            break
        }
        
        let cgimg: CGImage = ctx!.makeImage()!
        let img = UIImage(cgImage: cgimg)
        return img
    }
}
