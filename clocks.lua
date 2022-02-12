settings_table = {
   {
       name='memperc',
       arg='/',
       max=100,
       bg_colour=0xc2cdc3,
       bg_alpha=0.7,
       fg_colour=0x684E38,
       fg_alpha=1,
       x=230, y=410,
       radius=55,
       thickness=18,
       start_angle=0,
       end_angle=270
   },
   {
       name='swap',
       arg='/',
       max=100,
       bg_colour=0xc2cdc3,
       bg_alpha=0.5,
       fg_colour=0x684E38,
       fg_alpha=0.8,
       x=230, y=410,
       radius=70,
       thickness=7,
       start_angle=0,
       end_angle=270
   },
   {
		name='mem',
		arg='/',
		max=100,
		bg_colour=0xc2cdc3,
		bg_alpha=0.3,
		fg_colour=0xc2cdc3,
		fg_alpha=0.3,
		x=20, y=20,
		radius=20,
		thickness=2,
		start_angle=270,
		end_angle=359
	},
	{
		name='mem',
		arg='/',
		max=100,
		bg_colour=0xc2cdc3,
		bg_alpha=0.3,
		fg_colour=0xc2cdc3,
		fg_alpha=0.3,
		x=302, y=20,
		radius=20,
		thickness=2,
		start_angle=0,
		end_angle=90
	},
	{
		name='mem',
		arg='/',
		max=100,
		bg_colour=0xc2cdc3,
		bg_alpha=0.3,
		fg_colour=0xc2cdc3,
		fg_alpha=0.3,
		x=20, y=850,
		radius=20,
		thickness=2,
		start_angle=180,
		end_angle=270
	},
	{
		name='mem',
		arg='/',
		max=100,
		bg_colour=0xc2cdc3,
		bg_alpha=0.3,
		fg_colour=0xc2cdc3,
		fg_alpha=0.3,
		x=302, y=850,
		radius=20,
		thickness=2,
		start_angle=90,
		end_angle=180
	}
	
}

require 'cairo'


corner_r=45

bg_colour=0x121212
bg_alpha=0.4

function rgb_to_r_g_b(colour,alpha)
  return ((colour / 0x10000) % 0x100) / 255., ((colour / 0x100) % 0x100) / 255., (colour % 0x100) / 255., alpha
end

function draw_ring(cr,t,pt)
  local w,h=conky_window.width,conky_window.height

  local xc,yc,ring_r,ring_w,sa,ea=pt['x'],pt['y'],pt['radius'],pt['thickness'],pt['start_angle'],pt['end_angle']
  local bgc, bga, fgc, fga=pt['bg_colour'], pt['bg_alpha'], pt['fg_colour'], pt['fg_alpha']

  local angle_0=sa*(2*math.pi/360)-math.pi/2
  local angle_f=ea*(2*math.pi/360)-math.pi/2
  local t_arc=t*(angle_f-angle_0)

  --Draw background ring
  cairo_arc(cr,xc,yc,ring_r,angle_0,angle_f)
  cairo_set_source_rgba(cr,rgb_to_r_g_b(bgc,bga))
  cairo_set_line_width(cr,ring_w)
  cairo_stroke(cr)

  --Draw indicator ring
  cairo_arc(cr,xc,yc,ring_r,angle_0,angle_0+t_arc)
  cairo_set_source_rgba(cr,rgb_to_r_g_b(fgc,fga))
  cairo_stroke(cr)
end

function DrawLine (cr,start_x,start_y,end_x,end_y,linewidth)
  -- set colour (r,g,b,alpha)
  cairo_set_source_rgba(cr,1,1,1,0.3)
  cairo_move_to(cr,conky_window.width - start_x,start_y)
  cairo_rel_line_to(cr,-end_x,end_y)
  cairo_set_line_width(cr,linewidth)
  cairo_stroke(cr)

end

