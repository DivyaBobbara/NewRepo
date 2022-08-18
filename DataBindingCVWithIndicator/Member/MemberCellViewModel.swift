//
//  MemberCellViewModel.swift
//  DataBindingCVWithIndicator
//
//  Created by Naga Divya Bobbara on 18/08/22.
//

import Foundation
class MemberCellViewModel:RowViewModel{
    var isLoading : Observable<Bool>
    var updateButtonPressed : (()->Void)?
    init(isLoading : Observable <Bool> = Observable<Bool>(value: false),
         updateButtonPressed: (()->Void)? = nil){
        self.isLoading = isLoading
        self.updateButtonPressed = updateButtonPressed
    }
    
}
