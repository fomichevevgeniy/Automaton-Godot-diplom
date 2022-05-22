shader_type canvas_item;

float rand(vec2 co)
{
   return fract(sin(dot(co.xy,vec2(12.9898,78.233))) * 43758.5453);
}

void fragment()
{
	float chance = distance(UV, vec2(0.5f,0.5f));
	if (rand(UV*sin(TIME)) <= chance)
	{
		COLOR = vec4(0f);
		return;
	}
	
	COLOR = vec4(0,0,0,1f);
}