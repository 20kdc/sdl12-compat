#version 120
uniform sampler2D iChannel0;
uniform float iTime;
uniform vec2 iResolution;

void main() {
	gl_FragColor = texture2D(iChannel0, gl_TexCoord[0].xy) * (0.9 + (sin((gl_TexCoord[0].y * iResolution.y * 3.14159) + 0.5) * 0.1));
}
