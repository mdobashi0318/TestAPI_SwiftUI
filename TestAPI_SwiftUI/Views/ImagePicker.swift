//
//  ImagePicker.swift
//  TestAPI_SwiftUI
//
//  Created by 土橋正晴 on 2020/11/15.
//

import SwiftUI


struct ImagePicker: UIViewControllerRepresentable  {
    
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    @Binding var imageStr: String
    
    @Environment(\.presentationMode) private var presentationMode
    
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.sourceType = sourceType
        imagePicker.allowsEditing = true
        imagePicker.delegate = context.coordinator
        
        return imagePicker
    }
    
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        var parent: ImagePicker
        
        init(_ imagePicker: ImagePicker) {
            self.parent = imagePicker
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            let image = info[.originalImage] as! UIImage
            let imageData: Data = image.pngData()! as Data
            parent.imageStr = imageData.base64EncodedString(options: .lineLength64Characters)
            
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}


