// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Battleship {
    uint8 constant GRID_SIZE = 5;
    enum CellStatus { Empty, Ship, Hit, Miss }
    
    struct Player {
        address addr;
        bool ready;
        CellStatus[GRID_SIZE][GRID_SIZE] board;
        uint8 remainingShips;
    }
    
    mapping(address => Player) public players;
    address[] public playerAddresses;
    uint8 public turn;
    
    modifier onlyPlayers() {
        require(players[msg.sender].addr == msg.sender, "Not a registered player");
        _;
    }
    
    function joinGame() external {
        require(playerAddresses.length < 2, "Game is full");
        require(players[msg.sender].addr != msg.sender, "Already joined");
        
        players[msg.sender] = Player(msg.sender, false, [[CellStatus.Empty]], 3);
        playerAddresses.push(msg.sender);
    }
    
    function placeShip(uint8 x, uint8 y) external onlyPlayers {
        require(!players[msg.sender].ready, "Already placed ships");
        require(x < GRID_SIZE && y < GRID_SIZE, "Invalid coordinates");
        require(players[msg.sender].board[x][y] == CellStatus.Empty, "Already occupied");
        
        players[msg.sender].board[x][y] = CellStatus.Ship;
    }
    
    function readyUp() external onlyPlayers {
        players[msg.sender].ready = true;
    }
    
    function attack(uint8 x, uint8 y) external onlyPlayers {
        require(players[playerAddresses[turn]].addr == msg.sender, "Not your turn");
        require(x < GRID_SIZE && y < GRID_SIZE, "Invalid coordinates");
        
        address opponent = playerAddresses[turn == 0 ? 1 : 0];
        require(players[opponent].ready, "Opponent not ready");
        
        if (players[opponent].board[x][y] == CellStatus.Ship) {
            players[opponent].board[x][y] = CellStatus.Hit;
            players[opponent].remainingShips--;
        } else {
            players[opponent].board[x][y] = CellStatus.Miss;
        }
        
        if (players[opponent].remainingShips == 0) {
            // Game over, winner is msg.sender
        }
        
        turn = turn == 0 ? 1 : 0;
    }
}
