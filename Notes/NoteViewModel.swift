//
//  NoteViewModel.swift
//  Notes
//
//  Created by Elif Dede on 4/3/24.
//

import Foundation
import FirebaseCore
import FirebaseFirestore

class NoteViewModel: ObservableObject {
    @Published  var notes = [NoteModel]()
    
    let db = Firestore.firestore()
    
    func fetchData() {
        self.notes.removeAll()
        db.collection("notes")
            .getDocuments(){ (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        do {
                            self.notes.append(try document.data(as: NoteModel.self))
                        } catch {
                            print(error)
                        }
                    }
                }
            }
        
        //        do {
        //              let querySnapshot = try await db.collection("notes").getDocuments()
        //              for document in querySnapshot.documents {
        //                print("\(document.documentID) => \(document.data())")
        //              }
        //            } catch {
        //              print("Error getting documents: \(error)")
        //            }
        
        
    }
    
    func saveData(note: NoteModel){
        // edit note
        // add note
       
        if let id = note.id {
            if !note.title.isEmpty || !note.notesdata.isEmpty {
                let docRef = db.collection("notes").document(id)
                docRef.updateData([
                    "title": note.title,
                    "notesdata": note.notesdata
                ]){ err in
                    if let err = err {
                        print("Error updating document: \(err)")
                    } else {
                        print("Document successfully updated")
                        
                    }
                }
            }
        } else {
            if !note.title.isEmpty || !note.notesdata.isEmpty {
                var ref: DocumentReference? = nil
                ref = db.collection("notes").addDocument(data: [
                    "title": note.title,
                    "notesdata": note.notesdata
                ]){ err in
                    if let err = err {
                        print("Error updating document: \(err)")
                    } else {
                        print("Document added with ID: \(ref!.documentID)")
                    }
                }
            }
        }
    }
}
        
        
        
        


