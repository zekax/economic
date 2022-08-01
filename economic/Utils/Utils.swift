//
//  Utils.swift
//  economic
//
//  Created by José Rodrigues on 01/08/2022.
//

import Foundation
import UIKit

class Utils{
    static func savePNGImage(image: UIImage)-> String{
        
        let filename:String = UUID().uuidString + ".png"
        
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        
        let fileURL = URL(fileURLWithPath: documentDirectory).appendingPathComponent(filename)
        
        let data = image.pngData()
        try? data?.write(to: fileURL)
        
        return fileURL.absoluteString
    }
    
    static func loadPNGImage(path: String)-> UIImage{
        
        let filename:String = UUID().uuidString + ".png"
        
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        
        let fileURL = URL(fileURLWithPath: documentDirectory).appendingPathComponent(filename)
        
        let data = image.pngData()
        try? data?.write(to: fileURL)
        
        return fileURL.absoluteString
    }
}
