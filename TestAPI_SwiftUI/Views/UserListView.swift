//
//  UserListView.swift
//  TestAPI_SwiftUI
//
//  Created by 土橋正晴 on 2020/11/14.
//

import SwiftUI

struct UserListView: View {
    
    @ObservedObject var viewModel = UserViewModel()
    
    @State var isInputView: Bool = false
    
    @State var imageStr = ""
    
    var addButton: some View {
        Button(action: {
            isInputView.toggle()
        }, label: {
            Image(systemName: "plus")
        })
        .sheet(isPresented: $isInputView, content: {
            InputUserView(name: .constant(""), text: .constant(""), imageStr: $imageStr)
        })
    }
    
    var body: some View {
        NavigationView {
            UserList(model: .constant(self.viewModel.model))
                .listStyle(PlainListStyle())
                .navigationBarItems(trailing: addButton)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        UserListView(viewModel: UserViewModel())
    }
}
