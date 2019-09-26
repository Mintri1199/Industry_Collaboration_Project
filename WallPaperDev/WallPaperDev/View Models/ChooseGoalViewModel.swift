//
//  ChooseGoalViewModel.swift
//  WallPaperDev
//
//  Created by Jackson Ho on 9/25/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import Foundation

class ChooseGoalViewModel {
        
    var selectedGoals: [String] = []
    
    // An array of goals to populate the table view
    
    // function to fetch the goals from core data
    
    // function to preSelect the goals when the user want to change the selected goals
    func preselectGoals(_ array: [String]) {
        selectedGoals = array
    }
    
    // function to limit the goals selection to 4
}
