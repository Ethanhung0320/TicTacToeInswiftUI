import SwiftUI

struct ContentView: View {
    @State private var board: [[String]] = Array(repeating: Array(repeating: "", count: 3), count: 3)
    @State private var isCircleTurn: Bool = true
    @State private var showingAlert: Bool = false
    @State private var winner:String? = nil
    @State private var circleScore = 0
    @State private var crossScore = 0
    var body: some View {
        ZStack {
            backgroundView
            VStack {
                Text("輪到誰")
                    .font(.system(size: 22))
                    .foregroundColor(.black)
                    .padding(.top, 25)
                    .padding(.bottom, 28.6)
                Button(action: {
                  }) {
                      Text(isCircleTurn ? "O" : "X")
                          .font(.system(size: 70, weight: .heavy))
                          .foregroundColor(.black)
                }
                ZStack {
                    Color(red: 66 / 255, green: 76 / 255, blue: 128 / 255)
                        .frame(width: 373.67, height: 373.67)
                    VStack(spacing: 5) {
                        ForEach(0...2, id: \.self)
                        { row in
                            HStack(spacing: 5) {
                                ForEach(0...2, id: \.self)
                                { column in
                                    Button(action: {
                                        if board[row][column].isEmpty {
                                            board[row][column] = isCircleTurn ?  "O" : "X"
                                            let won = checkForWinner()
                                            if won {
                                                showingAlert = true
                                                if isCircleTurn {
                                                    winner = "圈圈 贏了！"
                                                    circleScore += 1
                                                } else {
                                                    winner = "叉叉 贏了！"
                                                    crossScore += 1
                                                }
                                            }
                                            isCircleTurn.toggle()
                                            var isBoardFull = true
                                            for row in board {
                                                for cell in row {
                                                    if cell.isEmpty {
                                                        isBoardFull = false
                                                        break
                                                    }
                                                }
                                                if !isBoardFull {
                                                    break
                                                }
                                            }
                                            if isBoardFull && !won {
                                                showingAlert = true
                                                winner = "平手"
                                            }
                                        }
                                    }) {
                                        Text(board[row][column])
                                            .font(.system(size: 60, weight: .bold))
                                            .foregroundColor(Color(red: 162/255, green: 89/255, blue: 255/255))
                                            .frame(width: 121.33, height: 121.33)
                                            .background(Color(red: 184/255, green: 230/255, blue: 237/255))
                                    }
                                    .alert(isPresented: $showingAlert) {
                                        Alert(title: Text("\(winner ?? "")"), message: Text("圈圈分數：\(circleScore)分！ \n叉叉分數：\(crossScore)分！ "), dismissButton: .default(Text("重來一次")) {
                                            self.restartGame()
                                        })
                                    }
                                }
                            }
                        }
                    }
                }
                Spacer()
            }
        }
    }
    var backgroundView: some View {
        Color(red: 234 / 255, green: 242 / 255, blue: 253 / 255)
            .edgesIgnoringSafeArea(.all)
    }
    
    
    
    func checkForWinner() -> Bool {
        for row in 0...2 {
            if !board[row][0].isEmpty && board[row][0] == board[row][1] && board[row][1] == board[row][2] {return true}
        }
        for column in 0...2 {
            if !board[0][column].isEmpty && board[0][column] == board[1][column] && board[1][column] == board[2][column] {return true}
        }
        if !board[0][0].isEmpty && board[0][0] == board[1][1] && board[1][1] == board[2][2] {
            return true
        }
        if !board[0][2].isEmpty && board[0][2] == board[1][1] && board[1][1] == board[2][0] {
            return true
        }
        return false
    }
    func restartGame() {
        board = Array(repeating: Array(repeating: "", count: 3), count: 3)
         isCircleTurn = true
         showingAlert = false
         winner = nil
    }
}

#Preview {
    ContentView()
}
