TristControl = {
  State = {
      MENU = 0,
      GAME = 1
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
  Trist:init(0);
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


function TristControl:onKeyDown(key)
  if (m_state == TristControl.State.MENU) then
      
  elseif (m_state == TristControl.State.GAME) then
     Platform:onKeyDown(key);
  end
   
end

function TristControl:onKeyUp(key)
    if (m_state == TristControl.State.MENU) then
      
  elseif (m_state == TristControl.State.GAME) then
     Platform:onKeyUp(key);
  end
end


function TristControl:mousePressed(x, y, button)
  print(x, y, button);
  if (x > 490 and x < 790) then
      if (y > 100 and y < 200) then
        TristControl:startGame(0);
      elseif (y > 210 and y < 310) then
        TristControl:startGame(1);
      end
  end
end