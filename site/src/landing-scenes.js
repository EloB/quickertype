// The scenes landing-art.js draws over the landing page's images: WebGL 1
// shaders (GLSL ES 1.00), one per image, named by the image. Each draws its
// image's scene at time T (seconds) on a canvas of R pixels.

export const VERTEX = "attribute vec2 a;void main(){gl_Position=vec4(a,0.,1.);}";

// highp: the hashes' sin()*43758 overflows mediump (landing-art.js draws
// only where fragment shaders have highp floats).
export const COMMON = `
precision highp float;
uniform vec2 R;
uniform float T;
float hash(float n){return fract(sin(n*12.9898)*43758.5453);}
float hash2(vec2 p){return fract(sin(dot(p,vec2(127.1,311.7)))*43758.5453);}
float noise(vec2 p){
  vec2 i=floor(p),f=fract(p);f=f*f*(3.-2.*f);
  return mix(mix(hash2(i),hash2(i+vec2(1.,0.)),f.x),mix(hash2(i+vec2(0.,1.)),hash2(i+vec2(1.,1.)),f.x),f.y);
}
float fbm(vec2 p){float s=0.,a=.5;for(int i=0;i<5;i++){s+=a*noise(p);p=p*2.02+vec2(3.1,1.7);a*=.5;}return s;}
// Soft highlights instead of clipping, and a little dither against banding.
vec4 finish(vec3 c){c=1.-exp(-c);c+=(hash2(gl_FragCoord.xy)-.5)/255.;return vec4(c,1.);}
`;

