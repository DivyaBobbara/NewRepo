//
//  CVListViewController.swift
//  DataBindingCVWithIndicator
//
//  Created by Naga Divya Bobbara on 18/08/22.
//

import Foundation
import Alamofire
class CVListViewController{
    let viewModel  : GetPostsListViewModel
    init(viewModel : GetPostsListViewModel = GetPostsListViewModel()){
        self.viewModel = viewModel
    }
    
    func start()
    {
        viewModel.isLoading.value = true
        viewModel.isTableViewHidden.value = true
        viewModel.title.value = "Loading...."
        apiCall()
    }
    func apiCall()
    {
        DispatchQueue.global().async {
            sleep(3)
            AF.request("http://stagetao.gcf.education:3000/api/v1/posts/5", method: .get, parameters: nil,headers: nil).responseDecodable(of: GetPosts.self) { response in
                print(response)
                self.viewModel.isLoading.value = false
                self.viewModel.isTableViewHidden.value = false
                self.viewModel.title.value = "Get Posts UserNames"
                self.viewModel.userLists.value = (response.value?.data?.compactMap({
                    TableViewCellViewModel(userName: $0.userName ?? "")
                }))!
               
            }
        }
    }
}
