//
//  DetailsUserView.swift
//  TestAPI_SwiftUI
//
//  Created by 土橋正晴 on 2020/11/19.
//

import SwiftUI

struct DetailsUserView: View {
    
    @Binding var model: UsersModel
    
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
            print("編集画面")
        }, label: {
            Image(systemName: "plus")
        })
    }
    
    
    var textSection: some View {
        Section(header: Text("テキスト"), content: {
            Text(model.text ?? "")
        })
    }
    
    
    var imageSection: some View {
        Section(header: Text("画像"), content: {
            Button(action: {
                print("画像の拡大表示")
            }, label: {
                Image.setImage(imageStr: model.image)
                    .resizable()
                    .frame(width: 50, height: 50)
            })
            .frame(width: 50, height: 50)
        })
    }
    
}



struct DetailsUserView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailsUserView(model: .constant(testUser[0]))
        }
    }
}
