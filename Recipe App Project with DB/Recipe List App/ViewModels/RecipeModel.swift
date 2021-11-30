//
//  RecipeModel.swift
//  Recipe List app
//
//  Created by Nemanja Velimirovic  on 2021-09-16.
//

import Foundation

class RecipeModel: ObservableObject {
    
    @Published var recipes = [Recipe]()
    
    
    init() {
        
        // Creates an instance of data service and get the data
        self.recipes = DataService.getLocalData()
    }
    
    static func getPortion(ingredient:Ingredient, recipeServings:Int, targetServings:Int) -> String {
        
        var portion = ""
        var numerator = ingredient.num
        var denominator = ingredient.denom
        var wholePortions = 0
        
                    
        // Gets a single serving size by multiplying denominator by the recipe servings
        denominator *= recipeServings
        
        // Gets target portion by multiplying numerator by target servings
        numerator *= targetServings
        
        // Reduces fraction by greatest common divisor
        let divisor = Rational.greatestCommonDivisor(numerator, denominator)
        numerator /= divisor
        denominator /= divisor
        
        // Gets the whole portion if numerator > denominator
        if numerator >= denominator {
            
            // Calculates whole portions
            wholePortions = numerator / denominator
            
            // Calculates the remainder
            numerator = numerator % denominator
            
            // Assignes to portion string
            portion += String(wholePortions)
        }
        
        // Expresses the remainder as a fraction
        if numerator > 0 {
            
            // Assignes remainder as fraction to the portion string
            portion += wholePortions > 0 ? " " : ""
            portion += "\(numerator)/\(denominator)"
        }
        
        
        
        if var unit = ingredient.unit {
            
            // If we need to pluralize
            if wholePortions > 1 {
            
                // Calculates appropriate suffix
                if unit.suffix(2) == "ch" {
                    unit += "es"
                }
                else if unit.suffix(1) == "f" {
                    unit = String(unit.dropLast())
                    unit += "ves"
                }
                else {
                    unit += "s"
                }
            }
            
            portion += ingredient.num == nil && ingredient.denom == nil ? "" : " "
            
            return portion + unit
        }
        
        return portion
    }
}
