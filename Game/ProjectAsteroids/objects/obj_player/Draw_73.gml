/// @description Put in front

#region Lines
if(global.debugLines) {
	for(var i = 0; i < 8; i++) {
		if(vision[i]) draw_set_color(c_red); else draw_set_color(c_white);
		draw_line(x,y,x+lengthdir_x(vision_range, (i*45) + image_angle), y + lengthdir_y(vision_range, (i*45)+image_angle));
	}
}
#endregion

#region Score
if(global.debugScore) {
	draw_set_color(c_orange);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_text_transformed(x,y,string(mlPoints),10,10,0);
	draw_set_halign(fa_left);
	draw_set_color(c_white);	
}
#endregion

#region Draw NN

if(global.selectedPlayer == id) {
	
	var startY  = (room_height-520);
	var startX  = 80;
	
	if(global.pause) {
		startX  = room_width/2 - 340;
	}
	
	var offsetX = 125;
	var offsetY = 30;
	var biasOffset = 30;
	var maxNum = 1;
	
	// Hidden layer (INPUT)
	for(var h = 0; h < global.hiddenHeight; h++) {
		
		// Draw Lines 
		for(var i = 0; i < INPUT.size; i++) { 
			var colorP = 0;
			with(mlController) {
				colorP = (hiddenWeight[0][h][i] * input[i]) / maxNum;
				colorP = clamp(colorP,0,1);
			}
			var colorMerge = merge_color(c_red,c_green,colorP);
			draw_set_color(colorMerge);
			draw_line(startX,startY+(i*offsetY),startX + offsetX,startY + (h*offsetY));
			draw_set_color(c_white);
		}
		
		// Draw Node 
		var colorP = 0;
		with(mlController) {
			colorP = hidden[0][h] / maxNum;
			colorP = clamp(colorP,0,1);
		}
		var colorMerge = merge_color(c_red,c_green,colorP);
		draw_sprite_ext(spr_nn_node,0,startX + offsetX, startY + (h*offsetY),1,1,image_angle,colorMerge,1);
		
	}
	
	// Input Layer
	for(var i = 0; i < INPUT.size; i++) {
		
		// Node Colors
		var colorP = 0;
		with(mlController) {
			colorP = input[i] / maxNum;	
			colorP = clamp(colorP,0,1);
		}
		var colorMerge = merge_color(c_red,c_green,colorP);
		
		// Node 
		draw_sprite_ext(spr_nn_node,0,startX, startY + (i*offsetY),1,1,image_angle,colorMerge,1);
	}
	
	// Hidden layer (EXTRA)
	for(var d = 1; d < global.hiddenDepth; d++) {
		for(var h = 0; h < global.hiddenHeight; h++) {
			
			// Draw Line 
			for(var i = 0; i < global.hiddenHeight; i++) {
				// Line Colors 
				var colorP = 0;
				with(mlController) {
					colorP = (hiddenWeight[d][h][i] * hidden[d-1][h]) / maxNum;
					colorP = clamp(colorP,0,1);
				}
				var colorMerge = merge_color(c_red,c_green,colorP);
				draw_set_color(colorMerge);
				draw_line(startX+offsetX+((d-1)*offsetX),startY+(i*offsetY),startX+offsetX+(d*offsetX),startY + (h*offsetY));
				draw_set_color(c_white);
			}
			
			// Draw Node 
			var colorP = 0;
			with(mlController) {
				colorP = hidden[d][h] / maxNum;
				colorP = clamp(colorP,0,1);
			}
			var colorMerge = merge_color(c_red,c_green,colorP);
			
			draw_sprite_ext(spr_nn_node,0,startX+offsetX+(d*offsetX), startY + (h*offsetY),1,1,image_angle,colorMerge,1);
			
		}	
	}
	
	// Output Layer 
	for(var o = 0; o < OUTPUT.size; o++) { 
		
		// Draw Line
		for(var w = 0; w < global.hiddenHeight; w++) {
			
			// Line Colors 
			var colorP = 0;
			with(mlController) {
				colorP = (outputWeights[o][w] * hidden[global.hiddenDepth-1][w]) / maxNum;
				colorP = clamp(colorP,0,1);
			}
			var colorMerge = merge_color(c_red,c_green,colorP);
			
			draw_set_color(colorMerge);
			draw_line(startX+offsetX+((global.hiddenDepth-1)*offsetX),startY+(w*offsetY),startX+offsetX+(global.hiddenDepth*offsetX),startY + (o*offsetY));
			draw_set_color(c_white);
		}
		
		// Draw Node
		var colorP = 0;
		with(mlController) {
			colorP = output[o] / maxNum;
			colorP = clamp(colorP,0,1);
		}
		var colorMerge = merge_color(c_red,c_green,colorP);
		
		draw_sprite_ext(spr_nn_node,0,startX+offsetX+(global.hiddenDepth*offsetX), startY + (o*offsetY),1,1,image_angle,colorMerge,1);
		
	}
	
	// Bias Node
	for(var b = 0; b <= global.hiddenDepth; b++) {
		
		// Colors
		var colorP = 0;
		with(mlController) {
			colorP = bias[b] / maxNum;
			colorP = clamp(colorP,0,1);
		}
		var colorMerge = merge_color(c_red,c_green,colorP);
		draw_set_color(colorMerge);
		draw_line(startX+(offsetX/2)+(offsetX*b),startY-biasOffset,startX+((b+1)*offsetX),startY);
		draw_set_color(c_white);
		draw_sprite_ext(spr_nn_node,0,startX+(offsetX/2)+(offsetX*b), startY-biasOffset,1,1,image_angle,colorMerge,1);
	}
	
}

