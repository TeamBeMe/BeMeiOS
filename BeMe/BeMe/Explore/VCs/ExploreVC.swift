//
//  ExploreVC.swift
//  BeMe
//
//  Created by 이재용 on 2020/12/30.
//

import UIKit

class ExploreVC: UIViewController {

    //MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()

        adjustScrollViewInset()
    }

    
    //MARK: - IBOulets
    @IBOutlet weak var exploreScrollView: UIScrollView!
    @IBOutlet weak var highLightBar: UIView!
    @IBOutlet weak var highLightBarLeading: NSLayoutConstraint!
    
    //MARK: - IBActions

    @IBAction func recentButtonTapped(_ sender: UIButton) {
        moveHighLightBar(to: sender)
    }
    @IBAction func favoriteButtonTapped(_ sender: UIButton) {
        moveHighLightBar(to: sender)
    }
}

extension ExploreVC {
    //MARK: - private Method
    
    private func moveHighLightBar(to button: UIButton) {
        
        UIView.animate(withDuration: 0.2, delay: 0, options: [.curveLinear], animations: {
            
            // Slide Animation
            self.highLightBar.frame.origin.x = 30 + button.frame.minX
            
            // FadeIn Animation
            //self.highLightBarLeading.constant = 30 + button.frame.minX
        }) { _ in
            
        }
    }

    private func adjustScrollViewInset() {
        if #available(iOS 11.0, *) {
            exploreScrollView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        
    }
}

extension ExploreVC: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        print("~~~> offset\(exploreScrollView.contentOffset)")
    }
    
}
