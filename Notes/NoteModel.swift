//
//  NoteModel.swift
//  Notes
//
//  Created by Elif Dede on 4/2/24.
//

import Foundation
import FirebaseFirestoreSwift

struct NoteModel: Codable, Identifiable {
    @DocumentID var id: String?
    var title: String
    var notesdata: String
}
