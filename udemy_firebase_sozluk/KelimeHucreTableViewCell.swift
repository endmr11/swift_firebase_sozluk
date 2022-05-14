//
//  KelimeHucreTableViewCell.swift
//  udemy_firebase_sozluk
//
//  Created by Eren Demir on 14.05.2022.
//

import UIKit

class KelimeHucreTableViewCell: UITableViewCell {

    @IBOutlet weak var ingilizceLabel: UILabel!
    
    @IBOutlet weak var turkceLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
