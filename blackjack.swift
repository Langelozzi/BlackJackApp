import UIKit

class ViewController: UIViewController {

    
    //money amount variables
    @IBOutlet weak var betAmount: UILabel!
    @IBOutlet weak var bankAmount: UILabel!
    var playerBet = 0
    var playerBank = 500
    
    //card stacks
    @IBOutlet weak var dealerCardStack: UIStackView!
    @IBOutlet weak var playerCardStack: UIStackView!
    
    //other setup variables
    var myDeck: [String] = []
    var dealerCount = 0
    var playerCount = 0
    var playerCardSpacing = 0
    var dealerCardSpacing = 0
    var playerHand: [Int] = []
    var dealerHand: [Int] = []
    var testPlayerHand: [Int] = []
    var testDealerHand: [Int] = []
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var playButtonImage: UIButton!
    var cardBackBool = true
    
    func createdeck() -> [String] {
        let suits = ["Hearts", "Diamonds", "Clubs", "Spades"]
        
        var blankDeck: [String] = []
        
        for suit in suits {
            for rank in 2...13{
                if rank < 10{
                    let newCard = suit + "0" + String(rank)
                    blankDeck.append(newCard)
                }
                else if rank == 10 {
                    let newCard = suit + String(rank)
                    blankDeck.append(newCard)
                    
                }
                else if rank == 11 {
                    let newCard = suit + String(rank)
                    blankDeck.append(newCard)
                }
                else {
                    let newCard = suit + String(rank) + "10"
                    blankDeck.append(newCard)
                }
            }
        }
        return blankDeck
    }
    
    func randomCard(deck: [String]) -> String{
        
        let maxRange = deck.count - 1
        let randomNum = Int.random(in: 0...maxRange)
        
        return deck[randomNum]
        
    }
    
    func checkStatus() {
        
        var dealertotal = dealerHand.reduce(0, +)
        var playertotal = playerHand.reduce(0, +)
        
        if playertotal > 21 && dealertotal < 21{
            lblStatus.text = "Player Bust!"
            playerBet = 0
            betAmount.text = String(playerBet)
        }
        else if playertotal < 21 && dealertotal > 21{
            lblStatus.text = "Dealer Bust!"
            playerBank += (playerBet * 2)
            bankAmount.text = String(playerBank)
            playerBet = 0
            betAmount.text = String(playerBet)
        }
        else if playertotal == 21 && dealertotal != 21{
            lblStatus.text = "Player wins!"
            playerBank += (playerBet * 2)
            bankAmount.text = String(playerBank)
            playerBet = 0
            betAmount.text = String(playerBet)
        }
        else if playertotal != 21 && dealertotal == 21 {
            lblStatus.text = "Dealer wins!"
            playerBet = 0
            betAmount.text = String(playerBet)
        }
        else if playertotal == 21 && dealertotal == 21 {
            lblStatus.text = "Draw"
            playerBet = 0
            betAmount.text = String(playerBet)
        }
        else{
            lblStatus.text = "Hit or Stand"
        }
    }
    
    func gameFinish() {
        
        //everything needs to go back to beginning
        
    }
    
    func firstDealerCards() {
        
        let cardView = UIImageView()
        let card = myDeck.removeLast()
        var nextCard = Int(card.suffix(2))!
        
        if cardBackBool == true {
            dealerHand.append(nextCard)
            var dealertotal = dealerHand.reduce(0, +)
           
            
            if dealertotal > 21 {
                var elevenCard = dealerHand.firstIndex(where: {$0 == 11}) ?? -1
                if elevenCard != -1{
                    dealerHand.remove(at: elevenCard)
                    dealerHand.append(1)
                    
                }
            }
            
            dealertotal = dealerHand.reduce(0, +)
            print(dealerHand)
            print(dealertotal)
            print(dealerCount)
        
            dealerCardSpacing -= 25
            dealerCardStack.spacing = CGFloat(dealerCardSpacing)
            
            dealerCount += 1
        
            cardView.image = UIImage(named: "card_back")
            dealerCardStack.insertArrangedSubview(cardView, at: 0)
        }
        else if cardBackBool == false {
            //var firstIndex = dealerCardStack.arrangedSubviews.index(before: 1)
            dealerCardStack.removeArrangedSubview(cardView)
            cardView.removeFromSuperview()
            cardView.image = UIImage(named: card)
            //dealerCardStack.insertArrangedSubview(cardView, at: 0)
            
        }
    }
    