function DrawBars (cr,start_x,start_y,bar_width,bar_height,corenum,r,g,b)
  -- set colour (r,g,b,alpha)
  cairo_set_source_rgba(cr,1,1,1,0.4)
  cairo_rectangle (cr,start_x,start_y,bar_width,-bar_height)
  cairo_fill(cr)
  cairo_set_source_rgba(cr,r,g,b,1)
  value = tonumber(conky_parse(string.format("${cpu cpu0}",corenum,corenum)))
  -- IF TEMP BARS DO NOT SHOW, try commenting the line above with '--' and uncommenting the line below by removing '--'. (Thanks to /u/IAmAFedora)
  --value = tonumber(conky_parse(string.format("${exec sensors | grep -o 'Core %s:         +[0-9].' | sed -r 's/%s:|[^0-9]//g'}",corenum,corenum)))
  -- OR THESE ONES (remove '--[[' and ']]':
  --[[local handle = io.popen("sensors")
  local cpuTemp = handle:read("*a")
  value = tonumber(cpuTemp:match("CPU Temperature:%s+\+(%d+)"))
  handle:close()
  ]]
  max_value=0
  scale=bar_height/max_value
  indicator_height=scale*value
  cairo_rectangle (cr,start_x,start_y,bar_width,-indicator_height)
  cairo_fill (cr)
end

function DrawBars2 (cr,start_x,start_y,bar_width,bar_height,corenum,r,g,b)
  -- set colour (r,g,b,alpha)
  cairo_set_source_rgba(cr,1,1,1,0.4)
  cairo_rectangle (cr,start_x,start_y,bar_width,-bar_height)
  cairo_fill(cr)
  cairo_set_source_rgba(cr,r,g,b,1)
  value = tonumber(conky_parse(string.format("${cpu cpu1}",corenum,corenum)))
  -- IF TEMP BARS DO NOT SHOW, try commenting the line above with '--' and uncommenting the line below by removing '--'. (Thanks to /u/IAmAFedora)
  --value = tonumber(conky_parse(string.format("${exec sensors | grep -o 'Core %s:         +[0-9].' | sed -r 's/%s:|[^0-9]//g'}",corenum,corenum)))
  -- OR THESE ONES (remove '--[[' and ']]':
  --[[local handle = io.popen("sensors")
  local cpuTemp = handle:read("*a")
  value = tonumber(cpuTemp:match("CPU Temperature:%s+\+(%d+)"))
  handle:close()
  ]]
  max_value=100
  scale=bar_height/max_value
  indicator_height=scale*value
  cairo_rectangle (cr,start_x,start_y,bar_width,-indicator_height)
  cairo_fill (cr)
end

function DrawBars3 (cr,start_x,start_y,bar_width,bar_height,corenum,r,g,b)
  -- set colour (r,g,b,alpha)
  cairo_set_source_rgba(cr,1,1,1,0.4)
  cairo_rectangle (cr,start_x,start_y,bar_width,-bar_height)
  cairo_fill(cr)
  cairo_set_source_rgba(cr,r,g,b,1)
  value = tonumber(conky_parse(string.format("${cpu cpu2}",corenum,corenum)))
  -- IF TEMP BARS DO NOT SHOW, try commenting the line above with '--' and uncommenting the line below by removing '--'. (Thanks to /u/IAmAFedora)
  --value = tonumber(conky_parse(string.format("${exec sensors | grep -o 'Core %s:         +[0-9].' | sed -r 's/%s:|[^0-9]//g'}",corenum,corenum)))
  -- OR THESE ONES (remove '--[[' and ']]':
  --[[local handle = io.popen("sensors")
  local cpuTemp = handle:read("*a")
  value = tonumber(cpuTemp:match("CPU Temperature:%s+\+(%d+)"))
  handle:close()
  ]]
  max_value=100
  scale=bar_height/max_value
  indicator_height=scale*value
  cairo_rectangle (cr,start_x,start_y,bar_width,-indicator_height)
  cairo_fill (cr)
end

function DrawBars4 (cr,start_x,start_y,bar_width,bar_height,corenum,r,g,b)
  -- set colour (r,g4,b,alpha)
  cairo_set_source_rgba(cr,1,1,1,0.4)
  cairo_rectangle (cr,start_x,start_y,bar_width,-bar_height)
  cairo_fill(cr)
  cairo_set_source_rgba(cr,r,g,b,1)
  value = tonumber(conky_parse(string.format("${cpu cpu3}",corenum,corenum)))
  -- IF TEMP BARS DO NOT SHOW, try commenting the line above with '--' and uncommenting the line below by removing '--'. (Thanks to /u/IAmAFedora)
  --value = tonumber(conky_parse(string.format("${exec sensors | grep -o 'Core %s:         +[0-9].' | sed -r 's/%s:|[^0-9]//g'}",corenum,corenum)))
  -- OR THESE ONES (remove '--[[' and ']]':
  --[[local handle = io.popen("sensors")
  local cpuTemp = handle:read("*a")
  value = tonumber(cpuTemp:match("CPU Temperature:%s+\+(%d+)"))
  handle:close()
  ]]
  max_value=100
  scale=bar_height/max_value
  indicator_height=scale*value
  cairo_rectangle (cr,start_x,start_y,bar_width,-indicator_height)
  cairo_fill (cr)
end

function DrawBars5 (cr,start_x,start_y,bar_width,bar_height,corenum,r,g,b)
  -- set colour (r,g,b,alpha)
  cairo_set_source_rgba(cr,1,1,1,0.4)
  cairo_rectangle (cr,start_x,start_y,bar_width,-bar_height)
  cairo_fill(cr)
  cairo_set_source_rgba(cr,r,g,b,1)
  value = tonumber(conky_parse(string.format("${cpu cpu4}",corenum,corenum)))
  -- IF TEMP BARS DO NOT SHOW, try commenting the line above with '--' and uncommenting the line below by removing '--'. (Thanks to /u/IAmAFedora)
  --value = tonumber(conky_parse(string.format("${exec sensors | grep -o 'Core %s:         +[0-9].' | sed -r 's/%s:|[^0-9]//g'}",corenum,corenum)))
  -- OR THESE ONES (remove '--[[' and ']]':
  --[[local handle = io.popen("sensors")
  local cpuTemp = handle:read("*a")
  value = tonumber(cpuTemp:match("CPU Temperature:%s+\+(%d+)"))
  handle:close()
  ]]
  max_value=100
  scale=bar_height/max_value
  indicator_height=scale*value
  cairo_rectangle (cr,start_x,start_y,bar_width,-indicator_height)
  cairo_fill (cr)
end
function DrawBars6 (cr,start_x,start_y,bar_width,bar_height,corenum,r,g,b)
  -- set colour (r,g,b,alpha)
  cairo_set_source_rgba(cr,1,1,1,0.4)
  cairo_rectangle (cr,start_x,start_y,bar_width,-bar_height)
  cairo_fill(cr)
  cairo_set_source_rgba(cr,r,g,b,1)
  value = tonumber(conky_parse(string.format("${cpu cpu5}",corenum,corenum)))
  -- IF TEMP BARS DO NOT SHOW, try commenting the line above with '--' and uncommenting the line below by removing '--'. (Thanks to /u/IAmAFedora)
  --value = tonumber(conky_parse(string.format("${exec sensors | grep -o 'Core %s:         +[0-9].' | sed -r 's/%s:|[^0-9]//g'}",corenum,corenum)))
  -- OR THESE ONES (remove '--[[' and ']]':
  --[[local handle = io.popen("sensors")
  local cpuTemp = handle:read("*a")
  value = tonumber(cpuTemp:match("CPU Temperature:%s+\+(%d+)"))
  handle:close()
  ]]
  max_value=100
  scale=bar_height/max_value
  indicator_height=scale*value
  cairo_rectangle (cr,start_x,start_y,bar_width,-indicator_height)
  cairo_fill (cr)
end

function DrawBars7 (cr,start_x,start_y,bar_width,bar_height,corenum,r,g,b)
  -- set colour (r,g,b,alpha)
  cairo_set_source_rgba(cr,1,1,1,0.4)
  cairo_rectangle (cr,start_x,start_y,bar_width,-bar_height)
  cairo_fill(cr)
  cairo_set_source_rgba(cr,r,g,b,1)
  value = tonumber(conky_parse(string.format("${cpu cpu6}",corenum,corenum)))
  -- IF TEMP BARS DO NOT SHOW, try commenting the line above with '--' and uncommenting the line below by removing '--'. (Thanks to /u/IAmAFedora)
  --value = tonumber(conky_parse(string.format("${exec sensors | grep -o 'Core %s:         +[0-9].' | sed -r 's/%s:|[^0-9]//g'}",corenum,corenum)))
  -- OR THESE ONES (remove '--[[' and ']]':
  --[[local handle = io.popen("sensors")
  local cpuTemp = handle:read("*a")
  value = tonumber(cpuTemp:match("CPU Temperature:%s+\+(%d+)"))
  handle:close()
  ]]
  max_value=100
  scale=bar_height/max_value
  indicator_height=scale*value
  cairo_rectangle (cr,start_x,start_y,bar_width,-indicator_height)
  cairo_fill (cr)
end

function DrawBars8 (cr,start_x,start_y,bar_width,bar_height,corenum,r,g,b)
  -- set colour (r,g,b,alpha)
  cairo_set_source_rgba(cr,1,1,1,0.4)
  cairo_rectangle (cr,start_x,start_y,bar_width,-bar_height)
  cairo_fill(cr)
  cairo_set_source_rgba(cr,r,g,b,1)
  value = tonumber(conky_parse(string.format("${cpu cpu7}",corenum,corenum)))
  -- IF TEMP BARS DO NOT SHOW, try commenting the line above with '--' and uncommenting the line below by removing '--'. (Thanks to /u/IAmAFedora)
  --value = tonumber(conky_parse(string.format("${exec sensors | grep -o 'Core %s:         +[0-9].' | sed -r 's/%s:|[^0-9]//g'}",corenum,corenum)))
  -- OR THESE ONES (remove '--[[' and ']]':
  --[[local handle = io.popen("sensors")
  local cpuTemp = handle:read("*a")
  value = tonumber(cpuTemp:match("CPU Temperature:%s+\+(%d+)"))
  handle:close()
  ]]
  max_value=100
  scale=bar_height/max_value
  indicator_height=scale*value
  cairo_rectangle (cr,start_x,start_y,bar_width,-indicator_height)
  cairo_fill (cr)
end

function conky_clock_rings()
  local function setup_rings(cr,pt)
  local str=''
  local value=0

  str=string.format('${%s %s}',pt['name'],pt['arg'])
  str=conky_parse(str)

  value=tonumber(str)
  if value == nil then value = 0 end

  pct=value/pt['max']
  draw_ring(cr,pct,pt)
end

--Check that Conky has been running for at least 5s
  if conky_window==nil then return end
  local w=conky_window.width
  local h=conky_window.height
  local cs=cairo_xlib_surface_create(conky_window.display,conky_window.drawable,conky_window.visual, w, h)

  local cr=cairo_create(cs)
  
	cairo_move_to(cr,corner_r,0)
	cairo_line_to(cr,w-corner_r,0)
	cairo_curve_to(cr,w,0,w,0,w,corner_r)
	cairo_line_to(cr,w,h-corner_r)
	cairo_curve_to(cr,w,h,w,h,w-corner_r,h)
	cairo_line_to(cr,corner_r,h)
	cairo_curve_to(cr,0,h,0,h,0,h-corner_r)
	cairo_line_to(cr,0,corner_r)
	cairo_curve_to(cr,0,0,0,0,corner_r,0)
	cairo_close_path(cr)  

	cairo_set_source_rgba(cr,rgb_to_r_g_b(bg_colour,bg_alpha))
	cairo_fill(cr)

  local updates=conky_parse('${updates}')
  update_num=tonumber(updates)

  if update_num>5 then
    for i in pairs(settings_table) do
      setup_rings(cr,settings_table[i])
    end
  end

  --parse in arguments as so (cr,startx postion,starty postion, how much to move x, how much to move y)
  DrawLine(cr,20,0,287,0,2)
  DrawLine(cr,20,870,287,0,2)  
  DrawLine(cr,0,20,0,835,2)
  DrawLine(cr,322,20,0,835,2)
  DrawLine(cr,20,792,250,0,4)

  --draw network lines
  --DrawLine(cr,398,155,0,23,4)
  --DrawLine(cr,0,155,40,0,
  --draw cpu temp bars
  DrawBars(cr,206,260,7,75,0,rgb_to_r_g_b(0x684E38))
  DrawBars2(cr,218,260,7,75,1,rgb_to_r_g_b(0x684E38))
  DrawBars3(cr,230,260,7,75,2,rgb_to_r_g_b(0x684E38))
  DrawBars4(cr,242,260,7,75,3,rgb_to_r_g_b(0x684E38))
  DrawBars5(cr,254,260,7,75,0,rgb_to_r_g_b(0x684E38))
  DrawBars6(cr,266,260,7,75,1,rgb_to_r_g_b(0x684E38))
  DrawBars7(cr,278,260,7,75,2,rgb_to_r_g_b(0x684E38))
  DrawBars8(cr,290,260,7,75,3,rgb_to_r_g_b(0x684E38))
  --draw cpu temp lines
  --draw cpu temp lines
  --DrawLine(cr,0,320,348,0,4)
  --DrawLine(cr,348,318,0,26,4)
  --draw mem lines
  --DrawLine(cr,0,585,144,0,4)


  --draw_clock_hands(cr,clock_x,clock_y)
end
