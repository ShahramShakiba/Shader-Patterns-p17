varying vec2 vUv;

void main() {
  
    float strength = step(0.8, mod(vUv.x / 0.1, 1.0));
    strength *= step(0.8, mod(vUv.y / 0.1, 1.0));

    gl_FragColor = vec4(strength, strength, strength, 1.0);
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
- top: black | bottom: white

void main() {
    float strength = 1.0 - vUv.y;

    gl_FragColor = vec4(strength, strength, strength, 1.0);
}


==================================================
* Pattern-06
==================================================
- 10%: black | 90%: white

void main() {
    float strength = vUv.y / 0.1;

    gl_FragColor = vec4(strength, strength, strength, 1.0);
}


==================================================
* Pattern-07
==================================================
- Repeating pattern of the pattern-06 | Stripe Effect

void main() {
    float strength = mod(vUv.y / 0.1, 1.0);

    gl_FragColor = vec4(strength, strength, strength, 1.0);
}


? mod(x, y):  modulus (remainder) after division
    - The mod(x, y) function returns the remainder of x divided by y.
    - For example, mod(5.5, 1.0) returns 0.5 because 5.5 divided by 1.0 leaves a remainder of 0.5.

? Stripe Effect
    - The stripes are horizontal because the calculation uses vUv.y.
    - Each stripe is 0.1 units tall in UV coordinates.
    - The resulting visual effect is a series of horizontal bands that vary in grayscale intensity from black to white, repeating every 0.1 units along the vertical axis.



==================================================
* Pattern-08
==================================================
- Sharp Stripe Effect

void main() {
    float strength = mod(vUv.y / 0.1, 1.0);

    if (strength < 0.5) {
        strength = 0.0;
    } else {
        strength = 1.0;
    }

    // strength = strength < 0.5 ? 0.0 : 1.0;

    gl_FragColor = vec4(strength, strength, strength, 1.0);
}

- do not use if-else statment or tarnary operator because they can impact performance, if you can avoid doing "if-else" or " tarnary"

INSTEAD USE : 

? step()
    - when it reaches a limit, it'll be 1 and before that 0

void main() {
    float strength = mod(vUv.y / 0.1, 1.0);
    strength = step(0.5, strength);

    gl_FragColor = vec4(strength, strength, strength, 1.0);
}

  - if the value above this limit(0.5) the step will provide 1 



==================================================
* Pattern-09
==================================================
- Sharp Stripe Effect but narrow & horizontally

void main() {
    float strength = mod(vUv.y / 0.1, 1.0);
    strength = step(0.8, strength);

    gl_FragColor = vec4(strength, strength, strength, 1.0);
}



==================================================
* Pattern-10
==================================================
- Sharp Stripe Effect but narrow & vertically

void main() {
    float strength = mod(vUv.x / 0.1, 1.0);
    strength = step(0.8, strength);

    gl_FragColor = vec4(strength, strength, strength, 1.0);
}



==================================================
* Pattern-11
==================================================
- Strip Effect like a chest board

void main() {
    float strength = step(0.8, mod(vUv.x / 0.1, 1.0));
    strength += step(0.8, mod(vUv.y / 0.1, 1.0));

    gl_FragColor = vec4(strength, strength, strength, 1.0);
}



==================================================
* Pattern-12
==================================================
- a plane with lots of dots

void main() {
    float strength = step(0.8, mod(vUv.x / 0.1, 1.0));
    strength *= step(0.8, mod(vUv.y / 0.1, 1.0));

    gl_FragColor = vec4(strength, strength, strength, 1.0);
}



==================================================
* Pattern-13
==================================================



==================================================
* Pattern-14
==================================================



==================================================
* Pattern-15
==================================================



==================================================
* Pattern-16
==================================================



==================================================
* Pattern-17
==================================================



==================================================
* Pattern-18
==================================================



==================================================
* Pattern-19
==================================================



==================================================
* Pattern-20
==================================================



*/