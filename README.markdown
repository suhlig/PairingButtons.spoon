# PairingButtons

[![Build Status](https://travis-ci.org/suhlig/PairingButtons.spoon.svg?branch=master)](https://travis-ci.org/suhlig/PairingButtons.spoon)

Runs [Hammerspoon](http://www.hammerspoon.org/) code on pressing a physical button.

In a pair programming session, this [Spoon](http://www.hammerspoon.org/Spoons) switches between each pair's settings on the press of a button. Two buttons are connected to a [Teensy](https://www.pjrc.com/teensy) (or Arduino) which sends a MIDI SysEx message via USB when a button was pressed.

This Spoon applies whatever settings are associated with the button that was pressed, e.g. switching the keyboard layout between German and US.

# Installation

1. [Download the latest ZIP](https://github.com/suhlig/PairingButtons.spoon/archive/master.zip)
2. Unzip it to `~/.hammerspoon/Spoons/PairingButtons.spoon`
3. Load it in `~/.hammerspoon/init.lua` with `hs.loadSpoon("PairingButtons")`
4. On the Teensy, connect a button between pins 7 and ground and another between pin 8 and ground.
5. Open the `PairingButtons.ino` file with the [Teensyduino IDE](https://www.pjrc.com/teensy/teensyduino.html) and upload it to the Teensy (or Arduino). Make sure you have the [USB mode set to MIDI](https://www.pjrc.com/teensy/td_midi.html).
6. While still connected by USB, the Teensy now behaves like a MIDI device and will send a SysEx message for each button pressed, which triggers the Spoon.

# Development

```sh
$ luarocks install busted
$ busted .
```

Run all tests whenever a Lua file has changed:

```sh
$ fswatch -r *.lua | xargs -I {} busted .
```

# TODO

* As confirmation, switch the LEDs from Hammerspoon (instead of just within the Teensy program)
