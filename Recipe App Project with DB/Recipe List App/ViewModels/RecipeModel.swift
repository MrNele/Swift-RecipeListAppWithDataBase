//
//  RecipeModel.swift
//  Recipe List app
//
//  Created by Nemanja Velimirovic  on 2021-09-16.
//

import Foundation
import UIKit

class RecipeModel: ObservableObject {
    
    // References to the managed object context
    let managedObjectContext = PersistenceController.shared.container.viewContext
    
    @Published var recipes = [Recipe]()
    
    init() {
        
//        // Creates an instance of data service and get the data
//        self.recipes = DataService.getLocalData()
        
        // Checks if we have preloaded the data into core data
        checkLoadedData()
    }
    
    func checkLoadedData() {
        
        // Checks local storage for the flag
        let status = UserDefaults.standard.bool(forKey: Constants.isDataPreloaded)
    
        // If it is false, then we should parse the local json and preload into Core Data
        if status == false {
            preloadLocalData()
        }
    }
    
    func preloadLocalData(){
        
        // Parses the local JSON file
        let localRecipes = DataService.getLocalData()
        
        // Creates Core Data objects
        for r in localRecipes {
            
            // Creates a core data object
            let recipe = Recipe(context: managedObjectContext)
            
            // Sets its properties
            recipe.cookTime = r.cookTime
            recipe.directions = r.directions
            recipe.featured = r.featured
            recipe.highlights = r.highlights
            recipe.id = UUID()
            recipe.image = UIImage(named: r.image)?.jpegData(compressionQuality: 1.0)
            recipe.name = r.name
            recipe.prepTime = r.prepTime
            recipe.servings = r.servings
            recipe.summary = r.description
            recipe.totalTime = r.totalTime
            
            
            // sets the ingredients for them we need to user for loop
            for i in r.ingredients {
                
                // Creates a core data ingredient object
                let ingredient = Ingredient(context: managedObjectContext)
                
                ingredient.id = UUID()
                ingredient.name = i.name
                ingredient.unit = i.unit
                ingredient.num = i.num ?? 1
                ingredient.denom = i.denom ?? 1
                
                // Adds this ingredient to the recipe
                recipe.addToIngredients(ingredient)
            }
        }
        
        // Saves into Core Data
        do {
        try managedObjectContext.save()
            
            // Sets local storage flag
            UserDefaults.standard.setValue(true, forKey: Constants.isDataPreloaded)
        } catch {
            // Couln't save to core data
        }
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
    