export const SCENES = {
    // x runs 0..aspect, y 0..1 from the bottom; the band's top is masked
    // away (.hero-art), so the trails run in its lower half.
    "speed-trails": `
float trail(vec2 p,float y,float head,float len,float w){
  float behind=head-p.x;
  float along=behind>=0.?exp(-behind/len):exp(-behind*behind/(w*w*30.));
  float d=abs(p.y-y);
  return along*(exp(-d*d/(w*w))+.6*w/(d+w)*exp(-d*12.)+.22*exp(-d*d/(w*w*40.)));
}
void main(){
  float asp=R.x/R.y;
  vec2 uv=gl_FragCoord.xy/R;
  vec2 p=vec2(uv.x*asp,uv.y);
  vec3 col=mix(vec3(.018,.02,.06),vec3(.07,.08,.21),exp(-pow((uv.y-.46)/.3,2.)));
  col*=1.-.3*pow(abs(uv.x-.5)*2.,3.);
  // smoke, drifting with the race
  vec2 q=vec2(p.x*.8-T*.07,p.y*2.4);
  float s=fbm(q+1.3*fbm(q*1.4+vec2(T*.03,0.)));
  col+=vec3(.16,.22,.55)*s*s*exp(-pow((uv.y-.44)/.2,2.))*1.7;
  // out-of-focus lights
  for(int i=0;i<9;i++){
    float f=float(i);
    vec2 c=vec2(mod(hash(f)*(asp+.6)+T*(.015+.02*hash(f+3.)),asp+.6)-.3,.30+.26*hash(f+7.));
    float r=.025+.035*hash(f+11.);
    col+=vec3(.3,.42,.8)*.16*smoothstep(r,r*.6,length(p-c))*(.6+.4*sin(T*.8+f*2.1));
  }
  // quicktype: blue, slow, its tail across the whole band
  float vb=.24,lb=1.25,pb=(asp+6.*lb+.4)/vb;
  float hb=mod(T+(asp*.93+.2)/vb,pb)*vb-.2;
  float yb=.36+.032*sin(p.x*1.6+.4)+.01*sin(p.x*3.7-T*.5);
  float b=trail(p,yb,hb,lb,.015);
  col+=mix(vec3(.36,.62,1.),vec3(.8,.92,1.),.4*exp(-abs(p.y-yb)/.006))*b*1.9;
  // quickertype: violet, fast, overtaking it every few seconds
  float vv=1.35,lv=.5,pv=(asp+4.*lv+.4)/vv+.4;
  float hv=mod(T+(asp*.45+.2)/vv,pv)*vv-.2;
  float yv=.45+.022*sin(p.x*1.9+1.8)+.008*sin(p.x*4.1+T*.6);
  float v=trail(p,yv,hv,lv,.012);
  col+=mix(vec3(.72,.38,1.),vec3(1.,.95,1.),.8*exp(-abs(p.y-yv)/.006))*v*2.8;
  // the head's flare
  vec2 hd=p-vec2(hv,yv);
  col+=vec3(.8,.6,1.)*.0016/(dot(hd*vec2(.35,1.),hd*vec2(.35,1.))+.0016)*.35;
  gl_FragColor=finish(col);
}`,

    // x runs about -0.9..0.9, y -0.5..0.5, both in units of the height.
    "thanks-threads": `
float centre(float x){return .07*x+.045*sin(x*2.3);}
void main(){
  vec2 p=(gl_FragCoord.xy-.5*R)/R.y;
  vec3 col=mix(vec3(.018,.022,.075),vec3(.04,.05,.15),.5+.5*p.y);
  for(int i=0;i<7;i++){
    float f=float(i);
    vec2 c=vec2(hash(f)*1.8-.9+.03*sin(T*.2+f),hash(f+5.)-.5);
    float r=.05+.07*hash(f+9.);
    col+=vec3(.12,.16,.42)*.35*smoothstep(r,0.,length(p-c));
  }
  float fan=smoothstep(.05,.85,abs(p.x));
  float fan2=smoothstep(.05,.85,abs(p.x+.004));
  float breathe=.06*sin(T*.35);
  for(int i=0;i<56;i++){
    float f=float(i);
    float s=(f+.5)/56.*2.-1.;
    float th=f*2.39996;
    float sway=.03*sin(T*.55+f*1.7+p.x*2.5);
    float ph=th+11.*p.x*(1.-fan)-T*.9;
    float y=centre(p.x)+fan*(s*(.9+breathe)+sway)+(.066+.02*fan)*sin(ph);
    float x2=p.x+.004;
    float ph2=th+11.*x2*(1.-fan2)-T*.9;
    float y2=centre(x2)+fan2*(s*(.9+breathe)+.03*sin(T*.55+f*1.7+x2*2.5))+(.066+.02*fan2)*sin(ph2);
    float k=(y2-y)/.004;
    float d=abs(p.y-y)/sqrt(1.+k*k);
    // some threads out of focus: wider and fainter
    float blur=step(.78,hash(f+4.3));
    float w=(.0018+.0016*fan)*(.7+.7*hash(f+2.9))*(1.+2.5*blur);
    float lit=mix(.45+.55*cos(ph),.85,fan)*(1.-.6*blur);
    vec3 hue=mix(vec3(.42,.6,1.),vec3(.66,.52,1.),hash(f+1.7));
    col+=hue*lit*(exp(-d*d/(w*w))*.95+.0009/(d+.004)+.05*exp(-d*d/.0016));
  }
  // the cord: four thick strands braided where the threads meet
  float cord=1.-smoothstep(.1,.36,abs(p.x));
  for(int j=0;j<3;j++){
    float ph=float(j)*2.0944+8.*p.x-T*.9;
    float y=centre(p.x)+.034*sin(ph);
    float d=abs(p.y-y)/sqrt(1.+pow(.034*8.*cos(ph),2.));
    float w=.016;
    float tube=sqrt(max(0.,1.-d*d/(w*w)));
    float front=.5+.5*cos(ph);
    col+=mix(vec3(.35,.5,1.),vec3(.8,.78,1.),tube)*tube*cord*front*front*.55;
  }
  col*=1.-.3*dot(p*vec2(.7,1.2),p*vec2(.7,1.2));
  gl_FragColor=finish(col);
}`,

    // Each half is the same lattice, the left one mirrored: x is folded
    // around the line of light.
    "parity-mirror": `
float box(vec3 p,float b){vec3 q=abs(p)-b;return length(max(q,0.))+min(max(q.x,max(q.y,q.z)),0.);}
float frame(vec3 p,float b,float e){
  p=abs(p)-b;vec3 q=abs(p+e)-e;
  return min(min(
    length(max(vec3(p.x,q.y,q.z),0.))+min(max(p.x,max(q.y,q.z)),0.),
    length(max(vec3(q.x,p.y,q.z),0.))+min(max(q.x,max(p.y,q.z)),0.)),
    length(max(vec3(q.x,q.y,p.z),0.))+min(max(q.x,max(q.y,p.z)),0.));
}
// A 3x3x3 block of glass cubes without its centre and face centres: one
// octant's four cubes, folded out by symmetry.
const float S=.21,B=.088;
void scene(vec3 p,out float body,out float edge){
  vec3 o=abs(p);
  vec3 a=o-vec3(S,S,0.),b=o-vec3(S,0.,S),c=o-vec3(0.,S,S),d=o-vec3(S,S,S);
  body=min(min(box(a,B),box(b,B)),min(box(c,B),box(d,B)));
  edge=min(min(frame(a,B,.003),frame(b,B,.003)),min(frame(c,B,.003),frame(d,B,.003)));
}
mat3 turn(float a,float b){
  float ca=cos(a),sa=sin(a),cb=cos(b),sb=sin(b);
  return mat3(ca,0.,-sa,0.,1.,0.,sa,0.,ca)*mat3(1.,0.,0.,0.,cb,sb,0.,-sb,cb);
}
void main(){
  vec2 p=(gl_FragCoord.xy-.5*R)/R.y;
  vec3 col=mix(vec3(.012,.012,.05),vec3(.03,.03,.10),.5+.5*p.y);
  vec2 q=vec2(abs(p.x)-.45,p.y);
  float pulse=mod(T*.32,1.7)-.85;
  float sync=exp(-pulse*pulse*10.);
  vec3 ro=vec3(0.,0.,3.),rd=normalize(vec3(q,-2.25));
  mat3 m=turn(T*.3+.35,.36+.1*sin(T*.37));
  vec3 rl=m*rd;
  vec3 glass=vec3(0.);
  float t=2.3,was=1.,faces=0.;
  for(int i=0;i<60;i++){
    vec3 x=m*(ro+rd*t);
    float body,edge;
    scene(x,body,edge);
    // a face, where the ray enters a block: lit at grazing angles (Fresnel)
    if(body<0.&&was>=0.&&faces<3.){
      vec2 e=vec2(.002,0.);float b1,b2,b3,b4,b5,b6,z;
      scene(x+e.xyy,b1,z);scene(x-e.xyy,b2,z);scene(x+e.yxy,b3,z);
      scene(x-e.yxy,b4,z);scene(x+e.yyx,b5,z);scene(x-e.yyx,b6,z);
      vec3 n=normalize(vec3(b1-b2,b3-b4,b5-b6));
      float f=pow(1.-abs(dot(n,rl)),3.);
      glass+=mix(vec3(.2,.17,.55),vec3(.8,.74,1.),f)*(.3+.7*f)*(1.-faces*.3)*(.65+.35*n.y);
      faces+=1.;
    }
    was=body;
    float h=max(abs(body)*.55,.008);
    if(body<0.)glass+=vec3(.30,.24,.78)*h*1.8;
    glass+=vec3(.70,.64,1.)*h*.00016/(edge*edge+.000025);
    t+=h;
    if(t>3.9)break;
  }
  col+=glass*(1.+.45*sync);
  float line=.0018/(abs(p.x)+.0018);
  col+=vec3(.55,.55,1.)*line*(.8+.2*sin(T*1.3));
  col+=vec3(.9,.9,1.)*line*exp(-pow((p.y-pulse)*5.,2.))*1.2;
  gl_FragColor=finish(col);
}`,
};
