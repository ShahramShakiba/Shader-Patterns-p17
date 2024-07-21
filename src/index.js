//===================================================
/* "It is not an actual project; therefore,
I rely on comments to assess the code." */
//===================================================
import { OrbitControls } from 'three/examples/jsm/controls/OrbitControls.js';
import * as THREE from 'three';
import GUI from 'lil-gui';
import vertex from './shaders/test/vertex.glsl';
import fragment from './shaders/test/fragment.glsl';

const canvas = document.querySelector('canvas.webgl');
const gui = new GUI();
const scene = new THREE.Scene();

let width = window.innerWidth;
let height = window.innerHeight;

//================== Objects ========================
//========== Geometry
const geometry = new THREE.PlaneGeometry(1, 1, 32, 32);
// console.log(geometry.attributes);

//========== Material
const material = new THREE.ShaderMaterial({
  vertexShader: vertex,
  fragmentShader: fragment,
  uniforms : {
    uTime: {value: 0.0}
  },
  side: THREE.DoubleSide,
});
// console.log(material);

//========== Mesh
const mesh = new THREE.Mesh(geometry, material);
scene.add(mesh);

//===================== Camera =========================
const camera = new THREE.PerspectiveCamera(75, width / height, 0.1, 100);
camera.position.set(0.25, -0.25, 1);
scene.add(camera);

//================ Orbit Controls ======================
const controls = new OrbitControls(camera, canvas);
controls.enableDamping = true;

//==================== Renderer ========================
const renderer = new THREE.WebGLRenderer({
  canvas: canvas,
  antialias: true,
});
renderer.setSize(width, height);
renderer.setPixelRatio(Math.min(window.devicePixelRatio, 2));

//================ Resize Listener ====================
window.addEventListener('resize', () => {
  width = window.innerWidth;
  height = window.innerHeight;

  camera.aspect = width / height;
  camera.updateProjectionMatrix();

  renderer.setSize(width, height);
  renderer.setPixelRatio(Math.min(window.devicePixelRatio, 2));
});

//=================== Animate =======================
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
