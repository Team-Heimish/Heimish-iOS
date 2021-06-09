//
//  SplashVC.swift
//  Heimish-iOS
//
//  Created by Wonseok Lee on 2021/06/09.
//

import UIKit

class SplashVC: UIViewController {

    @IBOutlet weak var logoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logoImageView.makeRounded(cornerRadius: nil)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let homeVC = (self.storyboard?.instantiateViewController(identifier: "HomeVC"))! as HomeVC
            self.navigationController?.pushViewController(homeVC, animated: true)
        }
    }
}
