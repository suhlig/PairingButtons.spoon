-- function spoon:init()
--   createMenuBar()
-- end

function createMenuBar()
  menuBar = hs.menubar.new()
  menuBar:setTitle("PB")
  menuBar:setMenu({
    { title = "About Pairing Buttons...", fn = onClickAbout },
    { title = "-" },
    newSetupMenuEntry("Left"),
    newSetupMenuEntry("Right"),
  })
end

function onClickAbout()
  hs.dialog.alert(
    0, 0, function(_) end , "Pairing Buttons",
    "Runs Hammerspoon code on pressing a physical button",
    "Dismiss", nil, "NSInformationalAlertStyle"
  )
end

function newSetupMenuEntry(side)
  return {
    title = "Set " .. side .. " Pair...",
    fn = function() onClickSetup(side) end
  }
end

function onClickSetup(side)
  button, input = hs.dialog.textPrompt(side .. " pair", "Please enter your name:", side, "OK", "Cancel")

  if button == "OK" then
    hs.alert("Hello " .. input)
  end
end
