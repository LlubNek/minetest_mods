minetest_mods
=============

Various mods for minetest.

For mods without their own README, consider these CC0 or WTFPL.


player_data
-----------

Allows you to associate persistent data with a particular player name (or other string).


home_positions
--------------

Adds a new command, '/home', which allows a player to set their respawn point.
Also adds '/where', which reports the player's position, and '/killme', which kills the player.

This mod depends on player_data.


stairs2
-------

Modifies the default stairs mod to allow other mods to define new stairs and slabs, and adds desert stone and glass stairs and slabs.

This mod depends on default and stairs, and uses code derived from the stairs mod.

This mod is licensed under LGPL 2.1.  See the README.txt file in the mod directory for more information.
