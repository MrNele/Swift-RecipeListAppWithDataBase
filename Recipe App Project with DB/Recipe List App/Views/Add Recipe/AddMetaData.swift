//
//  AddMetaData.swift
//  Recipe List App
//
//  Created by iMac on 2.12.21..
//

import SwiftUI

struct AddMetaData: View {
    
    @Binding var name: String
    @Binding var summary: String
    @Binding var prepTime: String
    @Binding var cookTime: String
    @Binding var totalTime: String
    @Binding var servings: String
    
    var body: some View {
       
        Group {
                       
            HStack {
                Text("Name: ")
                    .bold()
                TextField("Tuna Casserola", text: $name)
            }
            
            HStack {
                Text("Summary: ")
                    .bold()
                TextField("A delicious meal for the whole family", text: $summary)
            }
            
            HStack {
                Text("Prep time: ")
                    .bold()
                TextField("1 hour", text: $prepTime)
            }
            
            HStack {
                Text("Cook time: ")
                    .bold()
                TextField("2 hours", text: $cookTime)
            }
            
            HStack {
                Text("Total time: ")
                    .bold()
                TextField("3 hours", text: $totalTime)
            }
            
            HStack {
                Text("Servings: ")
                    .bold()
                TextField("6", text: $servings)
            }
        }
    }
}
