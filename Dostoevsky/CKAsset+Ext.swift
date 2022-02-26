//
//  CKAsset+Ext.swift
//  Dostoevsky
//
//  Created by Julian Gierl on 22.02.22.
//

import CloudKit
import UIKit

extension CKAsset{
    func convertToUIImage() -> UIImage {
        
        let placeholder = PlaceholderImage.banner
        
        guard let fileUrl = self.fileURL else { return placeholder }
        do{
            let data = try Data(contentsOf: fileUrl)
            return UIImage(data: data) ?? placeholder
        }catch{
            return placeholder
        }
    }
}
