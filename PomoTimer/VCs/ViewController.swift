//
//  ViewController.swift
//  PomoTimer
//
//  Created by Kovs on 19.04.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // scrollView.isScrollEnabled = true
        scrollView.bounces = true
        scrollView.alwaysBounceVertical = true
        
        
        
    }


}

