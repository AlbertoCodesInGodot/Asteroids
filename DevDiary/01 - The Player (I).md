# The Player - Dev Diary I

### Goal

Create a first functional version of the game:

- Basic black background representing the universe.
- Simple space ship with basic movement logic.
- Scene borders interconnected (so wen user crosses a screen border he appears in the opposite border).

### Implementation

#### Project Settings

#### The Player (I)

In our game, the player is a triangle-shaped space ship floating on space. The ship has a set of prepellers on its back and left and right wings. The ship can then prepel forward or left and right by rotating over its center (tank controls). While prepelling forward the ship carries some inertia. When the ship stops, that inertia keeps pushing the ship forward, and decreases gradually until the ship stops.

1. 