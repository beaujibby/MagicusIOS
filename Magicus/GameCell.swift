//
//  GameCell.swift
//  Magicus
//
//  Created by Beamer Wilkins on 9/22/16.
//  Copyright © 2016 TRNSFR, Inc. All rights reserved.
//

import UIKit

class GameCell: UITableViewCell {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
