//
//  UserListView.swift
//  TestAPI_SwiftUI
//
//  Created by 土橋正晴 on 2020/11/14.
//

import SwiftUI

struct UserListView: View {
    
    @ObservedObject var viewModel = UserViewModel()
    
    var body: some View {
        NavigationView {
            List {
                if self.viewModel.model.count == 0 {
                    Text("ユーザが見つかりませんでした")
                } else {
                    ForEach(0..<self.viewModel.model.count, id: \.self) { row in
                        Text(viewModel.model[row].name!)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        UserListView()
    }
}
