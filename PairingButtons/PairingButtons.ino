#include <Bounce.h>

const byte SYSEX_BEGIN     = 0xF0;
const byte SYSEX_END       = 0xF7;
const byte MANUFACTURER_ID = 0x42;

// Create Bounce objects for each button.  The Bounce object
// automatically deals with contact chatter or "bounce", and
// it makes detecting changes very simple.
Bounce button7 = Bounce(7, 5);
Bounce button8 = Bounce(8, 5);
int ledLeft = 14;
int ledRight = 15;

void setup() {
  pinMode(7, INPUT_PULLUP);
  pinMode(8, INPUT_PULLUP);
  pinMode(ledLeft, OUTPUT);
  pinMode(ledRight, OUTPUT);
}

void loop() {
  // Update all the buttons.  There should not be any long
  // delays in loop(), so this runs repetitively at a rate
  // faster than the buttons could be pressed and released.
  button7.update();
  button8.update();

  if (button7.fallingEdge()) {
    // see https://stackoverflow.com/a/15720219/3212907 and
    // https://cnx.org/contents/csA1TDZU@3/MIDI-Messages#id-758884344759
    byte data[] = { SYSEX_BEGIN, MANUFACTURER_ID, 0x07, SYSEX_END };
    usbMIDI.sendSysEx(sizeof(data), data, true);

    digitalWrite(ledLeft, HIGH);
    digitalWrite(ledRight, LOW);
  }

  if (button8.fallingEdge()) {
    byte data[] = { SYSEX_BEGIN, MANUFACTURER_ID, 0x08, SYSEX_END };
    usbMIDI.sendSysEx(sizeof(data), data, true);

    digitalWrite(ledLeft, LOW);
    digitalWrite(ledRight, HIGH);
  }

  if (button7.risingEdge()) {
  }

  // MIDI Controllers should discard incoming MIDI messages.
  // http://forum.pjrc.com/threads/24179-Teensy-3-Ableton-Analog-CC-causes-midi-crash
  while (usbMIDI.read()) {
    // ignore incoming messages
  }
}
