//
//  ToDoCellTableViewCell.swift
//  ToDoList
//
//  Created by Wolfpack Digital on 03.08.2021.
//

import UIKit

protocol ToDoCellDelegate: AnyObject
{
    func checkmarkTapped(sender: ToDoCellTableViewCell)
}


class ToDoCellTableViewCell: UITableViewCell
{

    weak var delegate: ToDoCellDelegate?

    
    @IBOutlet var isCompleteButton: UIButton!
    @IBOutlet var titleLabel: UILabel!
  
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func completeButtonTapped(_ sender: UIButton)
    {
        delegate?.checkmarkTapped(sender: self)
    }
    
}
