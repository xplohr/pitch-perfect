//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Che-Chuen Ho on 3/12/15.
//  Copyright (c) 2015 Che-Chuen Ho. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject {
    var filePathUrl:NSURL!
    var title:String!
    
    init(fromPath filePath:NSURL!, fromFileName fileName: String!) {
        filePathUrl = filePath
        title = fileName
    }
}