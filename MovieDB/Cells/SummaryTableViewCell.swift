//
//  SummaryTableViewCell.swift
//  MovieDB
//
//  Created by Punde, Rasika Nanasaheb on 02/11/20.
//  Copyright © 2020 Rasika Punde. All rights reserved.
//

import UIKit

class SummaryTableViewCell: UITableViewCell {
    static let cellId = "SummaryTableViewCell"
    
    @IBOutlet private weak var summaryTitleLabel: UILabel!
    @IBOutlet private weak var summaryLabel: UILabel!

    /// Set up UI cell
    /// - Parameter summaryText: Based on summary text update label
    func setUpView(summaryText: String) {
        summaryLabel.text = summaryText
        summaryLabel.font = .getGothicMediumFont(size: 16.0)
        summaryLabel.textColor = .darkGray
        summaryLabel.setLineSpacing(value: 4.0)

        summaryTitleLabel.text = NSLocalizedString("Overview.Title", comment: "")
        summaryTitleLabel.font = .getGothicBoldFont(size: 20.0)
        summaryTitleLabel.textColor = .black
    }
    
}
