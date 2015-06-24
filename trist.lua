Trist = { 

	createTetromino = function()
        local tetromino = {
            cells = {}; -- Tetromino buffer
            x = 0;
            y = 0;
            size = 0;
            type = nil;
        };
        return tetromino;
    end;
};

function Trist:getHardestTetromino()
  
  
  
  
  
  
  	
  
  
  

  tetromino = Platform:random() % Game.TETROMINO_TYPES;
  tetromino = 0;
  
  rating = Trist:bestWellRating(Game.m_map, tetromino, 10);
  
  print("Best block is: " .. tostring(bestBlock));
  return tetromino;
  
  

end


function Trist:worstPiece()
	worstRating = null;
	worstId = null;

	for piece=1,Game.TETROMINO_TYPES do
		print("eh");
		--currentRating = bestWellRating(thisWell, piece, searchDepth);
	end

end


function Trist:bestWellRating(thisWell, pieceId, thisSearchDepth)

	-- thisPiece = {
	-- 	id = pieceId,
	-- 	x  = 0,
	-- 	y  = 0,
	-- 	o  = 0
	-- };



	-- thisBlock = {
 --            cells = {}, -- Tetromino buffer
 --            x = 0,
 --            y = 0,
 --            size = 0,
 --            type = nil
 --        };
 --	thisBlock = Trist:createTetromino();
