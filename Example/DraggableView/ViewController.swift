//
//  ViewController.swift
//  DraggableView
//
//  Created by IsaacDouglas on 12/17/2019.
//  Copyright (c) 2019 IsaacDouglas. All rights reserved.
//

import UIKit
import DraggableView

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let infoViewController = DraggableViewController()
        infoViewController.addMasterViewController(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

