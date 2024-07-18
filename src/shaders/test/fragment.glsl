varying vec2 vUv;

void main() {
    vec2 lightUvX = vec2(
        vUv.x * 0.1 + 0.45,
        vUv.y * 0.5 + 0.25
    );
    float lightX = 0.015 / distance(lightUvX, vec2(0.5));
   
    vec2 lightUvY = vec2(
        vUv.y * 0.1 + 0.45,
        vUv.x * 0.5 + 0.25
    );
    float lightY = 0.015 / distance(lightUvY, vec2(0.5));


    float strength = lightX * lightY;

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
- left: black | right: white  | Gradient

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
- a plane with lots of wide-dots | bars

void main() {
    float strength = step(0.4, mod(vUv.x / 0.1, 1.0));
    strength *= step(0.8, mod(vUv.y / 0.1, 1.0));

    gl_FragColor = vec4(strength, strength, strength, 1.0);
}



==================================================
* Pattern-14
==================================================
- two bars on the right & top stick to each other
void main() {
    float barX = step(0.4, mod(vUv.x / 0.1, 1.0));
    barX *= step(0.8, mod(vUv.y / 0.1, 1.0));
   
    float barY = step(0.8, mod(vUv.x / 0.1, 1.0));
    barY *= step(0.4, mod(vUv.y / 0.1, 1.0));

    float strength = barX + barY;

    gl_FragColor = vec4(strength, strength, strength, 1.0);
}


==================================================
* Pattern-15
==================================================
- bunch of plus mark

void main() {
    float barX = step(0.4, mod(vUv.x / 0.1, 1.0));
    barX *= step(0.8, mod(vUv.y / 0.1, 1.0));
   
    float barY = step(0.8, mod(vUv.x / 0.1 + 0.2, 1.0)); // offset it by 0.2
    barY *= step(0.4, mod(vUv.y / 0.1 - 0.2, 1.0)); // offset it by 0.2

    float strength = barX + barY;

    gl_FragColor = vec4(strength, strength, strength, 1.0);
}


==================================================
* Pattern-16
==================================================
- left and right: white | center: black

void main() {
    float strength = abs(vUv.x - 0.5);

    gl_FragColor = vec4(strength, strength, strength, 1.0);
}

? abs() function:
    - returns the absolute value of x.
    - For example, abs(-0.5) returns 0.5 and abs(0.5) returns 0.5.

 - vUv.x varies from 0.0 to 1.0 across the horizontal axis.
 - Subtracting 0.5 shifts the range to -0.5 to 0.5.
 - The abs function makes this range 0.0 to 0.5, then back to 0.0 
 as vUv.x goes from 0.0 to 1.0.

- At vUv.x = 0.0 and vUv.x = 1.0, strength is 0.5. | white
- At vUv.x = 0.5, strength is 0.0. | black


==================================================
* Pattern-17
==================================================
- 4 suqare | black and whute

void main() {
    float strength = min(abs(vUv.x - 0.5), abs(vUv.y - 0.5));

    gl_FragColor = vec4(strength, strength, strength, 1.0);
}


==================================================
* Pattern-18
==================================================
- invert pattern-17

void main() {
    float strength = max(abs(vUv.x - 0.5), abs(vUv.y - 0.5));

    gl_FragColor = vec4(strength, strength, strength, 1.0);
}



==================================================
* Pattern-19
==================================================
- a black square in the middle | like a frame with thick edges

void main() {
    float strength = step(0.2, max(abs(vUv.x - 0.5), abs(vUv.y - 0.5)));

    gl_FragColor = vec4(strength, strength, strength, 1.0);
}



==================================================
* Pattern-20
==================================================
- a fram with thin edges

void main() {
    float strength = step(0.4, max(abs(vUv.x - 0.5), abs(vUv.y - 0.5)));

    gl_FragColor = vec4(strength, strength, strength, 1.0);
}

OR

void main() {
    float square1 = step(0.2, max(abs(vUv.x - 0.5), abs(vUv.y - 0.5)));
    float square2 = 1.0 - step(0.25, max(abs(vUv.x - 0.5), abs(vUv.y - 0.5)));
    float strength = square1 * square2;

    gl_FragColor = vec4(strength, strength, strength, 1.0);
}

==================================================
* Pattern-21
==================================================
- low level gradient | vertically

void main() {
    float strength = floor(vUv.x * 10.0) / 10.0;

    gl_FragColor = vec4(strength, strength, strength, 1.0);
}

? floor : 
  - get the lower value



==================================================
* Pattern-22
==================================================
- low level gradient | like a Grid network

void main() {
    float strength = 
        floor(vUv.x * 10.0) / 10.0 * floor(vUv.y * 10.0) / 10.0;

    gl_FragColor = vec4(strength, strength, strength, 1.0);
}



==================================================
* Pattern-23
==================================================
- Create a broken TV channel

float random(vec2 st) {
    return 
        fract(sin(dot(st.xy, vec2(12.9898, 78.233))) * 43758.5453123);
}

void main() {
    float strength = random(vUv);
        
    gl_FragColor = vec4(strength, strength, strength, 1.0);
}



==================================================
* Pattern-24
==================================================
- Grid network with randomness

float random(vec2 st) {
    return 
        fract(sin(dot(st.xy, vec2(12.9898, 78.233))) * 43758.5453123);
}

void main() {
    vec2 gridUv = vec2(
        floor(vUv.x * 10.0) / 10.0,
        floor(vUv.y * 10.0) / 10.0
    );

    float strength = random(gridUv);

    gl_FragColor = vec4(strength, strength, strength, 1.0);
}



==================================================
* Pattern-25
==================================================
- Random grid network with offset

float random(vec2 st) {
    return 
        fract(sin(dot(st.xy, vec2(12.9898, 78.233))) * 43758.5453123);
}

void main() {
    vec2 gridUv = vec2(
        floor(vUv.x * 10.0) / 10.0,
        floor(vUv.y * 10.0 + vUv * 5.0) / 10.0
    );

    float strength = random(gridUv);

    gl_FragColor = vec4(strength, strength, strength, 1.0);
}



==================================================
* Pattern-26
==================================================
- Length of UV

void main() {
    float strength = length(vUv);

    gl_FragColor = vec4(strength, strength, strength, 1.0);
}



==================================================
* Pattern-27
==================================================
- get length of UV in the center | dark point in the center

void main() {
    float strength = length(vUv - 0.5);

    gl_FragColor = vec4(strength, strength, strength, 1.0);
}


OR

? distance between UV coordinate and a desire point
void main() {
    // float strength = distance(vUv, vec2(0.5));
    float strength = distance(vUv, vec2(0.7, 0.3));

    gl_FragColor = vec4(strength, strength, strength, 1.0);
}



==================================================
* Pattern-28
==================================================
- oposite of pattern 27 

void main() {
    float strength = 1.0 - distance(vUv, vec2(0.5));

    gl_FragColor = vec4(strength, strength, strength, 1.0);
}



==================================================
* Pattern-29
==================================================
- Moon shape effect

void main() {
    float strength = 0.05 / distance(vUv, vec2(0.5));

    gl_FragColor = vec4(strength, strength, strength, 1.0);
}

- with this light-point effect you never reaches 0 
- it might be a problem in some situation you can see the edges of 
  your plane



==================================================
* Pattern-30
==================================================
- sttretch Moon

void main() {
    vec2 lightUv = vec2(
        vUv.x * 0.1 + 0.45,
        vUv.y * 0.5 + 0.25
    );

    float strength = 0.015 / distance(lightUv, vec2(0.5));

    gl_FragColor = vec4(strength, strength, strength, 1.0);
}



==================================================
* Pattern-31
==================================================
- Star 

void main() {
    vec2 lightUvX = vec2(
        vUv.x * 0.1 + 0.45,
        vUv.y * 0.5 + 0.25
    );
    float lightX = 0.015 / distance(lightUvX, vec2(0.5));
   
    vec2 lightUvY = vec2(
        vUv.y * 0.1 + 0.45,
        vUv.x * 0.5 + 0.25
    );
    float lightY = 0.015 / distance(lightUvY, vec2(0.5));


    float strength = lightX * lightY;

    gl_FragColor = vec4(strength, strength, strength, 1.0);
}



==================================================
* Pattern-32
==================================================


==================================================
* Pattern-33
==================================================


==================================================
* Pattern-34
==================================================


==================================================
* Pattern-35
==================================================


==================================================
* Pattern-36
==================================================


==================================================
* Pattern-37
==================================================


==================================================
* Pattern-38
==================================================


==================================================
* Pattern-39
==================================================


==================================================
* Pattern-40
==================================================


==================================================
* Pattern-41
==================================================


==================================================
* Pattern-42
==================================================


==================================================
* Pattern-43
==================================================


==================================================
* Pattern-44
==================================================



*/