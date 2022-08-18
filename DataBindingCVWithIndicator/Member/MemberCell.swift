//
//  CollectionViewCell.swift
//  DataBindingCVWithIndicator
//
//  Created by Naga Divya Bobbara on 18/08/22.
//

import UIKit

class CollectionViewCell: UICollectionViewCell,CellConfigurable{
    
    @IBOutlet weak var likesButton: UIButton!
    
    @IBOutlet weak var likesCountLabel: UILabel!
    @IBOutlet weak var lblOutlet: UILabel!
    
    @IBOutlet weak var postDataLabelOutlet: UILabel!
    
    var viewModel = MemberCellViewModel()
    func setup(viewModel: RowViewModel) {
    guard let viewModel = viewModel as? MemberCellViewModel else { return }
        self.viewModel = viewModel
        
        
    }
    
}
