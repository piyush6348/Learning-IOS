/*
 * Copyright (c) 2016 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import Foundation

enum RecipeInstructionType {
  case ingredient, cookingInstructions
}

struct InstructionViewModel {
  let recipe: Recipe?
  var type: RecipeInstructionType
  var ingredientsState = [Bool]()
  var directionsState = [Bool]()
  
  init(recipe: Recipe, type: RecipeInstructionType) {
    self.recipe = recipe
    self.type = type
    
    if let ingredients = recipe.ingredients {
      ingredientsState = [Bool](repeating: false, count:ingredients.count)
    }
    
    if let directions = recipe.directions {
      directionsState = [Bool](repeating: false, count:directions.count)
    }
  }
  
  mutating func numberOfItems() -> Int {
    
    switch type {
    case .ingredient:
      if let ingredients = recipe?.ingredients {
        return ingredients.count
      }
    case .cookingInstructions:
      if let directions = recipe?.directions {
        return directions.count
      }
    }
    
    return 0
  }
  
  func numberOfSections() -> Int {
    return 1
  }
  
  func itemFor(_ index: Int) -> String? {
    switch type {
    case .ingredient:
      if let ingredients = recipe?.ingredients {
        return ingredients[index]
      }
    case .cookingInstructions:
      if let directions = recipe?.directions {
        return directions[index]
      }
    }
    return nil
  }
  
  func getStateFor(_ index: Int) -> Bool {
    switch type {
    case .ingredient:
      return ingredientsState[index]
    case .cookingInstructions:
      return directionsState[index]
    }
  }
  
  mutating func selectItemFor(_ index: Int) {
    switch type {
    case .ingredient:
      let previousState = ingredientsState[index]
      ingredientsState[index] = !previousState
    case .cookingInstructions:
      let previousState = directionsState[index]
      directionsState[index] = !previousState
    }
  }
}
