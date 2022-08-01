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
}
