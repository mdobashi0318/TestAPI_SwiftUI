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
    
    var addButton: some View {
        Button(action: {
            isInputView.toggle()
        }, label: {
            Image(systemName: "plus")
        })
        .sheet(isPresented: $isInputView, content: {
            InputUserView()
                .onDisappear {
                    viewModel.fetchAllUser()
                }
        })
    }
    
    
    var reloadButton: some View {
        Button(action: {
            self.viewModel.fetchAllUser()
        }, label: {
            Image(systemName: "arrow.clockwise")
        })
    }
    
    var body: some View {
        NavigationView {
            UserList(model: self.$viewModel.model)
                .listStyle(PlainListStyle())
                .navigationBarItems(leading: reloadButton, trailing: addButton)
                .onAppear {
                    viewModel.fetchAllUser()
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        UserListView(viewModel: UserViewModel())
    }
}
