//
//  todo.swift
//  fv4firebase
//
//  Created by applwes on 2024-11-28.
//
import SwiftUI
import Firebase

class Todo {
    var title = ""
    var id = ""
}

struct Todoview: View {
    @State var todoadd = ""  // New todo item input
    @State var todolist = [Todo]()  // List to hold fetched todos

    var body: some View {
        VStack {
            // TextField to add new todo
            HStack {
                TextField("Add Hero", text: $todoadd)
                Button(action: {
                    todosave()
                }) {
                    Text("Add")
                }
            }
            
            
            
            // Display the list of todos
            //List(todolist, id: \.id) { todoitem in
                ZStack {
                              ForEach(todolist, id: \.id) { todoitem in
                                  CardView(person: todoitem.title)
                                      .zIndex(Double(todolist.firstIndex(where: { $0.id == todoitem.id }) ?? 0))  // Ensure correct stacking order
                                      .padding(.top, CGFloat(todolist.firstIndex(where: { $0.id == todoitem.id }) ?? 0) * 20) // Add spacing for stacked cards
                              } }
            }
       // }
        
        
        .padding()
        .onAppear {
            // On view appear, load the todos from Firebase
            Task {
                await todoload()
            }
        }
    }

    // Fetch the todos from Firebase
    func todoload() async {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        todolist = []  // Clear the current list
        
        do {
            // Fetch data from Firebase
            let tododata = try await ref.child("todo").getData()
            print(tododata.childrenCount)
            
            for todoitem in tododata.children {
                let todosnap = todoitem as! DataSnapshot
                let tododict = todosnap.value as? [String : String]
                
                if let title = tododict?["title"] {
                    var faketodo = Todo()
                    faketodo.title = title  // Get the title of the todo item
                    faketodo.id = todosnap.key  // Set the ID from Firebase
                    
                    todolist.append(faketodo)  // Add to the list of todos
                }
            }
        } catch {
            print("Error fetching data: \(error)")
        }
    }

    // Save the new todo to Firebase
    func todosave() {
        var ref: DatabaseReference!
        ref = Database.database().reference()

        ref.child("todo").childByAutoId().child("title").setValue(todoadd)
        
        // After saving, reload the data
        Task {
            await todoload()
        }
    }
}


#Preview {
    Todoview()
}