--	thisBlock = Game:createTetromino();

	thisWellhighestBlue = Game.BOARD_TILEMAP_HEIGHT;

	thisBlock = Trist:createTetromino();
	Game:setTetromino(pieceId, thisBlock);
	thisBlock.type = pieceId;

			-- 	// iterate over all possible resulting positions and get
			-- 	// best rating
			 	bestRating = null;
			-- 	// move the piece down to a lower position before we have to
			-- 	// start pathfinding for it
			-- 	// move through empty rows
				while 
			 		thisBlock.y + 4 < Game.BOARD_TILEMAP_HEIGHT    -- piece is above the bottom
					and thisWell[thisBlock.x][thisBlock.y + 4] == -1 -- nothing immediately below it
				do 
					thisBlock, hasCollision = Trist:tryTransform(thisWell, thisBlock, "D"); --// down
				end

				piecePositions = {};
				piecePositions[1] = thisBlock;

				hashCodes = {};
				hashCodes[Trist:pieceHash(thisBlock)] = 1;

				i = 0; c = 1;
				while (i < #piecePositions) do

					thisBlock = piecePositions[i+1];
					

					-- apply all possible transforms
					for j=1,4 do
						typ = "";
						if (j==1) then typ="U"; elseif (j==2) then typ="D";
							elseif (j==3) then typ="L";elseif (j==4) then typ="R";end

						newBlock, hasCollision = Trist:tryTransform(thisWell, thisBlock, typ);

						if hasCollision then
							print("hasCollision!");
							if (typ == "D") then
								--copy map
								newWell = {};
								for x=0,Game.BOARD_TILEMAP_WIDTH-1 do
									newWell[x] = {};
									for y=0,Game.BOARD_TILEMAP_HEIGHT-1 do
										newWell[x][y] = thisWell[x][y];
									end
								end
								newWellRating = -1;

								--add piece
								Trist:addPieceToWell(newWell, newWellRating, newBlock);

								--calculate value
								currentRating = newWellRating; -- + (
			-- 	TODO			thisSearchDepth == 0 ? worstPieceRating(newWell, thisSearchDepth-1) / 100

								-- store
			 					if(bestRating == null or currentRating > bestRating) then
			 						bestRating = currentRating;
			 						bestBlock = newBlock;
			 					end
								
							end
						else -- transform succeeded?
							-- new location? append to list
							-- check locations, they are significant
							newHashCode = Trist:pieceHash(newBlock);
							if (hashCodes[newHashCode] == null) then
								piecePositions[c] = newBlock;
								hashCodes[newHashCode] = 1;
							end
						end

						print("transfrom tried: " .. typ);
						Trist:printBlock(thisBlock);
						Trist:printBlock(newBlock);

					end
					i = i + 1;
				end

			-- 	// push first position
			-- 	var piecePositions = [];
			-- 	piecePositions.push(thisPiece);
			-- 	var ints = [];
			-- 	ints[hashCode(thisPiece.x, thisPiece.y, thisPiece.o)] = 1;
			-- 	// a simple for loop won't work here because
			-- 	// we are increasing the list as we go

			-- 	var i = 0;
			-- 	while(i < piecePositions.length) {
			-- 		thisPiece = piecePositions[i];
			-- 		// apply all possible transforms
			-- 		for(var j in transforms) {
			-- 			var newPiece = tryTransform(thisWell, thisPiece, j);
			-- 			// transformation failed?
			-- 			if(newPiece == null) {
			-- 				// piece locked? better add that to the list
			-- 				// do NOT check locations, they aren't significant here
			-- 				if(j == "D") {
			-- 					// make newWell from thisWell
			-- 					// no deep copying in javascript!!
			-- 					var newWell = {
			-- 						"content" : [],
			-- 						"score" : thisWell.score,
			-- 						"highestBlue" : thisWell.highestBlue
			-- 					};
			-- 					for(var row2 = 0; row2 < wellDepth; row2++) {
			-- 						newWell.content.push(thisWell.content[row2]);
			-- 					}
			-- 					// alter the well
			-- 					// this will update newWell, including certain well metadata
			-- 					addPiece(newWell, thisPiece);
			-- 					// here is the clever recursive search bit
			-- 					// higher is better
			-- 					var currentRating = newWell.highestBlue + (
			-- 						thisSearchDepth == 0 ?
			-- 							0
			-- 						:
			-- 							// deeper lines are worth less than immediate lines
			-- 							// this is so the game will never give you a line if it can avoid it
			-- 							// NOTE: make sure rating doesn't return a range of more than 100 values...
			-- 							worstPieceRating(newWell, thisSearchDepth-1) / 100
			-- 					);
			-- 					// store
			-- 					if(bestRating == null || currentRating > bestRating) {
			-- 						bestRating = currentRating;
			-- 					}
			-- 				}
			-- 			}
			-- 			// transform succeeded?
			-- 			else {
			-- 				// new location? append to list
			-- 				// check locations, they are significant
			-- 				var newHashCode = hashCode(newPiece.x, newPiece.y, newPiece.o);
			-- 				if(ints[newHashCode] == undefined) {
			-- 					piecePositions.push(newPiece);
			-- 					ints[newHashCode] = 1;
			-- 				}
			-- 			}
			-- 		}
			-- 		i++;
			-- 	}
			-- 	return bestRating;

			return bestRating, bestBlock;
end



function Trist:addPieceToWell(thisWell, thisWellRating, block)
				-- The falling tetromino has reached the bottom,
				-- so we copy their cells to the board map.
	for i = 0, block.size - 1 do
		for j = 0, block.size - 1 do
			if (block.cells[i][j] ~= Game.Cell.EMPTY) then
				thisWell[block.x + i][block.y + j] = block.cells[i][j];
			end
		end
	end


	--thisWellRating = math.min(thisWellRating, yActual);
end


function Trist:printWell(thisWell)

	string = "Well\n";
	for y=0,Game.BOARD_TILEMAP_HEIGHT-1 do
		for x=0,Game.BOARD_TILEMAP_WIDTH-1 do
			char = thisWell[x][y];
			if (thisWell[x][y] == -1) then char = "x"; end
			string = string .. char;
		end
		string = string .. "\n";
	end
	print(string);

end


function Trist:tryTransform(thisWell, thisPiece, transformId)

	--print("tryTransform" .. tostring(thisPiece));

	--copy piece
	copyPiece = Trist:createTetromino();
	copyPiece.cells = {};
	for x=0,Game.TETROMINO_SIZE-1 do
		copyPiece.cells[x] = {};
		for y=0,Game.TETROMINO_SIZE-1 do
			copyPiece.cells[x][y] = thisPiece.cells[x][y];
		end
	end
	copyPiece.cells = thisPiece.cells;
	copyPiece.x = thisPiece.x; copyPiece.y = thisPiece.y;
	copyPiece.size = thisPiece.size; copyPiece.type = thisPiece.type;

	hasCollision = false;

	-- apply transform (very fast now)
	if (transformId == "L") then
		hasCollision = Trist:moveTetromino(thisWell, copyPiece, -1, 0);
	elseif (transformId == "R") then
		hasCollision = Trist:moveTetromino(thisWell, copyPiece, 1, 0);
	elseif (transformId == "D") then
		hasCollision = Trist:moveTetromino(thisWell, copyPiece, 0, 1);
	elseif (transformId == "U") then
		Trist:rotateTetromino(thisWell, copyPiece, true);
	end


	return copyPiece, hasCollision;


end




-- Rotate falling tetromino. If there are no collisions when the
-- tetromino is rotated this modifies the tetromino's cell buffer.
function Trist:rotateTetromino(thisWell, block, clockwise)
    local i; local j;

	-- Temporary array to hold rotated cells.
	local rotated = {};  

	-- If TETROMINO_O is falling return immediately.
	if (block.type == Game.TetrominoType.O) then
		-- Rotation doesn't require any changes.
		return; 
	end

	-- Initialize rotated cells to blank.
	Game:setMatrixCells(rotated, Game.TETROMINO_SIZE, Game.TETROMINO_SIZE, Game.Cell.EMPTY);

	-- Copy rotated cells to the temporary array.
	for i = 0, block.size - 1 do
		for j = 0, block.size - 1 do
			if (clockwise) then
				rotated[block.size - j - 1][i] = block.cells[i][j];
			else
				rotated[j][block.size - i - 1] = block.cells[i][j];
			end
		end
	end

	local wallDisplace = 0;

	-- Check collision with left wall.
	if (block.x < 0) then
        i = 0;
		while ((wallDisplace == 0) and (i < -block.x)) do
			for j = 0, block.size - 1 do
				if (rotated[i][j] ~= Game.Cell.EMPTY) then
					wallDisplace = i - block.x;
					break;
				end
			end
            i = i + 1;
		end
	-- Or check collision with right wall.
	elseif (block.x > Game.BOARD_TILEMAP_WIDTH - block.size) then
		i = block.size - 1;
		while ((wallDisplace == 0) and (i >= Game.BOARD_TILEMAP_WIDTH - block.x)) do
			for j = 0, block.size - 1 do
				if (rotated[i][j] ~= Game.Cell.EMPTY) then
					wallDisplace = -block.x - i + Game.BOARD_TILEMAP_WIDTH - 1;
					break;
				end
			end
            i = i - 1;
        end
	end

	-- Check collision with board floor and other cells on board.
	for i = 0, block.size - 1 do
		for j = 0, block.size - 1 do
			if (rotated[i][j] ~= Game.Cell.EMPTY) then
				-- Check collision with bottom border of the map.
				if (block.y + j >= Game.BOARD_TILEMAP_HEIGHT) then
					-- There is a collision therefore return.
					return; 
                end
				-- Check collision with existing cells in the map.
				if (thisWell[i + block.x + wallDisplace][j + block.y] ~= Game.Cell.EMPTY) then
					-- There is a collision therefore return.
					return; 
				end
			end
		end
	end
	-- Move the falling piece if there was wall collision and it's a legal move.
	if (wallDisplace ~= 0) then
		block.x = block.x + wallDisplace;
	end

	-- There are no collisions, replace tetromino cells with rotated cells.
	for i = 0, Game.TETROMINO_SIZE - 1 do
		for j = 0, Game.TETROMINO_SIZE - 1 do
			block.cells[i][j] = rotated[i][j];
		end
	end

end


-- Move tetromino in the direction specified by (x, y) (in tile units)
-- This function detects if there are filled rows or if the move
-- lands a falling tetromino, also checks for game over condition.
function Trist:moveTetromino(thisWell, block, x, y)
	local i; local j;

	-- Check if the move would create a collision.
	if (Trist:checkCollision(thisWell, block, x, y)) then
		-- In case of collision check if move was downwards (y == 1)
		if (y == 1) then
			-- Check if collision occurs when the falling
			-- tetromino is on the 1st or 2nd row.
			if (block.y <= 1) then
				-- If this happens the game is over.
				--self.m_isOver = true;  
				print("over!") ;
			else
				-- The falling tetromino has reached the bottom,
				-- so we copy their cells to the board map.
				for i = 0, block.size - 1 do
					for j = 0, block.size - 1 do
						if (block.cells[i][j] ~= Game.Cell.EMPTY) then
							thisWell[block.x + i][block.y + j] = block.cells[i][j];
						end
					end
				end

				-- Check if the landing tetromino has created full rows.
				local numFilledRows = 0;
				for j = 1, Game.BOARD_TILEMAP_HEIGHT - 1 do
					local hasFullRow = true;
					for i = 0, Game.BOARD_TILEMAP_WIDTH - 1 do
						if (thisWell[i][j] == Game.Cell.EMPTY) then
							hasFullRow = false;
							break;
						end
					end
					-- If we found a full row we need to remove that row from the map
					-- we do that by just moving all the above rows one row below.
					if (hasFullRow) then
						for x = 0, Game.BOARD_TILEMAP_WIDTH - 1 do
							for y = j, 1, -1 do
								thisWell[x][y] = thisWell[x][y - 1];
							end
						end
						-- Increase filled row counter.
						numFilledRows = numFilledRows + 1;
					end
				end
			end
		end
		return true;
	else
		-- There are no collisions, just move the tetromino.
		block.x = block.x + x;
		block.y = block.y + y;
		return false;
	end
end



-- Check if tetromino will collide with something if it is moved in the requested direction.
-- If there are collisions returns 1 else returns 0.
function Trist:checkCollision(thisWell, block, dx, dy)

	local newx = block.x + dx;
	local newy = block.y + dy;
	local hasCollision = false;


	for i = 0, block.size - 1 do
		for j = 0, block.size - 1 do
			if (block.cells[i][j] ~= Game.Cell.EMPTY) then
				-- Check that tetromino would be inside the left, right and bottom borders.
				if ((newx + i < 0) or (newx + i >= Game.BOARD_TILEMAP_WIDTH)
								   or (newy + j >= Game.BOARD_TILEMAP_HEIGHT)) then
					hasCollision = true;
				end
				-- Check that tetromino won't collide with existing cells in the map.
				if (thisWell[newx + i][newy + j] ~= Game.Cell.EMPTY) then
					hasCollision = true;
				end
			end
		end
	end

	-- if (hasCollision == false) then
	-- 	block.x = newx;
	-- 	block.y = newy;
	-- end

	return hasCollision;
	
end


function Trist:pieceHash(block)

	hash = 1;
	hash = hash + block.x * 37;
	hash = hash + block.y * 37;
	hash = hash + block.size * 37;
	hash = hash + block.type * 37;

	return hash;
end


function Trist:printBlock(block)
	print("PrintBlock: " .. tostring(block) .. " - x, y: " .. tostring(block.x) .. "," .. tostring(block.y) ..", size: " .. tostring(block.size));
	str = "";
	for y=0,Game.TETROMINO_SIZE-1 do
		for x=0,Game.TETROMINO_SIZE-1 do
			char = block.cells[x][y];
			if (char == -1) then char = "x"; end
			str = str .. tostring(char);
		end
		str = str .. "\n";
	end
	print(str);
end


-- function tryTransform(thisWell, thisPiece, transformId) {
-- 				// can't alter in place
-- 				var id = thisPiece.id;
-- 				var x  = thisPiece.x;
-- 				var y  = thisPiece.y;
-- 				var o  = thisPiece.o;
-- 				// apply transform (very fast now)
-- 				switch(transformId) {
-- 					case "L": x--;             break;
-- 					case "R": x++;             break;
-- 					case "D": y++;             break;
-- 					case "U": o = (o + 1) % 4; break;
-- 				}
-- 				var orientation = orientations[id][o];
-- 				var xActual = x + orientation.xMin;
-- 				var yActual = y + orientation.yMin;
-- 				if(
-- 					   xActual < 0                            // make sure not off left side
-- 					|| xActual + orientation.xDim > wellWidth // make sure not off right side
-- 					|| yActual + orientation.yDim > wellDepth // make sure not off bottom
-- 				) {
-- 					return null;
-- 				}
-- 				// make sure there is NOTHING IN THE WAY
-- 				// we do this by hunting for bit collisions
-- 				for(var row = 0; row < orientation.rows.length; row++) { // 0 to 0, 1, 2 or 3 depending on vertical size of piece
-- 					if(thisWell.content[yActual + row] & (orientation.rows[row] << xActual)) {
-- 						return null;
-- 					}
-- 				}
-- 				return { "id" : id, "x" : x, "y" : y, "o" : o };
-- 			}



			-- // pick the worst piece that could be put into this well
			-- // return the piece
			-- // but not its rating
			-- function worstPiece(thisWell) {
			-- 	// iterate over all the pieces getting ratings
			-- 	// select the lowest
			-- 	var worstRating = null;
			-- 	var worstId = null;
			-- 	// we already have a list of possible pieces to iterate over
			-- 	var startTime = new Date().getTime();
			-- 	for(var id in pieces) {
			-- 		var currentRating = bestWellRating(thisWell, id, searchDepth);
			-- 		// update worstRating
			-- 		if(worstRating == null || currentRating < worstRating) {
			-- 			worstRating = currentRating;
			-- 			worstId = id;
			-- 		}
			-- 		// return instantly upon finding a 0
			-- 		if(worstRating == 0) {
			-- 			break;
			-- 		}
			-- 	}
			-- 	return {
			-- 		"id" : worstId,
			-- 		"x"  : Math.floor((wellWidth - 4) / 2),
			-- 		"y"  : 0,
			-- 		"o"  : 0
			-- 	};
			-- }
			-- // pick the worst piece that could be put into this well
			-- // return the rating of this piece
			-- // but NOT the piece itself...
			-- function worstPieceRating(thisWell, thisSearchDepth) {
			-- 	// iterate over all the pieces getting ratings
			-- 	// select the lowest
			-- 	var worstRating = null;
			-- 	// we already have a list of possible pieces to iterate over
			-- 	for(var id in pieces) {
			-- 		var currentRating = bestWellRating(thisWell, id, thisSearchDepth);
			-- 		if(worstRating == null || currentRating < worstRating) {
			-- 			worstRating = currentRating;
			-- 		}
			-- 		// if we have a 0 then that suffices, no point in searching further
			-- 		// (except for benchmarking purposes)
			-- 		if(worstRating == 0) {
			-- 			return 0;
			-- 		}
			-- 	}
			-- 	return worstRating;
			-- }



			-- // given a well and a piece, find the best possible location to put it
			-- // return the best rating found
			-- function bestWellRating(thisWell, pieceId, thisSearchDepth) {
			-- 	var thisPiece = {
			-- 		"id" : pieceId,
			-- 		"x"  : 0,
			-- 		"y"  : 0,
			-- 		"o"  : 0
			-- 	};
			-- 	// iterate over all possible resulting positions and get
			-- 	// best rating
			-- 	var bestRating = null;
			-- 	// move the piece down to a lower position before we have to
			-- 	// start pathfinding for it
			-- 	// move through empty rows
			-- 	while(
			-- 		   thisPiece.y + 4 < wellDepth    // piece is above the bottom
			-- 		&& thisWell.content[thisPiece.y + 4] == 0 // nothing immediately below it
			-- 	) {
			-- 		thisPiece = tryTransform(thisWell, thisPiece, "D"); // down
			-- 	}
			-- 	// push first position
			-- 	var piecePositions = [];
			-- 	piecePositions.push(thisPiece);
			-- 	var ints = [];
			-- 	ints[hashCode(thisPiece.x, thisPiece.y, thisPiece.o)] = 1;
			-- 	// a simple for loop won't work here because
			-- 	// we are increasing the list as we go
			-- 	var i = 0;
			-- 	while(i < piecePositions.length) {
			-- 		thisPiece = piecePositions[i];
			-- 		// apply all possible transforms
			-- 		for(var j in transforms) {
			-- 			var newPiece = tryTransform(thisWell, thisPiece, j);
			-- 			// transformation failed?
			-- 			if(newPiece == null) {
			-- 				// piece locked? better add that to the list
			-- 				// do NOT check locations, they aren't significant here
			-- 				if(j == "D") {
			-- 					// make newWell from thisWell
			-- 					// no deep copying in javascript!!
			-- 					var newWell = {
			-- 						"content" : [],
			-- 						"score" : thisWell.score,
			-- 						"highestBlue" : thisWell.highestBlue
			-- 					};
			-- 					for(var row2 = 0; row2 < wellDepth; row2++) {
			-- 						newWell.content.push(thisWell.content[row2]);
			-- 					}
			-- 					// alter the well
			-- 					// this will update newWell, including certain well metadata
			-- 					addPiece(newWell, thisPiece);
			-- 					// here is the clever recursive search bit
			-- 					// higher is better
			-- 					var currentRating = newWell.highestBlue + (
			-- 						thisSearchDepth == 0 ?
			-- 							0
			-- 						:
			-- 							// deeper lines are worth less than immediate lines
			-- 							// this is so the game will never give you a line if it can avoid it
			-- 							// NOTE: make sure rating doesn't return a range of more than 100 values...
			-- 							worstPieceRating(newWell, thisSearchDepth-1) / 100
			-- 					);
			-- 					// store
			-- 					if(bestRating == null || currentRating > bestRating) {
			-- 						bestRating = currentRating;
			-- 					}
			-- 				}
			-- 			}
			-- 			// transform succeeded?
			-- 			else {
			-- 				// new location? append to list
			-- 				// check locations, they are significant
			-- 				var newHashCode = hashCode(newPiece.x, newPiece.y, newPiece.o);
			-- 				if(ints[newHashCode] == undefined) {
			-- 					piecePositions.push(newPiece);
			-- 					ints[newHashCode] = 1;
			-- 				}
			-- 			}
			-- 		}
			-- 		i++;
			-- 	}
			-- 	return bestRating;
			-- }