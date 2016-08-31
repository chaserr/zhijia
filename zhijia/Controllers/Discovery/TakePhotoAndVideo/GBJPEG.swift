//
//  GBJPEG.swift
//  zhijia
//
//  Created by 张浩 on 16/5/18.
//  Copyright © 2016年 Beijing tongxing Technology Development Co., Ltd. All rights reserved.
//

import UIKit
import MobileCoreServices
import ImageIO

class GBJPEG: NSObject {

    
    
    private let kFigAppleMakerNote_AssetIdentifier = "17"
    private let path : String
    
    init(path : String) {
        self.path = path
    }
    
    func read() -> String? {
        guard let makerNote = metadata()?.objectForKey(kCGImagePropertyMakerAppleDictionary) as! NSDictionary? else {
            return nil
        }
        return makerNote.objectForKey(kFigAppleMakerNote_AssetIdentifier) as! String?
    }
    
    func write(dest : String, assetIdentifier : String) {
        guard let dest = CGImageDestinationCreateWithURL(NSURL(fileURLWithPath: dest), kUTTypeJPEG, 1, nil)
            else { return }
        defer { CGImageDestinationFinalize(dest) }
        guard let imageSource = self.imageSource() else { return }
        guard let metadata = self.metadata()?.mutableCopy() as! NSMutableDictionary! else { return }
        
        let makerNote = NSMutableDictionary()
        makerNote.setObject(assetIdentifier, forKey: kFigAppleMakerNote_AssetIdentifier)
        metadata.setObject(makerNote, forKey: kCGImagePropertyMakerAppleDictionary as String)
        CGImageDestinationAddImageFromSource(dest, imageSource, 0, metadata)
    }
    
    private func metadata() -> NSDictionary? {
        return self.imageSource().flatMap {
            CGImageSourceCopyPropertiesAtIndex($0, 0, nil) as NSDictionary?
        }
    }
    
    private func imageSource() ->  CGImageSourceRef? {
        return self.data().flatMap {
            CGImageSourceCreateWithData($0, nil)
        }
    }
    
    private func data() -> NSData? {
        return NSData(contentsOfFile: path)
    }
}
