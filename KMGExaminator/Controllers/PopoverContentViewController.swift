//
//  PopoverContentViewController.swift
//  KMGExaminator
//
//  Created by Alexey Tsymlov on 2/22/15.
//  Copyright (c) 2015 Alexey Tsymlov. All rights reserved.
//

import UIKit

class PopoverContentViewController: UIViewController {
    @IBOutlet weak var group: UITextField!
    @IBOutlet weak var level: UITextField!

    override func viewDidLoad() {
        self.preferredContentSize = CGSizeMake(320.0,200.0)
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


}
