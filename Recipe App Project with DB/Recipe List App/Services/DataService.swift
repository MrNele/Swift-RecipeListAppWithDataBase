//
//  DataService.swift
//  Recipe List app
//
//  Created by Nemanja Velimirovic  on 2021-09-16.
//

import Foundation

class DataService {
    
    static func getLocalData() -> [RecipeJSON] {
        
        
        // Parses local json file
        
        // Gets a url path to the json file
        let pathString = Bundle.main.path(forResource: "recipes", ofType: "json")
        
        // Checks if pathString is not nil, otherwise...
        guard pathString != nil else {
            return [RecipeJSON]()
        }
        
        // Creates a url object
        let url = URL(fileURLWithPath: pathString!)
        
        do {
            // Creates a data object
            let data = try Data(contentsOf: url)
            
            // Decodes the data with a JSON decoder
            let decoder = JSONDecoder()
            
            do {
                
                let recipeData = try decoder.decode([RecipeJSON].self, from: data)
                
                // Adds the unique IDs
                for r in recipeData {
                    r.id = UUID()
                    
                    // Adds unique IDs to recipe ingredients
                    for i in r.ingredients {
                        i.id = UUID()
                    }
                }
                
                // Returns the recipes
                return recipeData
            }
            catch {
                // error with parsing json
                print(error)
            }
        }
        catch {
            // error with getting data
            print(error)
        }
        
        return [RecipeJSON]()
    }
    
}
