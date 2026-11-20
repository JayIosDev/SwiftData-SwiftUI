import SwiftUI
import Playgrounds

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
        
    }
}

#Preview {
    ContentView()
}

#Playground("Array Example") {
    let numbers = [10, 20, 30, 40]

    let result = numbers.filter { $0 > 10 }

    print(result)
}
