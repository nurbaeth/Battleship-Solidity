# Battleship Solidity

A blockchain-based Battleship game implemented in Solidity. Players can join the game, deploy their ships, and take turns attacking coordinates. The game logic runs on-chain, ensuring transparency and fairness.

## Features
- **Two-player turn-based gameplay**
- **Decentralized game logic** on the Ethereum blockchain
- **Smart contract-enforced fairness**
- **Fully transparent battles**

## How It Works
1. **Players Join**: Two players join the game by calling `joinGame()`.
2. **Ship Placement**: Each player places their ships using `placeShip(x, y)`.
3. **Ready Check**: Once ships are placed, players confirm their readiness with `readyUp()`.
4. **Turn-Based Attacks**: Players take turns attacking enemy coordinates using `attack(x, y)`.
5. **Win Condition**: The player who destroys all enemy ships first wins.

## Smart Contract Overview
The contract uses a 5x5 grid where each cell can have one of the following states:
- **Empty**: No ship placed
- **Ship**: A ship is present
- **Hit**: A ship has been hit
- **Miss**: An attack missed

## Deployment
To deploy the contract, use Remix, Hardhat, or Foundry:
```sh
yarn hardhat deploy --network <network>
```

## Future Improvements
- Expand to larger grid sizes
- Support for more than two players
- On-chain randomness for ship placement

## License
This project is licensed under the MIT License.

