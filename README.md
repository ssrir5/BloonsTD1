# Bloons Tower Defense Game Development

## Project Overview

This project is a fully functional **Bloons Tower Defense** game, created from scratch using **System Verilog**. The game simulates bloons moving along a path while the player defends against them using a character that launches darts to pop the bloons. The project was developed over the course of **May 2023 - June 2023** and features various game mechanics and an FPGA-based USB communication interface for connectivity.

## Key Features

- **Bloon Generation and Path Mechanics**: Implemented procedural bloon generation and developed path-following mechanics to simulate the movement of bloons through the game map.
  
- **Collision Detection**: Developed precise bloon-dart collision detection logic to ensure accurate gameplay, where darts hit and pop the bloons.

- **Character with Aiming Algorithms**: Integrated a main character with advanced aiming algorithms to dynamically target bloons and launch darts. Ensured valid character placement within the game environment.

- **USB Communication Interface**: Designed and integrated an **FPGA-based USB communication interface** using **SPI** and **PIOs** to handle connectivity and facilitate smooth game operations.

## Technologies Used

- **System Verilog**: For game logic, bloon generation, and collision detection.
- **FPGA Development**: Implemented the game logic on an FPGA, allowing real-time play.
- **SPI and PIOs**: Utilized for the USB communication interface.

## Future Improvements

- Enhanced graphics and sound effects.
- Increased levels of complexity for the game mechanics.
- Additional tower types and bloon varieties.
