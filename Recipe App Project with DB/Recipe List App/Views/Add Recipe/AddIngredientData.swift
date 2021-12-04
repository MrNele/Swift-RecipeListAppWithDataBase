//
//  AddIngredientData.swift
//  Recipe List App
//
//  Created by iMac on 3.12.21..
//

import SwiftUI

struct AddIngredientData: View {
    
    @Binding var ingredients: [IngredientJSON]
    
    @State private var name = ""
    @State private var unit = ""
    @State private var num = ""
    @State private var denom = ""
    
    var body: some View {
        VStack (alignment: .leading){
            Text("Ingredients:")
                .bold()
                .padding(.top, 5)
            
            HStack {
                
                TextField("Sugar", text: $name)
                
                TextField("1", text: $num)
                    .frame(width: 20)
                
                Text("/")
                
                TextField("2", text: $denom)
                    .frame(width: 20)
                
                TextField("cups", text: $unit)
                
                Button("Add") {
                    
                    //  Make sure that the fields are populated
                    let cleanedName = name.trimmingCharacters(in: .whitespaces)
                    let cleanedNum = num.trimmingCharacters(in: .whitespaces)
                    let cleanedDenom = denom.trimmingCharacters(in: .whitespaces)
                    let cleanedUnit = unit.trimmingCharacters(in: .whitespaces)
                    
                    // Checks that all the fields are filled in
                    if cleanedName == "" || cleanedNum == "" || cleanedDenom == "" || cleanedUnit == ""{
                        return
                        
                    }
                    
                    // Creates an IngredientJSON object and sets its properties
                    let i  = IngredientJSON()
                    i.id = UUID()
                    i.name = cleanedName
                    i.num = Int(cleanedNum) ?? 1
                    i.denom = Int(cleanedDenom) ?? 1
                    i.unit = cleanedUnit
                    
                    // Adds this ingredient to the list
                    ingredients.append(i)
                    
                    // Clears text field
                    name = ""
                    num = ""
                    denom = ""
                    unit = ""
                }
            }
            
            ForEach(ingredients) { ingredient in
                Text("\(ingredient.name), \(ingredient.num ?? 1)/\(ingredient.denom ?? 1) \(ingredient.unit ?? "")")
            }
        }
    }
}
