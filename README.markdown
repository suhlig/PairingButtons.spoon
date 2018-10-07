# PairingButtons

[![Build Status](https://travis-ci.org/suhlig/PairingButtons.spoon.svg?branch=master)](https://travis-ci.org/suhlig/PairingButtons.spoon)

In a pair programming session, this [Spoon](http://www.hammerspoon.org/Spoons) switches between each engineer's settings on the press of a button. It runs [Hammerspoon](http://www.hammerspoon.org/) code on pressing one of the physical buttons and applies the current driver's preferences to the workstation shared between the two engineers, e.g. switching the keyboard layout between German and US.

The two buttons are connected to a [Teensy](https://www.pjrc.com/teensy) (or Arduino) which sends a MIDI SysEx message via USB when a button was pressed.

  ![Detail view of pairing buttons](detail.jpg)

# Example

This pairing station consists of

- two (mirrored) screens,
- two keyboards (one built-in to the laptop, one via external USB), and
- two pointing devices (trackpad of the laptop, and an external USB mouse).

  ![](pairing-station.jpg)

In this setting, the pairing buttons should be placed between the two engineers, so that both can easily reach their designated button.

Both engineers have equal opportunity to be driver or navigator. All it takes to signal that one wants to drive is to press a button:

  ![A person presses the button to signal that she becomes the driver](in-action.jpg)

The act of reaching for and pressing the button, the sound it makes (it's a mechanical button, after all), and the LED of the button lighting up is a clear sign that this person has taken over the driver's responsibility. Hence, the other engineer becomes the navigator.

Swapping again is equally simple - the current navigator presses the button, has her preferences applied, and assumes the driver role.

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
