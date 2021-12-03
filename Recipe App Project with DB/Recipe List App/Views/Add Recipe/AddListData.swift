//
//  AddListData.swift
//  Recipe List App
//
//  Created by iMac on 2.12.21..
//

import SwiftUI

struct AddListData: View {
    
    @Binding var list: [String]
    
    @State private var item: String = ""
    
    var title: String
    var placeholderText: String
    
    var body: some View {
        
        VStack (alignment: .leading){
            
            HStack {
        
                Text("\(title):")
                    .bold()
                
                TextField(placeholderText, text: $item)
            
                Button("Add") {
                    // Adds item to the list
                    if item.trimmingCharacters(in: .whitespacesAndNewlines) != "" {
                        
                        // Adds the item to the list
                        list.append(item.trimmingCharacters(in: .whitespacesAndNewlines))
                        
                        // Clears the text field
                        item = ""
                    }
                }
            }
            
            // List out the items added so far
            ForEach(list, id: \.self) { item in
                Text(item)
            }
        }
        
    }
}
