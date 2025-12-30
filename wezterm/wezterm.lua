local Config = require("config")

require("events.gui-startup").setup()

return Config:init()
	:append(require("config.appearance"))
	:append(require("config.bindings"))
	:append(require("config.fonts"))
	:append(require("config.general")).options
