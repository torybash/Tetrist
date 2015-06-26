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

-- ========================================================================== --
--   Platform implementation.                                                 --
--   Copyright (c) 2011 Laurens Rodriguez Oscanoa.                            --
-- -------------------------------------------------------------------------- --

-- Screen size 
local SCREEN_WIDTH  = 800;
local SCREEN_HEIGHT = 600;

-- Size of square tile 
local TILE_SIZE = 16;

-- Board up-left corner coordinates 
local BOARD_X = 320;
local BOARD_Y = 0;

-- Game over text
local GAMEOVER_X    = 220;
local GAMEOVER_Y    = 450;

-- Score position and length on screen 
local SCORE_X      = 108;
local SCORE_Y      = 52;
local SCORE_LENGTH = 10;

-- Lines position and length on screen 
local LINES_X      = 10;
local LINES_Y      = 550;
local LINES_LENGTH = 5;

-- Level position and length on screen 
local LEVEL_X      = 108;
local LEVEL_Y      = 16;
local LEVEL_LENGTH = 5;

local HIGHSCORE_X = 665;
local HIGHSCORE_Y = 10;

-- Tetromino subtotals position 
local TETROMINO_X   = 425;
local TETROMINO_L_Y = 53;
local TETROMINO_I_Y = 77;
local TETROMINO_T_Y = 101;
local TETROMINO_S_Y = 125;
local TETROMINO_Z_Y = 149;
local TETROMINO_O_Y = 173;
local TETROMINO_J_Y = 197;

-- Keys info
local KEYS_INFO_X   = 10;
local KEY_RESTART_Y = 10;
local KEY_MOVEUP_Y = 35;
local KEY_MOVELR_Y = 60;
local KEY_MOVEDOWN_Y = 85;
local KEY_DROP_Y = 110;

-- Size of subtotals 
local TETROMINO_LENGTH = 5;

-- Tetromino total position 
local PIECES_X      = 418;
local PIECES_Y      = 221;
local PIECES_LENGTH = 6;

-- Size of number 
local NUMBER_WIDTH  = 7;
local NUMBER_HEIGHT = 9;
    
isInitialized = false;    
    
Platform = { 
    m_bmpBackground = nil;
    m_bmpBlocks = nil;
    m_bmpNumbers = nil;    
    
    m_blocks = nil;
    m_numbers = nil;

    m_musicLoop = nil;
    m_musicIntro = nil;
    m_musicMute = nil;
};
    
-- Initializes platform.
function Platform:init()
    -- Initialize random generator
    math.randomseed(os.time());

    -- Load images.
    self.m_bmpBackground = love.graphics.newImage("bg.png");
    
    self.m_bmpBlocks = love.graphics.newImage("blocks.png");
    self.m_bmpBlocks:setFilter("nearest", "nearest");    
    local w = self.m_bmpBlocks:getWidth();
    local h = self.m_bmpBlocks:getHeight();

    -- Load music.
	-- self.m_musicIntro = love.audio.newSource("stc_theme_intro.ogg");
	-- self.m_musicIntro:setVolume(0.5);
	-- self.m_musicIntro:play();
	-- self.m_musicLoop = love.audio.newSource("stc_theme_loop.ogg", "stream");
	-- self.m_musicLoop:setLooping(true);
	-- self.m_musicLoop:setVolume(0.5);
	-- m_musicMute = false;

    -- Create quads for blocks
    self.m_blocks = {};
   for shadow = 0, 1 do
       self.m_blocks[shadow] = {};
        for color = 0, Game.COLORS - 1 do
            self.m_blocks[shadow][color] = love.graphics.newQuad(TILE_SIZE * color, TILE_SIZE * shadow,
                                                                 TILE_SIZE, TILE_SIZE, w, h);
        end
    end

    isInitialized = true;
end

-- Process events and notify game.
function Platform:onKeyDown(key)
    if (key == "escape") then
        love.event.push("quit");
    end
    if ((key == "left") or (key == "a")) then
        Game:onEventStart(Game.Event.MOVE_LEFT);
    end
    if ((key == "right") or (key == "d")) then
        Game:onEventStart(Game.Event.MOVE_RIGHT);
    end
    if ((key == "down") or (key == "s")) then
        Game:onEventStart(Game.Event.MOVE_DOWN);
    end
    if ((key == "up") or (key == "w")) then
        Game:onEventStart(Game.Event.ROTATE_CW);
    end
   if (key == " ") then
       Game:onEventStart(Game.Event.DROP);
   end
    if (key == "r") then
        Game:onEventStart(Game.Event.RESTART);
    end
    if (key == "f1") then
        Game:onEventStart(Game.Event.PAUSE);
    end
    -- if (key == "f2") then
    --     Game:onEventStart(Game.Event.SHOW_NEXT);
    -- end
    -- if (key == "f3") then
    --     Game:onEventStart(Game.Event.SHOW_SHADOW);
    -- end
