//
//  StorageFloatingVC.swift
//  Heimish-iOS
//
//  Created by Wonseok Lee on 2021/06/09.
//

import UIKit
import RealmSwift

class StorageFloatingVC: UIViewController {
    let realm = try? Realm()
    var idx: Int = 0
    
    @IBOutlet weak var floatingBtn: UIButton!
    @IBOutlet weak var complainingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        floatingBtn.makeRounded(cornerRadius: nil)
        if let complaining = realm?.objects(Counseiling.self).filter("idx = \(idx)").first?.complaining {
            complainingLabel.text = complaining
        } else {
            complainingLabel.text = "해당 상담은 속마음 기록을 OFF 하셨었네요!"
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
