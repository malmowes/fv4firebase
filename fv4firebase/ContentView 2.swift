//
//  ContentView.swift
//  v3bill
//
//  Created by applwes on 2024-11-21.
//

import SwiftUI

struct ContentView2: View {
    private var people: [String] =
    
    [" Mario", " Luigi", " Peach", " Bowser", "Toad", "Daisy"].reversed()
        
    var body: some View {
     VStack {
            ZStack {
             ForEach(people, id: \.self) { person in
                 CardView(person: person)
                }
         }
        }
    }
    
    
    
    
   
}

struct ContentView2_Previews: PreviewProvider {
    static var previews: some View {
        ContentView2()
    }
}
