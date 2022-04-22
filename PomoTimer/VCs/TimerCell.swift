//
//  TimerCell.swift
//  PomoTimer
//
//  Created by Kovs on 19.04.2022.
//

import UIKit

class TimerCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var minutesLabel: UILabel!
    
    @IBOutlet weak var isMarked: UIImageView!
    
    func setName(timerName: String) {
        name.text = timerName
    }
    
    func setStar(isMarkedBool: Bool) {
        if isMarkedBool == false {
            isMarked.image = UIImage(systemName: "star.fill")?.withTintColor(.yellow)
        } else {
            isMarked.image = UIImage(systemName: "star")?.withTintColor(.gray)
        }
    }
    
    func setMinutes(min: Int) {
        lazy var minString = "\(min)"
        if min == 1 {
            minutesLabel.text = "1 minute"
        } else if minString.last == "1" {
            minutesLabel.text = "\(min) minute"
        } else {
            minutesLabel.text = "\(min) minutes"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}
