m_bmpBackground = null;

TristMenu = {
  
};

function TristMenu:initMenu()
	    -- Load images.
    self.m_bmpBackground = love.graphics.newImage("menu.png");

end

function TristMenu:renderMenu()
  
  love.graphics.draw(self.m_bmpBackground, 0, 0);
end

