#version 120
uniform sampler2D iChannel0;
uniform float iTime;
uniform vec2 iResolution;

vec4 doSampleAt(vec2 at) {
	// bring into -1 to 1 range
	vec2 transformedCoord = at - 0.5;
	// do thing
	float xScale = 0.0 + (1.0 / cos(transformedCoord.y));
	float yScale = 0.0 + (1.0 / cos(transformedCoord.x));
	transformedCoord = vec2(xScale * tan(transformedCoord.x), yScale * tan(transformedCoord.y));
	// final scale then bring out of range
	transformedCoord = (transformedCoord * 0.92) + 0.5;
	if (transformedCoord.x < 0.0 || transformedCoord.x >= 1.0 || transformedCoord.y < 0.0 || transformedCoord.y >= 1.0) {
		return vec4(0.0, 0.0, 0.0, 1.0);
	} else {
		return texture2D(iChannel0, transformedCoord) * (0.9 + (sin((transformedCoord.y * iResolution.y * 3.14159) + 0.5) * 0.1));
	}
}

void main() {
	float nudgeX = 0.5 / iResolution.x;
	float nudgeY = 0.5 / iResolution.y;
	vec4 a = doSampleAt(gl_TexCoord[0].xy + vec2(0.0, -nudgeY));
	vec4 b = doSampleAt(gl_TexCoord[0].xy + vec2(nudgeX, 0.0));
	vec4 c = doSampleAt(gl_TexCoord[0].xy + vec2(0.0, nudgeY));
	vec4 d = doSampleAt(gl_TexCoord[0].xy + vec2(-nudgeX, 0.0));
	gl_FragColor = (a + b + c + d) / 4.0;
}
