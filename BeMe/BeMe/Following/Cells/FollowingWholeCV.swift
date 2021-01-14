//
//  FollowingWholeCollectionView.swift
//  BeMe
//
//  Created by Yunjae Kim on 2021/01/12.
//

import UIKit

class FollowingWholeCV: UICollectionView {

    private var reloadDataCompletionBlock: (() -> Void)?
    
    func reloadDataWithCompletion(_ complete: @escaping () -> Void) {
        reloadDataCompletionBlock = complete
        super.reloadData()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let block = reloadDataCompletionBlock {
            block()
        }
    }
}
