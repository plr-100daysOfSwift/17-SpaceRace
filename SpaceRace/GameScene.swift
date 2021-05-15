//
//  GameScene.swift
//  SpaceRace
//
//  Created by Paul Richardson on 16/05/2021.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {

	var starfield: SKEmitterNode!
	var player: SKSpriteNode!
	var scoreLabel: SKLabelNode

	var score = 0 {
		didSet {
			scoreLabel.text = "Score: \(score)"
		}
	}

	override func didMove(to view: SKView) {
		
	}

	override func update(_ currentTime: TimeInterval) {
		// Called before each frame is rendered
	}

}
