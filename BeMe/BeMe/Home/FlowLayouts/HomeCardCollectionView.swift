//
//  FollowingWholeCollectionView.swift
//  BeMe
//
//  Created by Yunjae Kim on 2021/01/12.
//

import UIKit

class HomeCardCollectionView: UICollectionView {

    private var reloadDataCompletionBlock: (() -> Void)?
    
    func reloadDataWithCompletion(_ complete: @escaping () -> Void) {
        reloadDataCompletionBlock = complete
        print("callled")
        super.reloadData()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let block = reloadDataCompletionBlock {
            block()
        }
    }
}
