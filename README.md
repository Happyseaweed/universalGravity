# universalGravity
A program made with Java in Processing that simulates how different planets effect each other's orbits.

Controls:
  [Left mouse button] = spawn a new planet.
  [P] = pause simulation.

Other Notes:
The 'yeet' problem
  - When two bodies of mass encounter each other at close distances, both bodies have high acceleration due to the close encounter and it results in both getting thrown
    off into the distance.
  - I believed this to be an calculation speed problem: the positions of the bodies change faster than the calculations are being done. i.e. when the calculation finishes,
    it is already too late and the force exerted on each body is already too small to prevent them from getting thrown off the screen.
  - A solution I found to this problem is just to adjust the force of gravity proportionally to the distance.
  - This solution is currently implemented and it works quite well.
  
The Collision problem
  - Collision is not implemented at the moment.
  - Therefore, if two masses were to 'collide' they would go through each other and each would be thrown off the screen at a very high velocity.
  
  
Creators: Siwei Du
Uploaded: Feburary.11th.2021
