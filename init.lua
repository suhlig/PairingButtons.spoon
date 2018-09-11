--- === PairingButtons ===
---
--- Runs Hammerspoon code on pressing a physical button
---
--- In a pair programming session, this Spoon switches between each pair's
--- settings on the press of a button. Two buttons are connected to a Teensy
--- (or Arduino) which sends a MIDI SysEx message via USB when a button was
--- pressed. This Spoon applies whatever settings are associated with the button
--- that was pressed, e.g. switching the keyboard layout between German and US.
---
--- Installation:
--- 1. [Download the latest ZIP](https://github.com/suhlig/PairingButtons.spoon/releases)
--- 2. Unzip it to `~/.hammerspoon/Spoons/PairingButtons.spoon`
--- 3. Load it in `~/.hammerspoon/.init.lua` with `hs.loadSpoon("PairingButtons")`

local obj = {}

obj.__index = obj
obj.name = "PairingButtons"
obj.version = "1.0"
obj.author = "Steffen Uhlig <steffen@familie-uhlig.net>"
obj.homepage = "https://github.com/suhlig/PairingButtons.spoon"
obj.license = "MIT - https://opensource.org/licenses/MIT"

function obj:init()
  midiDevice = hs.midi.new("Teensy MIDI")

  if midiDevice then
    midiDevice:callback(onMidiMessage)
  else
    hs.alert("Could not find MIDI device")
  end
end

local function getSetting (label, default)
  return hs.settings.get(obj.name .. "." .. label) or default
end

local function setSetting (label, value)
  hs.settings.set(obj.name .. "." .. label, value); return value
end

local DEFAULT_DRIVER = "Steffen"

function onMidiMessage(object, deviceName, commandType, description, metadata)
  if metadata.manufacturerID == 0x42 then
    driver = getSetting("driver", nil)

    -- TODO Keep a table that maps key code to driver name
    if metadata.sysexData == "07" then
      if driver == nil then
        driver = DEFAULT_DRIVER
      elseif driver == "Steffen" then
        hs.alert(driver .. " is still the driver")
      else
        driver = setSetting("driver", "Steffen")
        hs.alert(driver .. " is now the driver")

        -- TODO put into its own function or file, mapped by driver name
        hs.keycodes.setLayout("German")
      end
    elseif metadata.sysexData == "08" then
      if driver == nil then
        driver = DEFAULT_DRIVER
      elseif driver == "Julz" then
        hs.alert(driver .. " is still the driver")
      else
        driver = setSetting("driver", "Julz")
        hs.alert(driver .. " is now the driver")

        -- TODO put into its own function or file, mapped by driver name
        hs.keycodes.setLayout("U.S.")
      end
    end
  end
end

return obj
