

require("game");
require("platform")
require("trist");
require("trist_control");
require("trist_menu");


function love.load()
	io.stdout:setvbuf("no") --Print to console

  TristControl:init();
end

function love.update(dt)
  TristControl.update(dt);
end

function love.draw()
  TristControl:renderGame();
end

function love.keypressed(key, unicode)
  TristControl:keypressed(key, unicode);
end

function love.keyreleased(key)
  TristControl:keyreleased(key);
end

function love.mousepressed(x, y, button)
  TristControl:mousePressed(x, y, button);
end
