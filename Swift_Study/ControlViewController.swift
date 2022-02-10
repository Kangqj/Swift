//
//  ViewController.swift
//  Swift_Study
//
//  Created by james on 2022/2/10.
//

import UIKit

class ControlViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var nameLab: UILabel!
    @IBOutlet weak var mBtn: UIButton!
    @IBOutlet weak var mImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func clickAction(_ sender: Any) {
        NSLog("123456");
        nameLab.text = nameField.text;
        mImageView.image = UIImage(named: "icons8-dog-60");
    }
    
    static func instantiate() -> ControlViewController
    {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ControlViewController") as! ControlViewController
    }
}

