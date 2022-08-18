//
//  Model.swift
//  DataBindingCVWithIndicator
//
//  Created by Naga Divya Bobbara on 18/08/22.
//

import Foundation
struct GetPosts:Codable{
    let status : String?
    let data : [GetPostsData]?
}
struct GetPostsData:Codable{
    let userName : String?
}
