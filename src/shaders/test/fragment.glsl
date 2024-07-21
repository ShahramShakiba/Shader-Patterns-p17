varying vec2 vUv;

void main() {
    vec2 lightUv = vec2(
        vUv.x * 0.1 + 0.45,
        vUv.y * 0.5 + 0.25
    );

    float strength = 0.015 / distance(lightUv, vec2(0.5));

    gl_FragColor = vec4(strength, strength, strength, 1.0);
}


/*
==================================================
* Start point
==================================================
void main() {
    gl_FragColor = vec4(0.5, 0.0, 1.0, 1.0);
}


==================================================
* Pattern-01
==================================================
varying vec2 vUv;
void main() {
    gl_FragColor = vec4(vUv, 1.0, 1.0);
}


? How the Gradient is Created :
vUv contains two components: vUv.x and vUv.y.
These components are used as the "red" and "green" components of the color, respectively.

vec4(vUv, 1.0, 1.0) translates to vec4(vUv.x, vUv.y, 1.0, 1.0).
  - vUv.x varies from 0 to 1 across the horizontal axis.
  - vUv.y varies from 0 to 1 across the vertical axis.
  - The blue component is set to 1.0, making it full blue.
  - The alpha component is set to 1.0, making it fully opaque.

? Visual Effect :
As a result, the color of each pixel is determined by its UV coordinates.
    - At (0, 0), the color is vec4(0.0, 0.0, 1.0, 1.0) (blue).
    - At (1, 0), the color is vec4(1.0, 0.0, 1.0, 1.0) (magenta).
    - At (0, 1), the color is vec4(0.0, 1.0, 1.0, 1.0) (cyan).
    - At (1, 1), the color is vec4(1.0, 1.0, 1.0, 1.0) (white).

The gradient effect is created because the red and green components linearly interpolate based on the UV coordinates, while the blue component remains constant at 1.0.



==================================================
* Pattern-02 | UV Coordinates
==================================================
varying vec2 vUv;
void main() {
    gl_FragColor = vec4(vUv.x, vUv.y, 0.0, 1.0);

    // gl_FragColor = vec4(vUv.y, 0.459, vUv.x, 1.0); 
}


? Visual Effect :
  - At (0, 0), the color is vec4(0.0, 0.0, 0.0, 1.0) (black).
  - At (1, 0), the color is vec4(1.0, 0.0, 0.0, 1.0) (red).
  - At (0, 1), the color is vec4(0.0, 1.0, 0.0, 1.0) (green).
  - At (1, 1), the color is vec4(1.0, 1.0, 0.0, 1.0) (yellow).


==================================================
* Pattern-03 | Gradient: left: "black" and right: "white"  
==================================================
varying vec2 vUv;
void main() {
    gl_FragColor = vec4(vUv.x, vUv.x, vUv.x, 1.0);
}

OR

void main() {
    float strength = vUv.x;

    gl_FragColor = vec4(vec3(strength), 1.0);
}


==================================================
* Pattern-04 | top: "white" and bottom: "black"
==================================================
varying vec2 vUv;
void main() {
    float strength = vUv.y;
    
    gl_FragColor = vec4(strength, strength, strength, 1.0); 
}


==================================================
* Pattern-05 | top: "black" and bottom: "white"
==================================================
varying vec2 vUv;
void main() {
    float strength = 1.0 - vUv.y;

    gl_FragColor = vec4(strength, strength, strength, 1.0);
}


==================================================
* Pattern-06 | top: 90% white and bottom: 10% black 
==================================================
varying vec2 vUv;
void main() {
    float strength = vUv.y / 0.1;

    gl_FragColor = vec4(strength, strength, strength, 1.0);
}


==================================================
* Pattern-07 | Stripe Effect
==================================================
varying vec2 vUv;
void main() {
    float strength = mod(vUv.y / 0.1, 1.0);
    // float strength = mod(vUv.x / 0.35, 1.0);
    // float strength = mod(vUv.x / 0.65, 0.5);

    gl_FragColor = vec4(strength, strength, strength, 1.0);
}


* The mod() function thus creates a repeating sequence from 0 to 1.

? mod(x, y) :  modulus (remainder) after division
    - The mod(x, y) function returns the remainder of x divided by y.
    - For example, mod(5.5, 1.0) returns 0.5 because 5.5 divided by 1.0 leaves a remainder of 0.5.

    (X) valueToBeWrapped: The point or value that you want to be wrapped or repeated.

    (Y) wrappingInterval: The amount or interval at which the value should be wrapped or repeated.

? Stripe Effect :
    - The stripes are horizontal because the calculation uses vUv.y.
    - Each stripe is 0.1 units tall in UV coordinates.
    - The resulting visual effect is a series of horizontal bands that vary in grayscale intensity from black to white, repeating every 0.1 units along the vertical axis.



==================================================
* Pattern-08 | Sharp Stripe Effect
==================================================
varying vec2 vUv;
void main() {
    float strength = mod(vUv.y / 0.1, 1.0);

    if (strength < 0.5) {
        strength = 0.0;
    } else {
        strength = 1.0;
    }

    gl_FragColor = vec4(strength, strength, strength, 1.0);
}

! do not use if-else statment or tarnary operator because they can impact performance, if you can avoid doing "if-else" or " tarnary"


INSTEAD USE : 


? step() :
    - when it reaches a limit, it'll be 1(white) and before that 0(black)

? float step(float threshold, float inputValue);
    - threshold: The value that defines the boundary or limit.
    - inputValue: The value to be tested against the threshold.


varying vec2 vUv;
void main() {
    // float strength = mod(vUv.y / 0.1, 1.0);
    // strength = step(0.5, strength);

    float strength = mod(vUv.y / 0.1, 1.0);
    strength = step(0.3, strength);

    gl_FragColor = vec4(strength, strength, strength, 1.0);
}

  - for every 0.1 units in the y-axis 
       30% of the interval (0.03 units) will be black.
       70% of the interval (0.07 units) will be white.



==================================================
* Pattern-09 | Sharp Stripe Effect but narrow & horizontally
==================================================
varying vec2 vUv;
void main() {
    float strength = mod(vUv.y / 0.1, 1.0);
    strength = step(0.8, strength);

    gl_FragColor = vec4(strength, strength, strength, 1.0);
}



==================================================
* Pattern-10 | Sharp Stripe Effect but narrow & vertically
==================================================
varying vec2 vUv;
void main() {
    float strength = step(0.8, mod(vUv.x / 0.1, 1.0));

    gl_FragColor = vec4(strength, strength, strength, 1.0);
}



==================================================
* Pattern-11 | Strip Effect like a chess board
==================================================
varying vec2 vUv;
void main() {
    float strength = step(0.8, mod(vUv.x / 0.1, 1.0));
    strength += step(0.8, mod(vUv.y / 0.1, 1.0));

    strength = clamp(strength, 0.0, 1.0);

    vec3 blackColor = vec3(0.0);
    vec3 uvColor = vec3(vUv, 1.0);
    vec3 mixedColor = mix(blackColor, uvColor, strength);

    gl_FragColor = vec4(mixedColor, 1.0); 
}

? clamp() : 
    - without clamp you'll notice wierd bugs, like in some part color is not interpolated

    - By clamping strength, you ensure that the "mix" function always receives a valid interpolation factor, resulting in a predictable and correct output color.


==================================================
* Pattern-12 | Plane with lots of dots
==================================================
varying vec2 vUv;
void main() {
    float strength = step(0.8, mod(vUv.x / 0.1, 1.0));
    strength *= step(0.8, mod(vUv.y / 0.1, 1.0));

    gl_FragColor = vec4(strength, strength, strength, 1.0);
}



==================================================
* Pattern-13 | Plane with lots of bars
==================================================
varying vec2 vUv;
void main() {
    float strength = step(0.4, mod(vUv.x / 0.1, 1.0));
    strength *= step(0.8, mod(vUv.y / 0.1, 1.0));

    gl_FragColor = vec4(strength, strength, strength, 1.0);
}


==================================================
* Pattern-14 | Two bars on the right and top, stick to each other
==================================================
varying vec2 vUv;
void main() {
    float barX = step(0.4, mod(vUv.x / 0.1, 1.0));
    barX *= step(0.8, mod(vUv.y / 0.1, 1.0));
   
    float barY = step(0.8, mod(vUv.x / 0.1, 1.0));
    barY *= step(0.4, mod(vUv.y / 0.1, 1.0));

    float strength = barX + barY;

    gl_FragColor = vec4(strength, strength, strength, 1.0);
}

OR


void main() {
    float modX = mod(vUv.x / 0.1, 1.0);
    float modY = mod(vUv.y / 0.1, 1.0);

    float barX = step(0.5, modX) * step(0.8, modY);
    float barY = step(0.8, modX) * step(0.5, modY);

    float strength = barX + barY;

    gl_FragColor = vec4(strength, strength, strength, 1.0);
}


==================================================
* Pattern-15 | Bunch of plus sign
==================================================
varying vec2 vUv;
void main() {
    float barX = step(0.4, mod(vUv.x / 0.1, 1.0));
    barX *= step(0.8, mod(vUv.y / 0.1, 1.0));
   
    float barY = step(0.8, mod(vUv.x / 0.1 + 0.2, 1.0)); // offset it by 0.2
    barY *= step(0.4, mod(vUv.y / 0.1 - 0.2, 1.0)); // offset it by 0.2

    float strength = barX + barY;

    gl_FragColor = vec4(strength, strength, strength, 1.0);
}


==================================================
* Pattern-16 | left and right: white - center: black
==================================================
varying vec2 vUv;
void main() {
    float strength = abs(vUv.x - 0.5);

    gl_FragColor = vec4(strength, strength, strength, 1.0);
}


? abs() function :
    - returns the absolute value of x.
    - For example, abs(-0.5) returns 0.5 and abs(0.5) returns 0.5.

 - vUv.x varies from 0.0 to 1.0 across the horizontal axis.
 - Subtracting 0.5 shifts the range to -0.5 to 0.5.
 - The abs function makes this range 0.0 to 0.5, then back to 0.0 
 again

- At vUv.x = 0.0 and vUv.x = 1.0, strength is 0.5. | white
- At vUv.x = 0.5, strength is 0.0. | black


==================================================
* Pattern-17 | 4 suqare - black and white
==================================================
varying vec2 vUv;
void main() {
    float strength = min(abs(vUv.x - 0.5), abs(vUv.y - 0.5));

    gl_FragColor = vec4(strength, strength, strength, 1.0);
}


==================================================
* Pattern-18 | Invert pattern-17 - like a tunnel
==================================================
varying vec2 vUv;
void main() {
    float strength = max(abs(vUv.x - 0.5), abs(vUv.y - 0.5));

    gl_FragColor = vec4(strength, strength, strength, 1.0);
}



==================================================
* Pattern-19 | black square in the middle - like a frame with thick edges
==================================================
varying vec2 vUv;
void main() {
    float strength = step(0.2, max(abs(vUv.x - 0.5), abs(vUv.y - 0.5)));

    gl_FragColor = vec4(strength, strength, strength, 1.0);
}



==================================================
* Pattern-20 | Frame with thin edges
==================================================
varying vec2 vUv;
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
* Pattern-21 | Vertical Bands or Grayscale Steps
==================================================
varying vec2 vUv;
void main() {
    float strength = floor(vUv.x * 10.0) / 10.0;

    gl_FragColor = vec4(strength, strength, strength, 1.0);
}


? floor : 
  - get the lower value
  - Create vertical stripes or bands across the screen


==================================================
* Pattern-22 | low level gradient - like a Grid network
==================================================
varying vec2 vUv;
void main() {
    float strength = 
        floor(vUv.x * 10.0) / 10.0 * floor(vUv.y * 10.0) / 10.0;

    gl_FragColor = vec4(strength, strength, strength, 1.0);
}



==================================================
* Pattern-23 | A broken TV channel
==================================================
varying vec2 vUv;

float random(vec2 st) {
    return 
        fract(sin(dot(st.xy, vec2(12.9898, 78.233))) * 43758.5453123);
}

void main() {
    float strength = random(vUv);
        
    gl_FragColor = vec4(strength, strength, strength, 1.0);
}



? random(vec2 st) :
    - generates a pseudo-random number based on the input 2D coordinates st

? st :
    - The argument "st" is a 2D vector, often representing texture coordinates or screen space coordinates

? dot(st.xy, vec2(12.9898, 78.233)) : 
    - The purpose of this dot product is to combine the x and y components of st into a single value in a manner that introduces complexity, helping in pseudo-random generation.

? sin() : 
    - The sin function takes the result of the dot product and computes its sine. The sine function is used because it produces a non-linear, periodic output that contributes to the randomness.

? 12.9898, 78.233, and 43758.5453123 : 
    - These are arbitrary constants chosen to ensure the values produced by the dot product and sine function are suitably distributed and not easily predictable.

    - "43758.5453123" scales the sine value to spread out the resulting values over a wider range before applying fract.

? fract() :
    - The fract function takes the fractional part of the input (i.e., it returns the value minus its integer part). This effectively normalizes the result to the range [0.0, 1.0], which is useful for random number generation.



==================================================
* Pattern-24 | Grid network with randomness
==================================================
varying vec2 vUv;

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
* Pattern-25 | Random grid network with offset
==================================================
varying vec2 vUv;

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
* Pattern-26 | - Length of UV
==================================================
varying vec2 vUv;
void main() {
    float strength = length(vUv);

    gl_FragColor = vec4(strength, strength, strength, 1.0);
}



==================================================
* Pattern-27 | get length of UV in center - dark point in the center

==================================================
varying vec2 vUv;
void main() {
    float strength = length(vUv - 0.5);

    gl_FragColor = vec4(strength, strength, strength, 1.0);
}


OR


? distance between "UV coordinate" and a "desire point"

void main() {
    float strength = distance(vUv, vec2(0.7, 0.3));

    gl_FragColor = vec4(strength, strength, strength, 1.0);
}



==================================================
* Pattern-28 | opposite of 27
==================================================
varying vec2 vUv;

void main() {
    float strength = 1.0 - distance(vUv, vec2(0.5));

    gl_FragColor = vec4(strength, strength, strength, 1.0);
}



==================================================
* Pattern-29 | Moon Shape Effect
==================================================
varying vec2 vUv;
void main() {
    float strength = 0.05 / distance(vUv, vec2(0.5));

    gl_FragColor = vec4(strength, strength, strength, 1.0);
}

- with this light-point effect you never reaches 0 
- it might be a problem in some situation you can see the edges of 
  your plane



==================================================
* Pattern-30 | Stretch Moon
==================================================
varying vec2 vUv;
void main() {
    vec2 lightUv = vec2(
        vUv.x * 0.1 + 0.45,
        vUv.y * 0.5 + 0.25
    );

    float strength = 0.015 / distance(lightUv, vec2(0.5));

    gl_FragColor = vec4(strength, strength, strength, 1.0);
}



==================================================
* Pattern-31 | Star
==================================================
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



==================================================
* Pattern-32 | Star but rotating by one quarter of PI
==================================================
#define PI 3.1415926535897932384626433832795

varying vec2 vUv;

vec2 rotate(vec2 uv, float rotation, vec2 mid) {
    return vec2(
        cos(rotation) * (uv.x - mid.x) + sin(rotation) * (uv.y - mid.y) + mid.x,
        cos(rotation) * (uv.y - mid.y) - sin(rotation) * (uv.x - mid.x) + mid.y
    );
}

void main() {
    vec2 rotateUv = rotate(vUv, PI / 4.0, vec2(0.5));

    vec2 lightUvX = vec2(
        rotateUv.x * 0.1 + 0.45,
        rotateUv.y * 0.5 + 0.25
    );
    float lightX = 0.015 / distance(lightUvX, vec2(0.5));
   
    vec2 lightUvY = vec2(
        rotateUv.y * 0.1 + 0.45,
        rotateUv.x * 0.5 + 0.25
    );
    float lightY = 0.015 / distance(lightUvY, vec2(0.5));


    float strength = lightX * lightY;

    gl_FragColor = vec4(strength, strength, strength, 1.0);
}



==================================================
* Pattern-33 | Big black circle in the center 
==================================================
varying vec2 vUv;

void main() {
    float strength = step(0.3, distance(vUv, vec2(0.5)));

    gl_FragColor = vec4(strength, strength, strength, 1.0);
}



==================================================
* Pattern-34 | Two faded circle
==================================================
varying vec2 vUv;

void main() {
    float strength = abs(distance(vUv, vec2(0.5)) - 0.3);

    gl_FragColor = vec4(strength, strength, strength, 1.0);
}



==================================================
* Pattern-35 | Black circle
==================================================
varying vec2 vUv;

void main() {
    float strength = step(0.015, abs(distance(vUv, vec2(0.5)) - 0.3));

    gl_FragColor = vec4(strength, strength, strength, 1.0);
}



==================================================
* Pattern-36 | White Circle
==================================================
varying vec2 vUv;

void main() {
    float strength = 1.0 - step(0.015, abs(distance(vUv, vec2(0.5)) - 0.3));

    gl_FragColor = vec4(strength, strength, strength, 1.0);
}



==================================================
* Pattern-37 | Spooky circle
==================================================
varying vec2 vUv;

void main() {
    vec2 wavedUv = vec2(
        vUv.x,
        vUv.y + sin(vUv.x * 30.0) * 0.1
    );

    float strength = 1.0 - step(0.015, abs(distance(wavedUv, vec2(0.5)) - 0.3));

    gl_FragColor = vec4(strength, strength, strength, 1.0);
}



==================================================
* Pattern-38 | Strange shape like spilled liquid
==================================================
varying vec2 vUv;

void main() {
    vec2 wavedUv = vec2(
        vUv.x + sin(vUv.y * 30.0) * 0.1,
        vUv.y + sin(vUv.x * 30.0) * 0.1
    );

    float strength = 
        1.0 - step(0.015, abs(distance(wavedUv, vec2(0.5)) - 0.25));

    gl_FragColor = vec4(strength, strength, strength, 1.0);
}



==================================================
* Pattern-39 | sound waves - sense of movement and balance
==================================================
varying vec2 vUv;

void main() {
    vec2 wavedUv = vec2(
        vUv.x + sin(vUv.y * 100.0) * 0.1,
        vUv.y + sin(vUv.x * 100.0) * 0.1
    );

    float strength = 
        1.0 - step(0.015, abs(distance(wavedUv, vec2(0.5)) - 0.25));

    gl_FragColor = vec4(strength, strength, strength, 1.0);
}



==================================================
* Pattern-40 | Angle
==================================================
varying vec2 vUv;

void main() {
    float angle = atan(vUv.x, vUv.y);
    float strength = angle;

    gl_FragColor = vec4(strength, strength, strength, 1.0);
}


? atan(vUv.y, vUv.x) :
     computes the angle (in radians) between the positive x-axis and the point (vUv.x, vUv.y), effectively converting Cartesian coordinates to polar coordinates.



==================================================
* Pattern-41 | pattern40 starts from the center
==================================================
varying vec2 vUv;

void main() {
    float angle = atan(vUv.x - 0.5, vUv.y - 0.5);
    float strength = angle;

    gl_FragColor = vec4(strength, strength, strength, 1.0);
}



==================================================
* Pattern-42 | The gradient transitions from black to white, converging at a point near the center of the bottom edge
==================================================
#define PI 3.1415926535897932384626433832795

varying vec2 vUv;

void main() {
    float angle = atan(vUv.x - 0.5, vUv.y - 0.5);
    angle /= PI * 2.0;
    angle += 0.5;
    float strength = angle;

    gl_FragColor = vec4(strength, strength, strength, 1.0);
}



==================================================
* Pattern-43 | alternating dark and light triangles converging towards a central point
==================================================
#define PI 3.1415926535897932384626433832795

varying vec2 vUv;

void main() {
    float angle = atan(vUv.x - 0.5, vUv.y - 0.5);
    angle /= PI * 2.0;
    angle += 0.5;
    angle *= 20.0;
    angle = mod(angle, 1.0);
    float strength = angle;

    gl_FragColor = vec4(strength, strength, strength, 1.0);
}



==================================================
* Pattern-44 | central point from which white rays radiate outward against a black background
==================================================
#define PI 3.1415926535897932384626433832795

varying vec2 vUv;

void main() {
    float angle = atan(vUv.x - 0.5, vUv.y - 0.5);
    angle /= PI * 2.0;
    angle += 0.5;
    float strength = sin(angle * 100.0);

    gl_FragColor = vec4(strength, strength, strength, 1.0);
}



==================================================
* Pattern-45 | Wavy Circle Outline
==================================================
#define PI 3.1415926535897932384626433832795

varying vec2 vUv;

void main() {
    float angle = atan(vUv.x - 0.5, vUv.y - 0.5);
    angle /= PI * 2.0;
    angle += 0.5;
    float sinusoid = sin(angle * 100.0);
   
    float radius = 0.3 + sinusoid * 0.02;
    float strength = 1.0 - step(0.015, abs(distance(vUv, vec2(0.5)) - radius));

    gl_FragColor = vec4(strength, strength, strength, 1.0);
}


? sinusoid :
    The term "sinusoid" is commonly used to describe a waveform that follows the shape of a sine wave


==================================================
* | Pattern-46 | 
* Perlin moise: can recreate nature shapes like "clouds", "water", "fire", "terrain elevation" but it can also be used to animate the grass or snow moving in the wind
==================================================
//	Classic Perlin 2D Noise 
//	by Stefan Gustavson (https://github.com/stegu/webgl-noise)
vec2 fade(vec2 t) {
    return t*t*t*(t*(t*6.0-15.0)+10.0);
}

vec4 permute(vec4 x) {
    return mod(((x * 34.0) + 1.0) * x, 289.0);
}

float cnoise(vec2 P) {
  vec4 Pi = floor(P.xyxy) + vec4(0.0, 0.0, 1.0, 1.0);
  vec4 Pf = fract(P.xyxy) - vec4(0.0, 0.0, 1.0, 1.0);
  Pi = mod(Pi, 289.0); // To avoid truncation effects in permutation

  vec4 ix = Pi.xzxz;
  vec4 iy = Pi.yyww;
  vec4 fx = Pf.xzxz;
  vec4 fy = Pf.yyww;
  vec4 i = permute(permute(ix) + iy);

  vec4 gx = 2.0 * fract(i * 0.0243902439) - 1.0; // 1/41 = 0.024...
  vec4 gy = abs(gx) - 0.5;
  vec4 tx = floor(gx + 0.5);
  gx = gx - tx;
  vec2 g00 = vec2(gx.x, gy.x);
  vec2 g10 = vec2(gx.y, gy.y);
  vec2 g01 = vec2(gx.z, gy.z);
  vec2 g11 = vec2(gx.w, gy.w);

  vec4 norm = 1.79284291400159 - 0.85373472095314 * 
    vec4(dot(g00, g00), dot(g01, g01), dot(g10, g10), dot(g11, g11));
  g00 *= norm.x;
  g01 *= norm.y;
  g10 *= norm.z;
  g11 *= norm.w;
  float n00 = dot(g00, vec2(fx.x, fy.x));
  float n10 = dot(g10, vec2(fx.y, fy.y));
  float n01 = dot(g01, vec2(fx.z, fy.z));
  float n11 = dot(g11, vec2(fx.w, fy.w));

  vec2 fade_xy = fade(Pf.xy);
  vec2 n_x = mix(vec2(n00, n01), vec2(n10, n11), fade_xy.x);
  float n_xy = mix(n_x.x, n_x.y, fade_xy.y);

  return 2.3 * n_xy;
}

varying vec2 vUv;

void main() {
    float strength = cnoise(vUv * 10.0);
    gl_FragColor = vec4(vec3(strength), 1.0);
}


? you can get "cnoise" function from :
https://gist.github.com/patriciogonzalezvivo/670c22f3966e662d2f83




==================================================
* Pattern-47 | Sharp Perlin moise
==================================================
//	Classic Perlin 2D Noise 
//	by Stefan Gustavson (https://github.com/stegu/webgl-noise)
vec2 fade(vec2 t) {
    return t*t*t*(t*(t*6.0-15.0)+10.0);
}

vec4 permute(vec4 x) {
    return mod(((x * 34.0) + 1.0) * x, 289.0);
}

float cnoise(vec2 P) {
  vec4 Pi = floor(P.xyxy) + vec4(0.0, 0.0, 1.0, 1.0);
  vec4 Pf = fract(P.xyxy) - vec4(0.0, 0.0, 1.0, 1.0);
  Pi = mod(Pi, 289.0); // To avoid truncation effects in permutation

  vec4 ix = Pi.xzxz;
  vec4 iy = Pi.yyww;
  vec4 fx = Pf.xzxz;
  vec4 fy = Pf.yyww;
  vec4 i = permute(permute(ix) + iy);

  vec4 gx = 2.0 * fract(i * 0.0243902439) - 1.0; // 1/41 = 0.024...
  vec4 gy = abs(gx) - 0.5;
  vec4 tx = floor(gx + 0.5);
  gx = gx - tx;
  vec2 g00 = vec2(gx.x, gy.x);
  vec2 g10 = vec2(gx.y, gy.y);
  vec2 g01 = vec2(gx.z, gy.z);
  vec2 g11 = vec2(gx.w, gy.w);

  vec4 norm = 1.79284291400159 - 0.85373472095314 * 
    vec4(dot(g00, g00), dot(g01, g01), dot(g10, g10), dot(g11, g11));
  g00 *= norm.x;
  g01 *= norm.y;
  g10 *= norm.z;
  g11 *= norm.w;
  float n00 = dot(g00, vec2(fx.x, fy.x));
  float n10 = dot(g10, vec2(fx.y, fy.y));
  float n01 = dot(g01, vec2(fx.z, fy.z));
  float n11 = dot(g11, vec2(fx.w, fy.w));

  vec2 fade_xy = fade(Pf.xy);
  vec2 n_x = mix(vec2(n00, n01), vec2(n10, n11), fade_xy.x);
  float n_xy = mix(n_x.x, n_x.y, fade_xy.y);

  return 2.3 * n_xy;
}

varying vec2 vUv;

void main() {
    float strength = step(0.0, cnoise(vUv * 10.0));
    gl_FragColor = vec4(vec3(strength), 1.0);
}



==================================================
* Pattern-48 | Perlin noise - topographic maps or fluid dynamics visualizations
==================================================
//	Classic Perlin 2D Noise 
//	by Stefan Gustavson (https://github.com/stegu/webgl-noise)
vec2 fade(vec2 t) {
    return t*t*t*(t*(t*6.0-15.0)+10.0);
}

vec4 permute(vec4 x) {
    return mod(((x * 34.0) + 1.0) * x, 289.0);
}

float cnoise(vec2 P) {
  vec4 Pi = floor(P.xyxy) + vec4(0.0, 0.0, 1.0, 1.0);
  vec4 Pf = fract(P.xyxy) - vec4(0.0, 0.0, 1.0, 1.0);
  Pi = mod(Pi, 289.0); // To avoid truncation effects in permutation

  vec4 ix = Pi.xzxz;
  vec4 iy = Pi.yyww;
  vec4 fx = Pf.xzxz;
  vec4 fy = Pf.yyww;
  vec4 i = permute(permute(ix) + iy);

  vec4 gx = 2.0 * fract(i * 0.0243902439) - 1.0; // 1/41 = 0.024...
  vec4 gy = abs(gx) - 0.5;
  vec4 tx = floor(gx + 0.5);
  gx = gx - tx;
  vec2 g00 = vec2(gx.x, gy.x);
  vec2 g10 = vec2(gx.y, gy.y);
  vec2 g01 = vec2(gx.z, gy.z);
  vec2 g11 = vec2(gx.w, gy.w);

  vec4 norm = 1.79284291400159 - 0.85373472095314 * 
    vec4(dot(g00, g00), dot(g01, g01), dot(g10, g10), dot(g11, g11));
  g00 *= norm.x;
  g01 *= norm.y;
  g10 *= norm.z;
  g11 *= norm.w;
  float n00 = dot(g00, vec2(fx.x, fy.x));
  float n10 = dot(g10, vec2(fx.y, fy.y));
  float n01 = dot(g01, vec2(fx.z, fy.z));
  float n11 = dot(g11, vec2(fx.w, fy.w));

  vec2 fade_xy = fade(Pf.xy);
  vec2 n_x = mix(vec2(n00, n01), vec2(n10, n11), fade_xy.x);
  float n_xy = mix(n_x.x, n_x.y, fade_xy.y);

  return 2.3 * n_xy;
}

varying vec2 vUv;

void main() {
    float strength = 1.0 - abs(cnoise(vUv * 10.0));
    gl_FragColor = vec4(vec3(strength), 1.0);
}



==================================================
* Pattern-49 | Gradient Perlin moise
==================================================
//	Classic Perlin 2D Noise 
//	by Stefan Gustavson (https://github.com/stegu/webgl-noise)
vec2 fade(vec2 t) {
    return t*t*t*(t*(t*6.0-15.0)+10.0);
}

vec4 permute(vec4 x) {
    return mod(((x * 34.0) + 1.0) * x, 289.0);
}

float cnoise(vec2 P) {
  vec4 Pi = floor(P.xyxy) + vec4(0.0, 0.0, 1.0, 1.0);
  vec4 Pf = fract(P.xyxy) - vec4(0.0, 0.0, 1.0, 1.0);
  Pi = mod(Pi, 289.0); // To avoid truncation effects in permutation

  vec4 ix = Pi.xzxz;
  vec4 iy = Pi.yyww;
  vec4 fx = Pf.xzxz;
  vec4 fy = Pf.yyww;
  vec4 i = permute(permute(ix) + iy);

  vec4 gx = 2.0 * fract(i * 0.0243902439) - 1.0; // 1/41 = 0.024...
  vec4 gy = abs(gx) - 0.5;
  vec4 tx = floor(gx + 0.5);
  gx = gx - tx;
  vec2 g00 = vec2(gx.x, gy.x);
  vec2 g10 = vec2(gx.y, gy.y);
  vec2 g01 = vec2(gx.z, gy.z);
  vec2 g11 = vec2(gx.w, gy.w);

  vec4 norm = 1.79284291400159 - 0.85373472095314 * 
    vec4(dot(g00, g00), dot(g01, g01), dot(g10, g10), dot(g11, g11));
  g00 *= norm.x;
  g01 *= norm.y;
  g10 *= norm.z;
  g11 *= norm.w;
  float n00 = dot(g00, vec2(fx.x, fy.x));
  float n10 = dot(g10, vec2(fx.y, fy.y));
  float n01 = dot(g01, vec2(fx.z, fy.z));
  float n11 = dot(g11, vec2(fx.w, fy.w));

  vec2 fade_xy = fade(Pf.xy);
  vec2 n_x = mix(vec2(n00, n01), vec2(n10, n11), fade_xy.x);
  float n_xy = mix(n_x.x, n_x.y, fade_xy.y);

  return 2.3 * n_xy;
}

varying vec2 vUv;

void main() {
    float strength = sin(cnoise(vUv * 10.0) * 20.0);
    gl_FragColor = vec4(vec3(strength), 1.0);
}


==================================================
* Pattern-50 | Sharp Perlin moise
==================================================
//	Classic Perlin 2D Noise 
//	by Stefan Gustavson (https://github.com/stegu/webgl-noise)
vec2 fade(vec2 t) {
    return t*t*t*(t*(t*6.0-15.0)+10.0);
}

vec4 permute(vec4 x) {
    return mod(((x * 34.0) + 1.0) * x, 289.0);
}

float cnoise(vec2 P) {
  vec4 Pi = floor(P.xyxy) + vec4(0.0, 0.0, 1.0, 1.0);
  vec4 Pf = fract(P.xyxy) - vec4(0.0, 0.0, 1.0, 1.0);
  Pi = mod(Pi, 289.0); // To avoid truncation effects in permutation

  vec4 ix = Pi.xzxz;
  vec4 iy = Pi.yyww;
  vec4 fx = Pf.xzxz;
  vec4 fy = Pf.yyww;
  vec4 i = permute(permute(ix) + iy);

  vec4 gx = 2.0 * fract(i * 0.0243902439) - 1.0; // 1/41 = 0.024...
  vec4 gy = abs(gx) - 0.5;
  vec4 tx = floor(gx + 0.5);
  gx = gx - tx;
  vec2 g00 = vec2(gx.x, gy.x);
  vec2 g10 = vec2(gx.y, gy.y);
  vec2 g01 = vec2(gx.z, gy.z);
  vec2 g11 = vec2(gx.w, gy.w);

  vec4 norm = 1.79284291400159 - 0.85373472095314 * 
    vec4(dot(g00, g00), dot(g01, g01), dot(g10, g10), dot(g11, g11));
  g00 *= norm.x;
  g01 *= norm.y;
  g10 *= norm.z;
  g11 *= norm.w;
  float n00 = dot(g00, vec2(fx.x, fy.x));
  float n10 = dot(g10, vec2(fx.y, fy.y));
  float n01 = dot(g01, vec2(fx.z, fy.z));
  float n11 = dot(g11, vec2(fx.w, fy.w));

  vec2 fade_xy = fade(Pf.xy);
  vec2 n_x = mix(vec2(n00, n01), vec2(n10, n11), fade_xy.x);
  float n_xy = mix(n_x.x, n_x.y, fade_xy.y);

  return 2.3 * n_xy;
}

varying vec2 vUv;

void main() {
    float strength = step(0.9, sin(cnoise(vUv * 10.0) * 20.0));
    gl_FragColor = vec4(vec3(strength), 1.0);
}


==================================================
* Pattern-51 | Color Version, now we can add color to all patterns
==================================================
//	Classic Perlin 2D Noise 
//	by Stefan Gustavson (https://github.com/stegu/webgl-noise)
vec2 fade(vec2 t) {
    return t*t*t*(t*(t*6.0-15.0)+10.0);
}

vec4 permute(vec4 x) {
    return mod(((x * 34.0) + 1.0) * x, 289.0);
}

float cnoise(vec2 P) {
  vec4 Pi = floor(P.xyxy) + vec4(0.0, 0.0, 1.0, 1.0);
  vec4 Pf = fract(P.xyxy) - vec4(0.0, 0.0, 1.0, 1.0);
  Pi = mod(Pi, 289.0); // To avoid truncation effects in permutation

  vec4 ix = Pi.xzxz;
  vec4 iy = Pi.yyww;
  vec4 fx = Pf.xzxz;
  vec4 fy = Pf.yyww;
  vec4 i = permute(permute(ix) + iy);

  vec4 gx = 2.0 * fract(i * 0.0243902439) - 1.0; // 1/41 = 0.024...
  vec4 gy = abs(gx) - 0.5;
  vec4 tx = floor(gx + 0.5);
  gx = gx - tx;
  vec2 g00 = vec2(gx.x, gy.x);
  vec2 g10 = vec2(gx.y, gy.y);
  vec2 g01 = vec2(gx.z, gy.z);
  vec2 g11 = vec2(gx.w, gy.w);

  vec4 norm = 1.79284291400159 - 0.85373472095314 * 
    vec4(dot(g00, g00), dot(g01, g01), dot(g10, g10), dot(g11, g11));
  g00 *= norm.x;
  g01 *= norm.y;
  g10 *= norm.z;
  g11 *= norm.w;
  float n00 = dot(g00, vec2(fx.x, fy.x));
  float n10 = dot(g10, vec2(fx.y, fy.y));
  float n01 = dot(g01, vec2(fx.z, fy.z));
  float n11 = dot(g11, vec2(fx.w, fy.w));

  vec2 fade_xy = fade(Pf.xy);
  vec2 n_x = mix(vec2(n00, n01), vec2(n10, n11), fade_xy.x);
  float n_xy = mix(n_x.x, n_x.y, fade_xy.y);

  return 2.3 * n_xy;
}

varying vec2 vUv;

void main() {
    float strength = step(0.9, sin(cnoise(vUv * 10.0) * 20.0));

    // Clamp the strength
    strength = clamp(strength, 0.0, 1.0);

    // colored version
    vec3 blackColor = vec3(0.0);
    vec3 uvColor = vec3(vUv, 1.0);
    vec3 mixedColor = mix(blackColor, uvColor, strength);
    gl_FragColor = vec4(mixedColor, 1.0);

    // // black and white version
    // gl_FragColor = vec4(strength, strength, strength, 1.0);
}


? clamp(x, minVal, maxVal)
    - x is the value to be clamped.
    - minVal is the minimum value that x can be.
    - maxVal is the maximum value that x can be.



==================================================
* Pattern-52 | 
==================================================
varying vec2 vUv;
void main() {
    float modX = mod(vUv.x / 0.2, 1.0);
    float modY = mod(vUv.y / 0.1, 1.0);

    float strength =  modX + modY;


    strength = clamp(strength, 0.0, 1.0);

    vec3 blackColor = vec3(0.0);
    vec3 uvColor = vec3(0.86, vUv.x, 0.5);
    vec3 mixedColor = mix(blackColor, uvColor, strength);

    gl_FragColor = vec4(mixedColor, 1.0); 
}


==================================================
* Pattern-53 | 
==================================================
varying vec2 vUv;
void main() {
    float strength = step(0.02, abs(vUv.x - 0.5) * abs(vUv.y - 0.5));

    gl_FragColor = vec4(strength, strength, strength, 1.0);
}



==================================================
* Pattern-54 | 
==================================================
varying vec2 vUv;
void main() {
    // Calculate the distance from the center
    vec2 center = vec2(0.5);
    float distance = length(vUv - center);

    // Create a gradient effect
    float strength = smoothstep(0.5, 1.0, 1.0 - distance);

    gl_FragColor = vec4(vec3(strength), 1.0);
}



==================================================
* Pattern-55 | White hole like a white ball
==================================================
varying vec2 vUv;
void main() {
    // Calculate the distance from the center
    vec2 center = vec2(0.5);
    float distance = length(vUv - center);

    // Create a gradient effect
    float strength = smoothstep(0.5, 0.5, 1.0 - distance);

    gl_FragColor = vec4(vec3(strength), 1.0);
}


==================================================
* Pattern-56 | dark hole
==================================================
varying vec2 vUv;
void main() {
    vec2 centeredUv = vUv - vec2(0.5, 0.5);
    float distance = length(centeredUv);

    // Define the radius of the black hole in the center
    float holeRadius = 0.2;

    // Create a gradient effect for the walls
    float wallGradient = smoothstep(holeRadius, holeRadius + 0.6, distance);

    // Create the color based on the distance
    vec3 color = mix(vec3(0.0), vec3(1.0), wallGradient);

    gl_FragColor = vec4(color, 1.0);
}


==================================================
* Pattern-57 | 
==================================================
varying vec2 vUv;
void main() {
    // Center the coordinates 
    vec2 center = vUv - vec2(0.5);

    // Convert to polar coordinates
    float angle = atan(center.y, center.x);
    float radius = length(center);

    float tunnel = 0.5 + 0.5 * sin(10.0 * radius - angle * 5.0);

    // Create a gradient based on distance from center
    float gradient = 1.0 - radius;

    float strength = tunnel * gradient;
 
    gl_FragColor = vec4(vec3(strength), 1.0);
}


==================================================
* Pattern-58 | A point light in distance
==================================================
varying vec2 vUv;
void main() {
    vec2 centeredUv = vUv - vec2(0.5, 0.5);
    float distance = length(centeredUv);

    // Apply a perspective effect
    float perspective = 1.0 / (0.5 + distance * 10.0);

    // Create a gradient effect based on distance from the center
    float gradient = smoothstep(1.0, 0.0, distance);

    float strength = perspective * gradient;
    vec3 color = vec3(strength * 0.3);  // Darker value for realistic effect

    gl_FragColor = vec4(color, 1.0);
}



==================================================
* Pattern-59 | Checkerboard
==================================================
varying vec2 vUv;
void main() {
    float xStrength = floor(vUv.x * 10.0);
    float yStrength = floor(vUv.y * 10.0);
    float strength = mod(xStrength + yStrength, 2.0);

    gl_FragColor = vec4(strength, strength, strength, 1.0);
}


? floor : 
    - Combine vertical and horizontal bands to create a checkerboard pattern. 

? mod :
    - creates a repeating sequence from 0 to 1.


==================================================
* Pattern-60 | Circular Rings
==================================================
varying vec2 vUv;

void main() {
    float dist = distance(vUv, vec2(0.5));
    float strength = sin(dist * 50.0) * 0.5 + 0.5; // Adjust frequency with 50.0
    
    gl_FragColor = vec4(strength, strength, strength, 1.0);
}


==================================================
* Pattern-61 | Ripple Effect - Animated - Circular Wave Patterns
==================================================
varying vec2 vUv;
uniform float uTime;

void main() {
    float dist = distance(vUv, vec2(0.5));
    float strength = sin(dist * 20.0 - uTime * 5.0) * 0.5 + 0.5; 
    // uTime for animation
    
    gl_FragColor = vec4(strength, strength, strength, 1.0);
}


? Update the Shader Material :
    const material = new THREE.ShaderMaterial({
        vertexShader: vertex,
        fragmentShader: fragment,
        uniforms: {
            uTime: { value: 0.0 }
        },
        side: THREE.DoubleSide,
    });

? Modify the Animation Loop :
    let startTime = Date.now(); 

    const tick = () => {
        const elapsedTime = (Date.now() - startTime) / 1000; 

        // Update the uTime uniform
        material.uniforms.uTime.value = elapsedTime;

  
        controls.update();
        renderer.render(scene, camera);
        window.requestAnimationFrame(tick);
    };

    tick();


==================================================
* Pattern-62 | Starburst Effect
==================================================
varying vec2 vUv;

void main() {
    vec2 center = vec2(0.5);
    vec2 toCenter = vUv - center;
    float angle = atan(toCenter.y, toCenter.x);
    float dist = length(toCenter);
    float strength = abs(sin(angle * 10.0)) / (dist * 10.0 + 0.1);
    
    gl_FragColor = vec4(strength, strength, strength, 1.0);
}



==================================================
* Pattern-63 | Mandelbrot-Inspired Patterns
==================================================
varying vec2 vUv;

void main() {
    vec2 center = vec2(0.5);
    vec2 z = vUv * 2.0 - 1.0;
    vec2 c = z;
    float intensity = 0.0;

    for (int i = 0; i < 100; i++) {
        float x = (z.x * z.x - z.y * z.y) + c.x;
        float y = (z.y * z.x + z.x * z.y) + c.y;

        if (length(vec2(x, y)) > 2.0) break;
        
        z = vec2(x, y);
        intensity += 0.01;
    }

    gl_FragColor = vec4(intensity, intensity, intensity, 1.0);
}



==================================================
* Pattern-64 | 
==================================================




==================================================
* Pattern-65 | 
==================================================




==================================================
* Pattern-66 | 
==================================================




==================================================
* Pattern-67 | 
==================================================

*/