/// @description  tl_draw_tween_graph(tween, x, y, width, height, border_radius);
/// @function tl_draw_tween_graph
/// @param {Tween} tween - The tween to graph
/// @param {real} x - The x position
/// @param {real} y - The y position
/// @param {real} width - The width of the graph
/// @param {real} height - The height of the graph
/// @param {real} border_radius - The border radious
function tl_draw_tween_graph(argument0, argument1, argument2, argument3, argument4, argument5) {
	/**
	 * Draws a complete graph that shows the progress and the easing of the tween.
	 */


	// Draw graph

	var tween = argument0
	var xx = argument1
	var yy = argument2
	var ww = argument3
	var hh = argument4
	var r = argument5;

	var c_orange1 = make_color_rgb(255,127,0);
	var c_gray1 = make_color_rgb(80,80,80);
	var c_gray2 = make_color_rgb(102,102,102);

	var duration = anim_get_duration(tween);
	var repeats = anim_get_repeat(tween);
	var is_inf = (repeats < 0 || repeats == infinity);

	if (is_inf) {
		repeats = 0;	
	}

	for (var i = 0; i <= repeats; i++) {
		var is_yoyo_and_even = tween[TLANIM.YOYO] && (i mod 2 == 1);
	
		if (is_inf) {
			var p = (anim_get_time(tween) / duration);
		} else {
			var p = ((anim_get_totaltime(tween) - (duration * i)) / duration);
		}
	
		p = clamp(p, 0, 1);
	


		draw_set_color(c_gray1);
		draw_set_alpha(.3);
		// draws the background
		draw_roundrect_ext(xx,yy,xx+ww,yy+hh,r,r,false);

		if (p > 0) {
			draw_roundrect_ext(xx, yy, xx + ww * p, yy + hh, r, r, false);  
		}
		draw_set_color(c_orange1);
		draw_set_alpha(1);
		// DRAWS THE EASING LINE
	
		if (is_yoyo_and_even) {
			tl_draw_easing_graph( tween, xx, yy + hh, xx + ww, yy, max(1, hh / 50));
		} else {
			tl_draw_easing_graph( tween, xx, yy, xx + ww, yy + hh, max(1, hh / 50));
		}

		draw_set_color(c_gray2);
		draw_set_alpha(.5);
		// Draws the border line
		draw_roundrect_ext(xx, yy, xx + ww, yy + hh, r, r, true);
		draw_set_alpha(1);
	
		xx += ww;
	}




}
