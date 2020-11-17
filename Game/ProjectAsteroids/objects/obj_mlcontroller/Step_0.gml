/// @description Move

if(team != noone and botType != noone) {
	var move  = output[OUTPUT.move];
	var left  = output[OUTPUT.left];
	var right = output[OUTPUT.right];

	if(random(output[OUTPUT.move]) >= random_range(0,1)) move = 1;
	if(random(output[OUTPUT.left]) >= random_range(0,1)) left = 1;
	if(random(output[OUTPUT.right]) >= random_range(0,1)) right = 1;


	with(obj_inputController) {
		with(slot[other.team,other.botType]) {
			key_move  =  move;
			key_left  = left;
			key_right = right;
		}
	}
}

