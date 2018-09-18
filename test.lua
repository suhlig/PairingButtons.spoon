lu = require('luaunit')
pb = require('init')

function testAddPositive()
  lu.assertEquals("PairingButtons", pb.name)
end

os.exit(
  lu.LuaUnit.run()
)
