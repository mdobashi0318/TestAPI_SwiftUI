//
//  Image_Extension.swift
//  TestAPI_SwiftUI
//
//  Created by 土橋正晴 on 2020/11/15.
//

import SwiftUI

extension Image {
    
    static func setImage(imageStr: String?) -> Image {
        guard let imageStr = imageStr,
              let data = Data(base64Encoded: imageStr, options: .ignoreUnknownCharacters),
              let image = UIImage(data: data) else {
            
            return Image(systemName: "photo")
        }
        
        return Image(uiImage: image)
    }
}


