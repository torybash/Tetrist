TristControl = {
  State = {
      MENU = 0,
      GAME = 1,
      GAME_OVER = 2
  };
};

state = null;  

function TristControl:init()
  state = TristControl.State.MENU;
  TristMenu:initMenu();
end

function TristControl:startGame(difficulty)
  if (state == TristControl.State.GAME) then return; end
  state = TristControl.State.GAME;
  
  Platform:init()
  Trist:init(difficulty);
  useEvilOrder = false;
  if (difficulty > 0) then useEvilOrder = true; end
  Game:start(useEvilOrder);
  
  print("Starting game!");
end


function TristControl:update(dt)
  if (state == TristControl.State.MENU) then
    
  elseif (state == TristControl.State.GAME) then
    Game:update();
  end
end


function TristControl:renderGame()
  if (state == TristControl.State.MENU) then
    TristMenu:renderMenu();
  elseif (state == TristControl.State.GAME) then
     Platform:renderGame();
  end
    
end


function TristControl:keypressed(key, unicode)
  if (state == TristControl.State.MENU) then
      
  elseif (state == TristControl.State.GAME) then
     Platform:onKeyDown(key);
  end
   
end

function TristControl:keyreleased(key)


  if (state == TristControl.State.MENU) then
      
  elseif (state == TristControl.State.GAME) then
     Platform:onKeyUp(key);
  end
end


function TristControl:mousePressed(x, y, button)
  print(x, y);
  print(state);
  if (state == TristControl.State.MENU) then
    if (button ~= "l") then return; end
    if (x > 490 and x < 790) then
        if (y > 380 and y < 480) then
          TristControl:startGame(1);
        elseif (y > 490 and y < 590) then
          TristControl:startGame(0);
        end
    end
  elseif (state == TristControl.State.GAME) then

  end

end