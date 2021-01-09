//
//  MypageCVFlowLayout.swift
//  BeMe
//
//  Created by 박세란 on 2021/01/07.
//

import UIKit

class MypageCVFlowLayout: UICollectionViewFlowLayout {
    
    var mypageCRVDelegate: MypageCRVDelegate?
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let layoutAttributes = super.layoutAttributesForElements(in: rect)
        guard let offset = collectionView?.contentOffset, let stLayoutAttributes = layoutAttributes else {
            return layoutAttributes
        }
        if offset.y < 0 {
            
            for attributes in stLayoutAttributes {
                if let elmKind = attributes.representedElementKind, elmKind == UICollectionView.elementKindSectionHeader {
                    
                    let diffValue = abs(offset.y)
                    var frame = attributes.frame //현재 프레임 받음
                    frame.size.height = max(0, 393 + diffValue)
                    frame.origin.y = frame.minY - diffValue
                    attributes.frame = frame
                }
            }
        }
        
//        else {
//
//            for attributes in stLayoutAttributes {
//
//                if let elmKind = attributes.representedElementKind, elmKind == UICollectionView.elementKindSectionHeader {
//
//                    if offset.y >= 290 {
//                        mypageCRVDelegate?.headerFix()
//                        self.sectionHeadersPinToVisibleBounds = true
//                    } else {
//                        print("========else=======")
//                        mypageCRVDelegate?.headerOrigin()
//                        self.sectionHeadersPinToVisibleBounds = false
//                    }
//
//                }
//            }
//
//        }
        
        return layoutAttributes
    }
    
}
