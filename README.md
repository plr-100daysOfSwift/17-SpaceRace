# SpaceRace

[Hacking with Swift: 100 Days of Swift - Project 17][1]

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## Challenge

1. Stop the player from cheating by lifting their finger and tapping elsewhere – try implementing touchesEnded() to make it work.
2. Make the timer start at one second, but then after 20 enemies have been made subtract 0.1 seconds from it so it’s triggered every 0.9 seconds. After making 20 more, subtract another 0.1, and so on. Note: you should call invalidate() on gameTimer before giving it a new value, otherwise you end up with multiple timers.
3. Stop creating space debris after the player has died.

[1]: https://www.hackingwithswift.com/100/62