    func secondDealerCards() {
        
        let cardView = UIImageView()
        let card = myDeck.removeLast()
        var nextCard = Int(card.suffix(2))!
        

        dealerHand.append(nextCard)
        var dealertotal = dealerHand.reduce(0, +)
       
        
        if dealertotal > 21 {
            var elevenCard = dealerHand.firstIndex(where: {$0 == 11}) ?? -1
            if elevenCard != -1{
                dealerHand.remove(at: elevenCard)
                dealerHand.append(1)
                
            }
        }
        
        dealertotal = dealerHand.reduce(0, +)
        print(dealerHand)
        print(dealertotal)
        print(dealerCount)
    
        cardView.image = UIImage(named: card)
            
        dealerCardStack.addArrangedSubview(cardView)
        dealerCardSpacing -= 25
        dealerCardStack.spacing = CGFloat(dealerCardSpacing)
        
        dealerCount += 1

        
            
    }
    
    
    func givePlayerCard(){
        let cardView = UIImageView()
        let card = myDeck.removeLast()
        var nextCard = Int(card.suffix(2))!
        

        playerHand.append(nextCard)
        var playertotal = playerHand.reduce(0, +)
       
        
        if playertotal > 21 {
            var elevenCard = playerHand.firstIndex(where: {$0 == 11}) ?? -1
            if elevenCard != -1{
                playerHand.remove(at: elevenCard)
                playerHand.append(1)
                
            }
        }
        
        
        
        playertotal = playerHand.reduce(0, +)
        print(playerHand)
        print(playertotal)
        
        if playerCount < 5 {
            cardView.image = UIImage(named: card)
            
            playerCardStack.addArrangedSubview(cardView)
            playerCardSpacing -= 25
            playerCardStack.spacing = CGFloat(playerCardSpacing)
            
            
            playerCount += 1
    
        }
        
        
        
    }
        
    func giveDealerCard(){
        
        var dealertotal = dealerHand.reduce(0, +)
        
        while dealertotal < 18 {
        
            
            let cardView = UIImageView()
            let card = myDeck.removeLast()
            var nextCard = Int(card.suffix(2))!
            

            dealerHand.append(nextCard)
            dealertotal = dealerHand.reduce(0, +)
           
            
            if dealertotal > 21 {
                var elevenCard = dealerHand.firstIndex(where: {$0 == 11}) ?? -1
                if elevenCard != -1{
                    dealerHand.remove(at: elevenCard)
                    dealerHand.append(1)
                }
            }
            
            dealertotal = dealerHand.reduce(0, +)
            print(dealerHand)
            print(dealertotal)
            print(dealerCount)
            

            if dealerCount < 5 {
                cardView.image = UIImage(named: card)
                
                dealerCardStack.addArrangedSubview(cardView)
                dealerCardSpacing -= 25
                dealerCardStack.spacing = CGFloat(dealerCardSpacing)
                
                dealerCount += 1
            }
            
        }
            
    }
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        myDeck = createdeck()
        myDeck.shuffle()
        
        playerCardStack.spacing = CGFloat(playerCardSpacing)
        dealerCardStack.spacing = CGFloat(dealerCardSpacing)
                
    }
        
    @IBAction func playButton(_ sender: Any) {
        
        givePlayerCard()
        firstDealerCards()
        givePlayerCard()
        secondDealerCards()
        
        playButtonImage.isHidden = true
        
        var dealertotal = dealerHand.reduce(0, +)
        var playertotal = playerHand.reduce(0, +)
        
        if dealertotal != 21 || playertotal != 21 {
            lblStatus.text = "Hit or Stand"
        }
        else if playertotal == 21 && dealertotal != 21{
            lblStatus.text = "Player wins!"
            playerBank += (playerBet * 2)
            bankAmount.text = String(playerBank)
            playerBet = 0
            betAmount.text = String(playerBet)
            
        }
        else if playertotal != 21 && dealertotal == 21 {
            lblStatus.text = "Dealer wins!"
            playerBet = 0
            betAmount.text = String(playerBet)
        }
        else if playertotal == 21 && dealertotal == 21 {
            lblStatus.text = "Draw"
        }
    }
    

    //betting buttons
    @IBAction func addBetButton(_ sender: Any) {
        
        while playerBank > 0 {
            playerBet += 50
            betAmount.text = String(playerBet)
            playerBank -= 50
            bankAmount.text = String(playerBank)
            break
            
        }
        
    }
    
    @IBAction func minusBetButton(_ sender: Any) {
        
        while playerBet > 0 {
            playerBet -= 50
            betAmount.text = String(playerBet)
            playerBank += 50
            bankAmount.text = String(playerBank)
            break
            
        }
        
    }
    
    
    //hit and stand buttons
    @IBAction func hitButton(_ sender: Any) {
        
        givePlayerCard()
        checkStatus()
        
    }
    @IBAction func standButton(_ sender: Any) {
    
        
        cardBackBool = false
        firstDealerCards()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
            giveDealerCard()
            checkStatus()
            
            var dealertotal = dealerHand.reduce(0, +)
            var playertotal = playerHand.reduce(0, +)
            
            if playertotal > dealertotal && playertotal < 21 && dealertotal < 21 {
                lblStatus.text = "Player Wins!"
                playerBank += (playerBet * 2)
                bankAmount.text = String(playerBank)
                playerBet = 0
                betAmount.text = String(playerBet)
            }
            else if dealertotal > playertotal && playertotal < 21 && dealertotal < 21 {
                lblStatus.text = "Dealer Wins!"
                playerBet = 0
                betAmount.text = String(playerBet)
            }
        }
        
        
    }
        
    
}

