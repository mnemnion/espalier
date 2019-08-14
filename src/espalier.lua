








local ss      = require "singletons"
local dot     = require "espalier/dot"
local elpatt  = require "espalier/elpatt"
local Node    = require "espalier/node"
-- local Spec    = require "espalier/spec"
local Grammar = require "espalier/grammar"

local ortho8600 = require "espalier/grammars/ortho-8600"

local grammars = {ortho8600 = ortho8600}

return { dot      = dot,
         elpatt   = elpatt,
         node     = Node,
 --        spec    = Spec,
         phrase   = ss.Phrase,
         grammar  = Grammar,
         grammars = grammars,
         stator   = ss.Stator }
