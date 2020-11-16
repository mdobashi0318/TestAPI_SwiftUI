//
//  UserViewModel.swift
//  TestAPI_SwiftUI
//
//  Created by 土橋正晴 on 2020/11/14.
//

import Foundation


class UserViewModel: ObservableObject {

    @Published var model: [UsersModel] = []
    
    init() {
        fetchAllUser(success: {
            
        }, failure: { _ in
            
        })
    }
   
    func fetchAllUser(success: @escaping()->(), failure: @escaping(String?)->()) {
        
        UsersModel.fetchUsers() { result, error in
            
            if let _error = error {
                print("Error: \(_error)")
                failure("エラーが発生しました")
                return
            }
            
            self.model = result
            success()
        }
    }
    
    
    func postUser(name: String, text: String, imageStr: String, success: @escaping()->(), failure: @escaping(String?)->()) {
        
        if name == "" {
            failure("名前が入力されていません")
            return
        }
        
        if text == "" {
            failure("テキストが入力されていません")
            return
        }
        
        
        UsersModel.postRequest(name: name, text: text, image: imageStr) { error in
            if error != nil {
                failure("エラーが発生しました")
                return
            }
            success()
        }
    }
    
}
