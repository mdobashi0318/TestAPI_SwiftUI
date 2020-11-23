//
//  DetailsUserView.swift
//  TestAPI_SwiftUI
//
//  Created by 土橋正晴 on 2020/11/19.
//

import SwiftUI

struct DetailsUserView: View {
    
    @State var model: UsersModel
    
    @State var isInputView: Bool = false
    
    var body: some View {
        List {
            textSection
            imageSection
                .navigationTitle(model.name ?? "")
                .navigationBarItems(trailing: addButton)
        }
    }
}


// MARK: - UI作成

extension DetailsUserView {
    
    var addButton: some View {
        Button(action: {
            self.isInputView.toggle()
        }, label: {
            Image(systemName: "plus")
        })
        .sheet(isPresented: $isInputView) {
            InputUserView(id: self.model.id,
                          name: self.model.name ?? "",
                          text: self.model.text ?? "",
                          imageStr: self.model.image ?? "",
                          isUpdate: true
            )
            .onDisappear {
                UserViewModel().fetchUser(id: model.id, success: { user in
                    self.model = user
                })
            }
        }
    }
    
    
    var textSection: some View {
        Section(header: Text("テキスト"), content: {
            Text(model.text ?? "")
        })
    }
    
    
    var imageSection: some View {
        Section(header: Text("画像"), content: {
            Button(action: {
                // TODO: 今後追加予定
                print("画像の拡大表示")
            }, label: {
                Image.setImage(imageStr: model.image)
                    .resizable()
                    .frame(width: 50, height: 50)
            })
        })
    }
    
}



struct DetailsUserView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailsUserView(model: testUser[0])
        }
    }
}
