# tic-tac-toe
##Tic Tac Toe game that never loses!
To install:
```
$ git clone git@github.com:davidjoliver/tic-tac-toe.git
$ cd tic-tac-toe
$ bundle exec rake play
```

After you pick "X" or "O", you will see the game board:

```
_|_|_
_|_|_
_|_|_

Pick a square:
```

Make your move by entering coordinates: `0,0` is the upper left corner, `1,1` is the middle, `2,2` is bottom right, etc.

When you hit return, the computer will think for a couple of seconds and make it's move.

Type `quit` to leave the game. To play a new game, just `$ bundle exec rake play` again.
