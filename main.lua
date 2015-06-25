-- ========================================================================== --
--                          STC - SIMPLE TETRIS CLONE                         --
-- -------------------------------------------------------------------------- --
--   A simple tetris clone in Lua using the LOVE engine:                      --
--   http://love2d.org/                                                       --
--                                                                            --
-- -------------------------------------------------------------------------- --
--   Copyright (c) 2011 Laurens Rodriguez Oscanoa.                            --
--                                                                            --
--   Permission is hereby granted, free of charge, to any person              --
--   obtaining a copy of this software and associated documentation           --
--   files (the "Software"), to deal in the Software without                  --
--   restriction, including without limitation the rights to use,             --
--   copy, modify, merge, publish, distribute, sublicense, and/or sell        --
--   copies of the Software, and to permit persons to whom the                --
--   Software is furnished to do so, subject to the following                 --
--   conditions:                                                              --
--                                                                            --
--   The above copyright notice and this permission notice shall be           --
--   included in all copies or substantial portions of the Software.          --
--                                                                            --
--   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,          --
--   EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES          --
--   OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND                 --
--   NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT              --
--   HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,             --
--   WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING             --
--   FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR            --
--   OTHER DEALINGS IN THE SOFTWARE.                                          --
-- -------------------------------------------------------------------------- --

require("game");
require("platform")
require("trist");
require("trist_control");
require("trist_menu");






function love.load()
	io.stdout:setvbuf("no") --Print to console

  love.graphics.setNewFont(18)

 
  
  TristControl:init();

	
 
    
end



function love.update(dt)
  TristControl.update(dt);
end

function love.draw()
  TristControl:renderGame();
end

function love.keypressed(key, unicode)
  --TristControl:onKeyDown(key);
  
  Platform:onKeyDown(key);
   
end

function love.keyreleased(key)
   Platform:onKeyUp(key);
  --TristControl:onKeyUp(key);    
end

function love.mousepressed(x, y, button)
  --DEBUG SHOULD NOT BE HERE
  print(x, y);
  if (button ~= "l") then return; end
  if (x > 490 and x < 790) then
      if (y > 380 and y < 480) then
        TristControl:startGame(1);
      elseif (y > 490 and y < 590) then
        TristControl:startGame(0);
      end
  end
    
  --TristControl.mousePressed(newx, newy, button);
end
