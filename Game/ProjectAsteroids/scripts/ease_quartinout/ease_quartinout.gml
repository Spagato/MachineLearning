/// @description  ease_quartinout(progress)
/// @function  ease_quartinout
/// @param {real} progress The easing progress from 0 to 1
/// @returns {real} The output normalized value
/// Do not call this script directly. For info about easings, refer to this folder documentation.
function ease_quartinout(argument0) {
	argument0+=argument0;
	if (argument0 < 1) {return (argument0*argument0*argument0*argument0)*.5;}
	argument0=2-argument0;
	return (2-(argument0*argument0*argument0*argument0))*.5;



}
