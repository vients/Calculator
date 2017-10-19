//
//  AdditionViewController.swift
//  Calculator
//
//  Created by Yurii Vients on 10/9/17.
//  Copyright © 2017 Yurii Vients. All rights reserved.
//

import UIKit

class ScrollViewController: UIViewController,UIScrollViewDelegate,InputInterface {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
     var delegate: InputDelegate?
//    var brain = Brain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        
        //pageControl.currentPage = 0
        view.bringSubview(toFront: pageControl)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func symbolPressed(_ symbol: String) {
        delegate?.enterDigit(symbol)
        print("asaad\(symbol)")
    }
    
    @IBAction func tapOnScrollView(_ sender: UIButton) {
        
        symbolPressed(sender.currentTitle!)
//        print(sender.currentTitle!)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let pageIndex = round(scrollView.contentOffset.x / view.frame.width)
        pageControl.currentPage = Int(pageIndex)
    }
}
