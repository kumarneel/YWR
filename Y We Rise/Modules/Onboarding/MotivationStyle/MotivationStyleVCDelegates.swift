//
//  MotivationStyleVCDelegates.swift
//  Y We Rise
//
//  Created by Neel Kumar on 10/11/22.
//

import Foundation

extension MotivationStyleVC: MotivationStyleViewDelegate {
    func didTapCell(motivationStyle: MotivationStyle, selected: Bool) {
        if selected {
            selectedMotivationStyleArray.append(motivationStyle)
        } else {
            for i in 0...selectedMotivationStyleArray.count-1 {
                if selectedMotivationStyleArray[i] == motivationStyle {
                    selectedMotivationStyleArray.remove(at: i)
                }
            }
        }
        print(selectedMotivationStyleArray)
    }
}
