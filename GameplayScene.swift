//
//  GameplayScene.swift
//  Jack The Giant
//
//  Created by Wesley Archbell on 14/2/17.
//  Copyright © 2017 Plastik Apps. All rights reserved.
//

import SpriteKit

class GameplayScene: SKScene, SKPhysicsContactDelegate {
    
    var cloudsController = CloudController()
    var mainCamera: SKCameraNode?
    var bg1: Background?
    var bg2: Background?
    var bg3: Background?
    
    var player: Player?
    
    var canMove = false
    var moveLeft = false
    
    private var distanceBeforeCreatingNewClouds: CGFloat = 0.0
    
    var centre: CGFloat?
    var distanceBetweenClouds = CGFloat(240)
    var minX = CGFloat(-150)
    var maxX = CGFloat(150)
    
    private let playerMinX = CGFloat(-210)
    private let playerMaxX = CGFloat(210)
    
    private var acceleration = CGFloat()
    private var cameraSpeed = CGFloat()
    private var maxSpeed = CGFloat()
    
    var pausePanel: SKSpriteNode?
    
    override func didMove(to view: SKView) {
        initVariables()
    }

    func initVariables() {
        centre = (scene?.size.width)! / (scene?.size.height)!
        player = childNode(withName: "Player") as? Player
        player?.initPlayerAndAnimations()

        mainCamera = childNode(withName: "Main Camera") as? SKCameraNode
        createBackgrounds()
        createGameLabels()
        GameplayController.instance.initGameplayController()
        
        cloudsController.arrangeCloudsInScene(scene: self.scene!, distanceBetweenClouds: distanceBetweenClouds, centre: centre!, minX: minX, maxX: maxX, initialClouds: true)
        
        self.distanceBeforeCreatingNewClouds = self.mainCamera!.position.y - 400
        self.physicsWorld.contactDelegate = self
        
        setCameraSpeedSettings()
    }
    
    private func setCameraSpeedSettings() {
        if (GameManager.instance.gameData?.easyDifficultySetting)! {
            acceleration = 0.02
            cameraSpeed = 1.5
            maxSpeed = 4
        } else if (GameManager.instance.gameData?.mediumDifficultySetting)! {
            acceleration = 0.04
            cameraSpeed = 2
            maxSpeed = 6
        } else if (GameManager.instance.gameData?.hardDifficultySetting)! {
            acceleration = 0.06
            cameraSpeed = 2.5
            maxSpeed = 8
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        var playerBody = SKPhysicsBody()
        var collectableBody = SKPhysicsBody()
        if contact.bodyA.node!.name == "Player" {
            playerBody = contact.bodyA
            collectableBody = contact.bodyB
        } else if contact.bodyB.node!.name == "Player" {
            playerBody = contact.bodyB
            collectableBody = contact.bodyB
        }
        if playerBody.node?.name == "Player" && collectableBody.node?.name == "Coin" {
            //play sound
            GameplayController.instance.incremenetCoins()
            collectableBody.node?.removeFromParent()
        } else if playerBody.node?.name == "Player" && collectableBody.node?.name == "Life" {
            GameplayController.instance.incrementLife()
            collectableBody.node?.removeFromParent()
        } else if playerBody.node?.name == "Player" && collectableBody.node?.name == "Dark Cloud" {
            self.scene?.isPaused = true
            playerBody.node?.removeFromParent()
            self.displayScorePanelAndKillPlayer()
        }
    }
    
    func createBackgrounds() {
        bg1 = childNode(withName: "BG 1") as? Background!
        bg2 = childNode(withName: "BG 2") as? Background!
        bg3 = childNode(withName: "BG 3") as? Background!
    }
    
    func createGameLabels() {
        GameplayController.instance.lifeLabel = self.mainCamera?.childNode(withName: "LifeLabel") as? SKLabelNode
        GameplayController.instance.coinLabel = self.mainCamera?.childNode(withName: "CoinLabel") as? SKLabelNode
        GameplayController.instance.scoreLabel = self.mainCamera?.childNode(withName: "ScoreLabel") as? SKLabelNode
    }

    override func update(_ currentTime: TimeInterval) {
        moveCameraDown()
        managePlayer()
        manageBackgrounds()
        createNewClouds()
        player!.updateScore()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            if (!self.isPaused) {
                if (location.x > centre!) {
                    moveLeft = false
                    player?.animatePlayer(moveLeft: moveLeft)
                } else {
                    moveLeft = true
                    player?.animatePlayer(moveLeft: moveLeft)
                }
            }
            if nodes(at: location)[0].name == "PauseButton" {
                if !self.isPaused {
                    createPausePanel()
                    self.isPaused = true
                }
            } else if nodes(at: location)[0].name == "ResumeButton" {
                self.pausePanel?.removeFromParent()
                self.isPaused = false
            } else if nodes(at: location)[0].name == "QuitButton" {
                showScene(scene: MainMenuScene(fileNamed: "MainMenuScene")!)
            }
        }
        canMove = true
    }
    
