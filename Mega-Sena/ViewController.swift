//
//  ViewController.swift
//  Mega-Sena
//
//  Created by João on 05/05/20.
//  Copyright © 2020 João. All rights reserved.
//

import UIKit

enum GameType: String { // Enum seguido do raw value
    case megasena = "Mega-Sena"
    case quina = "Quina"
}

infix operator >-< // Operador personalizado - infix operador atua entre dois valores
func >-< (total: Int, universe: Int) -> [Int] {
    var result: [Int] = []
    while result.count < total {
        let randomNumber = Int(arc4random_uniform(UInt32(universe))+1) // Gera um num aleatório de 0 a um valor determinado
        if !result.contains(randomNumber) {
            result.append(randomNumber)
        }
    }
    return result.sorted() // Ordena o array
}

class ViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var labelGameType: UILabel!
    @IBOutlet weak var segmentetGameType: UISegmentedControl!
    @IBOutlet var balls: [UIButton]! // Outlet Collection - array de UIButton
    
    // MARK: - View Life Cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        showNumber(for: .megasena)
    }

    // MARK: - IBAction
    @IBAction func GenerateGame() {
        switch segmentetGameType.selectedSegmentIndex {
        case 0:
            showNumber(for: .megasena)
        default:
            showNumber(for: .quina)
        }
    }
    
    func showNumber(for type: GameType) {
        labelGameType.text = type.rawValue
        var game: [Int] = []
        switch type {
        case .megasena:
            game = 6>-<60
            balls.last?.isHidden = false
        case .quina:
            game = 5>-<80
            balls.last?.isHidden = true // Esconde a última bola
        }
        
        for (index, game) in game.enumerated() { // array.enumerated() retorna uma tupla com key:value
            balls[index].setTitle("\(game)", for: .normal)
        }
    }
    
}

