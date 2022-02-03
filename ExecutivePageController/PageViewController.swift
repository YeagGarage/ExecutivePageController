//
//  PageViewController.swift
//  ExecutivePageController
//
//  Created by dmitriy.gribenuk on 02.02.2022.
import Foundation
import UIKit


class PageViewController: UIPageViewController {
    
    private var pages: [PageModel] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
        for i in 1...3 {
            self.pages.append(PageModel(title: "Title \(i)", subTitle: "Subtitle \(i)", image: ""))
        }
        */
        
        self.pages.append(PageModel(title: "Welcome", subTitle: "To Onboarding ", image: "1"))
        self.pages.append(PageModel(title: "Getting Started", subTitle: "Manage your self", image: "2"))
        self.pages.append(PageModel(title: "Easy to use", subTitle: "Any project ", image: "3"))
        
        self.dataSource = self
        
        self.preparePages()
    }
    
    
    func preparePages() {
        self.setViewControllers([self.pages.map( { model in
            return OnboardingViewController.load(with: model)
        }).first!], direction: .forward, animated: true, completion: nil)
    }
}




extension PageViewController: UIPageViewControllerDataSource {
    
    
    func forCutomPageOnly(viewController: UIViewController, doNext: @escaping(PageModel?) -> Void) {
        if let onBoardVC = viewController as? OnboardingViewController {
            doNext(onBoardVC.model)
        }
    }
    
    
    func index(before index: Int) -> Int? {
        if index > 0 && index < self.pages.count - 1 {
            return index + 1
        }
        return nil
    }
    
    
    func index(after index: Int) -> Int? {
        if index >= 0 && index < self.pages.count - 1 {
            return index + 1
        }
        return nil
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var vc: UIViewController?
        
        self.forCutomPageOnly(viewController: viewController) { [ weak self ] currentPage in
            guard let strSelf = self else { return }
            if let currentPage = currentPage , let currentIndex = strSelf.pages.firstIndex(of: currentPage), let previousIndex = self?.index(before: currentIndex)  {
                vc = OnboardingViewController.load(with: strSelf.pages[previousIndex])
            }
        }
        return vc
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var vc: UIViewController?
        
        self.forCutomPageOnly(viewController: viewController) { [ weak self ] currentPage in
            guard let strSelf = self else { return }
            if let currentPage = currentPage , let currentIndex = strSelf.pages.firstIndex(of: currentPage), let nextIndex = self?.index(after: currentIndex)  {
                vc = OnboardingViewController.load(with: strSelf.pages[nextIndex])
            }
        }
        return vc
    }
}
