//
//  DiffThoughtTVC.swift
//  BeMe
//
//  Created by 이재용 on 2021/01/08.
//

import UIKit

class DiffThoughtTVC: UITableViewCell {
    static let identifier: String = "DiffThoughtTVC"
    
    @IBOutlet weak var diffThoughtCollectionView: UICollectionView!
    
    weak var delegate: UITableViewButtonSelectedDelegate?
    
    private var currentIndex: CGFloat = 0
    
    private var isOneStepPaging = true
    
    var exploreThoughtArray: [ExploreThoughtData] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setThoughtCollectionView()
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    private func setThoughtCollectionView() {
        
        //        diffThoughtCollectionView.decelerationRate = .fast
        //        diffThoughtCollectionView.isPagingEnabled = false
        //        print("width: \(UIScreen.main.bounds.width)")
        //        print(self.frame.height)
        //        let cellWidth: CGFloat = UIScreen.main.bounds.width - 55.0
        //        let cellHeight: CGFloat = 229.0 // 상하, 좌우 inset value 설정
        //        let insetX = (UIScreen.main.bounds.width - cellWidth) / 2.0
        //        let layout = diffThoughtCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        //        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        //        layout.minimumLineSpacing = 12.0
        //        layout.scrollDirection = .horizontal
        //        diffThoughtCollectionView.contentInset = UIEdgeInsets(top: 16.0, left: insetX, bottom:  30.0, right: insetX)
        diffThoughtCollectionView.delegate = self
        diffThoughtCollectionView.dataSource = self
        
        let cellWidth: CGFloat = UIScreen.main.bounds.width - 55.0
        print(diffThoughtCollectionView.frame.width)
        let cellHeight: CGFloat = cellWidth * 229.0 / 320.0
        
        // 상하, 좌우 inset value 설정
        let insetX: CGFloat = (UIScreen.main.bounds.width - cellWidth) / 2.0
        let lineSpacing: CGFloat = 12.0
        
        let layout = diffThoughtCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        layout.minimumLineSpacing = lineSpacing
        layout.scrollDirection = .horizontal
        diffThoughtCollectionView.contentInset = UIEdgeInsets(top: 16, left: insetX, bottom: 30, right: insetX)
        
        diffThoughtCollectionView.decelerationRate = UIScrollView.DecelerationRate.fast
        
        print(diffThoughtCollectionView.contentInset)
        print((diffThoughtCollectionView.collectionViewLayout as! UICollectionViewFlowLayout).minimumLineSpacing)
    }
    
    
    @IBAction func friendButtonTapped(_ sender: Any) {
    }
    @IBAction func alarmButtonTapped(_ sender: Any) {
    }
}

extension DiffThoughtTVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let card = collectionView.dequeueReusableCell(withReuseIdentifier: DiffThoughtCVC.identifier, for: indexPath) as? DiffThoughtCVC else { return UICollectionViewCell() }
        
        card.makeRounded(cornerRadius: 6.0)
        
        return card
    }
    
}

extension DiffThoughtTVC: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.x)
    }
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>)
    {
        if scrollView == diffThoughtCollectionView {
            let layout = self.diffThoughtCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
            let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
            
            var offset = targetContentOffset.pointee
            let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
            var roundedIndex = round(index)
            
            if scrollView.contentOffset.x > targetContentOffset.pointee.x {
                roundedIndex = floor(index)
            } else if scrollView.contentOffset.x < targetContentOffset.pointee.x {
                roundedIndex = ceil(index)
            } else {
                roundedIndex = round(index)
            }
            
            if isOneStepPaging {
                if currentIndex > roundedIndex {
                    currentIndex -= 1
                    roundedIndex = currentIndex
                } else if currentIndex < roundedIndex {
                    currentIndex += 1
                    roundedIndex = currentIndex
                }
            }
            
            offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: -scrollView.contentInset.top)
            targetContentOffset.pointee = offset
        }
        
        
    }
}
