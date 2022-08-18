//
//  Observable.swift
//  DataBindingCVWithIndicator
//
//  Created by Naga Divya Bobbara on 18/08/22.
//

import Foundation
class Observable<T>{
    var value : T {
        didSet{
            valueChanged?(value)
        }
    }
    
    init(value : T){
        self.value = value
    }
    private var valueChanged  : ((T)->())?
    func addObserver(valueChanged : ((T)->())?){
        self.valueChanged = valueChanged
    }
    
    
}
