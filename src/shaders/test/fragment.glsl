varying vec2 vUv;

void main() {
    float strength = vUv.y;

    gl_FragColor = vec4(vec3(strength), 1.0);
}















/*
* Pattern-01

varying vec2 vUv;
void main() {
    // gl_FragColor = vec4(0.5, 0.0, 1.0, 1.0);

    gl_FragColor = vec4(vUv, 1.0, 1.0);
}

? How the Gradient is Created
vUv contains two components: vUv.x and vUv.y.
These components are used as the "red" and "green" components of the color, respectively.

vec4(vUv, 1.0, 1.0) translates to vec4(vUv.x, vUv.y, 1.0, 1.0).
  - vUv.x varies from 0 to 1 across the horizontal axis.
  - vUv.y varies from 0 to 1 across the vertical axis.
  - The blue component is set to 1.0, making it full blue.
  - The alpha component is set to 1.0, making it fully opaque.


? Visual Effect
As a result, the color of each pixel is determined by its UV coordinates.
    - At (0, 0), the color is vec4(0.0, 0.0, 1.0, 1.0) (blue).
    - At (1, 0), the color is vec4(1.0, 0.0, 1.0, 1.0) (magenta).
    - At (0, 1), the color is vec4(0.0, 1.0, 1.0, 1.0) (cyan).
    - At (1, 1), the color is vec4(1.0, 1.0, 1.0, 1.0) (white).

The gradient effect is created because the red and green components linearly interpolate based on the UV coordinates, while the blue component remains constant at 1.0.



==================================================
* Pattern-02
==================================================
void main() {
    gl_FragColor = vec4(vUv.x, vUv.y, 0.0, 1.0);
}

? Visual Effect
  - At (0, 0), the color is vec4(0.0, 0.0, 0.0, 1.0) (black).
  - At (1, 0), the color is vec4(1.0, 0.0, 0.0, 1.0) (red).
  - At (0, 1), the color is vec4(0.0, 1.0, 0.0, 1.0) (green).
  - At (1, 1), the color is vec4(1.0, 1.0, 0.0, 1.0) (yellow).


==================================================
* Pattern-03
==================================================
- left: black | right: white

void main() {
    gl_FragColor = vec4(vUv.x, vUv.x, vUv.x, 1.0);
}

OR

void main() {
    float strength = vUv.x;
    gl_FragColor = vec4(vec3(strength), 1.0);
}


==================================================
* Pattern-04
==================================================
- top: white | bottom: black

void main() {
    float strength = vUv.y;
    
    gl_FragColor = vec4(vec3(strength), 1.0);
}


==================================================
* Pattern-05
==================================================


==================================================
* Pattern-06
==================================================


==================================================
* Pattern-07
==================================================

==================================================
* Pattern-08

==================================================
* Pattern-09

==================================================
* Pattern-10



*/