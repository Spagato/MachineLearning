/// @description Controls all of the players settings

#region Keys

key_move  = 0;
key_left  = 0;
key_right = 0;

vision_range = 1000;
vision[7] = false;

#endregion

#region Settings

turnSpeed    = 400;  // How fast the ship turns
acceleration = 30 * 60;
fric         = 0.05; // How fast the ship slows down

#endregion

#region Essentials

	#region Gameplay
	
	lost = false; // Is it still in the game?
	
	#endregion

	#region Physics
	
	hsp = 0;
	vsp = 0;
	vel_x = 0;
	vel_y = 0;
	
	#endregion

	#region Deltatime
	
	deltatime = 0;
	
	#endregion
		
#endregion

#region Machine Learning

mlController = instance_create_depth(0,0,0,obj_mlcontroller);
mlPoints = 0;

pointTimer = 0;
pointRate = 1;

spinTimer = 0;
spinRate = 0.5;

#endregion