end

function Platform:onKeyUp(key)
    if ((key == "left") or (key == "a")) then
        Game:onEventEnd(Game.Event.MOVE_LEFT);
    end
    if ((key == "right") or (key == "d")) then
        Game:onEventEnd(Game.Event.MOVE_RIGHT);
    end
    if ((key == "down") or (key == "s")) then
        Game:onEventEnd(Game.Event.MOVE_DOWN);
    end
    if ((key == "up") or (key == "w")) then
        Game:onEventEnd(Game.Event.ROTATE_CW);
    end
--    if (key == "f4") then
--		if (self.m_musicMute) then
--			if (self.m_musicIntro) then
--				self.m_musicIntro:resume();
--			else
--				self.m_musicLoop:resume();
--			end
--		else
--			if (self.m_musicIntro) then
--				self.m_musicIntro:pause();
--			else
--				self.m_musicLoop:pause();
--			end
--		end
--		self.m_musicMute = not self.m_musicMute;
--    end
end

-- Draw a tile from a tetromino
function Platform:drawTile(x, y, tile, shadow)
    love.graphics.draw(self.m_bmpBlocks, self.m_blocks[shadow][tile], x, y);
end


-- Render the state of the game using platform functions.
function Platform:renderGame()

  if (not isInitialized) then return; end

    -- Draw background
    love.graphics.draw(self.m_bmpBackground, 0, 0);

    if (Game.m_isOver) then
        love.graphics.setNewFont(70);
        love.graphics.setColor(0, 0, 0);
        love.graphics.print("GAME OVER", GAMEOVER_X, GAMEOVER_Y);
        love.graphics.setColor(255, 255, 255);
     end

    -- Draw shadow tetromino
    if (Game:showShadow() and Game:shadowGap() > 0) then
        for i = 0, Game.TETROMINO_SIZE - 1 do
            for j = 0, Game.TETROMINO_SIZE - 1 do
                if (Game:fallingBlock().cells[i][j] ~= Game.Cell.EMPTY) then
                    Platform:drawTile(BOARD_X + (TILE_SIZE * (Game:fallingBlock().x + i)),
                                      BOARD_Y + (TILE_SIZE * (Game:fallingBlock().y + Game:shadowGap() + j)),
                                      Game:fallingBlock().cells[i][j], 1);
                end
            end
        end
    end

    -- Draw the cells in the board
    for i = 0, Game.BOARD_TILEMAP_WIDTH - 1 do
        for j = 0, Game.BOARD_TILEMAP_HEIGHT - 1 do
            if (Game:getCell(i, j) ~= Game.Cell.EMPTY) then
                Platform:drawTile(BOARD_X + (TILE_SIZE * i),
                                  BOARD_Y + (TILE_SIZE * j),
                                  Game:getCell(i, j), 0);
            end
        end
    end

    -- Draw falling tetromino
    for i = 0, Game.TETROMINO_SIZE - 1 do
        for j = 0, Game.TETROMINO_SIZE - 1 do
            if (Game:fallingBlock().cells[i][j] ~= Game.Cell.EMPTY) then
                Platform:drawTile(BOARD_X + TILE_SIZE * (Game:fallingBlock().x + i),
                                  BOARD_Y + TILE_SIZE * (Game:fallingBlock().y + j),
                                  Game:fallingBlock().cells[i][j], 0);
            end
        end
    end
    
    -- Draw game statistic data
    if (not Game:isPaused()) then
        --Show stats
        love.graphics.setNewFont(36);
        love.graphics.print("Lines: " .. Game:stats().lines, LINES_X, LINES_Y);
        love.graphics.setNewFont(18);
        love.graphics.print("High score: " .. Game:getHighScore(), HIGHSCORE_X, HIGHSCORE_Y);



        --Show help data
         love.graphics.setNewFont(14);
         love.graphics.print("R: Restart", KEYS_INFO_X, KEY_RESTART_Y);
         love.graphics.print("UP: Rotate", KEYS_INFO_X, KEY_MOVEUP_Y);
         love.graphics.print("LEFT/RIGHT: Move left/right", KEYS_INFO_X, KEY_MOVELR_Y);
         love.graphics.print("DOWN: Move down", KEYS_INFO_X, KEY_MOVEDOWN_Y);
         love.graphics.print("SPACE: Drop", KEYS_INFO_X, KEY_DROP_Y);

    end

	-- Adding music loop check here for convenience.
	-- if (self.m_musicIntro) then
	-- 	if (self.m_musicIntro:isStopped()) then
	-- 		self.m_musicIntro = nil;
	-- 		self.m_musicLoop:play();
	-- 	end
	-- end
end

function Platform:getSystemTime()
    return math.floor(1000 * love.timer.getTime());
end

function Platform:random()
    return math.random(1000000000);
end
