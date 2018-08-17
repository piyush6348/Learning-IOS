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

import UIKit

class RecipeInstructionsViewController: UITableViewController {
  
  fileprivate var headerView: UIView!
  fileprivate let kTableHeaderHeight: CGFloat = 300.0
  var recipe: Recipe!
  fileprivate var instructionViewModel: InstructionViewModel!
  @IBOutlet var likeButton: UIButton!
  @IBOutlet var backButton: UIButton!
  
  var didLikeFood = true
  
  @IBOutlet var dishImageView: UIImageView!
  @IBOutlet var dishLabel: UILabel!
  
  override var prefersStatusBarHidden: Bool {
    get {
      return true
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    assert(recipe != nil)
    
    backButton.accessibilityTraits = UIAccessibilityTraitButton
    backButton.accessibilityLabel = "Back"
    
    isLikedFood(true)
    instructionViewModel = InstructionViewModel(recipe: recipe, type: .ingredient)
    setupRecipe()
    setupTableView()
  }
  
  // MARK: - Action Outlets
  
  @IBAction func likeButtonPressed(_ sender: AnyObject) {
    isLikedFood(!didLikeFood)
  }
  
  func isLikedFood(_ liked: Bool) {
    if liked {
        likeButton.setTitle("😍", for: .normal)
        likeButton.accessibilityTraits = UIAccessibilityTraitButton
        likeButton.accessibilityLabel = "Like"
        didLikeFood = true
    } else {
        likeButton.setTitle("😖", for: .normal)
        likeButton.accessibilityTraits = UIAccessibilityTraitButton
        likeButton.accessibilityLabel = "Dislike"
        didLikeFood = false
    }
  }
  
  @IBAction func toggleSegment(_ sender: UISegmentedControl) {
    if sender.selectedSegmentIndex == 0 { // Ingredients
      instructionViewModel.type = .ingredient
    } else { //Instruction
      instructionViewModel.type = .cookingInstructions
    }
    tableView.reloadData()
  }
  
  @IBAction func tapBackButton(_ sender: AnyObject) {
    _ = navigationController?.popViewController(animated: true)
  }
}

// MARK: - Setup
extension RecipeInstructionsViewController {
  
  func setupRecipe() {
    dishImageView.image = recipe.photo
    dishLabel.text = recipe.name
  }
  
  func setupTableView() {
    tableView.estimatedRowHeight = 79
    tableView.rowHeight = UITableViewAutomaticDimension
  }
}

// MARK: - TableView Data Source
extension RecipeInstructionsViewController {
  override func numberOfSections(in tableView: UITableView) -> Int {
    return instructionViewModel.numberOfSections()
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return instructionViewModel.numberOfItems()
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: InstructionCell.self), for: indexPath) as! InstructionCell
    
    if let description = instructionViewModel.itemFor(indexPath.item) {
      cell.configure(description)
    }
    
    let strike = instructionViewModel.getStateFor(indexPath.item)
    cell.shouldStrikeThroughText(strike)
    
    return cell
  }
}

// MARK: - TableView Delegate
extension RecipeInstructionsViewController {
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    instructionViewModel.selectItemFor(indexPath.item)
    let cell = tableView.cellForRow(at: indexPath) as! InstructionCell
    let strike = instructionViewModel.getStateFor(indexPath.item)
    cell.shouldStrikeThroughText(strike)
  }
}