    func createPausePanel() {
        pausePanel = SKSpriteNode(imageNamed: "Pause Menu")
        pausePanel?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        pausePanel?.xScale = 1.6
        pausePanel?.yScale = 1.6
        pausePanel?.zPosition = 5
        pausePanel?.position = CGPoint(x: (self.mainCamera?.frame.size.width)! / 2, y: (self.mainCamera?.frame.size.height)! / 2)
        
        let resumeButton = SKSpriteNode(imageNamed: "Resume Button")
        resumeButton.name = "ResumeButton"
        resumeButton.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        resumeButton.position = CGPoint(x: (pausePanel?.position.x)!, y: (pausePanel?.position.y)! + 25)
        resumeButton.zPosition = 6
        pausePanel?.addChild(resumeButton)
        
        let quitButton = SKSpriteNode(imageNamed: "Quit Button 2")
        quitButton.name = "QuitButton"
        quitButton.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        quitButton.position = CGPoint(x: (pausePanel?.position.x)!, y: (pausePanel?.position.y)! - 45)
        quitButton.zPosition = 6
        pausePanel?.addChild(quitButton)
        
        self.mainCamera?.addChild(pausePanel!)
    }
    
    func createScorePanel() {
        
        let scorePanel = SKSpriteNode(imageNamed: "Show Score")
        scorePanel.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        scorePanel.zPosition = 8
        scorePanel.xScale = 1.5
        scorePanel.yScale = 1.5
        scorePanel.position = CGPoint(x: (self.mainCamera?.frame.size.width)! / 2, y: (self.mainCamera?.frame.size.height)! / 2)
        
        let scoreLabel = SKLabelNode(fontNamed: "Blow")
        scoreLabel.zPosition = 7
        scoreLabel.fontSize = 50
        scoreLabel.position.x = scorePanel.position.x - 60
        scoreLabel.position.y = scorePanel.position.y + 10
        scoreLabel.text = "\(GameplayController.instance.score!)"
        
        let coinLabel = SKLabelNode(fontNamed: "Blow")
        coinLabel.zPosition = 7
        coinLabel.fontSize = 50
        coinLabel.position.x = scorePanel.position.x - 60
        coinLabel.position.y = scorePanel.position.y - 105
        coinLabel.text = "\(GameplayController.instance.coins!)"
        
        scorePanel.addChild(scoreLabel)
        scorePanel.addChild(coinLabel)
        self.mainCamera?.addChild(scorePanel)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        canMove = false
        player?.stopPlayerAnimation() 
    }
    
    func managePlayer() {
        if canMove {
            player?.movePlayer(moveLeft: moveLeft)
        }
        
        if (self.player?.position.x)! > self.playerMaxX {
            self.player?.position.x = self.playerMaxX
        } else if (self.player?.position.x)! < self.playerMinX {
            self.player?.position.x = self.playerMinX
        }
        
        if (self.mainCamera?.position.y)! - (self.scene?.size.height)!/2 > (self.player?.position.y)! + 50 {
            self.scene?.isPaused = true
            self.displayScorePanelAndKillPlayer()
        } else if (self.mainCamera?.position.y)! + (self.scene?.size.height)!/2 < (self.player?.position.y)! - 60 {
            self.scene?.isPaused = true
            self.displayScorePanelAndKillPlayer()
        }
    }
    
