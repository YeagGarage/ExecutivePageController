//
//  OnboardingViewController.swift
//  ExecutivePageController
//
//  Created by dmitriy.gribenuk on 02.02.2022.
import Foundation
import UIKit


class OnboardingViewController: UIViewController {
    
    
    @IBOutlet weak var onboardImages: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    
    var model: PageModel?
    
    
    static func load(with page: PageModel) -> OnboardingViewController {
        let pageViewController = OnboardingViewController.loadFromNib()
        pageViewController.model = page
        return pageViewController
    }
    
    
    static func loadFromNib() -> OnboardingViewController {
        return OnboardingViewController(nibName: "OnboardViewController", bundle: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let page = self.model {
            self.update(with: page)
        }
        
    }
    
    
    func update(with page: PageModel) {
        self.titleLabel.text = page.title
        self.subTitleLabel.text = page.subTitle
        if let imageName = page.image, let image = UIImage(named: imageName) {
            self.onboardImages.image = image
        }
    }
    
    
}
