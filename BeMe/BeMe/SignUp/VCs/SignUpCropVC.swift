//
//  SignUpCropVC.swift
//  BeMe
//
//  Created by Yunjae Kim on 2021/01/08.
//

import UIKit

class SignUpCropVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var cropImage: UIImageView!
    var initialImage: UIImage?
    @IBOutlet weak var gridView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        gridView.setBorder(borderColor: .black, borderWidth: 1.0)
        gridView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        scrollView.delegate = self
        
        cropImage.image = initialImage
//        setupInitialZoomScale()
        scrollView.decelerationRate = .fast
    }
    
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        centerScrollViewContents()
    }

    private func centerScrollViewContents() {
        let frameHeight = cropImage.frame.size.height
        let frameWidth = cropImage.frame.size.width
        var point = CGPoint()
        if frameHeight < frameWidth {
            point.x = (frameWidth - scrollView.bounds.width)/2
        } else {
            
            point.y = (frameHeight - scrollView.bounds.height)/2
        }
        scrollView.setContentOffset(point, animated: false)
        scrollView.contentInset = UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30)
    }
    private func setupInitialZoomScale() {
        let scrollSize = self.scrollView.bounds.size
        if let imagesize = self.cropImage.image?.size {
            let widthRatio = scrollSize.width / imagesize.width
            let heightRatio = scrollSize.height / imagesize.height
            let minZoom = max(widthRatio, heightRatio)
            scrollView.minimumZoomScale = minZoom
            scrollView.zoomScale = minZoom
        }
    }

}

extension SignUpCropVC: UIScrollViewDelegate{
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return cropImage
    }

    
}