    func displayScorePanelAndKillPlayer() {
        createScorePanel()
        Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(GameplayScene.playerDied), userInfo: nil, repeats: false)
    }
    
    func moveCameraDown() {
        
        self.cameraSpeed = self.cameraSpeed + self.acceleration
        if (self.cameraSpeed > self.maxSpeed) {
            self.cameraSpeed = self.maxSpeed
        }
        
        self.mainCamera?.position.y -= self.cameraSpeed
    }
    
    func manageBackgrounds() {
        bg1?.moveBG(camera: mainCamera!)
        bg2?.moveBG(camera: mainCamera!)
        bg3?.moveBG(camera: mainCamera!)
    }
    
    func createNewClouds() {
        if self.distanceBeforeCreatingNewClouds > self.mainCamera!.position.y {
            self.distanceBeforeCreatingNewClouds = self.mainCamera!.position.y - 400
            self.cloudsController.arrangeCloudsInScene(scene: self, distanceBetweenClouds: distanceBetweenClouds, centre: centre!, minX: minX, maxX: maxX, initialClouds: false)
            removeOffScreenNodes()
        }
    }
    
    func removeOffScreenNodes() {
        for child in children {
            if child.position.y > ((self.mainCamera?.position.y)! + ((self.scene?.size.height)! / 2)) {
                if child.name!.components(separatedBy: " ")[0] != "BG" {
                    child.removeFromParent()
                }
            }
        }
    }
    
    func playerDied() {
        print("Player died")
        GameplayController.instance.life = (GameplayController.instance.life)! - 1
        if (GameplayController.instance.life)! >= 0 {
            print("Player has more \(GameplayController.instance.life! + 1) left.")
            GameManager.instance.gameRestartedFromPlayerDying = true
            showScene(scene: GameplayScene(fileNamed: "GameplayScene")!)
            GameplayController.instance.lifeLabel?.text = "x\((GameplayController.instance.life)!)"
        } else {
            print("Player has no more lives left")
            
            if (GameManager.instance.gameData?.easyDifficultySetting)! {
                
                if (GameplayController.instance.score)! > (GameManager.instance.gameData?.easyDifficultyScore)! {
                    print("New easy highscore: \((GameplayController.instance.score)!)")
                    GameManager.instance.gameData?.easyDifficultyScore = (GameplayController.instance.score)!
                }
                if (GameplayController.instance.coins)! > (GameManager.instance.gameData?.easyDifficultyCoinScore)! {
                    print("New easy coin highscore: \((GameplayController.instance.coins)!)")
                    GameManager.instance.gameData?.easyDifficultyCoinScore = (GameplayController.instance.coins)!
                }
            } else if (GameManager.instance.gameData?.mediumDifficultySetting)! {
                
                if (GameplayController.instance.score)! > (GameManager.instance.gameData?.mediumDifficultyScore)! {
                    print("New medium highscore: \((GameplayController.instance.score)!)")
                    GameManager.instance.gameData?.mediumDifficultyScore = (GameplayController.instance.score)!
                }
                if (GameplayController.instance.coins)! > (GameManager.instance.gameData?.mediumDifficultyCoinScore)! {
                    print("New medium coin highscore: \((GameplayController.instance.coins)!)")
                    GameManager.instance.gameData?.mediumDifficultyCoinScore = (GameplayController.instance.coins)!
                }
            } else if (GameManager.instance.gameData?.hardDifficultySetting)! {
                
                if (GameplayController.instance.score)! > (GameManager.instance.gameData?.hardDifficultyScore)! {
                    print("New hard highscore: \((GameplayController.instance.score)!)")
                    GameManager.instance.gameData?.hardDifficultyScore = (GameplayController.instance.score)!
                }
                if (GameplayController.instance.coins)! > (GameManager.instance.gameData?.hardDifficultyCoinScore)! {
                    print("New hard coin highscore: \((GameplayController.instance.coins)!)")
                    GameManager.instance.gameData?.hardDifficultyCoinScore = (GameplayController.instance.coins)!
                }
            }
            GameManager.instance.saveData()
            showScene(scene: MainMenuScene(fileNamed: "MainMenuScene")!)
        }
    }
    
    private func showScene(scene: SKScene) {
        scene.scaleMode = SKSceneScaleMode.aspectFill
        self.view?.presentScene(scene, transition: SKTransition.doorsCloseHorizontal(withDuration: 1))
    }
    
}
