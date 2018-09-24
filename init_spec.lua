describe('PairingButtons', function()
  local pairingButtons = require("init")
  local currentDriver = nil
  local sysexData = nil

  it('has a name', function()
    assert.are.equals('PairingButtons', pairingButtons.name)
  end)

  setup(function()
    _G.hs = {
      settings = {
        get = function(_) return currentDriver end,
        set = function(key, value) end
      },
      alert = function(_) end,
      keycodes = { setLayout = function(layout) end },
    }
  end)

  teardown(function()
    _G.hs = nil
  end)

  before_each(function()
    metadata = {
      manufacturerID = 0x42,
      sysexData = sysexData,
    }

    spy.on(hs.settings, 'get')
    spy.on(hs.settings, 'set')
    spy.on(hs, 'alert')
    spy.on(hs.keycodes, 'setLayout')
  end)

  describe('when Steffen is the current driver', function()
    setup(function() currentDriver = 'Steffen' end)

    describe('button 7 was pressed', function()
      setup(function() sysexData = '07' end)

      it('keeps Steffen as the current driver', function()
        onMidiMessage(_, _, _, _, metadata)

        assert.spy(hs.settings.get).was_called_with('PairingButtons.driver')
        assert.spy(hs.alert).was_called_with('Steffen is still the driver')
      end)
    end)

    describe('button 8 was pressed', function()
      setup(function() sysexData = '08' end)

      it('switches the current driver to Julz', function()
        onMidiMessage(_, _, _, _, metadata)

        assert.spy(hs.settings.get).was_called_with('PairingButtons.driver')
        assert.spy(hs.settings.set).was_called_with('PairingButtons.driver', 'Julz')
        assert.spy(hs.alert).was_called_with('Julz is now the driver')
        assert.spy(hs.keycodes.setLayout).was_called_with('U.S.')
      end)
    end)
  end)

  describe('when Julz is the current driver', function()
    setup(function() currentDriver = 'Julz' end)

    describe('button 7 was pressed', function()
      setup(function() sysexData = '07' end)

      it('switches the current driver to Steffen', function()
        onMidiMessage(_, _, _, _, metadata)

        assert.spy(hs.settings.get).was_called_with('PairingButtons.driver')
        assert.spy(hs.settings.set).was_called_with('PairingButtons.driver', 'Steffen')
        assert.spy(hs.alert).was_called_with('Steffen is now the driver')
        assert.spy(hs.keycodes.setLayout).was_called_with('German')
      end)
    end)

    describe('button 8 was pressed', function()
      setup(function() sysexData = '08' end)

      it('keeps Julz as the current driver', function()
        onMidiMessage(_, _, _, _, metadata)

        assert.spy(hs.settings.get).was_called_with('PairingButtons.driver')
        assert.spy(hs.alert).was_called_with('Julz is still the driver')
      end)
    end)
  end)
end)
