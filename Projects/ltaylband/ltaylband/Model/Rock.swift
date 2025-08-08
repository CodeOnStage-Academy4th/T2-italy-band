//
//  Rock.swift
//  ltaylband
//
//  Created by 김재윤 on 8/8/25.
//

import Foundation
import SwiftData

@Model
final class Rock: Identifiable {
    var id: UUID
    var name: String
    var spentTime: Int

    var grade: Grade
    
    var shirt: String
    var pants: String
    var eyes: String
    var hat: String
    
    init(
        id: UUID,
        name: String,
        spentTime: Int,
        grade: Grade,
        shirt: String,
        pants: String,
        eyes: String,
        hat: String
    ) {
        self.id = id
        self.name = name
        self.spentTime = spentTime
        self.grade = grade
        self.shirt = shirt
        self.pants = pants
        self.eyes = eyes
        self.hat = hat
    }
}
