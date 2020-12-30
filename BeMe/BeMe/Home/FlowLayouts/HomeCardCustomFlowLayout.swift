//
//  HomeCardCustomFlowLayout.swift
//  BeMe
//
//  Created by Yunjae Kim on 2020/12/30.
//

import UIKit

class HomeCardCustomFlowLayout: UICollectionViewFlowLayout {
    private var isInit: Bool = false
    
    override func prepare() {
        super.prepare()
        guard !isInit else { return }
        
        guard let collectionView = self.collectionView else { return }
        
        let collectionViewSize = collectionView.bounds
        itemSize = CGSize(width: collectionViewSize.width-50*2, height: 150)
        
        let xInset = (collectionViewSize.width-itemSize.width) / 2
        self.sectionInset = UIEdgeInsets(top: 0, left: xInset, bottom: 0, right: xInset)
        
        scrollDirection = .horizontal
        
        minimumLineSpacing = 10 - (itemSize.width - itemSize.width*0.7)/2
        
        isInit = true
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let superAttributes = super.layoutAttributesForElements(in: rect)
        
        superAttributes?.forEach { attributes in
            guard let collectionView = self.collectionView else { return }
            
            let collectionViewCenter = collectionView.frame.size.width / 2
            let offsetX = collectionView.contentOffset.x
            let center = attributes.center.x - offsetX
            
            let maxDis = self.itemSize.width + self.minimumLineSpacing
            let dis = min(abs(collectionViewCenter-center), maxDis)
            
            let ratio = (maxDis - dis)/maxDis
            let scale = ratio * (1-0.8) + 0.8
            
            attributes.transform = CGAffineTransform(scaleX: 1, y: scale)
        }
        
        return superAttributes
    }
    
    
    
}