#endregion

#region Draw Key Probabilities

if(global.selectedPlayer == id) {
	var startX = (room_width/2) - 200;
	var offsetX = 300;
	var startY = room_height - 100;
	
	if(global.pause) {
		startX  = (room_width/2) - 100;
	}

	var colorM = 0;
	var colorL = 0;
	var colorR = 0;
	var probabilityM = 0;
	var probabilityL = 0;
	var probabilityR = 0;
	with(mlController) {
		probabilityM = output[OUTPUT.move]
		probabilityL = output[OUTPUT.left]
		probabilityR = output[OUTPUT.right]
	}
	probabilityM = clamp(probabilityM, 0, 1);
	probabilityL = clamp(probabilityL, 0, 1);
	probabilityR = clamp(probabilityR, 0, 1);

	// Move 
	colorM = clamp(probabilityM, 0, 1);
	var colorMerge = merge_color(c_red,c_green,colorM);
	draw_set_color(c_white);
	draw_text_transformed(startX, startY, string("MOVE"), 3, 3, 0);
	draw_set_color(colorMerge);
	draw_text_transformed(startX, startY-70,string(probabilityM * 100) + string("%"), 3, 3, 0);
	
	// Left
	colorL = clamp(probabilityL, 0, 1);
	var colorMerge = merge_color(c_red,c_green,colorL);
	draw_set_color(c_white);
	draw_text_transformed(startX + offsetX, startY, string("LEFT"), 3, 3, 0);
	draw_set_color(colorMerge);
	draw_text_transformed(startX + offsetX, startY-70,string(probabilityL * 100) + string("%"), 3, 3, 0);
	
	// Right
	colorR = clamp(probabilityR, 0, 1);
	var colorMerge = merge_color(c_red,c_green,colorR);	
	draw_set_color(c_white);
	draw_text_transformed(startX + (2*offsetX), startY, string("RIGHT"), 3, 3, 0);
	draw_set_color(colorMerge);
	draw_text_transformed(startX + (2*offsetX), startY-70,string(probabilityR * 100) + string("%"), 3, 3, 0);

	
	
}

#endregion