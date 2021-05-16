//
//  GameScene.swift
//  SpaceRace
//
//  Created by Paul Richardson on 16/05/2021.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {

	var starfield: SKEmitterNode!
	var player: SKSpriteNode!
	var scoreLabel: SKLabelNode!

	var score = 0 {
		didSet {
			scoreLabel.text = "Score: \(score)"
		}
	}

	var possibleEnemies = ["ball", "hammer", "tv"]
	var gameTimer: Timer?
	var isGaveOver = false
	var playerTouched = false

	override func didMove(to view: SKView) {
		backgroundColor = .black

		starfield = SKEmitterNode(fileNamed: "starfield")
		starfield.position = CGPoint(x: 1024, y: 384)
		starfield.advanceSimulationTime(10)
		addChild(starfield)
		starfield.zPosition = -1

		player = SKSpriteNode(imageNamed: "player")
		player.position = CGPoint(x: 100, y: 384)
		player.physicsBody = SKPhysicsBody(texture: player.texture!, size: player.size)
		player.physicsBody?.contactTestBitMask = 1
		player.name = "player"
		addChild(player)

		scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
		scoreLabel.position = CGPoint(x: 16, y: 16)
		scoreLabel.horizontalAlignmentMode = .left
		addChild(scoreLabel)

		score = 0

		physicsWorld.gravity = CGVector(dx: 0, dy: 0)
		physicsWorld.contactDelegate = self

		gameTimer = Timer.scheduledTimer(timeInterval: 0.35, target: self, selector: #selector(createEnemy), userInfo: nil, repeats: true)
	}

	override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
		guard let touch = touches.first else { return }
		var location = touch.location(in: self)

		if location.y < 100 {
			location.y = 100
		} else if location.y > 668 {
			location.y = 668
		}

		player.position = location

	}

	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		guard let touch = touches.first else { return }
		let location = touch.location(in: self)
		let tappedNodes = nodes(at: location)
		guard let _ = tappedNodes.first(where: { node in
			node.name == "player"
		}) else {
			return
		}
		playerTouched = true
		super.touchesBegan(touches, with: event)

	}

	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		playerTouched = false
		super.touchesEnded(touches, with: event)
	}

	func didBegin(_ contact: SKPhysicsContact) {
		guard let explosion = SKEmitterNode(fileNamed: "explosion") else {
			fatalError("Unable to create node using explosion.sks")
		}
		explosion.position = player.position
		addChild(explosion)
		player.removeFromParent()

		isGaveOver = true
	}

	override func update(_ currentTime: TimeInterval) {

		for node in children {
			if node.position.x < -300 {
				node.removeFromParent()
			}
		}

		if !isGaveOver {
			score += 1
		}
	}

	@objc func createEnemy() {
		guard let enemy = possibleEnemies.randomElement() else { return }

		let sprite = SKSpriteNode(imageNamed: enemy)
		sprite.position = CGPoint(x: 1200, y: Int.random(in: 50...736))
		addChild(sprite)

		sprite.physicsBody = SKPhysicsBody(texture: sprite.texture!, size: sprite.size)
		sprite.physicsBody?.categoryBitMask = 1
		sprite.physicsBody?.velocity = CGVector(dx: -500, dy: 0)
		sprite.physicsBody?.angularVelocity = 5
		sprite.physicsBody?.angularDamping = 0
		sprite.physicsBody?.linearDamping = 0
	}
}
