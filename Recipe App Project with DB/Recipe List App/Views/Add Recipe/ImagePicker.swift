//
//  ImagePicker.swift
//  Recipe List App
//
//  Created by iMac on 5.12.21..
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    
    //**
    @Environment(\.presentationMode) var presentationMode
    //**
    
    var selectedSource: UIImagePickerController.SourceType
    
    @Binding var recipeImage: UIImage?
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        
        // Creates the image picker controller
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = context.coordinator
        imagePickerController.sourceType = selectedSource
        
        return imagePickerController
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        // Creates a coordinator
        Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        
        var parent: ImagePicker
        
        init(parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            // Checks if we can get the image
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
            {
                // We were able to get the uiImage into the image constant, pass this back to the AddRecipeView
                parent.recipeImage = image
                
                // Dismiss the view
                // first way
//                parent.isShowingImagePicker = false
                
                // second way
                //**
                parent.presentationMode.wrappedValue.dismiss()
            }
        }
    }
}
