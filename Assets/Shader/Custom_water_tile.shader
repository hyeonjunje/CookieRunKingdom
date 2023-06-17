//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Custom/water_tile" {
Properties {
_TileIndex ("Tile Index", Float) = 0
_FlipFactor ("Flip Factor", Float) = 1
_MainTex ("Main Texture", 2D) = "white" { }
[Header(Distortion)] [Space (5)] [Toggle(USE_DISTORTION)] _UseDist ("Use", Float) = 0
_DistTex ("Distortion Texture", 2D) = "white" { }
_Dist ("Distortion", Range(0, 1)) = 0
_DistFlowX ("Distortion Flow X", Range(-1, 1)) = 0
_DistFlowY ("Distortion Flow Y", Range(-1, 1)) = 0
[Header(Vertex Animation)] [Space (5)] [Toggle (USE_VERT_ANI)] _VertexAni ("Use", Float) = 0
_WaveScale ("Wave Scale", Range(0, 100)) = 1
_WaveSpd ("Wave Speed", Range(0, 10)) = 1
_WaveDist ("Wave Distance", Range(0, 10)) = 1
_AdditiveColor ("Additive Color", Color) = (0,0,0,0)
_GlobalAdditiveIntensity ("Global Additive Intensity", Float) = 0
[Header(Color Adjust)] [Space (5)] [Toggle(USE_COLOR_ADJUST)] _UseHSBC ("Use", Float) = 0
_Hue ("Hue", Range(-180, 180)) = 0
_Saturation ("Saturation", Range(-100, 100)) = 0
_Lightness ("Lightness", Range(-100, 100)) = 0
_Contrast ("Contrast", Range(-100, 100)) = 0
_Invert ("Invert", Range(0, 1)) = 0
_PostColor ("Post Color Layer", Color) = (1,1,1,1)
_Blending ("Original Color & Adjust Color Blending", Range(0, 1)) = 1
_Intensity ("All Properties Intensity", Range(0, 1)) = 1
[Toggle (USE_AUTO_COLOR_CHANGE)] _AutoColChange ("Auto Color Change", Float) = 0
_AutoColChangeSpeed ("Auto Color Change Speed", Range(0, 10)) = 0
}
SubShader {
 LOD 100
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
  ZWrite Off
  Cull Off
  GpuProgramID 49469
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _TileIndex;
uniform 	float _FlipFactor;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = in_POSITION0.x * _FlipFactor;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat4 = u_xlat0.x * _TileIndex;
    u_xlatb4 = u_xlat4>=(-u_xlat4);
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2 = _TileIndex / u_xlat0.y;
    u_xlat2 = floor(u_xlat2);
    u_xlat1.y = (-u_xlat2) + in_TEXCOORD0.y;
    u_xlat2 = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat2 * _TileIndex;
    u_xlat2 = fract(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
float u_xlat0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
void main()
{
    u_xlat0 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat10_1 * vs_COLOR0;
    u_xlat2.xyz = _AdditiveColor.xyz * u_xlat1.www + (-u_xlat1.xyz);
    u_xlat2.xyz = _AdditiveColor.www * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat1.www + (-u_xlat2.xyz);
    SV_Target0.xyz = vec3(u_xlat0) * u_xlat1.xyz + u_xlat2.xyz;
    SV_Target0.w = u_xlat1.w;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _TileIndex;
uniform 	float _FlipFactor;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = in_POSITION0.x * _FlipFactor;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat4 = u_xlat0.x * _TileIndex;
    u_xlatb4 = u_xlat4>=(-u_xlat4);
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2 = _TileIndex / u_xlat0.y;
    u_xlat2 = floor(u_xlat2);
    u_xlat1.y = (-u_xlat2) + in_TEXCOORD0.y;
    u_xlat2 = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat2 * _TileIndex;
    u_xlat2 = fract(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
float u_xlat0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
void main()
{
    u_xlat0 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat10_1 * vs_COLOR0;
    u_xlat2.xyz = _AdditiveColor.xyz * u_xlat1.www + (-u_xlat1.xyz);
    u_xlat2.xyz = _AdditiveColor.www * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat1.www + (-u_xlat2.xyz);
    SV_Target0.xyz = vec3(u_xlat0) * u_xlat1.xyz + u_xlat2.xyz;
    SV_Target0.w = u_xlat1.w;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _TileIndex;
uniform 	float _FlipFactor;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = in_POSITION0.x * _FlipFactor;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat4 = u_xlat0.x * _TileIndex;
    u_xlatb4 = u_xlat4>=(-u_xlat4);
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2 = _TileIndex / u_xlat0.y;
    u_xlat2 = floor(u_xlat2);
    u_xlat1.y = (-u_xlat2) + in_TEXCOORD0.y;
    u_xlat2 = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat2 * _TileIndex;
    u_xlat2 = fract(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
float u_xlat0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
void main()
{
    u_xlat0 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat10_1 * vs_COLOR0;
    u_xlat2.xyz = _AdditiveColor.xyz * u_xlat1.www + (-u_xlat1.xyz);
    u_xlat2.xyz = _AdditiveColor.www * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat1.www + (-u_xlat2.xyz);
    SV_Target0.xyz = vec3(u_xlat0) * u_xlat1.xyz + u_xlat2.xyz;
    SV_Target0.w = u_xlat1.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
"#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _TileIndex;
uniform 	float _FlipFactor;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = in_POSITION0.x * _FlipFactor;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat4 = u_xlat0.x * _TileIndex;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4>=(-u_xlat4));
#else
    u_xlatb4 = u_xlat4>=(-u_xlat4);
#endif
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2 = _TileIndex / u_xlat0.y;
    u_xlat2 = floor(u_xlat2);
    u_xlat1.y = (-u_xlat2) + in_TEXCOORD0.y;
    u_xlat2 = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat2 * _TileIndex;
    u_xlat2 = fract(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
float u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
void main()
{
    u_xlat0 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat16_1 * vs_COLOR0;
    u_xlat2.xyz = _AdditiveColor.xyz * u_xlat1.www + (-u_xlat1.xyz);
    u_xlat2.xyz = _AdditiveColor.www * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat1.www + (-u_xlat2.xyz);
    SV_Target0.xyz = vec3(u_xlat0) * u_xlat1.xyz + u_xlat2.xyz;
    SV_Target0.w = u_xlat1.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
"#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _TileIndex;
uniform 	float _FlipFactor;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = in_POSITION0.x * _FlipFactor;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat4 = u_xlat0.x * _TileIndex;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4>=(-u_xlat4));
#else
    u_xlatb4 = u_xlat4>=(-u_xlat4);
#endif
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2 = _TileIndex / u_xlat0.y;
    u_xlat2 = floor(u_xlat2);
    u_xlat1.y = (-u_xlat2) + in_TEXCOORD0.y;
    u_xlat2 = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat2 * _TileIndex;
    u_xlat2 = fract(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
float u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
void main()
{
    u_xlat0 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat16_1 * vs_COLOR0;
    u_xlat2.xyz = _AdditiveColor.xyz * u_xlat1.www + (-u_xlat1.xyz);
    u_xlat2.xyz = _AdditiveColor.www * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat1.www + (-u_xlat2.xyz);
    SV_Target0.xyz = vec3(u_xlat0) * u_xlat1.xyz + u_xlat2.xyz;
    SV_Target0.w = u_xlat1.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
"#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _TileIndex;
uniform 	float _FlipFactor;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = in_POSITION0.x * _FlipFactor;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat4 = u_xlat0.x * _TileIndex;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4>=(-u_xlat4));
#else
    u_xlatb4 = u_xlat4>=(-u_xlat4);
#endif
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2 = _TileIndex / u_xlat0.y;
    u_xlat2 = floor(u_xlat2);
    u_xlat1.y = (-u_xlat2) + in_TEXCOORD0.y;
    u_xlat2 = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat2 * _TileIndex;
    u_xlat2 = fract(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
float u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
void main()
{
    u_xlat0 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat16_1 * vs_COLOR0;
    u_xlat2.xyz = _AdditiveColor.xyz * u_xlat1.www + (-u_xlat1.xyz);
    u_xlat2.xyz = _AdditiveColor.www * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat1.www + (-u_xlat2.xyz);
    SV_Target0.xyz = vec3(u_xlat0) * u_xlat1.xyz + u_xlat2.xyz;
    SV_Target0.w = u_xlat1.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
struct PropsArray_Type {
	float _TileIndex;
	float _FlipFactor;
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityInstancing_Props {
#endif
	UNITY_UNIFORM PropsArray_Type PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
float u_xlat6;
int u_xlati6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat3.x = in_POSITION0.x * PropsArray[u_xlati0]._FlipFactor;
    u_xlati6 = int(u_xlati0 << 3);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat3.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat3.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat9 = u_xlat3.x * PropsArray[u_xlati0]._TileIndex;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat9>=(-u_xlat9));
#else
    u_xlatb9 = u_xlat9>=(-u_xlat9);
#endif
    u_xlat3.x = (u_xlatb9) ? u_xlat3.x : (-u_xlat3.x);
    u_xlat6 = PropsArray[u_xlati0]._TileIndex / u_xlat3.y;
    u_xlat6 = floor(u_xlat6);
    u_xlat1.y = (-u_xlat6) + in_TEXCOORD0.y;
    u_xlat6 = float(1.0) / u_xlat3.x;
    u_xlat0 = u_xlat6 * PropsArray[u_xlati0]._TileIndex;
    u_xlat0 = fract(u_xlat0);
    u_xlat0 = u_xlat0 * u_xlat3.x;
    u_xlat0 = floor(u_xlat0);
    u_xlat1.x = u_xlat0 + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
float u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
void main()
{
    u_xlat0 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat16_1 * vs_COLOR0;
    u_xlat2.xyz = _AdditiveColor.xyz * u_xlat1.www + (-u_xlat1.xyz);
    u_xlat2.xyz = _AdditiveColor.www * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat1.www + (-u_xlat2.xyz);
    SV_Target0.xyz = vec3(u_xlat0) * u_xlat1.xyz + u_xlat2.xyz;
    SV_Target0.w = u_xlat1.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
struct PropsArray_Type {
	float _TileIndex;
	float _FlipFactor;
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityInstancing_Props {
#endif
	UNITY_UNIFORM PropsArray_Type PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
float u_xlat6;
int u_xlati6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat3.x = in_POSITION0.x * PropsArray[u_xlati0]._FlipFactor;
    u_xlati6 = int(u_xlati0 << 3);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat3.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat3.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat9 = u_xlat3.x * PropsArray[u_xlati0]._TileIndex;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat9>=(-u_xlat9));
#else
    u_xlatb9 = u_xlat9>=(-u_xlat9);
#endif
    u_xlat3.x = (u_xlatb9) ? u_xlat3.x : (-u_xlat3.x);
    u_xlat6 = PropsArray[u_xlati0]._TileIndex / u_xlat3.y;
    u_xlat6 = floor(u_xlat6);
    u_xlat1.y = (-u_xlat6) + in_TEXCOORD0.y;
    u_xlat6 = float(1.0) / u_xlat3.x;
    u_xlat0 = u_xlat6 * PropsArray[u_xlati0]._TileIndex;
    u_xlat0 = fract(u_xlat0);
    u_xlat0 = u_xlat0 * u_xlat3.x;
    u_xlat0 = floor(u_xlat0);
    u_xlat1.x = u_xlat0 + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
float u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
void main()
{
    u_xlat0 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat16_1 * vs_COLOR0;
    u_xlat2.xyz = _AdditiveColor.xyz * u_xlat1.www + (-u_xlat1.xyz);
    u_xlat2.xyz = _AdditiveColor.www * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat1.www + (-u_xlat2.xyz);
    SV_Target0.xyz = vec3(u_xlat0) * u_xlat1.xyz + u_xlat2.xyz;
    SV_Target0.w = u_xlat1.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "INSTANCING_ON" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
struct PropsArray_Type {
	float _TileIndex;
	float _FlipFactor;
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityInstancing_Props {
#endif
	UNITY_UNIFORM PropsArray_Type PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
float u_xlat6;
int u_xlati6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat3.x = in_POSITION0.x * PropsArray[u_xlati0]._FlipFactor;
    u_xlati6 = int(u_xlati0 << 3);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat3.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat3.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat9 = u_xlat3.x * PropsArray[u_xlati0]._TileIndex;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat9>=(-u_xlat9));
#else
    u_xlatb9 = u_xlat9>=(-u_xlat9);
#endif
    u_xlat3.x = (u_xlatb9) ? u_xlat3.x : (-u_xlat3.x);
    u_xlat6 = PropsArray[u_xlati0]._TileIndex / u_xlat3.y;
    u_xlat6 = floor(u_xlat6);
    u_xlat1.y = (-u_xlat6) + in_TEXCOORD0.y;
    u_xlat6 = float(1.0) / u_xlat3.x;
    u_xlat0 = u_xlat6 * PropsArray[u_xlati0]._TileIndex;
    u_xlat0 = fract(u_xlat0);
    u_xlat0 = u_xlat0 * u_xlat3.x;
    u_xlat0 = floor(u_xlat0);
    u_xlat1.x = u_xlat0 + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
float u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
void main()
{
    u_xlat0 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat16_1 * vs_COLOR0;
    u_xlat2.xyz = _AdditiveColor.xyz * u_xlat1.www + (-u_xlat1.xyz);
    u_xlat2.xyz = _AdditiveColor.www * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat1.www + (-u_xlat2.xyz);
    SV_Target0.xyz = vec3(u_xlat0) * u_xlat1.xyz + u_xlat2.xyz;
    SV_Target0.w = u_xlat1.w;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "USE_AUTO_COLOR_CHANGE" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _TileIndex;
uniform 	float _FlipFactor;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = in_POSITION0.x * _FlipFactor;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat4 = u_xlat0.x * _TileIndex;
    u_xlatb4 = u_xlat4>=(-u_xlat4);
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2 = _TileIndex / u_xlat0.y;
    u_xlat2 = floor(u_xlat2);
    u_xlat1.y = (-u_xlat2) + in_TEXCOORD0.y;
    u_xlat2 = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat2 * _TileIndex;
    u_xlat2 = fract(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
float u_xlat0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
void main()
{
    u_xlat0 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat10_1 * vs_COLOR0;
    u_xlat2.xyz = _AdditiveColor.xyz * u_xlat1.www + (-u_xlat1.xyz);
    u_xlat2.xyz = _AdditiveColor.www * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat1.www + (-u_xlat2.xyz);
    SV_Target0.xyz = vec3(u_xlat0) * u_xlat1.xyz + u_xlat2.xyz;
    SV_Target0.w = u_xlat1.w;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "USE_AUTO_COLOR_CHANGE" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _TileIndex;
uniform 	float _FlipFactor;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = in_POSITION0.x * _FlipFactor;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat4 = u_xlat0.x * _TileIndex;
    u_xlatb4 = u_xlat4>=(-u_xlat4);
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2 = _TileIndex / u_xlat0.y;
    u_xlat2 = floor(u_xlat2);
    u_xlat1.y = (-u_xlat2) + in_TEXCOORD0.y;
    u_xlat2 = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat2 * _TileIndex;
    u_xlat2 = fract(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
float u_xlat0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
void main()
{
    u_xlat0 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat10_1 * vs_COLOR0;
    u_xlat2.xyz = _AdditiveColor.xyz * u_xlat1.www + (-u_xlat1.xyz);
    u_xlat2.xyz = _AdditiveColor.www * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat1.www + (-u_xlat2.xyz);
    SV_Target0.xyz = vec3(u_xlat0) * u_xlat1.xyz + u_xlat2.xyz;
    SV_Target0.w = u_xlat1.w;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "USE_AUTO_COLOR_CHANGE" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _TileIndex;
uniform 	float _FlipFactor;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = in_POSITION0.x * _FlipFactor;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat4 = u_xlat0.x * _TileIndex;
    u_xlatb4 = u_xlat4>=(-u_xlat4);
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2 = _TileIndex / u_xlat0.y;
    u_xlat2 = floor(u_xlat2);
    u_xlat1.y = (-u_xlat2) + in_TEXCOORD0.y;
    u_xlat2 = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat2 * _TileIndex;
    u_xlat2 = fract(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
float u_xlat0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
void main()
{
    u_xlat0 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat10_1 * vs_COLOR0;
    u_xlat2.xyz = _AdditiveColor.xyz * u_xlat1.www + (-u_xlat1.xyz);
    u_xlat2.xyz = _AdditiveColor.www * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat1.www + (-u_xlat2.xyz);
    SV_Target0.xyz = vec3(u_xlat0) * u_xlat1.xyz + u_xlat2.xyz;
    SV_Target0.w = u_xlat1.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "USE_AUTO_COLOR_CHANGE" }
"#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _TileIndex;
uniform 	float _FlipFactor;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = in_POSITION0.x * _FlipFactor;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat4 = u_xlat0.x * _TileIndex;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4>=(-u_xlat4));
#else
    u_xlatb4 = u_xlat4>=(-u_xlat4);
#endif
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2 = _TileIndex / u_xlat0.y;
    u_xlat2 = floor(u_xlat2);
    u_xlat1.y = (-u_xlat2) + in_TEXCOORD0.y;
    u_xlat2 = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat2 * _TileIndex;
    u_xlat2 = fract(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
float u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
void main()
{
    u_xlat0 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat16_1 * vs_COLOR0;
    u_xlat2.xyz = _AdditiveColor.xyz * u_xlat1.www + (-u_xlat1.xyz);
    u_xlat2.xyz = _AdditiveColor.www * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat1.www + (-u_xlat2.xyz);
    SV_Target0.xyz = vec3(u_xlat0) * u_xlat1.xyz + u_xlat2.xyz;
    SV_Target0.w = u_xlat1.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "USE_AUTO_COLOR_CHANGE" }
"#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _TileIndex;
uniform 	float _FlipFactor;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = in_POSITION0.x * _FlipFactor;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat4 = u_xlat0.x * _TileIndex;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4>=(-u_xlat4));
#else
    u_xlatb4 = u_xlat4>=(-u_xlat4);
#endif
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2 = _TileIndex / u_xlat0.y;
    u_xlat2 = floor(u_xlat2);
    u_xlat1.y = (-u_xlat2) + in_TEXCOORD0.y;
    u_xlat2 = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat2 * _TileIndex;
    u_xlat2 = fract(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
float u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
void main()
{
    u_xlat0 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat16_1 * vs_COLOR0;
    u_xlat2.xyz = _AdditiveColor.xyz * u_xlat1.www + (-u_xlat1.xyz);
    u_xlat2.xyz = _AdditiveColor.www * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat1.www + (-u_xlat2.xyz);
    SV_Target0.xyz = vec3(u_xlat0) * u_xlat1.xyz + u_xlat2.xyz;
    SV_Target0.w = u_xlat1.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "USE_AUTO_COLOR_CHANGE" }
"#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _TileIndex;
uniform 	float _FlipFactor;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = in_POSITION0.x * _FlipFactor;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat4 = u_xlat0.x * _TileIndex;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4>=(-u_xlat4));
#else
    u_xlatb4 = u_xlat4>=(-u_xlat4);
#endif
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2 = _TileIndex / u_xlat0.y;
    u_xlat2 = floor(u_xlat2);
    u_xlat1.y = (-u_xlat2) + in_TEXCOORD0.y;
    u_xlat2 = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat2 * _TileIndex;
    u_xlat2 = fract(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
float u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
void main()
{
    u_xlat0 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat16_1 * vs_COLOR0;
    u_xlat2.xyz = _AdditiveColor.xyz * u_xlat1.www + (-u_xlat1.xyz);
    u_xlat2.xyz = _AdditiveColor.www * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat1.www + (-u_xlat2.xyz);
    SV_Target0.xyz = vec3(u_xlat0) * u_xlat1.xyz + u_xlat2.xyz;
    SV_Target0.w = u_xlat1.w;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "USE_COLOR_ADJUST" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _TileIndex;
uniform 	float _FlipFactor;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = in_POSITION0.x * _FlipFactor;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat4 = u_xlat0.x * _TileIndex;
    u_xlatb4 = u_xlat4>=(-u_xlat4);
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2 = _TileIndex / u_xlat0.y;
    u_xlat2 = floor(u_xlat2);
    u_xlat1.y = (-u_xlat2) + in_TEXCOORD0.y;
    u_xlat2 = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat2 * _TileIndex;
    u_xlat2 = fract(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	float _Hue;
uniform 	float _Saturation;
uniform 	float _Lightness;
uniform 	float _Contrast;
uniform 	float _Invert;
uniform 	float _Blending;
uniform 	float _Intensity;
uniform 	vec4 _PostColor;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
vec4 u_xlat1;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
float u_xlat15;
void main()
{
    u_xlat0.x = _Hue * 0.0174532924;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat5.xyz = u_xlat10_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat5.xyz = u_xlat10_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat5.zxy);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz;
    u_xlat0.xyz = u_xlat10_2.xyz * u_xlat1.xxx + u_xlat0.xyz;
    u_xlat15 = (-u_xlat1.x) + 1.0;
    u_xlat1.x = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat10_2.xyz);
    u_xlat1.x = u_xlat1.x * 0.57735002;
    u_xlat0.xyz = u_xlat1.xxx * vec3(u_xlat15) + u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat0.xyz = (-vec3(u_xlat15)) + u_xlat0.xyz;
    u_xlat1.x = _Saturation * 0.00999999978 + 1.0;
    u_xlat0.xyz = u_xlat1.xxx * u_xlat0.xyz + vec3(u_xlat15);
    u_xlat16_3.xyz = vec3(vec3(_Lightness, _Lightness, _Lightness)) * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat0.x = _Contrast + 100.0;
    u_xlat0.x = u_xlat0.x * 0.00999999978;
    u_xlat16_3.xyz = u_xlat0.xxx * u_xlat16_3.xyz + vec3(0.5, 0.5, 0.5);
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_3.xyz * vec3(-2.0, -2.0, -2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vec3(_Invert) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * _PostColor.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = _PostColor.www * u_xlat0.xyz + u_xlat16_3.xyz;
    u_xlat1 = vs_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = vec4(vec4(_Intensity, _Intensity, _Intensity, _Intensity)) * u_xlat1 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0.xyz = (-u_xlat10_2.xyz) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1 = u_xlat1 * u_xlat10_2;
    u_xlat15 = _Intensity * _Blending;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat1.w;
    u_xlat15 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat15) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "USE_COLOR_ADJUST" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _TileIndex;
uniform 	float _FlipFactor;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = in_POSITION0.x * _FlipFactor;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat4 = u_xlat0.x * _TileIndex;
    u_xlatb4 = u_xlat4>=(-u_xlat4);
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2 = _TileIndex / u_xlat0.y;
    u_xlat2 = floor(u_xlat2);
    u_xlat1.y = (-u_xlat2) + in_TEXCOORD0.y;
    u_xlat2 = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat2 * _TileIndex;
    u_xlat2 = fract(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	float _Hue;
uniform 	float _Saturation;
uniform 	float _Lightness;
uniform 	float _Contrast;
uniform 	float _Invert;
uniform 	float _Blending;
uniform 	float _Intensity;
uniform 	vec4 _PostColor;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
vec4 u_xlat1;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
float u_xlat15;
void main()
{
    u_xlat0.x = _Hue * 0.0174532924;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat5.xyz = u_xlat10_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat5.xyz = u_xlat10_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat5.zxy);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz;
    u_xlat0.xyz = u_xlat10_2.xyz * u_xlat1.xxx + u_xlat0.xyz;
    u_xlat15 = (-u_xlat1.x) + 1.0;
    u_xlat1.x = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat10_2.xyz);
    u_xlat1.x = u_xlat1.x * 0.57735002;
    u_xlat0.xyz = u_xlat1.xxx * vec3(u_xlat15) + u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat0.xyz = (-vec3(u_xlat15)) + u_xlat0.xyz;
    u_xlat1.x = _Saturation * 0.00999999978 + 1.0;
    u_xlat0.xyz = u_xlat1.xxx * u_xlat0.xyz + vec3(u_xlat15);
    u_xlat16_3.xyz = vec3(vec3(_Lightness, _Lightness, _Lightness)) * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat0.x = _Contrast + 100.0;
    u_xlat0.x = u_xlat0.x * 0.00999999978;
    u_xlat16_3.xyz = u_xlat0.xxx * u_xlat16_3.xyz + vec3(0.5, 0.5, 0.5);
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_3.xyz * vec3(-2.0, -2.0, -2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vec3(_Invert) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * _PostColor.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = _PostColor.www * u_xlat0.xyz + u_xlat16_3.xyz;
    u_xlat1 = vs_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = vec4(vec4(_Intensity, _Intensity, _Intensity, _Intensity)) * u_xlat1 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0.xyz = (-u_xlat10_2.xyz) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1 = u_xlat1 * u_xlat10_2;
    u_xlat15 = _Intensity * _Blending;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat1.w;
    u_xlat15 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat15) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "USE_COLOR_ADJUST" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _TileIndex;
uniform 	float _FlipFactor;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = in_POSITION0.x * _FlipFactor;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat4 = u_xlat0.x * _TileIndex;
    u_xlatb4 = u_xlat4>=(-u_xlat4);
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2 = _TileIndex / u_xlat0.y;
    u_xlat2 = floor(u_xlat2);
    u_xlat1.y = (-u_xlat2) + in_TEXCOORD0.y;
    u_xlat2 = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat2 * _TileIndex;
    u_xlat2 = fract(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	float _Hue;
uniform 	float _Saturation;
uniform 	float _Lightness;
uniform 	float _Contrast;
uniform 	float _Invert;
uniform 	float _Blending;
uniform 	float _Intensity;
uniform 	vec4 _PostColor;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
vec4 u_xlat1;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
float u_xlat15;
void main()
{
    u_xlat0.x = _Hue * 0.0174532924;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat5.xyz = u_xlat10_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat5.xyz = u_xlat10_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat5.zxy);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz;
    u_xlat0.xyz = u_xlat10_2.xyz * u_xlat1.xxx + u_xlat0.xyz;
    u_xlat15 = (-u_xlat1.x) + 1.0;
    u_xlat1.x = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat10_2.xyz);
    u_xlat1.x = u_xlat1.x * 0.57735002;
    u_xlat0.xyz = u_xlat1.xxx * vec3(u_xlat15) + u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat0.xyz = (-vec3(u_xlat15)) + u_xlat0.xyz;
    u_xlat1.x = _Saturation * 0.00999999978 + 1.0;
    u_xlat0.xyz = u_xlat1.xxx * u_xlat0.xyz + vec3(u_xlat15);
    u_xlat16_3.xyz = vec3(vec3(_Lightness, _Lightness, _Lightness)) * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat0.x = _Contrast + 100.0;
    u_xlat0.x = u_xlat0.x * 0.00999999978;
    u_xlat16_3.xyz = u_xlat0.xxx * u_xlat16_3.xyz + vec3(0.5, 0.5, 0.5);
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_3.xyz * vec3(-2.0, -2.0, -2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vec3(_Invert) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * _PostColor.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = _PostColor.www * u_xlat0.xyz + u_xlat16_3.xyz;
    u_xlat1 = vs_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = vec4(vec4(_Intensity, _Intensity, _Intensity, _Intensity)) * u_xlat1 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0.xyz = (-u_xlat10_2.xyz) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1 = u_xlat1 * u_xlat10_2;
    u_xlat15 = _Intensity * _Blending;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat1.w;
    u_xlat15 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat15) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "INSTANCING_ON" "USE_AUTO_COLOR_CHANGE" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
struct PropsArray_Type {
	float _TileIndex;
	float _FlipFactor;
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityInstancing_Props {
#endif
	UNITY_UNIFORM PropsArray_Type PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
float u_xlat6;
int u_xlati6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat3.x = in_POSITION0.x * PropsArray[u_xlati0]._FlipFactor;
    u_xlati6 = int(u_xlati0 << 3);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat3.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat3.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat9 = u_xlat3.x * PropsArray[u_xlati0]._TileIndex;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat9>=(-u_xlat9));
#else
    u_xlatb9 = u_xlat9>=(-u_xlat9);
#endif
    u_xlat3.x = (u_xlatb9) ? u_xlat3.x : (-u_xlat3.x);
    u_xlat6 = PropsArray[u_xlati0]._TileIndex / u_xlat3.y;
    u_xlat6 = floor(u_xlat6);
    u_xlat1.y = (-u_xlat6) + in_TEXCOORD0.y;
    u_xlat6 = float(1.0) / u_xlat3.x;
    u_xlat0 = u_xlat6 * PropsArray[u_xlati0]._TileIndex;
    u_xlat0 = fract(u_xlat0);
    u_xlat0 = u_xlat0 * u_xlat3.x;
    u_xlat0 = floor(u_xlat0);
    u_xlat1.x = u_xlat0 + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
float u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
void main()
{
    u_xlat0 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat16_1 * vs_COLOR0;
    u_xlat2.xyz = _AdditiveColor.xyz * u_xlat1.www + (-u_xlat1.xyz);
    u_xlat2.xyz = _AdditiveColor.www * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat1.www + (-u_xlat2.xyz);
    SV_Target0.xyz = vec3(u_xlat0) * u_xlat1.xyz + u_xlat2.xyz;
    SV_Target0.w = u_xlat1.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "INSTANCING_ON" "USE_AUTO_COLOR_CHANGE" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
struct PropsArray_Type {
	float _TileIndex;
	float _FlipFactor;
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityInstancing_Props {
#endif
	UNITY_UNIFORM PropsArray_Type PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
float u_xlat6;
int u_xlati6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat3.x = in_POSITION0.x * PropsArray[u_xlati0]._FlipFactor;
    u_xlati6 = int(u_xlati0 << 3);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat3.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat3.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat9 = u_xlat3.x * PropsArray[u_xlati0]._TileIndex;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat9>=(-u_xlat9));
#else
    u_xlatb9 = u_xlat9>=(-u_xlat9);
#endif
    u_xlat3.x = (u_xlatb9) ? u_xlat3.x : (-u_xlat3.x);
    u_xlat6 = PropsArray[u_xlati0]._TileIndex / u_xlat3.y;
    u_xlat6 = floor(u_xlat6);
    u_xlat1.y = (-u_xlat6) + in_TEXCOORD0.y;
    u_xlat6 = float(1.0) / u_xlat3.x;
    u_xlat0 = u_xlat6 * PropsArray[u_xlati0]._TileIndex;
    u_xlat0 = fract(u_xlat0);
    u_xlat0 = u_xlat0 * u_xlat3.x;
    u_xlat0 = floor(u_xlat0);
    u_xlat1.x = u_xlat0 + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
float u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
void main()
{
    u_xlat0 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat16_1 * vs_COLOR0;
    u_xlat2.xyz = _AdditiveColor.xyz * u_xlat1.www + (-u_xlat1.xyz);
    u_xlat2.xyz = _AdditiveColor.www * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat1.www + (-u_xlat2.xyz);
    SV_Target0.xyz = vec3(u_xlat0) * u_xlat1.xyz + u_xlat2.xyz;
    SV_Target0.w = u_xlat1.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "INSTANCING_ON" "USE_AUTO_COLOR_CHANGE" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
struct PropsArray_Type {
	float _TileIndex;
	float _FlipFactor;
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityInstancing_Props {
#endif
	UNITY_UNIFORM PropsArray_Type PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
float u_xlat6;
int u_xlati6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat3.x = in_POSITION0.x * PropsArray[u_xlati0]._FlipFactor;
    u_xlati6 = int(u_xlati0 << 3);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat3.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat3.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat9 = u_xlat3.x * PropsArray[u_xlati0]._TileIndex;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat9>=(-u_xlat9));
#else
    u_xlatb9 = u_xlat9>=(-u_xlat9);
#endif
    u_xlat3.x = (u_xlatb9) ? u_xlat3.x : (-u_xlat3.x);
    u_xlat6 = PropsArray[u_xlati0]._TileIndex / u_xlat3.y;
    u_xlat6 = floor(u_xlat6);
    u_xlat1.y = (-u_xlat6) + in_TEXCOORD0.y;
    u_xlat6 = float(1.0) / u_xlat3.x;
    u_xlat0 = u_xlat6 * PropsArray[u_xlati0]._TileIndex;
    u_xlat0 = fract(u_xlat0);
    u_xlat0 = u_xlat0 * u_xlat3.x;
    u_xlat0 = floor(u_xlat0);
    u_xlat1.x = u_xlat0 + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
float u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
void main()
{
    u_xlat0 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat16_1 * vs_COLOR0;
    u_xlat2.xyz = _AdditiveColor.xyz * u_xlat1.www + (-u_xlat1.xyz);
    u_xlat2.xyz = _AdditiveColor.www * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat1.www + (-u_xlat2.xyz);
    SV_Target0.xyz = vec3(u_xlat0) * u_xlat1.xyz + u_xlat2.xyz;
    SV_Target0.w = u_xlat1.w;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "USE_AUTO_COLOR_CHANGE" "USE_COLOR_ADJUST" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _TileIndex;
uniform 	float _FlipFactor;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = in_POSITION0.x * _FlipFactor;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat4 = u_xlat0.x * _TileIndex;
    u_xlatb4 = u_xlat4>=(-u_xlat4);
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2 = _TileIndex / u_xlat0.y;
    u_xlat2 = floor(u_xlat2);
    u_xlat1.y = (-u_xlat2) + in_TEXCOORD0.y;
    u_xlat2 = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat2 * _TileIndex;
    u_xlat2 = fract(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec4 _Time;
uniform 	float _Hue;
uniform 	float _Saturation;
uniform 	float _Lightness;
uniform 	float _Contrast;
uniform 	float _Invert;
uniform 	float _Blending;
uniform 	float _Intensity;
uniform 	vec4 _PostColor;
uniform 	float _AutoColChangeSpeed;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat6;
float u_xlat15;
void main()
{
    u_xlat0.x = _Time.x * _AutoColChangeSpeed;
    u_xlat0.yz = vec2(_Hue, _Contrast) + vec2(180.0, 100.0);
    u_xlat0.x = u_xlat0.x * u_xlat0.y;
    u_xlat0.xy = u_xlat0.xz * vec2(0.0174532924, 0.00999999978);
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat6.xyz = u_xlat10_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat6.xyz = u_xlat10_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat6.zxy);
    u_xlat0.xzw = u_xlat0.xxx * u_xlat6.xyz;
    u_xlat0.xzw = u_xlat10_2.xyz * u_xlat1.xxx + u_xlat0.xzw;
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat6.x = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat10_2.xyz);
    u_xlat6.x = u_xlat6.x * 0.57735002;
    u_xlat0.xzw = u_xlat6.xxx * u_xlat1.xxx + u_xlat0.xzw;
    u_xlat1.x = dot(u_xlat0.xzw, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat0.xzw = u_xlat0.xzw + (-u_xlat1.xxx);
    u_xlat6.x = _Saturation * 0.00999999978 + 1.0;
    u_xlat0.xzw = u_xlat6.xxx * u_xlat0.xzw + u_xlat1.xxx;
    u_xlat16_3.xyz = vec3(vec3(_Lightness, _Lightness, _Lightness)) * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat0.xzw;
    u_xlat16_3.xyz = u_xlat16_3.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat16_3.xyz = u_xlat0.yyy * u_xlat16_3.xyz + vec3(0.5, 0.5, 0.5);
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_3.xyz * vec3(-2.0, -2.0, -2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vec3(_Invert) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * _PostColor.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = _PostColor.www * u_xlat0.xyz + u_xlat16_3.xyz;
    u_xlat1 = vs_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = vec4(vec4(_Intensity, _Intensity, _Intensity, _Intensity)) * u_xlat1 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0.xyz = (-u_xlat10_2.xyz) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1 = u_xlat1 * u_xlat10_2;
    u_xlat15 = _Intensity * _Blending;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat1.w;
    u_xlat15 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat15) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "USE_AUTO_COLOR_CHANGE" "USE_COLOR_ADJUST" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _TileIndex;
uniform 	float _FlipFactor;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = in_POSITION0.x * _FlipFactor;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat4 = u_xlat0.x * _TileIndex;
    u_xlatb4 = u_xlat4>=(-u_xlat4);
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2 = _TileIndex / u_xlat0.y;
    u_xlat2 = floor(u_xlat2);
    u_xlat1.y = (-u_xlat2) + in_TEXCOORD0.y;
    u_xlat2 = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat2 * _TileIndex;
    u_xlat2 = fract(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec4 _Time;
uniform 	float _Hue;
uniform 	float _Saturation;
uniform 	float _Lightness;
uniform 	float _Contrast;
uniform 	float _Invert;
uniform 	float _Blending;
uniform 	float _Intensity;
uniform 	vec4 _PostColor;
uniform 	float _AutoColChangeSpeed;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat6;
float u_xlat15;
void main()
{
    u_xlat0.x = _Time.x * _AutoColChangeSpeed;
    u_xlat0.yz = vec2(_Hue, _Contrast) + vec2(180.0, 100.0);
    u_xlat0.x = u_xlat0.x * u_xlat0.y;
    u_xlat0.xy = u_xlat0.xz * vec2(0.0174532924, 0.00999999978);
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat6.xyz = u_xlat10_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat6.xyz = u_xlat10_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat6.zxy);
    u_xlat0.xzw = u_xlat0.xxx * u_xlat6.xyz;
    u_xlat0.xzw = u_xlat10_2.xyz * u_xlat1.xxx + u_xlat0.xzw;
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat6.x = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat10_2.xyz);
    u_xlat6.x = u_xlat6.x * 0.57735002;
    u_xlat0.xzw = u_xlat6.xxx * u_xlat1.xxx + u_xlat0.xzw;
    u_xlat1.x = dot(u_xlat0.xzw, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat0.xzw = u_xlat0.xzw + (-u_xlat1.xxx);
    u_xlat6.x = _Saturation * 0.00999999978 + 1.0;
    u_xlat0.xzw = u_xlat6.xxx * u_xlat0.xzw + u_xlat1.xxx;
    u_xlat16_3.xyz = vec3(vec3(_Lightness, _Lightness, _Lightness)) * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat0.xzw;
    u_xlat16_3.xyz = u_xlat16_3.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat16_3.xyz = u_xlat0.yyy * u_xlat16_3.xyz + vec3(0.5, 0.5, 0.5);
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_3.xyz * vec3(-2.0, -2.0, -2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vec3(_Invert) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * _PostColor.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = _PostColor.www * u_xlat0.xyz + u_xlat16_3.xyz;
    u_xlat1 = vs_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = vec4(vec4(_Intensity, _Intensity, _Intensity, _Intensity)) * u_xlat1 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0.xyz = (-u_xlat10_2.xyz) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1 = u_xlat1 * u_xlat10_2;
    u_xlat15 = _Intensity * _Blending;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat1.w;
    u_xlat15 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat15) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "USE_AUTO_COLOR_CHANGE" "USE_COLOR_ADJUST" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _TileIndex;
uniform 	float _FlipFactor;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = in_POSITION0.x * _FlipFactor;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat4 = u_xlat0.x * _TileIndex;
    u_xlatb4 = u_xlat4>=(-u_xlat4);
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2 = _TileIndex / u_xlat0.y;
    u_xlat2 = floor(u_xlat2);
    u_xlat1.y = (-u_xlat2) + in_TEXCOORD0.y;
    u_xlat2 = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat2 * _TileIndex;
    u_xlat2 = fract(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec4 _Time;
uniform 	float _Hue;
uniform 	float _Saturation;
uniform 	float _Lightness;
uniform 	float _Contrast;
uniform 	float _Invert;
uniform 	float _Blending;
uniform 	float _Intensity;
uniform 	vec4 _PostColor;
uniform 	float _AutoColChangeSpeed;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat6;
float u_xlat15;
void main()
{
    u_xlat0.x = _Time.x * _AutoColChangeSpeed;
    u_xlat0.yz = vec2(_Hue, _Contrast) + vec2(180.0, 100.0);
    u_xlat0.x = u_xlat0.x * u_xlat0.y;
    u_xlat0.xy = u_xlat0.xz * vec2(0.0174532924, 0.00999999978);
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat6.xyz = u_xlat10_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat6.xyz = u_xlat10_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat6.zxy);
    u_xlat0.xzw = u_xlat0.xxx * u_xlat6.xyz;
    u_xlat0.xzw = u_xlat10_2.xyz * u_xlat1.xxx + u_xlat0.xzw;
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat6.x = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat10_2.xyz);
    u_xlat6.x = u_xlat6.x * 0.57735002;
    u_xlat0.xzw = u_xlat6.xxx * u_xlat1.xxx + u_xlat0.xzw;
    u_xlat1.x = dot(u_xlat0.xzw, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat0.xzw = u_xlat0.xzw + (-u_xlat1.xxx);
    u_xlat6.x = _Saturation * 0.00999999978 + 1.0;
    u_xlat0.xzw = u_xlat6.xxx * u_xlat0.xzw + u_xlat1.xxx;
    u_xlat16_3.xyz = vec3(vec3(_Lightness, _Lightness, _Lightness)) * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat0.xzw;
    u_xlat16_3.xyz = u_xlat16_3.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat16_3.xyz = u_xlat0.yyy * u_xlat16_3.xyz + vec3(0.5, 0.5, 0.5);
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_3.xyz * vec3(-2.0, -2.0, -2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vec3(_Invert) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * _PostColor.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = _PostColor.www * u_xlat0.xyz + u_xlat16_3.xyz;
    u_xlat1 = vs_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = vec4(vec4(_Intensity, _Intensity, _Intensity, _Intensity)) * u_xlat1 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0.xyz = (-u_xlat10_2.xyz) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1 = u_xlat1 * u_xlat10_2;
    u_xlat15 = _Intensity * _Blending;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat1.w;
    u_xlat15 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat15) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "USE_COLOR_ADJUST" }
"#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _TileIndex;
uniform 	float _FlipFactor;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = in_POSITION0.x * _FlipFactor;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat4 = u_xlat0.x * _TileIndex;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4>=(-u_xlat4));
#else
    u_xlatb4 = u_xlat4>=(-u_xlat4);
#endif
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2 = _TileIndex / u_xlat0.y;
    u_xlat2 = floor(u_xlat2);
    u_xlat1.y = (-u_xlat2) + in_TEXCOORD0.y;
    u_xlat2 = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat2 * _TileIndex;
    u_xlat2 = fract(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	float _Hue;
uniform 	float _Saturation;
uniform 	float _Lightness;
uniform 	float _Contrast;
uniform 	float _Invert;
uniform 	float _Blending;
uniform 	float _Intensity;
uniform 	vec4 _PostColor;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
float u_xlat15;
void main()
{
    u_xlat0.x = _Hue * 0.0174532924;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat5.xyz = u_xlat16_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat5.xyz = u_xlat16_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat5.zxy);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * u_xlat1.xxx + u_xlat0.xyz;
    u_xlat15 = (-u_xlat1.x) + 1.0;
    u_xlat1.x = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat16_2.xyz);
    u_xlat1.x = u_xlat1.x * 0.57735002;
    u_xlat0.xyz = u_xlat1.xxx * vec3(u_xlat15) + u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat0.xyz = (-vec3(u_xlat15)) + u_xlat0.xyz;
    u_xlat1.x = _Saturation * 0.00999999978 + 1.0;
    u_xlat0.xyz = u_xlat1.xxx * u_xlat0.xyz + vec3(u_xlat15);
    u_xlat16_3.xyz = vec3(vec3(_Lightness, _Lightness, _Lightness)) * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat0.x = _Contrast + 100.0;
    u_xlat0.x = u_xlat0.x * 0.00999999978;
    u_xlat16_3.xyz = u_xlat0.xxx * u_xlat16_3.xyz + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.xyz = min(max(u_xlat16_3.xyz, 0.0), 1.0);
#else
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = u_xlat16_3.xyz * vec3(-2.0, -2.0, -2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vec3(_Invert) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * _PostColor.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = _PostColor.www * u_xlat0.xyz + u_xlat16_3.xyz;
    u_xlat1 = vs_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = vec4(vec4(_Intensity, _Intensity, _Intensity, _Intensity)) * u_xlat1 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0.xyz = (-u_xlat16_2.xyz) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1 = u_xlat1 * u_xlat16_2;
    u_xlat15 = _Intensity * _Blending;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat1.w;
    u_xlat15 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat15) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "USE_COLOR_ADJUST" }
"#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _TileIndex;
uniform 	float _FlipFactor;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = in_POSITION0.x * _FlipFactor;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat4 = u_xlat0.x * _TileIndex;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4>=(-u_xlat4));
#else
    u_xlatb4 = u_xlat4>=(-u_xlat4);
#endif
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2 = _TileIndex / u_xlat0.y;
    u_xlat2 = floor(u_xlat2);
    u_xlat1.y = (-u_xlat2) + in_TEXCOORD0.y;
    u_xlat2 = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat2 * _TileIndex;
    u_xlat2 = fract(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	float _Hue;
uniform 	float _Saturation;
uniform 	float _Lightness;
uniform 	float _Contrast;
uniform 	float _Invert;
uniform 	float _Blending;
uniform 	float _Intensity;
uniform 	vec4 _PostColor;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
float u_xlat15;
void main()
{
    u_xlat0.x = _Hue * 0.0174532924;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat5.xyz = u_xlat16_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat5.xyz = u_xlat16_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat5.zxy);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * u_xlat1.xxx + u_xlat0.xyz;
    u_xlat15 = (-u_xlat1.x) + 1.0;
    u_xlat1.x = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat16_2.xyz);
    u_xlat1.x = u_xlat1.x * 0.57735002;
    u_xlat0.xyz = u_xlat1.xxx * vec3(u_xlat15) + u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat0.xyz = (-vec3(u_xlat15)) + u_xlat0.xyz;
    u_xlat1.x = _Saturation * 0.00999999978 + 1.0;
    u_xlat0.xyz = u_xlat1.xxx * u_xlat0.xyz + vec3(u_xlat15);
    u_xlat16_3.xyz = vec3(vec3(_Lightness, _Lightness, _Lightness)) * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat0.x = _Contrast + 100.0;
    u_xlat0.x = u_xlat0.x * 0.00999999978;
    u_xlat16_3.xyz = u_xlat0.xxx * u_xlat16_3.xyz + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.xyz = min(max(u_xlat16_3.xyz, 0.0), 1.0);
#else
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = u_xlat16_3.xyz * vec3(-2.0, -2.0, -2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vec3(_Invert) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * _PostColor.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = _PostColor.www * u_xlat0.xyz + u_xlat16_3.xyz;
    u_xlat1 = vs_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = vec4(vec4(_Intensity, _Intensity, _Intensity, _Intensity)) * u_xlat1 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0.xyz = (-u_xlat16_2.xyz) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1 = u_xlat1 * u_xlat16_2;
    u_xlat15 = _Intensity * _Blending;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat1.w;
    u_xlat15 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat15) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "USE_COLOR_ADJUST" }
"#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _TileIndex;
uniform 	float _FlipFactor;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = in_POSITION0.x * _FlipFactor;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat4 = u_xlat0.x * _TileIndex;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4>=(-u_xlat4));
#else
    u_xlatb4 = u_xlat4>=(-u_xlat4);
#endif
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2 = _TileIndex / u_xlat0.y;
    u_xlat2 = floor(u_xlat2);
    u_xlat1.y = (-u_xlat2) + in_TEXCOORD0.y;
    u_xlat2 = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat2 * _TileIndex;
    u_xlat2 = fract(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	float _Hue;
uniform 	float _Saturation;
uniform 	float _Lightness;
uniform 	float _Contrast;
uniform 	float _Invert;
uniform 	float _Blending;
uniform 	float _Intensity;
uniform 	vec4 _PostColor;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
float u_xlat15;
void main()
{
    u_xlat0.x = _Hue * 0.0174532924;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat5.xyz = u_xlat16_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat5.xyz = u_xlat16_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat5.zxy);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * u_xlat1.xxx + u_xlat0.xyz;
    u_xlat15 = (-u_xlat1.x) + 1.0;
    u_xlat1.x = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat16_2.xyz);
    u_xlat1.x = u_xlat1.x * 0.57735002;
    u_xlat0.xyz = u_xlat1.xxx * vec3(u_xlat15) + u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat0.xyz = (-vec3(u_xlat15)) + u_xlat0.xyz;
    u_xlat1.x = _Saturation * 0.00999999978 + 1.0;
    u_xlat0.xyz = u_xlat1.xxx * u_xlat0.xyz + vec3(u_xlat15);
    u_xlat16_3.xyz = vec3(vec3(_Lightness, _Lightness, _Lightness)) * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat0.x = _Contrast + 100.0;
    u_xlat0.x = u_xlat0.x * 0.00999999978;
    u_xlat16_3.xyz = u_xlat0.xxx * u_xlat16_3.xyz + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.xyz = min(max(u_xlat16_3.xyz, 0.0), 1.0);
#else
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = u_xlat16_3.xyz * vec3(-2.0, -2.0, -2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vec3(_Invert) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * _PostColor.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = _PostColor.www * u_xlat0.xyz + u_xlat16_3.xyz;
    u_xlat1 = vs_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = vec4(vec4(_Intensity, _Intensity, _Intensity, _Intensity)) * u_xlat1 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0.xyz = (-u_xlat16_2.xyz) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1 = u_xlat1 * u_xlat16_2;
    u_xlat15 = _Intensity * _Blending;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat1.w;
    u_xlat15 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat15) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "USE_DISTORTION" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DistTex_ST;
uniform 	float _DistFlowX;
uniform 	float _DistFlowY;
uniform 	float _TileIndex;
uniform 	float _FlipFactor;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = in_POSITION0.x * _FlipFactor;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat4 = u_xlat0.x * _TileIndex;
    u_xlatb4 = u_xlat4>=(-u_xlat4);
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2 = _TileIndex / u_xlat0.y;
    u_xlat2 = floor(u_xlat2);
    u_xlat1.y = (-u_xlat2) + in_TEXCOORD0.y;
    u_xlat2 = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat2 * _TileIndex;
    u_xlat2 = fract(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD0.xy * _DistTex_ST.xy + _DistTex_ST.zw;
    vs_TEXCOORD1.xy = vec2(_DistFlowX, _DistFlowY) * _Time.yy + u_xlat0.xy;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	float _Dist;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
uniform lowp sampler2D _DistTex;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat10_0.xy = texture2D(_DistTex, vs_TEXCOORD1.xy).xy;
    u_xlat0.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_Dist, _Dist)) + vs_TEXCOORD0.xy;
    u_xlat10_0 = texture2D(_MainTex, u_xlat0.xy);
    u_xlat0 = u_xlat10_0 * vs_COLOR0;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat0.w;
    u_xlat6 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat6) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "USE_DISTORTION" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DistTex_ST;
uniform 	float _DistFlowX;
uniform 	float _DistFlowY;
uniform 	float _TileIndex;
uniform 	float _FlipFactor;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = in_POSITION0.x * _FlipFactor;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat4 = u_xlat0.x * _TileIndex;
    u_xlatb4 = u_xlat4>=(-u_xlat4);
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2 = _TileIndex / u_xlat0.y;
    u_xlat2 = floor(u_xlat2);
    u_xlat1.y = (-u_xlat2) + in_TEXCOORD0.y;
    u_xlat2 = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat2 * _TileIndex;
    u_xlat2 = fract(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD0.xy * _DistTex_ST.xy + _DistTex_ST.zw;
    vs_TEXCOORD1.xy = vec2(_DistFlowX, _DistFlowY) * _Time.yy + u_xlat0.xy;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	float _Dist;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
uniform lowp sampler2D _DistTex;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat10_0.xy = texture2D(_DistTex, vs_TEXCOORD1.xy).xy;
    u_xlat0.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_Dist, _Dist)) + vs_TEXCOORD0.xy;
    u_xlat10_0 = texture2D(_MainTex, u_xlat0.xy);
    u_xlat0 = u_xlat10_0 * vs_COLOR0;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat0.w;
    u_xlat6 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat6) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "USE_DISTORTION" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DistTex_ST;
uniform 	float _DistFlowX;
uniform 	float _DistFlowY;
uniform 	float _TileIndex;
uniform 	float _FlipFactor;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = in_POSITION0.x * _FlipFactor;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat4 = u_xlat0.x * _TileIndex;
    u_xlatb4 = u_xlat4>=(-u_xlat4);
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2 = _TileIndex / u_xlat0.y;
    u_xlat2 = floor(u_xlat2);
    u_xlat1.y = (-u_xlat2) + in_TEXCOORD0.y;
    u_xlat2 = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat2 * _TileIndex;
    u_xlat2 = fract(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD0.xy * _DistTex_ST.xy + _DistTex_ST.zw;
    vs_TEXCOORD1.xy = vec2(_DistFlowX, _DistFlowY) * _Time.yy + u_xlat0.xy;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	float _Dist;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
uniform lowp sampler2D _DistTex;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat10_0.xy = texture2D(_DistTex, vs_TEXCOORD1.xy).xy;
    u_xlat0.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_Dist, _Dist)) + vs_TEXCOORD0.xy;
    u_xlat10_0 = texture2D(_MainTex, u_xlat0.xy);
    u_xlat0 = u_xlat10_0 * vs_COLOR0;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat0.w;
    u_xlat6 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat6) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "INSTANCING_ON" "USE_COLOR_ADJUST" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
struct PropsArray_Type {
	float _TileIndex;
	float _FlipFactor;
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityInstancing_Props {
#endif
	UNITY_UNIFORM PropsArray_Type PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
float u_xlat6;
int u_xlati6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat3.x = in_POSITION0.x * PropsArray[u_xlati0]._FlipFactor;
    u_xlati6 = int(u_xlati0 << 3);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat3.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat3.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat9 = u_xlat3.x * PropsArray[u_xlati0]._TileIndex;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat9>=(-u_xlat9));
#else
    u_xlatb9 = u_xlat9>=(-u_xlat9);
#endif
    u_xlat3.x = (u_xlatb9) ? u_xlat3.x : (-u_xlat3.x);
    u_xlat6 = PropsArray[u_xlati0]._TileIndex / u_xlat3.y;
    u_xlat6 = floor(u_xlat6);
    u_xlat1.y = (-u_xlat6) + in_TEXCOORD0.y;
    u_xlat6 = float(1.0) / u_xlat3.x;
    u_xlat0 = u_xlat6 * PropsArray[u_xlati0]._TileIndex;
    u_xlat0 = fract(u_xlat0);
    u_xlat0 = u_xlat0 * u_xlat3.x;
    u_xlat0 = floor(u_xlat0);
    u_xlat1.x = u_xlat0 + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	float _Hue;
uniform 	float _Saturation;
uniform 	float _Lightness;
uniform 	float _Contrast;
uniform 	float _Invert;
uniform 	float _Blending;
uniform 	float _Intensity;
uniform 	vec4 _PostColor;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
float u_xlat15;
void main()
{
    u_xlat0.x = _Hue * 0.0174532924;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat5.xyz = u_xlat16_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat5.xyz = u_xlat16_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat5.zxy);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * u_xlat1.xxx + u_xlat0.xyz;
    u_xlat15 = (-u_xlat1.x) + 1.0;
    u_xlat1.x = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat16_2.xyz);
    u_xlat1.x = u_xlat1.x * 0.57735002;
    u_xlat0.xyz = u_xlat1.xxx * vec3(u_xlat15) + u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat0.xyz = (-vec3(u_xlat15)) + u_xlat0.xyz;
    u_xlat1.x = _Saturation * 0.00999999978 + 1.0;
    u_xlat0.xyz = u_xlat1.xxx * u_xlat0.xyz + vec3(u_xlat15);
    u_xlat16_3.xyz = vec3(vec3(_Lightness, _Lightness, _Lightness)) * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat0.x = _Contrast + 100.0;
    u_xlat0.x = u_xlat0.x * 0.00999999978;
    u_xlat16_3.xyz = u_xlat0.xxx * u_xlat16_3.xyz + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.xyz = min(max(u_xlat16_3.xyz, 0.0), 1.0);
#else
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = u_xlat16_3.xyz * vec3(-2.0, -2.0, -2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vec3(_Invert) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * _PostColor.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = _PostColor.www * u_xlat0.xyz + u_xlat16_3.xyz;
    u_xlat1 = vs_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = vec4(vec4(_Intensity, _Intensity, _Intensity, _Intensity)) * u_xlat1 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0.xyz = (-u_xlat16_2.xyz) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1 = u_xlat1 * u_xlat16_2;
    u_xlat15 = _Intensity * _Blending;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat1.w;
    u_xlat15 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat15) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "INSTANCING_ON" "USE_COLOR_ADJUST" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
struct PropsArray_Type {
	float _TileIndex;
	float _FlipFactor;
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityInstancing_Props {
#endif
	UNITY_UNIFORM PropsArray_Type PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
float u_xlat6;
int u_xlati6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat3.x = in_POSITION0.x * PropsArray[u_xlati0]._FlipFactor;
    u_xlati6 = int(u_xlati0 << 3);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat3.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat3.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat9 = u_xlat3.x * PropsArray[u_xlati0]._TileIndex;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat9>=(-u_xlat9));
#else
    u_xlatb9 = u_xlat9>=(-u_xlat9);
#endif
    u_xlat3.x = (u_xlatb9) ? u_xlat3.x : (-u_xlat3.x);
    u_xlat6 = PropsArray[u_xlati0]._TileIndex / u_xlat3.y;
    u_xlat6 = floor(u_xlat6);
    u_xlat1.y = (-u_xlat6) + in_TEXCOORD0.y;
    u_xlat6 = float(1.0) / u_xlat3.x;
    u_xlat0 = u_xlat6 * PropsArray[u_xlati0]._TileIndex;
    u_xlat0 = fract(u_xlat0);
    u_xlat0 = u_xlat0 * u_xlat3.x;
    u_xlat0 = floor(u_xlat0);
    u_xlat1.x = u_xlat0 + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	float _Hue;
uniform 	float _Saturation;
uniform 	float _Lightness;
uniform 	float _Contrast;
uniform 	float _Invert;
uniform 	float _Blending;
uniform 	float _Intensity;
uniform 	vec4 _PostColor;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
float u_xlat15;
void main()
{
    u_xlat0.x = _Hue * 0.0174532924;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat5.xyz = u_xlat16_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat5.xyz = u_xlat16_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat5.zxy);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * u_xlat1.xxx + u_xlat0.xyz;
    u_xlat15 = (-u_xlat1.x) + 1.0;
    u_xlat1.x = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat16_2.xyz);
    u_xlat1.x = u_xlat1.x * 0.57735002;
    u_xlat0.xyz = u_xlat1.xxx * vec3(u_xlat15) + u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat0.xyz = (-vec3(u_xlat15)) + u_xlat0.xyz;
    u_xlat1.x = _Saturation * 0.00999999978 + 1.0;
    u_xlat0.xyz = u_xlat1.xxx * u_xlat0.xyz + vec3(u_xlat15);
    u_xlat16_3.xyz = vec3(vec3(_Lightness, _Lightness, _Lightness)) * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat0.x = _Contrast + 100.0;
    u_xlat0.x = u_xlat0.x * 0.00999999978;
    u_xlat16_3.xyz = u_xlat0.xxx * u_xlat16_3.xyz + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.xyz = min(max(u_xlat16_3.xyz, 0.0), 1.0);
#else
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = u_xlat16_3.xyz * vec3(-2.0, -2.0, -2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vec3(_Invert) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * _PostColor.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = _PostColor.www * u_xlat0.xyz + u_xlat16_3.xyz;
    u_xlat1 = vs_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = vec4(vec4(_Intensity, _Intensity, _Intensity, _Intensity)) * u_xlat1 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0.xyz = (-u_xlat16_2.xyz) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1 = u_xlat1 * u_xlat16_2;
    u_xlat15 = _Intensity * _Blending;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat1.w;
    u_xlat15 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat15) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "INSTANCING_ON" "USE_COLOR_ADJUST" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
struct PropsArray_Type {
	float _TileIndex;
	float _FlipFactor;
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityInstancing_Props {
#endif
	UNITY_UNIFORM PropsArray_Type PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
float u_xlat6;
int u_xlati6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat3.x = in_POSITION0.x * PropsArray[u_xlati0]._FlipFactor;
    u_xlati6 = int(u_xlati0 << 3);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat3.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat3.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat9 = u_xlat3.x * PropsArray[u_xlati0]._TileIndex;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat9>=(-u_xlat9));
#else
    u_xlatb9 = u_xlat9>=(-u_xlat9);
#endif
    u_xlat3.x = (u_xlatb9) ? u_xlat3.x : (-u_xlat3.x);
    u_xlat6 = PropsArray[u_xlati0]._TileIndex / u_xlat3.y;
    u_xlat6 = floor(u_xlat6);
    u_xlat1.y = (-u_xlat6) + in_TEXCOORD0.y;
    u_xlat6 = float(1.0) / u_xlat3.x;
    u_xlat0 = u_xlat6 * PropsArray[u_xlati0]._TileIndex;
    u_xlat0 = fract(u_xlat0);
    u_xlat0 = u_xlat0 * u_xlat3.x;
    u_xlat0 = floor(u_xlat0);
    u_xlat1.x = u_xlat0 + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	float _Hue;
uniform 	float _Saturation;
uniform 	float _Lightness;
uniform 	float _Contrast;
uniform 	float _Invert;
uniform 	float _Blending;
uniform 	float _Intensity;
uniform 	vec4 _PostColor;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
float u_xlat15;
void main()
{
    u_xlat0.x = _Hue * 0.0174532924;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat5.xyz = u_xlat16_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat5.xyz = u_xlat16_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat5.zxy);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * u_xlat1.xxx + u_xlat0.xyz;
    u_xlat15 = (-u_xlat1.x) + 1.0;
    u_xlat1.x = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat16_2.xyz);
    u_xlat1.x = u_xlat1.x * 0.57735002;
    u_xlat0.xyz = u_xlat1.xxx * vec3(u_xlat15) + u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat0.xyz = (-vec3(u_xlat15)) + u_xlat0.xyz;
    u_xlat1.x = _Saturation * 0.00999999978 + 1.0;
    u_xlat0.xyz = u_xlat1.xxx * u_xlat0.xyz + vec3(u_xlat15);
    u_xlat16_3.xyz = vec3(vec3(_Lightness, _Lightness, _Lightness)) * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat0.x = _Contrast + 100.0;
    u_xlat0.x = u_xlat0.x * 0.00999999978;
    u_xlat16_3.xyz = u_xlat0.xxx * u_xlat16_3.xyz + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.xyz = min(max(u_xlat16_3.xyz, 0.0), 1.0);
#else
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = u_xlat16_3.xyz * vec3(-2.0, -2.0, -2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vec3(_Invert) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * _PostColor.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = _PostColor.www * u_xlat0.xyz + u_xlat16_3.xyz;
    u_xlat1 = vs_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = vec4(vec4(_Intensity, _Intensity, _Intensity, _Intensity)) * u_xlat1 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0.xyz = (-u_xlat16_2.xyz) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1 = u_xlat1 * u_xlat16_2;
    u_xlat15 = _Intensity * _Blending;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat1.w;
    u_xlat15 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat15) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "USE_AUTO_COLOR_CHANGE" "USE_DISTORTION" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DistTex_ST;
uniform 	float _DistFlowX;
uniform 	float _DistFlowY;
uniform 	float _TileIndex;
uniform 	float _FlipFactor;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = in_POSITION0.x * _FlipFactor;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat4 = u_xlat0.x * _TileIndex;
    u_xlatb4 = u_xlat4>=(-u_xlat4);
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2 = _TileIndex / u_xlat0.y;
    u_xlat2 = floor(u_xlat2);
    u_xlat1.y = (-u_xlat2) + in_TEXCOORD0.y;
    u_xlat2 = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat2 * _TileIndex;
    u_xlat2 = fract(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD0.xy * _DistTex_ST.xy + _DistTex_ST.zw;
    vs_TEXCOORD1.xy = vec2(_DistFlowX, _DistFlowY) * _Time.yy + u_xlat0.xy;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	float _Dist;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
uniform lowp sampler2D _DistTex;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat10_0.xy = texture2D(_DistTex, vs_TEXCOORD1.xy).xy;
    u_xlat0.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_Dist, _Dist)) + vs_TEXCOORD0.xy;
    u_xlat10_0 = texture2D(_MainTex, u_xlat0.xy);
    u_xlat0 = u_xlat10_0 * vs_COLOR0;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat0.w;
    u_xlat6 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat6) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "USE_AUTO_COLOR_CHANGE" "USE_DISTORTION" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DistTex_ST;
uniform 	float _DistFlowX;
uniform 	float _DistFlowY;
uniform 	float _TileIndex;
uniform 	float _FlipFactor;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = in_POSITION0.x * _FlipFactor;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat4 = u_xlat0.x * _TileIndex;
    u_xlatb4 = u_xlat4>=(-u_xlat4);
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2 = _TileIndex / u_xlat0.y;
    u_xlat2 = floor(u_xlat2);
    u_xlat1.y = (-u_xlat2) + in_TEXCOORD0.y;
    u_xlat2 = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat2 * _TileIndex;
    u_xlat2 = fract(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD0.xy * _DistTex_ST.xy + _DistTex_ST.zw;
    vs_TEXCOORD1.xy = vec2(_DistFlowX, _DistFlowY) * _Time.yy + u_xlat0.xy;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	float _Dist;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
uniform lowp sampler2D _DistTex;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat10_0.xy = texture2D(_DistTex, vs_TEXCOORD1.xy).xy;
    u_xlat0.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_Dist, _Dist)) + vs_TEXCOORD0.xy;
    u_xlat10_0 = texture2D(_MainTex, u_xlat0.xy);
    u_xlat0 = u_xlat10_0 * vs_COLOR0;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat0.w;
    u_xlat6 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat6) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "USE_AUTO_COLOR_CHANGE" "USE_DISTORTION" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DistTex_ST;
uniform 	float _DistFlowX;
uniform 	float _DistFlowY;
uniform 	float _TileIndex;
uniform 	float _FlipFactor;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = in_POSITION0.x * _FlipFactor;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat4 = u_xlat0.x * _TileIndex;
    u_xlatb4 = u_xlat4>=(-u_xlat4);
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2 = _TileIndex / u_xlat0.y;
    u_xlat2 = floor(u_xlat2);
    u_xlat1.y = (-u_xlat2) + in_TEXCOORD0.y;
    u_xlat2 = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat2 * _TileIndex;
    u_xlat2 = fract(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD0.xy * _DistTex_ST.xy + _DistTex_ST.zw;
    vs_TEXCOORD1.xy = vec2(_DistFlowX, _DistFlowY) * _Time.yy + u_xlat0.xy;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	float _Dist;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
uniform lowp sampler2D _DistTex;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat10_0.xy = texture2D(_DistTex, vs_TEXCOORD1.xy).xy;
    u_xlat0.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_Dist, _Dist)) + vs_TEXCOORD0.xy;
    u_xlat10_0 = texture2D(_MainTex, u_xlat0.xy);
    u_xlat0 = u_xlat10_0 * vs_COLOR0;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat0.w;
    u_xlat6 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat6) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "USE_AUTO_COLOR_CHANGE" "USE_COLOR_ADJUST" }
"#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _TileIndex;
uniform 	float _FlipFactor;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = in_POSITION0.x * _FlipFactor;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat4 = u_xlat0.x * _TileIndex;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4>=(-u_xlat4));
#else
    u_xlatb4 = u_xlat4>=(-u_xlat4);
#endif
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2 = _TileIndex / u_xlat0.y;
    u_xlat2 = floor(u_xlat2);
    u_xlat1.y = (-u_xlat2) + in_TEXCOORD0.y;
    u_xlat2 = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat2 * _TileIndex;
    u_xlat2 = fract(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	float _Hue;
uniform 	float _Saturation;
uniform 	float _Lightness;
uniform 	float _Contrast;
uniform 	float _Invert;
uniform 	float _Blending;
uniform 	float _Intensity;
uniform 	vec4 _PostColor;
uniform 	float _AutoColChangeSpeed;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat6;
float u_xlat15;
void main()
{
    u_xlat0.x = _Time.x * _AutoColChangeSpeed;
    u_xlat0.yz = vec2(_Hue, _Contrast) + vec2(180.0, 100.0);
    u_xlat0.x = u_xlat0.x * u_xlat0.y;
    u_xlat0.xy = u_xlat0.xz * vec2(0.0174532924, 0.00999999978);
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat6.xyz = u_xlat16_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat6.xyz = u_xlat16_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat6.zxy);
    u_xlat0.xzw = u_xlat0.xxx * u_xlat6.xyz;
    u_xlat0.xzw = u_xlat16_2.xyz * u_xlat1.xxx + u_xlat0.xzw;
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat6.x = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat16_2.xyz);
    u_xlat6.x = u_xlat6.x * 0.57735002;
    u_xlat0.xzw = u_xlat6.xxx * u_xlat1.xxx + u_xlat0.xzw;
    u_xlat1.x = dot(u_xlat0.xzw, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat0.xzw = u_xlat0.xzw + (-u_xlat1.xxx);
    u_xlat6.x = _Saturation * 0.00999999978 + 1.0;
    u_xlat0.xzw = u_xlat6.xxx * u_xlat0.xzw + u_xlat1.xxx;
    u_xlat16_3.xyz = vec3(vec3(_Lightness, _Lightness, _Lightness)) * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat0.xzw;
    u_xlat16_3.xyz = u_xlat16_3.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat16_3.xyz = u_xlat0.yyy * u_xlat16_3.xyz + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.xyz = min(max(u_xlat16_3.xyz, 0.0), 1.0);
#else
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = u_xlat16_3.xyz * vec3(-2.0, -2.0, -2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vec3(_Invert) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * _PostColor.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = _PostColor.www * u_xlat0.xyz + u_xlat16_3.xyz;
    u_xlat1 = vs_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = vec4(vec4(_Intensity, _Intensity, _Intensity, _Intensity)) * u_xlat1 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0.xyz = (-u_xlat16_2.xyz) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1 = u_xlat1 * u_xlat16_2;
    u_xlat15 = _Intensity * _Blending;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat1.w;
    u_xlat15 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat15) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "USE_AUTO_COLOR_CHANGE" "USE_COLOR_ADJUST" }
"#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _TileIndex;
uniform 	float _FlipFactor;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = in_POSITION0.x * _FlipFactor;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat4 = u_xlat0.x * _TileIndex;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4>=(-u_xlat4));
#else
    u_xlatb4 = u_xlat4>=(-u_xlat4);
#endif
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2 = _TileIndex / u_xlat0.y;
    u_xlat2 = floor(u_xlat2);
    u_xlat1.y = (-u_xlat2) + in_TEXCOORD0.y;
    u_xlat2 = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat2 * _TileIndex;
    u_xlat2 = fract(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	float _Hue;
uniform 	float _Saturation;
uniform 	float _Lightness;
uniform 	float _Contrast;
uniform 	float _Invert;
uniform 	float _Blending;
uniform 	float _Intensity;
uniform 	vec4 _PostColor;
uniform 	float _AutoColChangeSpeed;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat6;
float u_xlat15;
void main()
{
    u_xlat0.x = _Time.x * _AutoColChangeSpeed;
    u_xlat0.yz = vec2(_Hue, _Contrast) + vec2(180.0, 100.0);
    u_xlat0.x = u_xlat0.x * u_xlat0.y;
    u_xlat0.xy = u_xlat0.xz * vec2(0.0174532924, 0.00999999978);
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat6.xyz = u_xlat16_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat6.xyz = u_xlat16_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat6.zxy);
    u_xlat0.xzw = u_xlat0.xxx * u_xlat6.xyz;
    u_xlat0.xzw = u_xlat16_2.xyz * u_xlat1.xxx + u_xlat0.xzw;
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat6.x = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat16_2.xyz);
    u_xlat6.x = u_xlat6.x * 0.57735002;
    u_xlat0.xzw = u_xlat6.xxx * u_xlat1.xxx + u_xlat0.xzw;
    u_xlat1.x = dot(u_xlat0.xzw, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat0.xzw = u_xlat0.xzw + (-u_xlat1.xxx);
    u_xlat6.x = _Saturation * 0.00999999978 + 1.0;
    u_xlat0.xzw = u_xlat6.xxx * u_xlat0.xzw + u_xlat1.xxx;
    u_xlat16_3.xyz = vec3(vec3(_Lightness, _Lightness, _Lightness)) * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat0.xzw;
    u_xlat16_3.xyz = u_xlat16_3.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat16_3.xyz = u_xlat0.yyy * u_xlat16_3.xyz + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.xyz = min(max(u_xlat16_3.xyz, 0.0), 1.0);
#else
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = u_xlat16_3.xyz * vec3(-2.0, -2.0, -2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vec3(_Invert) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * _PostColor.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = _PostColor.www * u_xlat0.xyz + u_xlat16_3.xyz;
    u_xlat1 = vs_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = vec4(vec4(_Intensity, _Intensity, _Intensity, _Intensity)) * u_xlat1 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0.xyz = (-u_xlat16_2.xyz) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1 = u_xlat1 * u_xlat16_2;
    u_xlat15 = _Intensity * _Blending;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat1.w;
    u_xlat15 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat15) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "USE_AUTO_COLOR_CHANGE" "USE_COLOR_ADJUST" }
"#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _TileIndex;
uniform 	float _FlipFactor;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = in_POSITION0.x * _FlipFactor;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat4 = u_xlat0.x * _TileIndex;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4>=(-u_xlat4));
#else
    u_xlatb4 = u_xlat4>=(-u_xlat4);
#endif
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2 = _TileIndex / u_xlat0.y;
    u_xlat2 = floor(u_xlat2);
    u_xlat1.y = (-u_xlat2) + in_TEXCOORD0.y;
    u_xlat2 = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat2 * _TileIndex;
    u_xlat2 = fract(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	float _Hue;
uniform 	float _Saturation;
uniform 	float _Lightness;
uniform 	float _Contrast;
uniform 	float _Invert;
uniform 	float _Blending;
uniform 	float _Intensity;
uniform 	vec4 _PostColor;
uniform 	float _AutoColChangeSpeed;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat6;
float u_xlat15;
void main()
{
    u_xlat0.x = _Time.x * _AutoColChangeSpeed;
    u_xlat0.yz = vec2(_Hue, _Contrast) + vec2(180.0, 100.0);
    u_xlat0.x = u_xlat0.x * u_xlat0.y;
    u_xlat0.xy = u_xlat0.xz * vec2(0.0174532924, 0.00999999978);
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat6.xyz = u_xlat16_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat6.xyz = u_xlat16_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat6.zxy);
    u_xlat0.xzw = u_xlat0.xxx * u_xlat6.xyz;
    u_xlat0.xzw = u_xlat16_2.xyz * u_xlat1.xxx + u_xlat0.xzw;
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat6.x = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat16_2.xyz);
    u_xlat6.x = u_xlat6.x * 0.57735002;
    u_xlat0.xzw = u_xlat6.xxx * u_xlat1.xxx + u_xlat0.xzw;
    u_xlat1.x = dot(u_xlat0.xzw, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat0.xzw = u_xlat0.xzw + (-u_xlat1.xxx);
    u_xlat6.x = _Saturation * 0.00999999978 + 1.0;
    u_xlat0.xzw = u_xlat6.xxx * u_xlat0.xzw + u_xlat1.xxx;
    u_xlat16_3.xyz = vec3(vec3(_Lightness, _Lightness, _Lightness)) * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat0.xzw;
    u_xlat16_3.xyz = u_xlat16_3.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat16_3.xyz = u_xlat0.yyy * u_xlat16_3.xyz + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.xyz = min(max(u_xlat16_3.xyz, 0.0), 1.0);
#else
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = u_xlat16_3.xyz * vec3(-2.0, -2.0, -2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vec3(_Invert) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * _PostColor.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = _PostColor.www * u_xlat0.xyz + u_xlat16_3.xyz;
    u_xlat1 = vs_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = vec4(vec4(_Intensity, _Intensity, _Intensity, _Intensity)) * u_xlat1 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0.xyz = (-u_xlat16_2.xyz) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1 = u_xlat1 * u_xlat16_2;
    u_xlat15 = _Intensity * _Blending;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat1.w;
    u_xlat15 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat15) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "USE_COLOR_ADJUST" "USE_DISTORTION" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DistTex_ST;
uniform 	float _DistFlowX;
uniform 	float _DistFlowY;
uniform 	float _TileIndex;
uniform 	float _FlipFactor;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = in_POSITION0.x * _FlipFactor;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat4 = u_xlat0.x * _TileIndex;
    u_xlatb4 = u_xlat4>=(-u_xlat4);
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2 = _TileIndex / u_xlat0.y;
    u_xlat2 = floor(u_xlat2);
    u_xlat1.y = (-u_xlat2) + in_TEXCOORD0.y;
    u_xlat2 = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat2 * _TileIndex;
    u_xlat2 = fract(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD0.xy * _DistTex_ST.xy + _DistTex_ST.zw;
    vs_TEXCOORD1.xy = vec2(_DistFlowX, _DistFlowY) * _Time.yy + u_xlat0.xy;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	float _Hue;
uniform 	float _Saturation;
uniform 	float _Lightness;
uniform 	float _Contrast;
uniform 	float _Invert;
uniform 	float _Blending;
uniform 	float _Intensity;
uniform 	vec4 _PostColor;
uniform 	float _Dist;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
uniform lowp sampler2D _DistTex;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
float u_xlat18;
float u_xlat19;
void main()
{
    u_xlat10_0.xy = texture2D(_DistTex, vs_TEXCOORD1.xy).xy;
    u_xlat0.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = u_xlat0.xy * vec2(_Dist) + vs_TEXCOORD0.xy;
    u_xlat10_0 = texture2D(_MainTex, u_xlat0.xy);
    u_xlat1.xyz = u_xlat10_0.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat1.xyz = u_xlat10_0.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat1.zxy);
    u_xlat19 = _Hue * 0.0174532924;
    u_xlat2.x = sin(u_xlat19);
    u_xlat3 = cos(u_xlat19);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xxx;
    u_xlat1.xyz = u_xlat10_0.xyz * vec3(u_xlat3) + u_xlat1.xyz;
    u_xlat19 = (-u_xlat3) + 1.0;
    u_xlat2.x = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat10_0.xyz);
    u_xlat2.x = u_xlat2.x * 0.57735002;
    u_xlat1.xyz = u_xlat2.xxx * vec3(u_xlat19) + u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat1.xyz = (-vec3(u_xlat19)) + u_xlat1.xyz;
    u_xlat2.x = _Saturation * 0.00999999978 + 1.0;
    u_xlat1.xyz = u_xlat2.xxx * u_xlat1.xyz + vec3(u_xlat19);
    u_xlat16_4.xyz = vec3(_Lightness) * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat1.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat1.x = _Contrast + 100.0;
    u_xlat1.x = u_xlat1.x * 0.00999999978;
    u_xlat16_4.xyz = u_xlat1.xxx * u_xlat16_4.xyz + vec3(0.5, 0.5, 0.5);
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_4.xyz * vec3(-2.0, -2.0, -2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = vec3(vec3(_Invert, _Invert, _Invert)) * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat1.xyz = u_xlat16_4.xyz * _PostColor.xyz + (-u_xlat16_4.xyz);
    u_xlat1.xyz = _PostColor.www * u_xlat1.xyz + u_xlat16_4.xyz;
    u_xlat2 = vs_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat2 = vec4(_Intensity) * u_xlat2 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1.xyz = (-u_xlat10_0.xyz) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat0 = u_xlat10_0 * u_xlat2;
    u_xlat19 = _Blending * _Intensity;
    u_xlat0.xyz = vec3(u_xlat19) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat0.w;
    u_xlat18 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat18) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "USE_COLOR_ADJUST" "USE_DISTORTION" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DistTex_ST;
uniform 	float _DistFlowX;
uniform 	float _DistFlowY;
uniform 	float _TileIndex;
uniform 	float _FlipFactor;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = in_POSITION0.x * _FlipFactor;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat4 = u_xlat0.x * _TileIndex;
    u_xlatb4 = u_xlat4>=(-u_xlat4);
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2 = _TileIndex / u_xlat0.y;
    u_xlat2 = floor(u_xlat2);
    u_xlat1.y = (-u_xlat2) + in_TEXCOORD0.y;
    u_xlat2 = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat2 * _TileIndex;
    u_xlat2 = fract(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD0.xy * _DistTex_ST.xy + _DistTex_ST.zw;
    vs_TEXCOORD1.xy = vec2(_DistFlowX, _DistFlowY) * _Time.yy + u_xlat0.xy;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	float _Hue;
uniform 	float _Saturation;
uniform 	float _Lightness;
uniform 	float _Contrast;
uniform 	float _Invert;
uniform 	float _Blending;
uniform 	float _Intensity;
uniform 	vec4 _PostColor;
uniform 	float _Dist;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
uniform lowp sampler2D _DistTex;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
float u_xlat18;
float u_xlat19;
void main()
{
    u_xlat10_0.xy = texture2D(_DistTex, vs_TEXCOORD1.xy).xy;
    u_xlat0.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = u_xlat0.xy * vec2(_Dist) + vs_TEXCOORD0.xy;
    u_xlat10_0 = texture2D(_MainTex, u_xlat0.xy);
    u_xlat1.xyz = u_xlat10_0.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat1.xyz = u_xlat10_0.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat1.zxy);
    u_xlat19 = _Hue * 0.0174532924;
    u_xlat2.x = sin(u_xlat19);
    u_xlat3 = cos(u_xlat19);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xxx;
    u_xlat1.xyz = u_xlat10_0.xyz * vec3(u_xlat3) + u_xlat1.xyz;
    u_xlat19 = (-u_xlat3) + 1.0;
    u_xlat2.x = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat10_0.xyz);
    u_xlat2.x = u_xlat2.x * 0.57735002;
    u_xlat1.xyz = u_xlat2.xxx * vec3(u_xlat19) + u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat1.xyz = (-vec3(u_xlat19)) + u_xlat1.xyz;
    u_xlat2.x = _Saturation * 0.00999999978 + 1.0;
    u_xlat1.xyz = u_xlat2.xxx * u_xlat1.xyz + vec3(u_xlat19);
    u_xlat16_4.xyz = vec3(_Lightness) * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat1.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat1.x = _Contrast + 100.0;
    u_xlat1.x = u_xlat1.x * 0.00999999978;
    u_xlat16_4.xyz = u_xlat1.xxx * u_xlat16_4.xyz + vec3(0.5, 0.5, 0.5);
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_4.xyz * vec3(-2.0, -2.0, -2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = vec3(vec3(_Invert, _Invert, _Invert)) * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat1.xyz = u_xlat16_4.xyz * _PostColor.xyz + (-u_xlat16_4.xyz);
    u_xlat1.xyz = _PostColor.www * u_xlat1.xyz + u_xlat16_4.xyz;
    u_xlat2 = vs_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat2 = vec4(_Intensity) * u_xlat2 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1.xyz = (-u_xlat10_0.xyz) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat0 = u_xlat10_0 * u_xlat2;
    u_xlat19 = _Blending * _Intensity;
    u_xlat0.xyz = vec3(u_xlat19) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat0.w;
    u_xlat18 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat18) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "USE_COLOR_ADJUST" "USE_DISTORTION" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DistTex_ST;
uniform 	float _DistFlowX;
uniform 	float _DistFlowY;
uniform 	float _TileIndex;
uniform 	float _FlipFactor;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = in_POSITION0.x * _FlipFactor;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat4 = u_xlat0.x * _TileIndex;
    u_xlatb4 = u_xlat4>=(-u_xlat4);
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2 = _TileIndex / u_xlat0.y;
    u_xlat2 = floor(u_xlat2);
    u_xlat1.y = (-u_xlat2) + in_TEXCOORD0.y;
    u_xlat2 = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat2 * _TileIndex;
    u_xlat2 = fract(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD0.xy * _DistTex_ST.xy + _DistTex_ST.zw;
    vs_TEXCOORD1.xy = vec2(_DistFlowX, _DistFlowY) * _Time.yy + u_xlat0.xy;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	float _Hue;
uniform 	float _Saturation;
uniform 	float _Lightness;
uniform 	float _Contrast;
uniform 	float _Invert;
uniform 	float _Blending;
uniform 	float _Intensity;
uniform 	vec4 _PostColor;
uniform 	float _Dist;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
uniform lowp sampler2D _DistTex;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
float u_xlat18;
float u_xlat19;
void main()
{
    u_xlat10_0.xy = texture2D(_DistTex, vs_TEXCOORD1.xy).xy;
    u_xlat0.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = u_xlat0.xy * vec2(_Dist) + vs_TEXCOORD0.xy;
    u_xlat10_0 = texture2D(_MainTex, u_xlat0.xy);
    u_xlat1.xyz = u_xlat10_0.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat1.xyz = u_xlat10_0.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat1.zxy);
    u_xlat19 = _Hue * 0.0174532924;
    u_xlat2.x = sin(u_xlat19);
    u_xlat3 = cos(u_xlat19);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xxx;
    u_xlat1.xyz = u_xlat10_0.xyz * vec3(u_xlat3) + u_xlat1.xyz;
    u_xlat19 = (-u_xlat3) + 1.0;
    u_xlat2.x = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat10_0.xyz);
    u_xlat2.x = u_xlat2.x * 0.57735002;
    u_xlat1.xyz = u_xlat2.xxx * vec3(u_xlat19) + u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat1.xyz = (-vec3(u_xlat19)) + u_xlat1.xyz;
    u_xlat2.x = _Saturation * 0.00999999978 + 1.0;
    u_xlat1.xyz = u_xlat2.xxx * u_xlat1.xyz + vec3(u_xlat19);
    u_xlat16_4.xyz = vec3(_Lightness) * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat1.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat1.x = _Contrast + 100.0;
    u_xlat1.x = u_xlat1.x * 0.00999999978;
    u_xlat16_4.xyz = u_xlat1.xxx * u_xlat16_4.xyz + vec3(0.5, 0.5, 0.5);
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_4.xyz * vec3(-2.0, -2.0, -2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = vec3(vec3(_Invert, _Invert, _Invert)) * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat1.xyz = u_xlat16_4.xyz * _PostColor.xyz + (-u_xlat16_4.xyz);
    u_xlat1.xyz = _PostColor.www * u_xlat1.xyz + u_xlat16_4.xyz;
    u_xlat2 = vs_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat2 = vec4(_Intensity) * u_xlat2 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1.xyz = (-u_xlat10_0.xyz) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat0 = u_xlat10_0 * u_xlat2;
    u_xlat19 = _Blending * _Intensity;
    u_xlat0.xyz = vec3(u_xlat19) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat0.w;
    u_xlat18 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat18) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "INSTANCING_ON" "USE_AUTO_COLOR_CHANGE" "USE_COLOR_ADJUST" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
struct PropsArray_Type {
	float _TileIndex;
	float _FlipFactor;
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityInstancing_Props {
#endif
	UNITY_UNIFORM PropsArray_Type PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
float u_xlat6;
int u_xlati6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat3.x = in_POSITION0.x * PropsArray[u_xlati0]._FlipFactor;
    u_xlati6 = int(u_xlati0 << 3);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat3.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat3.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat9 = u_xlat3.x * PropsArray[u_xlati0]._TileIndex;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat9>=(-u_xlat9));
#else
    u_xlatb9 = u_xlat9>=(-u_xlat9);
#endif
    u_xlat3.x = (u_xlatb9) ? u_xlat3.x : (-u_xlat3.x);
    u_xlat6 = PropsArray[u_xlati0]._TileIndex / u_xlat3.y;
    u_xlat6 = floor(u_xlat6);
    u_xlat1.y = (-u_xlat6) + in_TEXCOORD0.y;
    u_xlat6 = float(1.0) / u_xlat3.x;
    u_xlat0 = u_xlat6 * PropsArray[u_xlati0]._TileIndex;
    u_xlat0 = fract(u_xlat0);
    u_xlat0 = u_xlat0 * u_xlat3.x;
    u_xlat0 = floor(u_xlat0);
    u_xlat1.x = u_xlat0 + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	float _Hue;
uniform 	float _Saturation;
uniform 	float _Lightness;
uniform 	float _Contrast;
uniform 	float _Invert;
uniform 	float _Blending;
uniform 	float _Intensity;
uniform 	vec4 _PostColor;
uniform 	float _AutoColChangeSpeed;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat6;
float u_xlat15;
void main()
{
    u_xlat0.x = _Time.x * _AutoColChangeSpeed;
    u_xlat0.yz = vec2(_Hue, _Contrast) + vec2(180.0, 100.0);
    u_xlat0.x = u_xlat0.x * u_xlat0.y;
    u_xlat0.xy = u_xlat0.xz * vec2(0.0174532924, 0.00999999978);
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat6.xyz = u_xlat16_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat6.xyz = u_xlat16_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat6.zxy);
    u_xlat0.xzw = u_xlat0.xxx * u_xlat6.xyz;
    u_xlat0.xzw = u_xlat16_2.xyz * u_xlat1.xxx + u_xlat0.xzw;
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat6.x = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat16_2.xyz);
    u_xlat6.x = u_xlat6.x * 0.57735002;
    u_xlat0.xzw = u_xlat6.xxx * u_xlat1.xxx + u_xlat0.xzw;
    u_xlat1.x = dot(u_xlat0.xzw, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat0.xzw = u_xlat0.xzw + (-u_xlat1.xxx);
    u_xlat6.x = _Saturation * 0.00999999978 + 1.0;
    u_xlat0.xzw = u_xlat6.xxx * u_xlat0.xzw + u_xlat1.xxx;
    u_xlat16_3.xyz = vec3(vec3(_Lightness, _Lightness, _Lightness)) * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat0.xzw;
    u_xlat16_3.xyz = u_xlat16_3.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat16_3.xyz = u_xlat0.yyy * u_xlat16_3.xyz + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.xyz = min(max(u_xlat16_3.xyz, 0.0), 1.0);
#else
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = u_xlat16_3.xyz * vec3(-2.0, -2.0, -2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vec3(_Invert) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * _PostColor.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = _PostColor.www * u_xlat0.xyz + u_xlat16_3.xyz;
    u_xlat1 = vs_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = vec4(vec4(_Intensity, _Intensity, _Intensity, _Intensity)) * u_xlat1 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0.xyz = (-u_xlat16_2.xyz) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1 = u_xlat1 * u_xlat16_2;
    u_xlat15 = _Intensity * _Blending;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat1.w;
    u_xlat15 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat15) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "INSTANCING_ON" "USE_AUTO_COLOR_CHANGE" "USE_COLOR_ADJUST" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
struct PropsArray_Type {
	float _TileIndex;
	float _FlipFactor;
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityInstancing_Props {
#endif
	UNITY_UNIFORM PropsArray_Type PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
float u_xlat6;
int u_xlati6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat3.x = in_POSITION0.x * PropsArray[u_xlati0]._FlipFactor;
    u_xlati6 = int(u_xlati0 << 3);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat3.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat3.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat9 = u_xlat3.x * PropsArray[u_xlati0]._TileIndex;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat9>=(-u_xlat9));
#else
    u_xlatb9 = u_xlat9>=(-u_xlat9);
#endif
    u_xlat3.x = (u_xlatb9) ? u_xlat3.x : (-u_xlat3.x);
    u_xlat6 = PropsArray[u_xlati0]._TileIndex / u_xlat3.y;
    u_xlat6 = floor(u_xlat6);
    u_xlat1.y = (-u_xlat6) + in_TEXCOORD0.y;
    u_xlat6 = float(1.0) / u_xlat3.x;
    u_xlat0 = u_xlat6 * PropsArray[u_xlati0]._TileIndex;
    u_xlat0 = fract(u_xlat0);
    u_xlat0 = u_xlat0 * u_xlat3.x;
    u_xlat0 = floor(u_xlat0);
    u_xlat1.x = u_xlat0 + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	float _Hue;
uniform 	float _Saturation;
uniform 	float _Lightness;
uniform 	float _Contrast;
uniform 	float _Invert;
uniform 	float _Blending;
uniform 	float _Intensity;
uniform 	vec4 _PostColor;
uniform 	float _AutoColChangeSpeed;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat6;
float u_xlat15;
void main()
{
    u_xlat0.x = _Time.x * _AutoColChangeSpeed;
    u_xlat0.yz = vec2(_Hue, _Contrast) + vec2(180.0, 100.0);
    u_xlat0.x = u_xlat0.x * u_xlat0.y;
    u_xlat0.xy = u_xlat0.xz * vec2(0.0174532924, 0.00999999978);
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat6.xyz = u_xlat16_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat6.xyz = u_xlat16_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat6.zxy);
    u_xlat0.xzw = u_xlat0.xxx * u_xlat6.xyz;
    u_xlat0.xzw = u_xlat16_2.xyz * u_xlat1.xxx + u_xlat0.xzw;
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat6.x = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat16_2.xyz);
    u_xlat6.x = u_xlat6.x * 0.57735002;
    u_xlat0.xzw = u_xlat6.xxx * u_xlat1.xxx + u_xlat0.xzw;
    u_xlat1.x = dot(u_xlat0.xzw, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat0.xzw = u_xlat0.xzw + (-u_xlat1.xxx);
    u_xlat6.x = _Saturation * 0.00999999978 + 1.0;
    u_xlat0.xzw = u_xlat6.xxx * u_xlat0.xzw + u_xlat1.xxx;
    u_xlat16_3.xyz = vec3(vec3(_Lightness, _Lightness, _Lightness)) * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat0.xzw;
    u_xlat16_3.xyz = u_xlat16_3.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat16_3.xyz = u_xlat0.yyy * u_xlat16_3.xyz + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.xyz = min(max(u_xlat16_3.xyz, 0.0), 1.0);
#else
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = u_xlat16_3.xyz * vec3(-2.0, -2.0, -2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vec3(_Invert) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * _PostColor.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = _PostColor.www * u_xlat0.xyz + u_xlat16_3.xyz;
    u_xlat1 = vs_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = vec4(vec4(_Intensity, _Intensity, _Intensity, _Intensity)) * u_xlat1 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0.xyz = (-u_xlat16_2.xyz) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1 = u_xlat1 * u_xlat16_2;
    u_xlat15 = _Intensity * _Blending;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat1.w;
    u_xlat15 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat15) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "INSTANCING_ON" "USE_AUTO_COLOR_CHANGE" "USE_COLOR_ADJUST" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
struct PropsArray_Type {
	float _TileIndex;
	float _FlipFactor;
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityInstancing_Props {
#endif
	UNITY_UNIFORM PropsArray_Type PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
float u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
float u_xlat6;
int u_xlati6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat3.x = in_POSITION0.x * PropsArray[u_xlati0]._FlipFactor;
    u_xlati6 = int(u_xlati0 << 3);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat3.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat3.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat9 = u_xlat3.x * PropsArray[u_xlati0]._TileIndex;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat9>=(-u_xlat9));
#else
    u_xlatb9 = u_xlat9>=(-u_xlat9);
#endif
    u_xlat3.x = (u_xlatb9) ? u_xlat3.x : (-u_xlat3.x);
    u_xlat6 = PropsArray[u_xlati0]._TileIndex / u_xlat3.y;
    u_xlat6 = floor(u_xlat6);
    u_xlat1.y = (-u_xlat6) + in_TEXCOORD0.y;
    u_xlat6 = float(1.0) / u_xlat3.x;
    u_xlat0 = u_xlat6 * PropsArray[u_xlati0]._TileIndex;
    u_xlat0 = fract(u_xlat0);
    u_xlat0 = u_xlat0 * u_xlat3.x;
    u_xlat0 = floor(u_xlat0);
    u_xlat1.x = u_xlat0 + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	float _Hue;
uniform 	float _Saturation;
uniform 	float _Lightness;
uniform 	float _Contrast;
uniform 	float _Invert;
uniform 	float _Blending;
uniform 	float _Intensity;
uniform 	vec4 _PostColor;
uniform 	float _AutoColChangeSpeed;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat6;
float u_xlat15;
void main()
{
    u_xlat0.x = _Time.x * _AutoColChangeSpeed;
    u_xlat0.yz = vec2(_Hue, _Contrast) + vec2(180.0, 100.0);
    u_xlat0.x = u_xlat0.x * u_xlat0.y;
    u_xlat0.xy = u_xlat0.xz * vec2(0.0174532924, 0.00999999978);
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat6.xyz = u_xlat16_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat6.xyz = u_xlat16_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat6.zxy);
    u_xlat0.xzw = u_xlat0.xxx * u_xlat6.xyz;
    u_xlat0.xzw = u_xlat16_2.xyz * u_xlat1.xxx + u_xlat0.xzw;
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat6.x = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat16_2.xyz);
    u_xlat6.x = u_xlat6.x * 0.57735002;
    u_xlat0.xzw = u_xlat6.xxx * u_xlat1.xxx + u_xlat0.xzw;
    u_xlat1.x = dot(u_xlat0.xzw, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat0.xzw = u_xlat0.xzw + (-u_xlat1.xxx);
    u_xlat6.x = _Saturation * 0.00999999978 + 1.0;
    u_xlat0.xzw = u_xlat6.xxx * u_xlat0.xzw + u_xlat1.xxx;
    u_xlat16_3.xyz = vec3(vec3(_Lightness, _Lightness, _Lightness)) * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat0.xzw;
    u_xlat16_3.xyz = u_xlat16_3.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat16_3.xyz = u_xlat0.yyy * u_xlat16_3.xyz + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.xyz = min(max(u_xlat16_3.xyz, 0.0), 1.0);
#else
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = u_xlat16_3.xyz * vec3(-2.0, -2.0, -2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vec3(_Invert) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * _PostColor.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = _PostColor.www * u_xlat0.xyz + u_xlat16_3.xyz;
    u_xlat1 = vs_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = vec4(vec4(_Intensity, _Intensity, _Intensity, _Intensity)) * u_xlat1 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0.xyz = (-u_xlat16_2.xyz) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1 = u_xlat1 * u_xlat16_2;
    u_xlat15 = _Intensity * _Blending;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat1.w;
    u_xlat15 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat15) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "USE_AUTO_COLOR_CHANGE" "USE_COLOR_ADJUST" "USE_DISTORTION" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DistTex_ST;
uniform 	float _DistFlowX;
uniform 	float _DistFlowY;
uniform 	float _TileIndex;
uniform 	float _FlipFactor;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = in_POSITION0.x * _FlipFactor;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat4 = u_xlat0.x * _TileIndex;
    u_xlatb4 = u_xlat4>=(-u_xlat4);
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2 = _TileIndex / u_xlat0.y;
    u_xlat2 = floor(u_xlat2);
    u_xlat1.y = (-u_xlat2) + in_TEXCOORD0.y;
    u_xlat2 = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat2 * _TileIndex;
    u_xlat2 = fract(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD0.xy * _DistTex_ST.xy + _DistTex_ST.zw;
    vs_TEXCOORD1.xy = vec2(_DistFlowX, _DistFlowY) * _Time.yy + u_xlat0.xy;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec4 _Time;
uniform 	float _Hue;
uniform 	float _Saturation;
uniform 	float _Lightness;
uniform 	float _Contrast;
uniform 	float _Invert;
uniform 	float _Blending;
uniform 	float _Intensity;
uniform 	vec4 _PostColor;
uniform 	float _AutoColChangeSpeed;
uniform 	float _Dist;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
uniform lowp sampler2D _DistTex;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
vec4 u_xlat1;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
lowp vec2 u_xlat10_5;
float u_xlat15;
void main()
{
    u_xlat0.x = _Hue + 180.0;
    u_xlat5.x = _Time.x * _AutoColChangeSpeed;
    u_xlat0.x = u_xlat5.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * 0.0174532924;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat10_5.xy = texture2D(_DistTex, vs_TEXCOORD1.xy).xy;
    u_xlat5.xy = u_xlat10_5.xy + vec2(-0.5, -0.5);
    u_xlat5.xy = u_xlat5.xy * vec2(vec2(_Dist, _Dist)) + vs_TEXCOORD0.xy;
    u_xlat10_2 = texture2D(_MainTex, u_xlat5.xy);
    u_xlat5.xyz = u_xlat10_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat5.xyz = u_xlat10_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat5.zxy);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz;
    u_xlat0.xyz = u_xlat10_2.xyz * u_xlat1.xxx + u_xlat0.xyz;
    u_xlat15 = (-u_xlat1.x) + 1.0;
    u_xlat1.x = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat10_2.xyz);
    u_xlat1.x = u_xlat1.x * 0.57735002;
    u_xlat0.xyz = u_xlat1.xxx * vec3(u_xlat15) + u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat0.xyz = (-vec3(u_xlat15)) + u_xlat0.xyz;
    u_xlat1.x = _Saturation * 0.00999999978 + 1.0;
    u_xlat0.xyz = u_xlat1.xxx * u_xlat0.xyz + vec3(u_xlat15);
    u_xlat16_3.xyz = vec3(_Lightness) * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat0.x = _Contrast + 100.0;
    u_xlat0.x = u_xlat0.x * 0.00999999978;
    u_xlat16_3.xyz = u_xlat0.xxx * u_xlat16_3.xyz + vec3(0.5, 0.5, 0.5);
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_3.xyz * vec3(-2.0, -2.0, -2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vec3(vec3(_Invert, _Invert, _Invert)) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * _PostColor.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = _PostColor.www * u_xlat0.xyz + u_xlat16_3.xyz;
    u_xlat1 = vs_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = vec4(_Intensity) * u_xlat1 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0.xyz = (-u_xlat10_2.xyz) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1 = u_xlat1 * u_xlat10_2;
    u_xlat15 = _Blending * _Intensity;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat1.w;
    u_xlat15 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat15) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "USE_AUTO_COLOR_CHANGE" "USE_COLOR_ADJUST" "USE_DISTORTION" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DistTex_ST;
uniform 	float _DistFlowX;
uniform 	float _DistFlowY;
uniform 	float _TileIndex;
uniform 	float _FlipFactor;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = in_POSITION0.x * _FlipFactor;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat4 = u_xlat0.x * _TileIndex;
    u_xlatb4 = u_xlat4>=(-u_xlat4);
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2 = _TileIndex / u_xlat0.y;
    u_xlat2 = floor(u_xlat2);
    u_xlat1.y = (-u_xlat2) + in_TEXCOORD0.y;
    u_xlat2 = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat2 * _TileIndex;
    u_xlat2 = fract(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD0.xy * _DistTex_ST.xy + _DistTex_ST.zw;
    vs_TEXCOORD1.xy = vec2(_DistFlowX, _DistFlowY) * _Time.yy + u_xlat0.xy;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec4 _Time;
uniform 	float _Hue;
uniform 	float _Saturation;
uniform 	float _Lightness;
uniform 	float _Contrast;
uniform 	float _Invert;
uniform 	float _Blending;
uniform 	float _Intensity;
uniform 	vec4 _PostColor;
uniform 	float _AutoColChangeSpeed;
uniform 	float _Dist;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
uniform lowp sampler2D _DistTex;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
vec4 u_xlat1;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
lowp vec2 u_xlat10_5;
float u_xlat15;
void main()
{
    u_xlat0.x = _Hue + 180.0;
    u_xlat5.x = _Time.x * _AutoColChangeSpeed;
    u_xlat0.x = u_xlat5.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * 0.0174532924;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat10_5.xy = texture2D(_DistTex, vs_TEXCOORD1.xy).xy;
    u_xlat5.xy = u_xlat10_5.xy + vec2(-0.5, -0.5);
    u_xlat5.xy = u_xlat5.xy * vec2(vec2(_Dist, _Dist)) + vs_TEXCOORD0.xy;
    u_xlat10_2 = texture2D(_MainTex, u_xlat5.xy);
    u_xlat5.xyz = u_xlat10_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat5.xyz = u_xlat10_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat5.zxy);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz;
    u_xlat0.xyz = u_xlat10_2.xyz * u_xlat1.xxx + u_xlat0.xyz;
    u_xlat15 = (-u_xlat1.x) + 1.0;
    u_xlat1.x = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat10_2.xyz);
    u_xlat1.x = u_xlat1.x * 0.57735002;
    u_xlat0.xyz = u_xlat1.xxx * vec3(u_xlat15) + u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat0.xyz = (-vec3(u_xlat15)) + u_xlat0.xyz;
    u_xlat1.x = _Saturation * 0.00999999978 + 1.0;
    u_xlat0.xyz = u_xlat1.xxx * u_xlat0.xyz + vec3(u_xlat15);
    u_xlat16_3.xyz = vec3(_Lightness) * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat0.x = _Contrast + 100.0;
    u_xlat0.x = u_xlat0.x * 0.00999999978;
    u_xlat16_3.xyz = u_xlat0.xxx * u_xlat16_3.xyz + vec3(0.5, 0.5, 0.5);
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_3.xyz * vec3(-2.0, -2.0, -2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vec3(vec3(_Invert, _Invert, _Invert)) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * _PostColor.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = _PostColor.www * u_xlat0.xyz + u_xlat16_3.xyz;
    u_xlat1 = vs_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = vec4(_Intensity) * u_xlat1 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0.xyz = (-u_xlat10_2.xyz) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1 = u_xlat1 * u_xlat10_2;
    u_xlat15 = _Blending * _Intensity;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat1.w;
    u_xlat15 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat15) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "USE_AUTO_COLOR_CHANGE" "USE_COLOR_ADJUST" "USE_DISTORTION" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DistTex_ST;
uniform 	float _DistFlowX;
uniform 	float _DistFlowY;
uniform 	float _TileIndex;
uniform 	float _FlipFactor;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = in_POSITION0.x * _FlipFactor;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat4 = u_xlat0.x * _TileIndex;
    u_xlatb4 = u_xlat4>=(-u_xlat4);
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2 = _TileIndex / u_xlat0.y;
    u_xlat2 = floor(u_xlat2);
    u_xlat1.y = (-u_xlat2) + in_TEXCOORD0.y;
    u_xlat2 = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat2 * _TileIndex;
    u_xlat2 = fract(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD0.xy * _DistTex_ST.xy + _DistTex_ST.zw;
    vs_TEXCOORD1.xy = vec2(_DistFlowX, _DistFlowY) * _Time.yy + u_xlat0.xy;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec4 _Time;
uniform 	float _Hue;
uniform 	float _Saturation;
uniform 	float _Lightness;
uniform 	float _Contrast;
uniform 	float _Invert;
uniform 	float _Blending;
uniform 	float _Intensity;
uniform 	vec4 _PostColor;
uniform 	float _AutoColChangeSpeed;
uniform 	float _Dist;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
uniform lowp sampler2D _DistTex;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
vec4 u_xlat1;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
lowp vec2 u_xlat10_5;
float u_xlat15;
void main()
{
    u_xlat0.x = _Hue + 180.0;
    u_xlat5.x = _Time.x * _AutoColChangeSpeed;
    u_xlat0.x = u_xlat5.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * 0.0174532924;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat10_5.xy = texture2D(_DistTex, vs_TEXCOORD1.xy).xy;
    u_xlat5.xy = u_xlat10_5.xy + vec2(-0.5, -0.5);
    u_xlat5.xy = u_xlat5.xy * vec2(vec2(_Dist, _Dist)) + vs_TEXCOORD0.xy;
    u_xlat10_2 = texture2D(_MainTex, u_xlat5.xy);
    u_xlat5.xyz = u_xlat10_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat5.xyz = u_xlat10_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat5.zxy);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz;
    u_xlat0.xyz = u_xlat10_2.xyz * u_xlat1.xxx + u_xlat0.xyz;
    u_xlat15 = (-u_xlat1.x) + 1.0;
    u_xlat1.x = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat10_2.xyz);
    u_xlat1.x = u_xlat1.x * 0.57735002;
    u_xlat0.xyz = u_xlat1.xxx * vec3(u_xlat15) + u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat0.xyz = (-vec3(u_xlat15)) + u_xlat0.xyz;
    u_xlat1.x = _Saturation * 0.00999999978 + 1.0;
    u_xlat0.xyz = u_xlat1.xxx * u_xlat0.xyz + vec3(u_xlat15);
    u_xlat16_3.xyz = vec3(_Lightness) * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat0.x = _Contrast + 100.0;
    u_xlat0.x = u_xlat0.x * 0.00999999978;
    u_xlat16_3.xyz = u_xlat0.xxx * u_xlat16_3.xyz + vec3(0.5, 0.5, 0.5);
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_3.xyz * vec3(-2.0, -2.0, -2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vec3(vec3(_Invert, _Invert, _Invert)) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * _PostColor.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = _PostColor.www * u_xlat0.xyz + u_xlat16_3.xyz;
    u_xlat1 = vs_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = vec4(_Intensity) * u_xlat1 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0.xyz = (-u_xlat10_2.xyz) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1 = u_xlat1 * u_xlat10_2;
    u_xlat15 = _Blending * _Intensity;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat1.w;
    u_xlat15 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat15) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "USE_DISTORTION" }
"#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DistTex_ST;
uniform 	float _DistFlowX;
uniform 	float _DistFlowY;
uniform 	float _TileIndex;
uniform 	float _FlipFactor;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = in_POSITION0.x * _FlipFactor;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat4 = u_xlat0.x * _TileIndex;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4>=(-u_xlat4));
#else
    u_xlatb4 = u_xlat4>=(-u_xlat4);
#endif
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2 = _TileIndex / u_xlat0.y;
    u_xlat2 = floor(u_xlat2);
    u_xlat1.y = (-u_xlat2) + in_TEXCOORD0.y;
    u_xlat2 = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat2 * _TileIndex;
    u_xlat2 = fract(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD0.xy * _DistTex_ST.xy + _DistTex_ST.zw;
    vs_TEXCOORD1.xy = vec2(_DistFlowX, _DistFlowY) * _Time.yy + u_xlat0.xy;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	float _Dist;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
UNITY_LOCATION(0) uniform mediump sampler2D _DistTex;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat16_0.xy = texture(_DistTex, vs_TEXCOORD1.xy).xy;
    u_xlat0.xy = u_xlat16_0.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_Dist, _Dist)) + vs_TEXCOORD0.xy;
    u_xlat16_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat0.w;
    u_xlat6 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat6) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "USE_DISTORTION" }
"#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DistTex_ST;
uniform 	float _DistFlowX;
uniform 	float _DistFlowY;
uniform 	float _TileIndex;
uniform 	float _FlipFactor;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = in_POSITION0.x * _FlipFactor;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat4 = u_xlat0.x * _TileIndex;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4>=(-u_xlat4));
#else
    u_xlatb4 = u_xlat4>=(-u_xlat4);
#endif
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2 = _TileIndex / u_xlat0.y;
    u_xlat2 = floor(u_xlat2);
    u_xlat1.y = (-u_xlat2) + in_TEXCOORD0.y;
    u_xlat2 = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat2 * _TileIndex;
    u_xlat2 = fract(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD0.xy * _DistTex_ST.xy + _DistTex_ST.zw;
    vs_TEXCOORD1.xy = vec2(_DistFlowX, _DistFlowY) * _Time.yy + u_xlat0.xy;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	float _Dist;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
UNITY_LOCATION(0) uniform mediump sampler2D _DistTex;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat16_0.xy = texture(_DistTex, vs_TEXCOORD1.xy).xy;
    u_xlat0.xy = u_xlat16_0.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_Dist, _Dist)) + vs_TEXCOORD0.xy;
    u_xlat16_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat0.w;
    u_xlat6 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat6) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "USE_DISTORTION" }
"#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DistTex_ST;
uniform 	float _DistFlowX;
uniform 	float _DistFlowY;
uniform 	float _TileIndex;
uniform 	float _FlipFactor;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = in_POSITION0.x * _FlipFactor;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat4 = u_xlat0.x * _TileIndex;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4>=(-u_xlat4));
#else
    u_xlatb4 = u_xlat4>=(-u_xlat4);
#endif
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2 = _TileIndex / u_xlat0.y;
    u_xlat2 = floor(u_xlat2);
    u_xlat1.y = (-u_xlat2) + in_TEXCOORD0.y;
    u_xlat2 = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat2 * _TileIndex;
    u_xlat2 = fract(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD0.xy * _DistTex_ST.xy + _DistTex_ST.zw;
    vs_TEXCOORD1.xy = vec2(_DistFlowX, _DistFlowY) * _Time.yy + u_xlat0.xy;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	float _Dist;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
UNITY_LOCATION(0) uniform mediump sampler2D _DistTex;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat16_0.xy = texture(_DistTex, vs_TEXCOORD1.xy).xy;
    u_xlat0.xy = u_xlat16_0.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_Dist, _Dist)) + vs_TEXCOORD0.xy;
    u_xlat16_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat0.w;
    u_xlat6 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat6) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "USE_VERT_ANI" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _WaveScale;
uniform 	float _WaveSpd;
uniform 	float _WaveDist;
uniform 	float _TileIndex;
uniform 	float _FlipFactor;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = _Time.y * _WaveSpd;
    u_xlat0.x = in_POSITION0.y * _WaveDist + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _WaveScale;
    u_xlat0.x = in_POSITION0.x * _FlipFactor + u_xlat0.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat4 = u_xlat0.x * _TileIndex;
    u_xlatb4 = u_xlat4>=(-u_xlat4);
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2 = _TileIndex / u_xlat0.y;
    u_xlat2 = floor(u_xlat2);
    u_xlat1.y = (-u_xlat2) + in_TEXCOORD0.y;
    u_xlat2 = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat2 * _TileIndex;
    u_xlat2 = fract(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
float u_xlat0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
void main()
{
    u_xlat0 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat10_1 * vs_COLOR0;
    u_xlat2.xyz = _AdditiveColor.xyz * u_xlat1.www + (-u_xlat1.xyz);
    u_xlat2.xyz = _AdditiveColor.www * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat1.www + (-u_xlat2.xyz);
    SV_Target0.xyz = vec3(u_xlat0) * u_xlat1.xyz + u_xlat2.xyz;
    SV_Target0.w = u_xlat1.w;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "USE_VERT_ANI" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _WaveScale;
uniform 	float _WaveSpd;
uniform 	float _WaveDist;
uniform 	float _TileIndex;
uniform 	float _FlipFactor;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = _Time.y * _WaveSpd;
    u_xlat0.x = in_POSITION0.y * _WaveDist + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _WaveScale;
    u_xlat0.x = in_POSITION0.x * _FlipFactor + u_xlat0.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat4 = u_xlat0.x * _TileIndex;
    u_xlatb4 = u_xlat4>=(-u_xlat4);
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2 = _TileIndex / u_xlat0.y;
    u_xlat2 = floor(u_xlat2);
    u_xlat1.y = (-u_xlat2) + in_TEXCOORD0.y;
    u_xlat2 = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat2 * _TileIndex;
    u_xlat2 = fract(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
float u_xlat0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
void main()
{
    u_xlat0 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat10_1 * vs_COLOR0;
    u_xlat2.xyz = _AdditiveColor.xyz * u_xlat1.www + (-u_xlat1.xyz);
    u_xlat2.xyz = _AdditiveColor.www * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat1.www + (-u_xlat2.xyz);
    SV_Target0.xyz = vec3(u_xlat0) * u_xlat1.xyz + u_xlat2.xyz;
    SV_Target0.w = u_xlat1.w;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "USE_VERT_ANI" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _WaveScale;
uniform 	float _WaveSpd;
uniform 	float _WaveDist;
uniform 	float _TileIndex;
uniform 	float _FlipFactor;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = _Time.y * _WaveSpd;
    u_xlat0.x = in_POSITION0.y * _WaveDist + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _WaveScale;
    u_xlat0.x = in_POSITION0.x * _FlipFactor + u_xlat0.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat4 = u_xlat0.x * _TileIndex;
    u_xlatb4 = u_xlat4>=(-u_xlat4);
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2 = _TileIndex / u_xlat0.y;
    u_xlat2 = floor(u_xlat2);
    u_xlat1.y = (-u_xlat2) + in_TEXCOORD0.y;
    u_xlat2 = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat2 * _TileIndex;
    u_xlat2 = fract(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
float u_xlat0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
void main()
{
    u_xlat0 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat10_1 * vs_COLOR0;
    u_xlat2.xyz = _AdditiveColor.xyz * u_xlat1.www + (-u_xlat1.xyz);
    u_xlat2.xyz = _AdditiveColor.www * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat1.www + (-u_xlat2.xyz);
    SV_Target0.xyz = vec3(u_xlat0) * u_xlat1.xyz + u_xlat2.xyz;
    SV_Target0.w = u_xlat1.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "INSTANCING_ON" "USE_DISTORTION" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DistTex_ST;
uniform 	float _DistFlowX;
uniform 	float _DistFlowY;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
struct PropsArray_Type {
	float _Dist;
	float _TileIndex;
	float _FlipFactor;
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_Props {
#endif
	UNITY_UNIFORM PropsArray_Type PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
vec2 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
float u_xlat6;
int u_xlati6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat3.x = in_POSITION0.x * PropsArray[u_xlati0]._FlipFactor;
    u_xlati6 = int(u_xlati0 << 3);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat3.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat3.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat9 = u_xlat3.x * PropsArray[u_xlati0]._TileIndex;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat9>=(-u_xlat9));
#else
    u_xlatb9 = u_xlat9>=(-u_xlat9);
#endif
    u_xlat3.x = (u_xlatb9) ? u_xlat3.x : (-u_xlat3.x);
    u_xlat6 = PropsArray[u_xlati0]._TileIndex / u_xlat3.y;
    u_xlat6 = floor(u_xlat6);
    u_xlat1.y = (-u_xlat6) + in_TEXCOORD0.y;
    u_xlat6 = float(1.0) / u_xlat3.x;
    u_xlat0.x = u_xlat6 * PropsArray[u_xlati0]._TileIndex;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD0.xy * _DistTex_ST.xy + _DistTex_ST.zw;
    vs_TEXCOORD1.xy = vec2(_DistFlowX, _DistFlowY) * _Time.yy + u_xlat0.xy;
    vs_COLOR0 = in_COLOR0;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
struct PropsArray_Type {
	float _Dist;
	float _TileIndex;
	float _FlipFactor;
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_Props {
#endif
	UNITY_UNIFORM PropsArray_Type PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _DistTex;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
int u_xlati4;
float u_xlat6;
void main()
{
    u_xlat16_0.xy = texture(_DistTex, vs_TEXCOORD1.xy).xy;
    u_xlat0.xy = u_xlat16_0.xy + vec2(-0.5, -0.5);
    u_xlati4 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat0.xy = u_xlat0.xy * vec2(PropsArray[u_xlati4]._Dist) + vs_TEXCOORD0.xy;
    u_xlat16_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat0.w;
    u_xlat6 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat6) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "INSTANCING_ON" "USE_DISTORTION" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DistTex_ST;
uniform 	float _DistFlowX;
uniform 	float _DistFlowY;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
struct PropsArray_Type {
	float _Dist;
	float _TileIndex;
	float _FlipFactor;
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_Props {
#endif
	UNITY_UNIFORM PropsArray_Type PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
vec2 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
float u_xlat6;
int u_xlati6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat3.x = in_POSITION0.x * PropsArray[u_xlati0]._FlipFactor;
    u_xlati6 = int(u_xlati0 << 3);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat3.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat3.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat9 = u_xlat3.x * PropsArray[u_xlati0]._TileIndex;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat9>=(-u_xlat9));
#else
    u_xlatb9 = u_xlat9>=(-u_xlat9);
#endif
    u_xlat3.x = (u_xlatb9) ? u_xlat3.x : (-u_xlat3.x);
    u_xlat6 = PropsArray[u_xlati0]._TileIndex / u_xlat3.y;
    u_xlat6 = floor(u_xlat6);
    u_xlat1.y = (-u_xlat6) + in_TEXCOORD0.y;
    u_xlat6 = float(1.0) / u_xlat3.x;
    u_xlat0.x = u_xlat6 * PropsArray[u_xlati0]._TileIndex;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD0.xy * _DistTex_ST.xy + _DistTex_ST.zw;
    vs_TEXCOORD1.xy = vec2(_DistFlowX, _DistFlowY) * _Time.yy + u_xlat0.xy;
    vs_COLOR0 = in_COLOR0;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
struct PropsArray_Type {
	float _Dist;
	float _TileIndex;
	float _FlipFactor;
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_Props {
#endif
	UNITY_UNIFORM PropsArray_Type PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _DistTex;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
int u_xlati4;
float u_xlat6;
void main()
{
    u_xlat16_0.xy = texture(_DistTex, vs_TEXCOORD1.xy).xy;
    u_xlat0.xy = u_xlat16_0.xy + vec2(-0.5, -0.5);
    u_xlati4 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat0.xy = u_xlat0.xy * vec2(PropsArray[u_xlati4]._Dist) + vs_TEXCOORD0.xy;
    u_xlat16_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat0.w;
    u_xlat6 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat6) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "INSTANCING_ON" "USE_DISTORTION" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DistTex_ST;
uniform 	float _DistFlowX;
uniform 	float _DistFlowY;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
struct PropsArray_Type {
	float _Dist;
	float _TileIndex;
	float _FlipFactor;
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_Props {
#endif
	UNITY_UNIFORM PropsArray_Type PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
vec2 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
float u_xlat6;
int u_xlati6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat3.x = in_POSITION0.x * PropsArray[u_xlati0]._FlipFactor;
    u_xlati6 = int(u_xlati0 << 3);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat3.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat3.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat9 = u_xlat3.x * PropsArray[u_xlati0]._TileIndex;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat9>=(-u_xlat9));
#else
    u_xlatb9 = u_xlat9>=(-u_xlat9);
#endif
    u_xlat3.x = (u_xlatb9) ? u_xlat3.x : (-u_xlat3.x);
    u_xlat6 = PropsArray[u_xlati0]._TileIndex / u_xlat3.y;
    u_xlat6 = floor(u_xlat6);
    u_xlat1.y = (-u_xlat6) + in_TEXCOORD0.y;
    u_xlat6 = float(1.0) / u_xlat3.x;
    u_xlat0.x = u_xlat6 * PropsArray[u_xlati0]._TileIndex;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD0.xy * _DistTex_ST.xy + _DistTex_ST.zw;
    vs_TEXCOORD1.xy = vec2(_DistFlowX, _DistFlowY) * _Time.yy + u_xlat0.xy;
    vs_COLOR0 = in_COLOR0;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
struct PropsArray_Type {
	float _Dist;
	float _TileIndex;
	float _FlipFactor;
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_Props {
#endif
	UNITY_UNIFORM PropsArray_Type PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _DistTex;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
int u_xlati4;
float u_xlat6;
void main()
{
    u_xlat16_0.xy = texture(_DistTex, vs_TEXCOORD1.xy).xy;
    u_xlat0.xy = u_xlat16_0.xy + vec2(-0.5, -0.5);
    u_xlati4 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat0.xy = u_xlat0.xy * vec2(PropsArray[u_xlati4]._Dist) + vs_TEXCOORD0.xy;
    u_xlat16_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat0.w;
    u_xlat6 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat6) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "USE_AUTO_COLOR_CHANGE" "USE_VERT_ANI" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _WaveScale;
uniform 	float _WaveSpd;
uniform 	float _WaveDist;
uniform 	float _TileIndex;
uniform 	float _FlipFactor;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = _Time.y * _WaveSpd;
    u_xlat0.x = in_POSITION0.y * _WaveDist + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _WaveScale;
    u_xlat0.x = in_POSITION0.x * _FlipFactor + u_xlat0.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat4 = u_xlat0.x * _TileIndex;
    u_xlatb4 = u_xlat4>=(-u_xlat4);
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2 = _TileIndex / u_xlat0.y;
    u_xlat2 = floor(u_xlat2);
    u_xlat1.y = (-u_xlat2) + in_TEXCOORD0.y;
    u_xlat2 = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat2 * _TileIndex;
    u_xlat2 = fract(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
float u_xlat0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
void main()
{
    u_xlat0 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat10_1 * vs_COLOR0;
    u_xlat2.xyz = _AdditiveColor.xyz * u_xlat1.www + (-u_xlat1.xyz);
    u_xlat2.xyz = _AdditiveColor.www * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat1.www + (-u_xlat2.xyz);
    SV_Target0.xyz = vec3(u_xlat0) * u_xlat1.xyz + u_xlat2.xyz;
    SV_Target0.w = u_xlat1.w;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "USE_AUTO_COLOR_CHANGE" "USE_VERT_ANI" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _WaveScale;
uniform 	float _WaveSpd;
uniform 	float _WaveDist;
uniform 	float _TileIndex;
uniform 	float _FlipFactor;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = _Time.y * _WaveSpd;
    u_xlat0.x = in_POSITION0.y * _WaveDist + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _WaveScale;
    u_xlat0.x = in_POSITION0.x * _FlipFactor + u_xlat0.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat4 = u_xlat0.x * _TileIndex;
    u_xlatb4 = u_xlat4>=(-u_xlat4);
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2 = _TileIndex / u_xlat0.y;
    u_xlat2 = floor(u_xlat2);
    u_xlat1.y = (-u_xlat2) + in_TEXCOORD0.y;
    u_xlat2 = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat2 * _TileIndex;
    u_xlat2 = fract(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
float u_xlat0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
void main()
{
    u_xlat0 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat10_1 * vs_COLOR0;
    u_xlat2.xyz = _AdditiveColor.xyz * u_xlat1.www + (-u_xlat1.xyz);
    u_xlat2.xyz = _AdditiveColor.www * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat1.www + (-u_xlat2.xyz);
    SV_Target0.xyz = vec3(u_xlat0) * u_xlat1.xyz + u_xlat2.xyz;
    SV_Target0.w = u_xlat1.w;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "USE_AUTO_COLOR_CHANGE" "USE_VERT_ANI" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _WaveScale;
uniform 	float _WaveSpd;
uniform 	float _WaveDist;
uniform 	float _TileIndex;
uniform 	float _FlipFactor;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = _Time.y * _WaveSpd;
    u_xlat0.x = in_POSITION0.y * _WaveDist + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _WaveScale;
    u_xlat0.x = in_POSITION0.x * _FlipFactor + u_xlat0.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat4 = u_xlat0.x * _TileIndex;
    u_xlatb4 = u_xlat4>=(-u_xlat4);
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2 = _TileIndex / u_xlat0.y;
    u_xlat2 = floor(u_xlat2);
    u_xlat1.y = (-u_xlat2) + in_TEXCOORD0.y;
    u_xlat2 = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat2 * _TileIndex;
    u_xlat2 = fract(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
float u_xlat0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
void main()
{
    u_xlat0 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    u_xlat10_1 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat10_1 * vs_COLOR0;
    u_xlat2.xyz = _AdditiveColor.xyz * u_xlat1.www + (-u_xlat1.xyz);
    u_xlat2.xyz = _AdditiveColor.www * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat1.www + (-u_xlat2.xyz);
    SV_Target0.xyz = vec3(u_xlat0) * u_xlat1.xyz + u_xlat2.xyz;
    SV_Target0.w = u_xlat1.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "USE_AUTO_COLOR_CHANGE" "USE_DISTORTION" }
"#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DistTex_ST;
uniform 	float _DistFlowX;
uniform 	float _DistFlowY;
uniform 	float _TileIndex;
uniform 	float _FlipFactor;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = in_POSITION0.x * _FlipFactor;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat4 = u_xlat0.x * _TileIndex;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4>=(-u_xlat4));
#else
    u_xlatb4 = u_xlat4>=(-u_xlat4);
#endif
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2 = _TileIndex / u_xlat0.y;
    u_xlat2 = floor(u_xlat2);
    u_xlat1.y = (-u_xlat2) + in_TEXCOORD0.y;
    u_xlat2 = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat2 * _TileIndex;
    u_xlat2 = fract(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD0.xy * _DistTex_ST.xy + _DistTex_ST.zw;
    vs_TEXCOORD1.xy = vec2(_DistFlowX, _DistFlowY) * _Time.yy + u_xlat0.xy;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	float _Dist;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
UNITY_LOCATION(0) uniform mediump sampler2D _DistTex;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat16_0.xy = texture(_DistTex, vs_TEXCOORD1.xy).xy;
    u_xlat0.xy = u_xlat16_0.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_Dist, _Dist)) + vs_TEXCOORD0.xy;
    u_xlat16_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat0.w;
    u_xlat6 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat6) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "USE_AUTO_COLOR_CHANGE" "USE_DISTORTION" }
"#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DistTex_ST;
uniform 	float _DistFlowX;
uniform 	float _DistFlowY;
uniform 	float _TileIndex;
uniform 	float _FlipFactor;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = in_POSITION0.x * _FlipFactor;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat4 = u_xlat0.x * _TileIndex;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4>=(-u_xlat4));
#else
    u_xlatb4 = u_xlat4>=(-u_xlat4);
#endif
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2 = _TileIndex / u_xlat0.y;
    u_xlat2 = floor(u_xlat2);
    u_xlat1.y = (-u_xlat2) + in_TEXCOORD0.y;
    u_xlat2 = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat2 * _TileIndex;
    u_xlat2 = fract(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD0.xy * _DistTex_ST.xy + _DistTex_ST.zw;
    vs_TEXCOORD1.xy = vec2(_DistFlowX, _DistFlowY) * _Time.yy + u_xlat0.xy;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	float _Dist;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
UNITY_LOCATION(0) uniform mediump sampler2D _DistTex;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat16_0.xy = texture(_DistTex, vs_TEXCOORD1.xy).xy;
    u_xlat0.xy = u_xlat16_0.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_Dist, _Dist)) + vs_TEXCOORD0.xy;
    u_xlat16_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat0.w;
    u_xlat6 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat6) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "USE_AUTO_COLOR_CHANGE" "USE_DISTORTION" }
"#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DistTex_ST;
uniform 	float _DistFlowX;
uniform 	float _DistFlowY;
uniform 	float _TileIndex;
uniform 	float _FlipFactor;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = in_POSITION0.x * _FlipFactor;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat4 = u_xlat0.x * _TileIndex;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4>=(-u_xlat4));
#else
    u_xlatb4 = u_xlat4>=(-u_xlat4);
#endif
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2 = _TileIndex / u_xlat0.y;
    u_xlat2 = floor(u_xlat2);
    u_xlat1.y = (-u_xlat2) + in_TEXCOORD0.y;
    u_xlat2 = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat2 * _TileIndex;
    u_xlat2 = fract(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD0.xy * _DistTex_ST.xy + _DistTex_ST.zw;
    vs_TEXCOORD1.xy = vec2(_DistFlowX, _DistFlowY) * _Time.yy + u_xlat0.xy;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	float _Dist;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
UNITY_LOCATION(0) uniform mediump sampler2D _DistTex;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat16_0.xy = texture(_DistTex, vs_TEXCOORD1.xy).xy;
    u_xlat0.xy = u_xlat16_0.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_Dist, _Dist)) + vs_TEXCOORD0.xy;
    u_xlat16_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat0.w;
    u_xlat6 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat6) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "USE_COLOR_ADJUST" "USE_VERT_ANI" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _WaveScale;
uniform 	float _WaveSpd;
uniform 	float _WaveDist;
uniform 	float _TileIndex;
uniform 	float _FlipFactor;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = _Time.y * _WaveSpd;
    u_xlat0.x = in_POSITION0.y * _WaveDist + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _WaveScale;
    u_xlat0.x = in_POSITION0.x * _FlipFactor + u_xlat0.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat4 = u_xlat0.x * _TileIndex;
    u_xlatb4 = u_xlat4>=(-u_xlat4);
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2 = _TileIndex / u_xlat0.y;
    u_xlat2 = floor(u_xlat2);
    u_xlat1.y = (-u_xlat2) + in_TEXCOORD0.y;
    u_xlat2 = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat2 * _TileIndex;
    u_xlat2 = fract(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	float _Hue;
uniform 	float _Saturation;
uniform 	float _Lightness;
uniform 	float _Contrast;
uniform 	float _Invert;
uniform 	float _Blending;
uniform 	float _Intensity;
uniform 	vec4 _PostColor;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
vec4 u_xlat1;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
float u_xlat15;
void main()
{
    u_xlat0.x = _Hue * 0.0174532924;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat5.xyz = u_xlat10_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat5.xyz = u_xlat10_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat5.zxy);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz;
    u_xlat0.xyz = u_xlat10_2.xyz * u_xlat1.xxx + u_xlat0.xyz;
    u_xlat15 = (-u_xlat1.x) + 1.0;
    u_xlat1.x = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat10_2.xyz);
    u_xlat1.x = u_xlat1.x * 0.57735002;
    u_xlat0.xyz = u_xlat1.xxx * vec3(u_xlat15) + u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat0.xyz = (-vec3(u_xlat15)) + u_xlat0.xyz;
    u_xlat1.x = _Saturation * 0.00999999978 + 1.0;
    u_xlat0.xyz = u_xlat1.xxx * u_xlat0.xyz + vec3(u_xlat15);
    u_xlat16_3.xyz = vec3(vec3(_Lightness, _Lightness, _Lightness)) * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat0.x = _Contrast + 100.0;
    u_xlat0.x = u_xlat0.x * 0.00999999978;
    u_xlat16_3.xyz = u_xlat0.xxx * u_xlat16_3.xyz + vec3(0.5, 0.5, 0.5);
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_3.xyz * vec3(-2.0, -2.0, -2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vec3(_Invert) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * _PostColor.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = _PostColor.www * u_xlat0.xyz + u_xlat16_3.xyz;
    u_xlat1 = vs_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = vec4(vec4(_Intensity, _Intensity, _Intensity, _Intensity)) * u_xlat1 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0.xyz = (-u_xlat10_2.xyz) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1 = u_xlat1 * u_xlat10_2;
    u_xlat15 = _Intensity * _Blending;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat1.w;
    u_xlat15 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat15) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "USE_COLOR_ADJUST" "USE_VERT_ANI" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _WaveScale;
uniform 	float _WaveSpd;
uniform 	float _WaveDist;
uniform 	float _TileIndex;
uniform 	float _FlipFactor;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = _Time.y * _WaveSpd;
    u_xlat0.x = in_POSITION0.y * _WaveDist + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _WaveScale;
    u_xlat0.x = in_POSITION0.x * _FlipFactor + u_xlat0.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat4 = u_xlat0.x * _TileIndex;
    u_xlatb4 = u_xlat4>=(-u_xlat4);
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2 = _TileIndex / u_xlat0.y;
    u_xlat2 = floor(u_xlat2);
    u_xlat1.y = (-u_xlat2) + in_TEXCOORD0.y;
    u_xlat2 = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat2 * _TileIndex;
    u_xlat2 = fract(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	float _Hue;
uniform 	float _Saturation;
uniform 	float _Lightness;
uniform 	float _Contrast;
uniform 	float _Invert;
uniform 	float _Blending;
uniform 	float _Intensity;
uniform 	vec4 _PostColor;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
vec4 u_xlat1;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
float u_xlat15;
void main()
{
    u_xlat0.x = _Hue * 0.0174532924;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat5.xyz = u_xlat10_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat5.xyz = u_xlat10_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat5.zxy);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz;
    u_xlat0.xyz = u_xlat10_2.xyz * u_xlat1.xxx + u_xlat0.xyz;
    u_xlat15 = (-u_xlat1.x) + 1.0;
    u_xlat1.x = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat10_2.xyz);
    u_xlat1.x = u_xlat1.x * 0.57735002;
    u_xlat0.xyz = u_xlat1.xxx * vec3(u_xlat15) + u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat0.xyz = (-vec3(u_xlat15)) + u_xlat0.xyz;
    u_xlat1.x = _Saturation * 0.00999999978 + 1.0;
    u_xlat0.xyz = u_xlat1.xxx * u_xlat0.xyz + vec3(u_xlat15);
    u_xlat16_3.xyz = vec3(vec3(_Lightness, _Lightness, _Lightness)) * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat0.x = _Contrast + 100.0;
    u_xlat0.x = u_xlat0.x * 0.00999999978;
    u_xlat16_3.xyz = u_xlat0.xxx * u_xlat16_3.xyz + vec3(0.5, 0.5, 0.5);
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_3.xyz * vec3(-2.0, -2.0, -2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vec3(_Invert) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * _PostColor.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = _PostColor.www * u_xlat0.xyz + u_xlat16_3.xyz;
    u_xlat1 = vs_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = vec4(vec4(_Intensity, _Intensity, _Intensity, _Intensity)) * u_xlat1 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0.xyz = (-u_xlat10_2.xyz) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1 = u_xlat1 * u_xlat10_2;
    u_xlat15 = _Intensity * _Blending;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat1.w;
    u_xlat15 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat15) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "USE_COLOR_ADJUST" "USE_VERT_ANI" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _WaveScale;
uniform 	float _WaveSpd;
uniform 	float _WaveDist;
uniform 	float _TileIndex;
uniform 	float _FlipFactor;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = _Time.y * _WaveSpd;
    u_xlat0.x = in_POSITION0.y * _WaveDist + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _WaveScale;
    u_xlat0.x = in_POSITION0.x * _FlipFactor + u_xlat0.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat4 = u_xlat0.x * _TileIndex;
    u_xlatb4 = u_xlat4>=(-u_xlat4);
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2 = _TileIndex / u_xlat0.y;
    u_xlat2 = floor(u_xlat2);
    u_xlat1.y = (-u_xlat2) + in_TEXCOORD0.y;
    u_xlat2 = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat2 * _TileIndex;
    u_xlat2 = fract(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	float _Hue;
uniform 	float _Saturation;
uniform 	float _Lightness;
uniform 	float _Contrast;
uniform 	float _Invert;
uniform 	float _Blending;
uniform 	float _Intensity;
uniform 	vec4 _PostColor;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
vec4 u_xlat1;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
float u_xlat15;
void main()
{
    u_xlat0.x = _Hue * 0.0174532924;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat5.xyz = u_xlat10_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat5.xyz = u_xlat10_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat5.zxy);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz;
    u_xlat0.xyz = u_xlat10_2.xyz * u_xlat1.xxx + u_xlat0.xyz;
    u_xlat15 = (-u_xlat1.x) + 1.0;
    u_xlat1.x = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat10_2.xyz);
    u_xlat1.x = u_xlat1.x * 0.57735002;
    u_xlat0.xyz = u_xlat1.xxx * vec3(u_xlat15) + u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat0.xyz = (-vec3(u_xlat15)) + u_xlat0.xyz;
    u_xlat1.x = _Saturation * 0.00999999978 + 1.0;
    u_xlat0.xyz = u_xlat1.xxx * u_xlat0.xyz + vec3(u_xlat15);
    u_xlat16_3.xyz = vec3(vec3(_Lightness, _Lightness, _Lightness)) * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat0.x = _Contrast + 100.0;
    u_xlat0.x = u_xlat0.x * 0.00999999978;
    u_xlat16_3.xyz = u_xlat0.xxx * u_xlat16_3.xyz + vec3(0.5, 0.5, 0.5);
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_3.xyz * vec3(-2.0, -2.0, -2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vec3(_Invert) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * _PostColor.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = _PostColor.www * u_xlat0.xyz + u_xlat16_3.xyz;
    u_xlat1 = vs_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = vec4(vec4(_Intensity, _Intensity, _Intensity, _Intensity)) * u_xlat1 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0.xyz = (-u_xlat10_2.xyz) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1 = u_xlat1 * u_xlat10_2;
    u_xlat15 = _Intensity * _Blending;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat1.w;
    u_xlat15 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat15) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "INSTANCING_ON" "USE_AUTO_COLOR_CHANGE" "USE_DISTORTION" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DistTex_ST;
uniform 	float _DistFlowX;
uniform 	float _DistFlowY;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
struct PropsArray_Type {
	float _Dist;
	float _TileIndex;
	float _FlipFactor;
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_Props {
#endif
	UNITY_UNIFORM PropsArray_Type PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
vec2 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
float u_xlat6;
int u_xlati6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat3.x = in_POSITION0.x * PropsArray[u_xlati0]._FlipFactor;
    u_xlati6 = int(u_xlati0 << 3);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat3.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat3.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat9 = u_xlat3.x * PropsArray[u_xlati0]._TileIndex;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat9>=(-u_xlat9));
#else
    u_xlatb9 = u_xlat9>=(-u_xlat9);
#endif
    u_xlat3.x = (u_xlatb9) ? u_xlat3.x : (-u_xlat3.x);
    u_xlat6 = PropsArray[u_xlati0]._TileIndex / u_xlat3.y;
    u_xlat6 = floor(u_xlat6);
    u_xlat1.y = (-u_xlat6) + in_TEXCOORD0.y;
    u_xlat6 = float(1.0) / u_xlat3.x;
    u_xlat0.x = u_xlat6 * PropsArray[u_xlati0]._TileIndex;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD0.xy * _DistTex_ST.xy + _DistTex_ST.zw;
    vs_TEXCOORD1.xy = vec2(_DistFlowX, _DistFlowY) * _Time.yy + u_xlat0.xy;
    vs_COLOR0 = in_COLOR0;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
struct PropsArray_Type {
	float _Dist;
	float _TileIndex;
	float _FlipFactor;
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_Props {
#endif
	UNITY_UNIFORM PropsArray_Type PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _DistTex;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
int u_xlati4;
float u_xlat6;
void main()
{
    u_xlat16_0.xy = texture(_DistTex, vs_TEXCOORD1.xy).xy;
    u_xlat0.xy = u_xlat16_0.xy + vec2(-0.5, -0.5);
    u_xlati4 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat0.xy = u_xlat0.xy * vec2(PropsArray[u_xlati4]._Dist) + vs_TEXCOORD0.xy;
    u_xlat16_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat0.w;
    u_xlat6 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat6) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "INSTANCING_ON" "USE_AUTO_COLOR_CHANGE" "USE_DISTORTION" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DistTex_ST;
uniform 	float _DistFlowX;
uniform 	float _DistFlowY;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
struct PropsArray_Type {
	float _Dist;
	float _TileIndex;
	float _FlipFactor;
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_Props {
#endif
	UNITY_UNIFORM PropsArray_Type PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
vec2 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
float u_xlat6;
int u_xlati6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat3.x = in_POSITION0.x * PropsArray[u_xlati0]._FlipFactor;
    u_xlati6 = int(u_xlati0 << 3);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat3.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat3.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat9 = u_xlat3.x * PropsArray[u_xlati0]._TileIndex;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat9>=(-u_xlat9));
#else
    u_xlatb9 = u_xlat9>=(-u_xlat9);
#endif
    u_xlat3.x = (u_xlatb9) ? u_xlat3.x : (-u_xlat3.x);
    u_xlat6 = PropsArray[u_xlati0]._TileIndex / u_xlat3.y;
    u_xlat6 = floor(u_xlat6);
    u_xlat1.y = (-u_xlat6) + in_TEXCOORD0.y;
    u_xlat6 = float(1.0) / u_xlat3.x;
    u_xlat0.x = u_xlat6 * PropsArray[u_xlati0]._TileIndex;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD0.xy * _DistTex_ST.xy + _DistTex_ST.zw;
    vs_TEXCOORD1.xy = vec2(_DistFlowX, _DistFlowY) * _Time.yy + u_xlat0.xy;
    vs_COLOR0 = in_COLOR0;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
struct PropsArray_Type {
	float _Dist;
	float _TileIndex;
	float _FlipFactor;
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_Props {
#endif
	UNITY_UNIFORM PropsArray_Type PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _DistTex;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
int u_xlati4;
float u_xlat6;
void main()
{
    u_xlat16_0.xy = texture(_DistTex, vs_TEXCOORD1.xy).xy;
    u_xlat0.xy = u_xlat16_0.xy + vec2(-0.5, -0.5);
    u_xlati4 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat0.xy = u_xlat0.xy * vec2(PropsArray[u_xlati4]._Dist) + vs_TEXCOORD0.xy;
    u_xlat16_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat0.w;
    u_xlat6 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat6) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "INSTANCING_ON" "USE_AUTO_COLOR_CHANGE" "USE_DISTORTION" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DistTex_ST;
uniform 	float _DistFlowX;
uniform 	float _DistFlowY;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
struct PropsArray_Type {
	float _Dist;
	float _TileIndex;
	float _FlipFactor;
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_Props {
#endif
	UNITY_UNIFORM PropsArray_Type PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
vec2 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
float u_xlat6;
int u_xlati6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat3.x = in_POSITION0.x * PropsArray[u_xlati0]._FlipFactor;
    u_xlati6 = int(u_xlati0 << 3);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat3.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat3.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat9 = u_xlat3.x * PropsArray[u_xlati0]._TileIndex;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat9>=(-u_xlat9));
#else
    u_xlatb9 = u_xlat9>=(-u_xlat9);
#endif
    u_xlat3.x = (u_xlatb9) ? u_xlat3.x : (-u_xlat3.x);
    u_xlat6 = PropsArray[u_xlati0]._TileIndex / u_xlat3.y;
    u_xlat6 = floor(u_xlat6);
    u_xlat1.y = (-u_xlat6) + in_TEXCOORD0.y;
    u_xlat6 = float(1.0) / u_xlat3.x;
    u_xlat0.x = u_xlat6 * PropsArray[u_xlati0]._TileIndex;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD0.xy * _DistTex_ST.xy + _DistTex_ST.zw;
    vs_TEXCOORD1.xy = vec2(_DistFlowX, _DistFlowY) * _Time.yy + u_xlat0.xy;
    vs_COLOR0 = in_COLOR0;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
struct PropsArray_Type {
	float _Dist;
	float _TileIndex;
	float _FlipFactor;
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_Props {
#endif
	UNITY_UNIFORM PropsArray_Type PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _DistTex;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
int u_xlati4;
float u_xlat6;
void main()
{
    u_xlat16_0.xy = texture(_DistTex, vs_TEXCOORD1.xy).xy;
    u_xlat0.xy = u_xlat16_0.xy + vec2(-0.5, -0.5);
    u_xlati4 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat0.xy = u_xlat0.xy * vec2(PropsArray[u_xlati4]._Dist) + vs_TEXCOORD0.xy;
    u_xlat16_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat0.w;
    u_xlat6 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat6) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "USE_AUTO_COLOR_CHANGE" "USE_COLOR_ADJUST" "USE_VERT_ANI" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _WaveScale;
uniform 	float _WaveSpd;
uniform 	float _WaveDist;
uniform 	float _TileIndex;
uniform 	float _FlipFactor;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = _Time.y * _WaveSpd;
    u_xlat0.x = in_POSITION0.y * _WaveDist + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _WaveScale;
    u_xlat0.x = in_POSITION0.x * _FlipFactor + u_xlat0.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat4 = u_xlat0.x * _TileIndex;
    u_xlatb4 = u_xlat4>=(-u_xlat4);
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2 = _TileIndex / u_xlat0.y;
    u_xlat2 = floor(u_xlat2);
    u_xlat1.y = (-u_xlat2) + in_TEXCOORD0.y;
    u_xlat2 = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat2 * _TileIndex;
    u_xlat2 = fract(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec4 _Time;
uniform 	float _Hue;
uniform 	float _Saturation;
uniform 	float _Lightness;
uniform 	float _Contrast;
uniform 	float _Invert;
uniform 	float _Blending;
uniform 	float _Intensity;
uniform 	vec4 _PostColor;
uniform 	float _AutoColChangeSpeed;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat6;
float u_xlat15;
void main()
{
    u_xlat0.x = _Time.x * _AutoColChangeSpeed;
    u_xlat0.yz = vec2(_Hue, _Contrast) + vec2(180.0, 100.0);
    u_xlat0.x = u_xlat0.x * u_xlat0.y;
    u_xlat0.xy = u_xlat0.xz * vec2(0.0174532924, 0.00999999978);
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat6.xyz = u_xlat10_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat6.xyz = u_xlat10_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat6.zxy);
    u_xlat0.xzw = u_xlat0.xxx * u_xlat6.xyz;
    u_xlat0.xzw = u_xlat10_2.xyz * u_xlat1.xxx + u_xlat0.xzw;
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat6.x = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat10_2.xyz);
    u_xlat6.x = u_xlat6.x * 0.57735002;
    u_xlat0.xzw = u_xlat6.xxx * u_xlat1.xxx + u_xlat0.xzw;
    u_xlat1.x = dot(u_xlat0.xzw, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat0.xzw = u_xlat0.xzw + (-u_xlat1.xxx);
    u_xlat6.x = _Saturation * 0.00999999978 + 1.0;
    u_xlat0.xzw = u_xlat6.xxx * u_xlat0.xzw + u_xlat1.xxx;
    u_xlat16_3.xyz = vec3(vec3(_Lightness, _Lightness, _Lightness)) * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat0.xzw;
    u_xlat16_3.xyz = u_xlat16_3.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat16_3.xyz = u_xlat0.yyy * u_xlat16_3.xyz + vec3(0.5, 0.5, 0.5);
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_3.xyz * vec3(-2.0, -2.0, -2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vec3(_Invert) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * _PostColor.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = _PostColor.www * u_xlat0.xyz + u_xlat16_3.xyz;
    u_xlat1 = vs_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = vec4(vec4(_Intensity, _Intensity, _Intensity, _Intensity)) * u_xlat1 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0.xyz = (-u_xlat10_2.xyz) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1 = u_xlat1 * u_xlat10_2;
    u_xlat15 = _Intensity * _Blending;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat1.w;
    u_xlat15 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat15) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "USE_AUTO_COLOR_CHANGE" "USE_COLOR_ADJUST" "USE_VERT_ANI" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _WaveScale;
uniform 	float _WaveSpd;
uniform 	float _WaveDist;
uniform 	float _TileIndex;
uniform 	float _FlipFactor;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = _Time.y * _WaveSpd;
    u_xlat0.x = in_POSITION0.y * _WaveDist + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _WaveScale;
    u_xlat0.x = in_POSITION0.x * _FlipFactor + u_xlat0.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat4 = u_xlat0.x * _TileIndex;
    u_xlatb4 = u_xlat4>=(-u_xlat4);
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2 = _TileIndex / u_xlat0.y;
    u_xlat2 = floor(u_xlat2);
    u_xlat1.y = (-u_xlat2) + in_TEXCOORD0.y;
    u_xlat2 = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat2 * _TileIndex;
    u_xlat2 = fract(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec4 _Time;
uniform 	float _Hue;
uniform 	float _Saturation;
uniform 	float _Lightness;
uniform 	float _Contrast;
uniform 	float _Invert;
uniform 	float _Blending;
uniform 	float _Intensity;
uniform 	vec4 _PostColor;
uniform 	float _AutoColChangeSpeed;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat6;
float u_xlat15;
void main()
{
    u_xlat0.x = _Time.x * _AutoColChangeSpeed;
    u_xlat0.yz = vec2(_Hue, _Contrast) + vec2(180.0, 100.0);
    u_xlat0.x = u_xlat0.x * u_xlat0.y;
    u_xlat0.xy = u_xlat0.xz * vec2(0.0174532924, 0.00999999978);
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat6.xyz = u_xlat10_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat6.xyz = u_xlat10_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat6.zxy);
    u_xlat0.xzw = u_xlat0.xxx * u_xlat6.xyz;
    u_xlat0.xzw = u_xlat10_2.xyz * u_xlat1.xxx + u_xlat0.xzw;
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat6.x = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat10_2.xyz);
    u_xlat6.x = u_xlat6.x * 0.57735002;
    u_xlat0.xzw = u_xlat6.xxx * u_xlat1.xxx + u_xlat0.xzw;
    u_xlat1.x = dot(u_xlat0.xzw, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat0.xzw = u_xlat0.xzw + (-u_xlat1.xxx);
    u_xlat6.x = _Saturation * 0.00999999978 + 1.0;
    u_xlat0.xzw = u_xlat6.xxx * u_xlat0.xzw + u_xlat1.xxx;
    u_xlat16_3.xyz = vec3(vec3(_Lightness, _Lightness, _Lightness)) * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat0.xzw;
    u_xlat16_3.xyz = u_xlat16_3.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat16_3.xyz = u_xlat0.yyy * u_xlat16_3.xyz + vec3(0.5, 0.5, 0.5);
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_3.xyz * vec3(-2.0, -2.0, -2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vec3(_Invert) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * _PostColor.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = _PostColor.www * u_xlat0.xyz + u_xlat16_3.xyz;
    u_xlat1 = vs_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = vec4(vec4(_Intensity, _Intensity, _Intensity, _Intensity)) * u_xlat1 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0.xyz = (-u_xlat10_2.xyz) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1 = u_xlat1 * u_xlat10_2;
    u_xlat15 = _Intensity * _Blending;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat1.w;
    u_xlat15 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat15) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "USE_AUTO_COLOR_CHANGE" "USE_COLOR_ADJUST" "USE_VERT_ANI" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _WaveScale;
uniform 	float _WaveSpd;
uniform 	float _WaveDist;
uniform 	float _TileIndex;
uniform 	float _FlipFactor;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = _Time.y * _WaveSpd;
    u_xlat0.x = in_POSITION0.y * _WaveDist + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _WaveScale;
    u_xlat0.x = in_POSITION0.x * _FlipFactor + u_xlat0.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat4 = u_xlat0.x * _TileIndex;
    u_xlatb4 = u_xlat4>=(-u_xlat4);
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2 = _TileIndex / u_xlat0.y;
    u_xlat2 = floor(u_xlat2);
    u_xlat1.y = (-u_xlat2) + in_TEXCOORD0.y;
    u_xlat2 = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat2 * _TileIndex;
    u_xlat2 = fract(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec4 _Time;
uniform 	float _Hue;
uniform 	float _Saturation;
uniform 	float _Lightness;
uniform 	float _Contrast;
uniform 	float _Invert;
uniform 	float _Blending;
uniform 	float _Intensity;
uniform 	vec4 _PostColor;
uniform 	float _AutoColChangeSpeed;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
vec4 u_xlat1;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat6;
float u_xlat15;
void main()
{
    u_xlat0.x = _Time.x * _AutoColChangeSpeed;
    u_xlat0.yz = vec2(_Hue, _Contrast) + vec2(180.0, 100.0);
    u_xlat0.x = u_xlat0.x * u_xlat0.y;
    u_xlat0.xy = u_xlat0.xz * vec2(0.0174532924, 0.00999999978);
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat6.xyz = u_xlat10_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat6.xyz = u_xlat10_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat6.zxy);
    u_xlat0.xzw = u_xlat0.xxx * u_xlat6.xyz;
    u_xlat0.xzw = u_xlat10_2.xyz * u_xlat1.xxx + u_xlat0.xzw;
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat6.x = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat10_2.xyz);
    u_xlat6.x = u_xlat6.x * 0.57735002;
    u_xlat0.xzw = u_xlat6.xxx * u_xlat1.xxx + u_xlat0.xzw;
    u_xlat1.x = dot(u_xlat0.xzw, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat0.xzw = u_xlat0.xzw + (-u_xlat1.xxx);
    u_xlat6.x = _Saturation * 0.00999999978 + 1.0;
    u_xlat0.xzw = u_xlat6.xxx * u_xlat0.xzw + u_xlat1.xxx;
    u_xlat16_3.xyz = vec3(vec3(_Lightness, _Lightness, _Lightness)) * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat0.xzw;
    u_xlat16_3.xyz = u_xlat16_3.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat16_3.xyz = u_xlat0.yyy * u_xlat16_3.xyz + vec3(0.5, 0.5, 0.5);
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_3.xyz * vec3(-2.0, -2.0, -2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vec3(_Invert) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * _PostColor.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = _PostColor.www * u_xlat0.xyz + u_xlat16_3.xyz;
    u_xlat1 = vs_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = vec4(vec4(_Intensity, _Intensity, _Intensity, _Intensity)) * u_xlat1 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0.xyz = (-u_xlat10_2.xyz) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1 = u_xlat1 * u_xlat10_2;
    u_xlat15 = _Intensity * _Blending;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat1.w;
    u_xlat15 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat15) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "USE_COLOR_ADJUST" "USE_DISTORTION" }
"#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DistTex_ST;
uniform 	float _DistFlowX;
uniform 	float _DistFlowY;
uniform 	float _TileIndex;
uniform 	float _FlipFactor;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = in_POSITION0.x * _FlipFactor;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat4 = u_xlat0.x * _TileIndex;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4>=(-u_xlat4));
#else
    u_xlatb4 = u_xlat4>=(-u_xlat4);
#endif
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2 = _TileIndex / u_xlat0.y;
    u_xlat2 = floor(u_xlat2);
    u_xlat1.y = (-u_xlat2) + in_TEXCOORD0.y;
    u_xlat2 = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat2 * _TileIndex;
    u_xlat2 = fract(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD0.xy * _DistTex_ST.xy + _DistTex_ST.zw;
    vs_TEXCOORD1.xy = vec2(_DistFlowX, _DistFlowY) * _Time.yy + u_xlat0.xy;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	float _Hue;
uniform 	float _Saturation;
uniform 	float _Lightness;
uniform 	float _Contrast;
uniform 	float _Invert;
uniform 	float _Blending;
uniform 	float _Intensity;
uniform 	vec4 _PostColor;
uniform 	float _Dist;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
UNITY_LOCATION(0) uniform mediump sampler2D _DistTex;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
float u_xlat18;
float u_xlat19;
void main()
{
    u_xlat16_0.xy = texture(_DistTex, vs_TEXCOORD1.xy).xy;
    u_xlat0.xy = u_xlat16_0.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = u_xlat0.xy * vec2(_Dist) + vs_TEXCOORD0.xy;
    u_xlat16_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat1.xyz = u_xlat16_0.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat1.xyz = u_xlat16_0.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat1.zxy);
    u_xlat19 = _Hue * 0.0174532924;
    u_xlat2.x = sin(u_xlat19);
    u_xlat3 = cos(u_xlat19);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xxx;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(u_xlat3) + u_xlat1.xyz;
    u_xlat19 = (-u_xlat3) + 1.0;
    u_xlat2.x = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat16_0.xyz);
    u_xlat2.x = u_xlat2.x * 0.57735002;
    u_xlat1.xyz = u_xlat2.xxx * vec3(u_xlat19) + u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat1.xyz = (-vec3(u_xlat19)) + u_xlat1.xyz;
    u_xlat2.x = _Saturation * 0.00999999978 + 1.0;
    u_xlat1.xyz = u_xlat2.xxx * u_xlat1.xyz + vec3(u_xlat19);
    u_xlat16_4.xyz = vec3(_Lightness) * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat1.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat1.x = _Contrast + 100.0;
    u_xlat1.x = u_xlat1.x * 0.00999999978;
    u_xlat16_4.xyz = u_xlat1.xxx * u_xlat16_4.xyz + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.xyz = min(max(u_xlat16_4.xyz, 0.0), 1.0);
#else
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = u_xlat16_4.xyz * vec3(-2.0, -2.0, -2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = vec3(vec3(_Invert, _Invert, _Invert)) * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat1.xyz = u_xlat16_4.xyz * _PostColor.xyz + (-u_xlat16_4.xyz);
    u_xlat1.xyz = _PostColor.www * u_xlat1.xyz + u_xlat16_4.xyz;
    u_xlat2 = vs_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat2 = vec4(_Intensity) * u_xlat2 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1.xyz = (-u_xlat16_0.xyz) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat0 = u_xlat16_0 * u_xlat2;
    u_xlat19 = _Blending * _Intensity;
    u_xlat0.xyz = vec3(u_xlat19) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat0.w;
    u_xlat18 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat18) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "USE_COLOR_ADJUST" "USE_DISTORTION" }
"#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DistTex_ST;
uniform 	float _DistFlowX;
uniform 	float _DistFlowY;
uniform 	float _TileIndex;
uniform 	float _FlipFactor;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = in_POSITION0.x * _FlipFactor;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat4 = u_xlat0.x * _TileIndex;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4>=(-u_xlat4));
#else
    u_xlatb4 = u_xlat4>=(-u_xlat4);
#endif
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2 = _TileIndex / u_xlat0.y;
    u_xlat2 = floor(u_xlat2);
    u_xlat1.y = (-u_xlat2) + in_TEXCOORD0.y;
    u_xlat2 = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat2 * _TileIndex;
    u_xlat2 = fract(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD0.xy * _DistTex_ST.xy + _DistTex_ST.zw;
    vs_TEXCOORD1.xy = vec2(_DistFlowX, _DistFlowY) * _Time.yy + u_xlat0.xy;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	float _Hue;
uniform 	float _Saturation;
uniform 	float _Lightness;
uniform 	float _Contrast;
uniform 	float _Invert;
uniform 	float _Blending;
uniform 	float _Intensity;
uniform 	vec4 _PostColor;
uniform 	float _Dist;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
UNITY_LOCATION(0) uniform mediump sampler2D _DistTex;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
float u_xlat18;
float u_xlat19;
void main()
{
    u_xlat16_0.xy = texture(_DistTex, vs_TEXCOORD1.xy).xy;
    u_xlat0.xy = u_xlat16_0.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = u_xlat0.xy * vec2(_Dist) + vs_TEXCOORD0.xy;
    u_xlat16_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat1.xyz = u_xlat16_0.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat1.xyz = u_xlat16_0.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat1.zxy);
    u_xlat19 = _Hue * 0.0174532924;
    u_xlat2.x = sin(u_xlat19);
    u_xlat3 = cos(u_xlat19);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xxx;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(u_xlat3) + u_xlat1.xyz;
    u_xlat19 = (-u_xlat3) + 1.0;
    u_xlat2.x = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat16_0.xyz);
    u_xlat2.x = u_xlat2.x * 0.57735002;
    u_xlat1.xyz = u_xlat2.xxx * vec3(u_xlat19) + u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat1.xyz = (-vec3(u_xlat19)) + u_xlat1.xyz;
    u_xlat2.x = _Saturation * 0.00999999978 + 1.0;
    u_xlat1.xyz = u_xlat2.xxx * u_xlat1.xyz + vec3(u_xlat19);
    u_xlat16_4.xyz = vec3(_Lightness) * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat1.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat1.x = _Contrast + 100.0;
    u_xlat1.x = u_xlat1.x * 0.00999999978;
    u_xlat16_4.xyz = u_xlat1.xxx * u_xlat16_4.xyz + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.xyz = min(max(u_xlat16_4.xyz, 0.0), 1.0);
#else
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = u_xlat16_4.xyz * vec3(-2.0, -2.0, -2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = vec3(vec3(_Invert, _Invert, _Invert)) * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat1.xyz = u_xlat16_4.xyz * _PostColor.xyz + (-u_xlat16_4.xyz);
    u_xlat1.xyz = _PostColor.www * u_xlat1.xyz + u_xlat16_4.xyz;
    u_xlat2 = vs_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat2 = vec4(_Intensity) * u_xlat2 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1.xyz = (-u_xlat16_0.xyz) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat0 = u_xlat16_0 * u_xlat2;
    u_xlat19 = _Blending * _Intensity;
    u_xlat0.xyz = vec3(u_xlat19) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat0.w;
    u_xlat18 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat18) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "USE_COLOR_ADJUST" "USE_DISTORTION" }
"#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DistTex_ST;
uniform 	float _DistFlowX;
uniform 	float _DistFlowY;
uniform 	float _TileIndex;
uniform 	float _FlipFactor;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = in_POSITION0.x * _FlipFactor;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat4 = u_xlat0.x * _TileIndex;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4>=(-u_xlat4));
#else
    u_xlatb4 = u_xlat4>=(-u_xlat4);
#endif
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2 = _TileIndex / u_xlat0.y;
    u_xlat2 = floor(u_xlat2);
    u_xlat1.y = (-u_xlat2) + in_TEXCOORD0.y;
    u_xlat2 = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat2 * _TileIndex;
    u_xlat2 = fract(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD0.xy * _DistTex_ST.xy + _DistTex_ST.zw;
    vs_TEXCOORD1.xy = vec2(_DistFlowX, _DistFlowY) * _Time.yy + u_xlat0.xy;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	float _Hue;
uniform 	float _Saturation;
uniform 	float _Lightness;
uniform 	float _Contrast;
uniform 	float _Invert;
uniform 	float _Blending;
uniform 	float _Intensity;
uniform 	vec4 _PostColor;
uniform 	float _Dist;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
UNITY_LOCATION(0) uniform mediump sampler2D _DistTex;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
float u_xlat18;
float u_xlat19;
void main()
{
    u_xlat16_0.xy = texture(_DistTex, vs_TEXCOORD1.xy).xy;
    u_xlat0.xy = u_xlat16_0.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = u_xlat0.xy * vec2(_Dist) + vs_TEXCOORD0.xy;
    u_xlat16_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat1.xyz = u_xlat16_0.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat1.xyz = u_xlat16_0.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat1.zxy);
    u_xlat19 = _Hue * 0.0174532924;
    u_xlat2.x = sin(u_xlat19);
    u_xlat3 = cos(u_xlat19);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xxx;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(u_xlat3) + u_xlat1.xyz;
    u_xlat19 = (-u_xlat3) + 1.0;
    u_xlat2.x = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat16_0.xyz);
    u_xlat2.x = u_xlat2.x * 0.57735002;
    u_xlat1.xyz = u_xlat2.xxx * vec3(u_xlat19) + u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat1.xyz = (-vec3(u_xlat19)) + u_xlat1.xyz;
    u_xlat2.x = _Saturation * 0.00999999978 + 1.0;
    u_xlat1.xyz = u_xlat2.xxx * u_xlat1.xyz + vec3(u_xlat19);
    u_xlat16_4.xyz = vec3(_Lightness) * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat1.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat1.x = _Contrast + 100.0;
    u_xlat1.x = u_xlat1.x * 0.00999999978;
    u_xlat16_4.xyz = u_xlat1.xxx * u_xlat16_4.xyz + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.xyz = min(max(u_xlat16_4.xyz, 0.0), 1.0);
#else
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = u_xlat16_4.xyz * vec3(-2.0, -2.0, -2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = vec3(vec3(_Invert, _Invert, _Invert)) * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat1.xyz = u_xlat16_4.xyz * _PostColor.xyz + (-u_xlat16_4.xyz);
    u_xlat1.xyz = _PostColor.www * u_xlat1.xyz + u_xlat16_4.xyz;
    u_xlat2 = vs_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat2 = vec4(_Intensity) * u_xlat2 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1.xyz = (-u_xlat16_0.xyz) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat0 = u_xlat16_0 * u_xlat2;
    u_xlat19 = _Blending * _Intensity;
    u_xlat0.xyz = vec3(u_xlat19) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat0.w;
    u_xlat18 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat18) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "USE_DISTORTION" "USE_VERT_ANI" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DistTex_ST;
uniform 	float _DistFlowX;
uniform 	float _DistFlowY;
uniform 	float _WaveScale;
uniform 	float _WaveSpd;
uniform 	float _WaveDist;
uniform 	float _TileIndex;
uniform 	float _FlipFactor;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = _Time.y * _WaveSpd;
    u_xlat0.x = in_POSITION0.y * _WaveDist + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _WaveScale;
    u_xlat0.x = in_POSITION0.x * _FlipFactor + u_xlat0.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat4 = u_xlat0.x * _TileIndex;
    u_xlatb4 = u_xlat4>=(-u_xlat4);
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2 = _TileIndex / u_xlat0.y;
    u_xlat2 = floor(u_xlat2);
    u_xlat1.y = (-u_xlat2) + in_TEXCOORD0.y;
    u_xlat2 = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat2 * _TileIndex;
    u_xlat2 = fract(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD0.xy * _DistTex_ST.xy + _DistTex_ST.zw;
    vs_TEXCOORD1.xy = _Time.yy * vec2(_DistFlowX, _DistFlowY) + u_xlat0.xy;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	float _Dist;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
uniform lowp sampler2D _DistTex;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat10_0.xy = texture2D(_DistTex, vs_TEXCOORD1.xy).xy;
    u_xlat0.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_Dist, _Dist)) + vs_TEXCOORD0.xy;
    u_xlat10_0 = texture2D(_MainTex, u_xlat0.xy);
    u_xlat0 = u_xlat10_0 * vs_COLOR0;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat0.w;
    u_xlat6 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat6) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "USE_DISTORTION" "USE_VERT_ANI" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DistTex_ST;
uniform 	float _DistFlowX;
uniform 	float _DistFlowY;
uniform 	float _WaveScale;
uniform 	float _WaveSpd;
uniform 	float _WaveDist;
uniform 	float _TileIndex;
uniform 	float _FlipFactor;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = _Time.y * _WaveSpd;
    u_xlat0.x = in_POSITION0.y * _WaveDist + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _WaveScale;
    u_xlat0.x = in_POSITION0.x * _FlipFactor + u_xlat0.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat4 = u_xlat0.x * _TileIndex;
    u_xlatb4 = u_xlat4>=(-u_xlat4);
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2 = _TileIndex / u_xlat0.y;
    u_xlat2 = floor(u_xlat2);
    u_xlat1.y = (-u_xlat2) + in_TEXCOORD0.y;
    u_xlat2 = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat2 * _TileIndex;
    u_xlat2 = fract(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD0.xy * _DistTex_ST.xy + _DistTex_ST.zw;
    vs_TEXCOORD1.xy = _Time.yy * vec2(_DistFlowX, _DistFlowY) + u_xlat0.xy;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	float _Dist;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
uniform lowp sampler2D _DistTex;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat10_0.xy = texture2D(_DistTex, vs_TEXCOORD1.xy).xy;
    u_xlat0.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_Dist, _Dist)) + vs_TEXCOORD0.xy;
    u_xlat10_0 = texture2D(_MainTex, u_xlat0.xy);
    u_xlat0 = u_xlat10_0 * vs_COLOR0;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat0.w;
    u_xlat6 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat6) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "USE_DISTORTION" "USE_VERT_ANI" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DistTex_ST;
uniform 	float _DistFlowX;
uniform 	float _DistFlowY;
uniform 	float _WaveScale;
uniform 	float _WaveSpd;
uniform 	float _WaveDist;
uniform 	float _TileIndex;
uniform 	float _FlipFactor;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = _Time.y * _WaveSpd;
    u_xlat0.x = in_POSITION0.y * _WaveDist + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _WaveScale;
    u_xlat0.x = in_POSITION0.x * _FlipFactor + u_xlat0.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat4 = u_xlat0.x * _TileIndex;
    u_xlatb4 = u_xlat4>=(-u_xlat4);
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2 = _TileIndex / u_xlat0.y;
    u_xlat2 = floor(u_xlat2);
    u_xlat1.y = (-u_xlat2) + in_TEXCOORD0.y;
    u_xlat2 = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat2 * _TileIndex;
    u_xlat2 = fract(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD0.xy * _DistTex_ST.xy + _DistTex_ST.zw;
    vs_TEXCOORD1.xy = _Time.yy * vec2(_DistFlowX, _DistFlowY) + u_xlat0.xy;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	float _Dist;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
uniform lowp sampler2D _DistTex;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat10_0.xy = texture2D(_DistTex, vs_TEXCOORD1.xy).xy;
    u_xlat0.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_Dist, _Dist)) + vs_TEXCOORD0.xy;
    u_xlat10_0 = texture2D(_MainTex, u_xlat0.xy);
    u_xlat0 = u_xlat10_0 * vs_COLOR0;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat0.w;
    u_xlat6 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat6) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "INSTANCING_ON" "USE_COLOR_ADJUST" "USE_DISTORTION" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DistTex_ST;
uniform 	float _DistFlowX;
uniform 	float _DistFlowY;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
struct PropsArray_Type {
	float _Dist;
	float _TileIndex;
	float _FlipFactor;
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_Props {
#endif
	UNITY_UNIFORM PropsArray_Type PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
vec2 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
float u_xlat6;
int u_xlati6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat3.x = in_POSITION0.x * PropsArray[u_xlati0]._FlipFactor;
    u_xlati6 = int(u_xlati0 << 3);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat3.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat3.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat9 = u_xlat3.x * PropsArray[u_xlati0]._TileIndex;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat9>=(-u_xlat9));
#else
    u_xlatb9 = u_xlat9>=(-u_xlat9);
#endif
    u_xlat3.x = (u_xlatb9) ? u_xlat3.x : (-u_xlat3.x);
    u_xlat6 = PropsArray[u_xlati0]._TileIndex / u_xlat3.y;
    u_xlat6 = floor(u_xlat6);
    u_xlat1.y = (-u_xlat6) + in_TEXCOORD0.y;
    u_xlat6 = float(1.0) / u_xlat3.x;
    u_xlat0.x = u_xlat6 * PropsArray[u_xlati0]._TileIndex;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD0.xy * _DistTex_ST.xy + _DistTex_ST.zw;
    vs_TEXCOORD1.xy = vec2(_DistFlowX, _DistFlowY) * _Time.yy + u_xlat0.xy;
    vs_COLOR0 = in_COLOR0;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	int unity_BaseInstanceID;
uniform 	float _Hue;
uniform 	float _Saturation;
uniform 	float _Lightness;
uniform 	float _Contrast;
uniform 	float _Invert;
uniform 	float _Blending;
uniform 	float _Intensity;
uniform 	vec4 _PostColor;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
struct PropsArray_Type {
	float _Dist;
	float _TileIndex;
	float _FlipFactor;
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_Props {
#endif
	UNITY_UNIFORM PropsArray_Type PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _DistTex;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
int u_xlati12;
float u_xlat18;
float u_xlat19;
void main()
{
    u_xlat16_0.xy = texture(_DistTex, vs_TEXCOORD1.xy).xy;
    u_xlat0.xy = u_xlat16_0.xy + vec2(-0.5, -0.5);
    u_xlati12 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat0.xy = u_xlat0.xy * vec2(PropsArray[u_xlati12]._Dist) + vs_TEXCOORD0.xy;
    u_xlat16_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat1.xyz = u_xlat16_0.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat1.xyz = u_xlat16_0.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat1.zxy);
    u_xlat19 = _Hue * 0.0174532924;
    u_xlat2.x = sin(u_xlat19);
    u_xlat3 = cos(u_xlat19);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xxx;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(u_xlat3) + u_xlat1.xyz;
    u_xlat19 = (-u_xlat3) + 1.0;
    u_xlat2.x = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat16_0.xyz);
    u_xlat2.x = u_xlat2.x * 0.57735002;
    u_xlat1.xyz = u_xlat2.xxx * vec3(u_xlat19) + u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat1.xyz = (-vec3(u_xlat19)) + u_xlat1.xyz;
    u_xlat2.x = _Saturation * 0.00999999978 + 1.0;
    u_xlat1.xyz = u_xlat2.xxx * u_xlat1.xyz + vec3(u_xlat19);
    u_xlat16_4.xyz = vec3(_Lightness) * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat1.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat1.x = _Contrast + 100.0;
    u_xlat1.x = u_xlat1.x * 0.00999999978;
    u_xlat16_4.xyz = u_xlat1.xxx * u_xlat16_4.xyz + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.xyz = min(max(u_xlat16_4.xyz, 0.0), 1.0);
#else
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = u_xlat16_4.xyz * vec3(-2.0, -2.0, -2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = vec3(vec3(_Invert, _Invert, _Invert)) * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat1.xyz = u_xlat16_4.xyz * _PostColor.xyz + (-u_xlat16_4.xyz);
    u_xlat1.xyz = _PostColor.www * u_xlat1.xyz + u_xlat16_4.xyz;
    u_xlat2 = vs_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat2 = vec4(_Intensity) * u_xlat2 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1.xyz = (-u_xlat16_0.xyz) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat0 = u_xlat16_0 * u_xlat2;
    u_xlat19 = _Blending * _Intensity;
    u_xlat0.xyz = vec3(u_xlat19) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat0.w;
    u_xlat18 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat18) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "INSTANCING_ON" "USE_COLOR_ADJUST" "USE_DISTORTION" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DistTex_ST;
uniform 	float _DistFlowX;
uniform 	float _DistFlowY;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
struct PropsArray_Type {
	float _Dist;
	float _TileIndex;
	float _FlipFactor;
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_Props {
#endif
	UNITY_UNIFORM PropsArray_Type PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
vec2 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
float u_xlat6;
int u_xlati6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat3.x = in_POSITION0.x * PropsArray[u_xlati0]._FlipFactor;
    u_xlati6 = int(u_xlati0 << 3);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat3.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat3.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat9 = u_xlat3.x * PropsArray[u_xlati0]._TileIndex;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat9>=(-u_xlat9));
#else
    u_xlatb9 = u_xlat9>=(-u_xlat9);
#endif
    u_xlat3.x = (u_xlatb9) ? u_xlat3.x : (-u_xlat3.x);
    u_xlat6 = PropsArray[u_xlati0]._TileIndex / u_xlat3.y;
    u_xlat6 = floor(u_xlat6);
    u_xlat1.y = (-u_xlat6) + in_TEXCOORD0.y;
    u_xlat6 = float(1.0) / u_xlat3.x;
    u_xlat0.x = u_xlat6 * PropsArray[u_xlati0]._TileIndex;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD0.xy * _DistTex_ST.xy + _DistTex_ST.zw;
    vs_TEXCOORD1.xy = vec2(_DistFlowX, _DistFlowY) * _Time.yy + u_xlat0.xy;
    vs_COLOR0 = in_COLOR0;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	int unity_BaseInstanceID;
uniform 	float _Hue;
uniform 	float _Saturation;
uniform 	float _Lightness;
uniform 	float _Contrast;
uniform 	float _Invert;
uniform 	float _Blending;
uniform 	float _Intensity;
uniform 	vec4 _PostColor;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
struct PropsArray_Type {
	float _Dist;
	float _TileIndex;
	float _FlipFactor;
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_Props {
#endif
	UNITY_UNIFORM PropsArray_Type PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _DistTex;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
int u_xlati12;
float u_xlat18;
float u_xlat19;
void main()
{
    u_xlat16_0.xy = texture(_DistTex, vs_TEXCOORD1.xy).xy;
    u_xlat0.xy = u_xlat16_0.xy + vec2(-0.5, -0.5);
    u_xlati12 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat0.xy = u_xlat0.xy * vec2(PropsArray[u_xlati12]._Dist) + vs_TEXCOORD0.xy;
    u_xlat16_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat1.xyz = u_xlat16_0.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat1.xyz = u_xlat16_0.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat1.zxy);
    u_xlat19 = _Hue * 0.0174532924;
    u_xlat2.x = sin(u_xlat19);
    u_xlat3 = cos(u_xlat19);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xxx;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(u_xlat3) + u_xlat1.xyz;
    u_xlat19 = (-u_xlat3) + 1.0;
    u_xlat2.x = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat16_0.xyz);
    u_xlat2.x = u_xlat2.x * 0.57735002;
    u_xlat1.xyz = u_xlat2.xxx * vec3(u_xlat19) + u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat1.xyz = (-vec3(u_xlat19)) + u_xlat1.xyz;
    u_xlat2.x = _Saturation * 0.00999999978 + 1.0;
    u_xlat1.xyz = u_xlat2.xxx * u_xlat1.xyz + vec3(u_xlat19);
    u_xlat16_4.xyz = vec3(_Lightness) * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat1.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat1.x = _Contrast + 100.0;
    u_xlat1.x = u_xlat1.x * 0.00999999978;
    u_xlat16_4.xyz = u_xlat1.xxx * u_xlat16_4.xyz + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.xyz = min(max(u_xlat16_4.xyz, 0.0), 1.0);
#else
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = u_xlat16_4.xyz * vec3(-2.0, -2.0, -2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = vec3(vec3(_Invert, _Invert, _Invert)) * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat1.xyz = u_xlat16_4.xyz * _PostColor.xyz + (-u_xlat16_4.xyz);
    u_xlat1.xyz = _PostColor.www * u_xlat1.xyz + u_xlat16_4.xyz;
    u_xlat2 = vs_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat2 = vec4(_Intensity) * u_xlat2 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1.xyz = (-u_xlat16_0.xyz) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat0 = u_xlat16_0 * u_xlat2;
    u_xlat19 = _Blending * _Intensity;
    u_xlat0.xyz = vec3(u_xlat19) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat0.w;
    u_xlat18 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat18) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "INSTANCING_ON" "USE_COLOR_ADJUST" "USE_DISTORTION" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DistTex_ST;
uniform 	float _DistFlowX;
uniform 	float _DistFlowY;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
struct PropsArray_Type {
	float _Dist;
	float _TileIndex;
	float _FlipFactor;
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_Props {
#endif
	UNITY_UNIFORM PropsArray_Type PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
vec2 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
float u_xlat6;
int u_xlati6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat3.x = in_POSITION0.x * PropsArray[u_xlati0]._FlipFactor;
    u_xlati6 = int(u_xlati0 << 3);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat3.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat3.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat9 = u_xlat3.x * PropsArray[u_xlati0]._TileIndex;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat9>=(-u_xlat9));
#else
    u_xlatb9 = u_xlat9>=(-u_xlat9);
#endif
    u_xlat3.x = (u_xlatb9) ? u_xlat3.x : (-u_xlat3.x);
    u_xlat6 = PropsArray[u_xlati0]._TileIndex / u_xlat3.y;
    u_xlat6 = floor(u_xlat6);
    u_xlat1.y = (-u_xlat6) + in_TEXCOORD0.y;
    u_xlat6 = float(1.0) / u_xlat3.x;
    u_xlat0.x = u_xlat6 * PropsArray[u_xlati0]._TileIndex;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD0.xy * _DistTex_ST.xy + _DistTex_ST.zw;
    vs_TEXCOORD1.xy = vec2(_DistFlowX, _DistFlowY) * _Time.yy + u_xlat0.xy;
    vs_COLOR0 = in_COLOR0;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	int unity_BaseInstanceID;
uniform 	float _Hue;
uniform 	float _Saturation;
uniform 	float _Lightness;
uniform 	float _Contrast;
uniform 	float _Invert;
uniform 	float _Blending;
uniform 	float _Intensity;
uniform 	vec4 _PostColor;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
struct PropsArray_Type {
	float _Dist;
	float _TileIndex;
	float _FlipFactor;
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_Props {
#endif
	UNITY_UNIFORM PropsArray_Type PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _DistTex;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
int u_xlati12;
float u_xlat18;
float u_xlat19;
void main()
{
    u_xlat16_0.xy = texture(_DistTex, vs_TEXCOORD1.xy).xy;
    u_xlat0.xy = u_xlat16_0.xy + vec2(-0.5, -0.5);
    u_xlati12 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat0.xy = u_xlat0.xy * vec2(PropsArray[u_xlati12]._Dist) + vs_TEXCOORD0.xy;
    u_xlat16_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat1.xyz = u_xlat16_0.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat1.xyz = u_xlat16_0.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat1.zxy);
    u_xlat19 = _Hue * 0.0174532924;
    u_xlat2.x = sin(u_xlat19);
    u_xlat3 = cos(u_xlat19);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xxx;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(u_xlat3) + u_xlat1.xyz;
    u_xlat19 = (-u_xlat3) + 1.0;
    u_xlat2.x = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat16_0.xyz);
    u_xlat2.x = u_xlat2.x * 0.57735002;
    u_xlat1.xyz = u_xlat2.xxx * vec3(u_xlat19) + u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat1.xyz = (-vec3(u_xlat19)) + u_xlat1.xyz;
    u_xlat2.x = _Saturation * 0.00999999978 + 1.0;
    u_xlat1.xyz = u_xlat2.xxx * u_xlat1.xyz + vec3(u_xlat19);
    u_xlat16_4.xyz = vec3(_Lightness) * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat1.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat1.x = _Contrast + 100.0;
    u_xlat1.x = u_xlat1.x * 0.00999999978;
    u_xlat16_4.xyz = u_xlat1.xxx * u_xlat16_4.xyz + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.xyz = min(max(u_xlat16_4.xyz, 0.0), 1.0);
#else
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = u_xlat16_4.xyz * vec3(-2.0, -2.0, -2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = vec3(vec3(_Invert, _Invert, _Invert)) * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat1.xyz = u_xlat16_4.xyz * _PostColor.xyz + (-u_xlat16_4.xyz);
    u_xlat1.xyz = _PostColor.www * u_xlat1.xyz + u_xlat16_4.xyz;
    u_xlat2 = vs_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat2 = vec4(_Intensity) * u_xlat2 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1.xyz = (-u_xlat16_0.xyz) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat0 = u_xlat16_0 * u_xlat2;
    u_xlat19 = _Blending * _Intensity;
    u_xlat0.xyz = vec3(u_xlat19) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat0.w;
    u_xlat18 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat18) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "USE_AUTO_COLOR_CHANGE" "USE_DISTORTION" "USE_VERT_ANI" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DistTex_ST;
uniform 	float _DistFlowX;
uniform 	float _DistFlowY;
uniform 	float _WaveScale;
uniform 	float _WaveSpd;
uniform 	float _WaveDist;
uniform 	float _TileIndex;
uniform 	float _FlipFactor;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = _Time.y * _WaveSpd;
    u_xlat0.x = in_POSITION0.y * _WaveDist + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _WaveScale;
    u_xlat0.x = in_POSITION0.x * _FlipFactor + u_xlat0.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat4 = u_xlat0.x * _TileIndex;
    u_xlatb4 = u_xlat4>=(-u_xlat4);
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2 = _TileIndex / u_xlat0.y;
    u_xlat2 = floor(u_xlat2);
    u_xlat1.y = (-u_xlat2) + in_TEXCOORD0.y;
    u_xlat2 = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat2 * _TileIndex;
    u_xlat2 = fract(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD0.xy * _DistTex_ST.xy + _DistTex_ST.zw;
    vs_TEXCOORD1.xy = _Time.yy * vec2(_DistFlowX, _DistFlowY) + u_xlat0.xy;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	float _Dist;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
uniform lowp sampler2D _DistTex;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat10_0.xy = texture2D(_DistTex, vs_TEXCOORD1.xy).xy;
    u_xlat0.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_Dist, _Dist)) + vs_TEXCOORD0.xy;
    u_xlat10_0 = texture2D(_MainTex, u_xlat0.xy);
    u_xlat0 = u_xlat10_0 * vs_COLOR0;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat0.w;
    u_xlat6 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat6) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "USE_AUTO_COLOR_CHANGE" "USE_DISTORTION" "USE_VERT_ANI" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DistTex_ST;
uniform 	float _DistFlowX;
uniform 	float _DistFlowY;
uniform 	float _WaveScale;
uniform 	float _WaveSpd;
uniform 	float _WaveDist;
uniform 	float _TileIndex;
uniform 	float _FlipFactor;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = _Time.y * _WaveSpd;
    u_xlat0.x = in_POSITION0.y * _WaveDist + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _WaveScale;
    u_xlat0.x = in_POSITION0.x * _FlipFactor + u_xlat0.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat4 = u_xlat0.x * _TileIndex;
    u_xlatb4 = u_xlat4>=(-u_xlat4);
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2 = _TileIndex / u_xlat0.y;
    u_xlat2 = floor(u_xlat2);
    u_xlat1.y = (-u_xlat2) + in_TEXCOORD0.y;
    u_xlat2 = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat2 * _TileIndex;
    u_xlat2 = fract(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD0.xy * _DistTex_ST.xy + _DistTex_ST.zw;
    vs_TEXCOORD1.xy = _Time.yy * vec2(_DistFlowX, _DistFlowY) + u_xlat0.xy;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	float _Dist;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
uniform lowp sampler2D _DistTex;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat10_0.xy = texture2D(_DistTex, vs_TEXCOORD1.xy).xy;
    u_xlat0.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_Dist, _Dist)) + vs_TEXCOORD0.xy;
    u_xlat10_0 = texture2D(_MainTex, u_xlat0.xy);
    u_xlat0 = u_xlat10_0 * vs_COLOR0;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat0.w;
    u_xlat6 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat6) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "USE_AUTO_COLOR_CHANGE" "USE_DISTORTION" "USE_VERT_ANI" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DistTex_ST;
uniform 	float _DistFlowX;
uniform 	float _DistFlowY;
uniform 	float _WaveScale;
uniform 	float _WaveSpd;
uniform 	float _WaveDist;
uniform 	float _TileIndex;
uniform 	float _FlipFactor;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = _Time.y * _WaveSpd;
    u_xlat0.x = in_POSITION0.y * _WaveDist + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _WaveScale;
    u_xlat0.x = in_POSITION0.x * _FlipFactor + u_xlat0.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat4 = u_xlat0.x * _TileIndex;
    u_xlatb4 = u_xlat4>=(-u_xlat4);
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2 = _TileIndex / u_xlat0.y;
    u_xlat2 = floor(u_xlat2);
    u_xlat1.y = (-u_xlat2) + in_TEXCOORD0.y;
    u_xlat2 = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat2 * _TileIndex;
    u_xlat2 = fract(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD0.xy * _DistTex_ST.xy + _DistTex_ST.zw;
    vs_TEXCOORD1.xy = _Time.yy * vec2(_DistFlowX, _DistFlowY) + u_xlat0.xy;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	float _Dist;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
uniform lowp sampler2D _DistTex;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat10_0.xy = texture2D(_DistTex, vs_TEXCOORD1.xy).xy;
    u_xlat0.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_Dist, _Dist)) + vs_TEXCOORD0.xy;
    u_xlat10_0 = texture2D(_MainTex, u_xlat0.xy);
    u_xlat0 = u_xlat10_0 * vs_COLOR0;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat0.w;
    u_xlat6 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat6) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "USE_AUTO_COLOR_CHANGE" "USE_COLOR_ADJUST" "USE_DISTORTION" }
"#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DistTex_ST;
uniform 	float _DistFlowX;
uniform 	float _DistFlowY;
uniform 	float _TileIndex;
uniform 	float _FlipFactor;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = in_POSITION0.x * _FlipFactor;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat4 = u_xlat0.x * _TileIndex;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4>=(-u_xlat4));
#else
    u_xlatb4 = u_xlat4>=(-u_xlat4);
#endif
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2 = _TileIndex / u_xlat0.y;
    u_xlat2 = floor(u_xlat2);
    u_xlat1.y = (-u_xlat2) + in_TEXCOORD0.y;
    u_xlat2 = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat2 * _TileIndex;
    u_xlat2 = fract(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD0.xy * _DistTex_ST.xy + _DistTex_ST.zw;
    vs_TEXCOORD1.xy = vec2(_DistFlowX, _DistFlowY) * _Time.yy + u_xlat0.xy;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	float _Hue;
uniform 	float _Saturation;
uniform 	float _Lightness;
uniform 	float _Contrast;
uniform 	float _Invert;
uniform 	float _Blending;
uniform 	float _Intensity;
uniform 	vec4 _PostColor;
uniform 	float _AutoColChangeSpeed;
uniform 	float _Dist;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
UNITY_LOCATION(0) uniform mediump sampler2D _DistTex;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec2 u_xlat16_5;
float u_xlat15;
void main()
{
    u_xlat0.x = _Hue + 180.0;
    u_xlat5.x = _Time.x * _AutoColChangeSpeed;
    u_xlat0.x = u_xlat5.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * 0.0174532924;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat16_5.xy = texture(_DistTex, vs_TEXCOORD1.xy).xy;
    u_xlat5.xy = u_xlat16_5.xy + vec2(-0.5, -0.5);
    u_xlat5.xy = u_xlat5.xy * vec2(vec2(_Dist, _Dist)) + vs_TEXCOORD0.xy;
    u_xlat16_2 = texture(_MainTex, u_xlat5.xy);
    u_xlat5.xyz = u_xlat16_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat5.xyz = u_xlat16_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat5.zxy);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * u_xlat1.xxx + u_xlat0.xyz;
    u_xlat15 = (-u_xlat1.x) + 1.0;
    u_xlat1.x = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat16_2.xyz);
    u_xlat1.x = u_xlat1.x * 0.57735002;
    u_xlat0.xyz = u_xlat1.xxx * vec3(u_xlat15) + u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat0.xyz = (-vec3(u_xlat15)) + u_xlat0.xyz;
    u_xlat1.x = _Saturation * 0.00999999978 + 1.0;
    u_xlat0.xyz = u_xlat1.xxx * u_xlat0.xyz + vec3(u_xlat15);
    u_xlat16_3.xyz = vec3(_Lightness) * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat0.x = _Contrast + 100.0;
    u_xlat0.x = u_xlat0.x * 0.00999999978;
    u_xlat16_3.xyz = u_xlat0.xxx * u_xlat16_3.xyz + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.xyz = min(max(u_xlat16_3.xyz, 0.0), 1.0);
#else
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = u_xlat16_3.xyz * vec3(-2.0, -2.0, -2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vec3(vec3(_Invert, _Invert, _Invert)) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * _PostColor.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = _PostColor.www * u_xlat0.xyz + u_xlat16_3.xyz;
    u_xlat1 = vs_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = vec4(_Intensity) * u_xlat1 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0.xyz = (-u_xlat16_2.xyz) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1 = u_xlat1 * u_xlat16_2;
    u_xlat15 = _Blending * _Intensity;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat1.w;
    u_xlat15 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat15) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "USE_AUTO_COLOR_CHANGE" "USE_COLOR_ADJUST" "USE_DISTORTION" }
"#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DistTex_ST;
uniform 	float _DistFlowX;
uniform 	float _DistFlowY;
uniform 	float _TileIndex;
uniform 	float _FlipFactor;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = in_POSITION0.x * _FlipFactor;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat4 = u_xlat0.x * _TileIndex;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4>=(-u_xlat4));
#else
    u_xlatb4 = u_xlat4>=(-u_xlat4);
#endif
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2 = _TileIndex / u_xlat0.y;
    u_xlat2 = floor(u_xlat2);
    u_xlat1.y = (-u_xlat2) + in_TEXCOORD0.y;
    u_xlat2 = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat2 * _TileIndex;
    u_xlat2 = fract(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD0.xy * _DistTex_ST.xy + _DistTex_ST.zw;
    vs_TEXCOORD1.xy = vec2(_DistFlowX, _DistFlowY) * _Time.yy + u_xlat0.xy;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	float _Hue;
uniform 	float _Saturation;
uniform 	float _Lightness;
uniform 	float _Contrast;
uniform 	float _Invert;
uniform 	float _Blending;
uniform 	float _Intensity;
uniform 	vec4 _PostColor;
uniform 	float _AutoColChangeSpeed;
uniform 	float _Dist;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
UNITY_LOCATION(0) uniform mediump sampler2D _DistTex;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec2 u_xlat16_5;
float u_xlat15;
void main()
{
    u_xlat0.x = _Hue + 180.0;
    u_xlat5.x = _Time.x * _AutoColChangeSpeed;
    u_xlat0.x = u_xlat5.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * 0.0174532924;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat16_5.xy = texture(_DistTex, vs_TEXCOORD1.xy).xy;
    u_xlat5.xy = u_xlat16_5.xy + vec2(-0.5, -0.5);
    u_xlat5.xy = u_xlat5.xy * vec2(vec2(_Dist, _Dist)) + vs_TEXCOORD0.xy;
    u_xlat16_2 = texture(_MainTex, u_xlat5.xy);
    u_xlat5.xyz = u_xlat16_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat5.xyz = u_xlat16_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat5.zxy);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * u_xlat1.xxx + u_xlat0.xyz;
    u_xlat15 = (-u_xlat1.x) + 1.0;
    u_xlat1.x = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat16_2.xyz);
    u_xlat1.x = u_xlat1.x * 0.57735002;
    u_xlat0.xyz = u_xlat1.xxx * vec3(u_xlat15) + u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat0.xyz = (-vec3(u_xlat15)) + u_xlat0.xyz;
    u_xlat1.x = _Saturation * 0.00999999978 + 1.0;
    u_xlat0.xyz = u_xlat1.xxx * u_xlat0.xyz + vec3(u_xlat15);
    u_xlat16_3.xyz = vec3(_Lightness) * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat0.x = _Contrast + 100.0;
    u_xlat0.x = u_xlat0.x * 0.00999999978;
    u_xlat16_3.xyz = u_xlat0.xxx * u_xlat16_3.xyz + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.xyz = min(max(u_xlat16_3.xyz, 0.0), 1.0);
#else
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = u_xlat16_3.xyz * vec3(-2.0, -2.0, -2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vec3(vec3(_Invert, _Invert, _Invert)) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * _PostColor.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = _PostColor.www * u_xlat0.xyz + u_xlat16_3.xyz;
    u_xlat1 = vs_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = vec4(_Intensity) * u_xlat1 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0.xyz = (-u_xlat16_2.xyz) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1 = u_xlat1 * u_xlat16_2;
    u_xlat15 = _Blending * _Intensity;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat1.w;
    u_xlat15 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat15) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "USE_AUTO_COLOR_CHANGE" "USE_COLOR_ADJUST" "USE_DISTORTION" }
"#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DistTex_ST;
uniform 	float _DistFlowX;
uniform 	float _DistFlowY;
uniform 	float _TileIndex;
uniform 	float _FlipFactor;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = in_POSITION0.x * _FlipFactor;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat4 = u_xlat0.x * _TileIndex;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4>=(-u_xlat4));
#else
    u_xlatb4 = u_xlat4>=(-u_xlat4);
#endif
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2 = _TileIndex / u_xlat0.y;
    u_xlat2 = floor(u_xlat2);
    u_xlat1.y = (-u_xlat2) + in_TEXCOORD0.y;
    u_xlat2 = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat2 * _TileIndex;
    u_xlat2 = fract(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD0.xy * _DistTex_ST.xy + _DistTex_ST.zw;
    vs_TEXCOORD1.xy = vec2(_DistFlowX, _DistFlowY) * _Time.yy + u_xlat0.xy;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	float _Hue;
uniform 	float _Saturation;
uniform 	float _Lightness;
uniform 	float _Contrast;
uniform 	float _Invert;
uniform 	float _Blending;
uniform 	float _Intensity;
uniform 	vec4 _PostColor;
uniform 	float _AutoColChangeSpeed;
uniform 	float _Dist;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
UNITY_LOCATION(0) uniform mediump sampler2D _DistTex;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec2 u_xlat16_5;
float u_xlat15;
void main()
{
    u_xlat0.x = _Hue + 180.0;
    u_xlat5.x = _Time.x * _AutoColChangeSpeed;
    u_xlat0.x = u_xlat5.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * 0.0174532924;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat16_5.xy = texture(_DistTex, vs_TEXCOORD1.xy).xy;
    u_xlat5.xy = u_xlat16_5.xy + vec2(-0.5, -0.5);
    u_xlat5.xy = u_xlat5.xy * vec2(vec2(_Dist, _Dist)) + vs_TEXCOORD0.xy;
    u_xlat16_2 = texture(_MainTex, u_xlat5.xy);
    u_xlat5.xyz = u_xlat16_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat5.xyz = u_xlat16_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat5.zxy);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * u_xlat1.xxx + u_xlat0.xyz;
    u_xlat15 = (-u_xlat1.x) + 1.0;
    u_xlat1.x = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat16_2.xyz);
    u_xlat1.x = u_xlat1.x * 0.57735002;
    u_xlat0.xyz = u_xlat1.xxx * vec3(u_xlat15) + u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat0.xyz = (-vec3(u_xlat15)) + u_xlat0.xyz;
    u_xlat1.x = _Saturation * 0.00999999978 + 1.0;
    u_xlat0.xyz = u_xlat1.xxx * u_xlat0.xyz + vec3(u_xlat15);
    u_xlat16_3.xyz = vec3(_Lightness) * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat0.x = _Contrast + 100.0;
    u_xlat0.x = u_xlat0.x * 0.00999999978;
    u_xlat16_3.xyz = u_xlat0.xxx * u_xlat16_3.xyz + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.xyz = min(max(u_xlat16_3.xyz, 0.0), 1.0);
#else
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = u_xlat16_3.xyz * vec3(-2.0, -2.0, -2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vec3(vec3(_Invert, _Invert, _Invert)) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * _PostColor.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = _PostColor.www * u_xlat0.xyz + u_xlat16_3.xyz;
    u_xlat1 = vs_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = vec4(_Intensity) * u_xlat1 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0.xyz = (-u_xlat16_2.xyz) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1 = u_xlat1 * u_xlat16_2;
    u_xlat15 = _Blending * _Intensity;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat1.w;
    u_xlat15 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat15) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "USE_COLOR_ADJUST" "USE_DISTORTION" "USE_VERT_ANI" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DistTex_ST;
uniform 	float _DistFlowX;
uniform 	float _DistFlowY;
uniform 	float _WaveScale;
uniform 	float _WaveSpd;
uniform 	float _WaveDist;
uniform 	float _TileIndex;
uniform 	float _FlipFactor;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = _Time.y * _WaveSpd;
    u_xlat0.x = in_POSITION0.y * _WaveDist + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _WaveScale;
    u_xlat0.x = in_POSITION0.x * _FlipFactor + u_xlat0.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat4 = u_xlat0.x * _TileIndex;
    u_xlatb4 = u_xlat4>=(-u_xlat4);
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2 = _TileIndex / u_xlat0.y;
    u_xlat2 = floor(u_xlat2);
    u_xlat1.y = (-u_xlat2) + in_TEXCOORD0.y;
    u_xlat2 = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat2 * _TileIndex;
    u_xlat2 = fract(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD0.xy * _DistTex_ST.xy + _DistTex_ST.zw;
    vs_TEXCOORD1.xy = _Time.yy * vec2(_DistFlowX, _DistFlowY) + u_xlat0.xy;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	float _Hue;
uniform 	float _Saturation;
uniform 	float _Lightness;
uniform 	float _Contrast;
uniform 	float _Invert;
uniform 	float _Blending;
uniform 	float _Intensity;
uniform 	vec4 _PostColor;
uniform 	float _Dist;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
uniform lowp sampler2D _DistTex;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
float u_xlat18;
float u_xlat19;
void main()
{
    u_xlat10_0.xy = texture2D(_DistTex, vs_TEXCOORD1.xy).xy;
    u_xlat0.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = u_xlat0.xy * vec2(_Dist) + vs_TEXCOORD0.xy;
    u_xlat10_0 = texture2D(_MainTex, u_xlat0.xy);
    u_xlat1.xyz = u_xlat10_0.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat1.xyz = u_xlat10_0.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat1.zxy);
    u_xlat19 = _Hue * 0.0174532924;
    u_xlat2.x = sin(u_xlat19);
    u_xlat3 = cos(u_xlat19);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xxx;
    u_xlat1.xyz = u_xlat10_0.xyz * vec3(u_xlat3) + u_xlat1.xyz;
    u_xlat19 = (-u_xlat3) + 1.0;
    u_xlat2.x = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat10_0.xyz);
    u_xlat2.x = u_xlat2.x * 0.57735002;
    u_xlat1.xyz = u_xlat2.xxx * vec3(u_xlat19) + u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat1.xyz = (-vec3(u_xlat19)) + u_xlat1.xyz;
    u_xlat2.x = _Saturation * 0.00999999978 + 1.0;
    u_xlat1.xyz = u_xlat2.xxx * u_xlat1.xyz + vec3(u_xlat19);
    u_xlat16_4.xyz = vec3(_Lightness) * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat1.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat1.x = _Contrast + 100.0;
    u_xlat1.x = u_xlat1.x * 0.00999999978;
    u_xlat16_4.xyz = u_xlat1.xxx * u_xlat16_4.xyz + vec3(0.5, 0.5, 0.5);
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_4.xyz * vec3(-2.0, -2.0, -2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = vec3(vec3(_Invert, _Invert, _Invert)) * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat1.xyz = u_xlat16_4.xyz * _PostColor.xyz + (-u_xlat16_4.xyz);
    u_xlat1.xyz = _PostColor.www * u_xlat1.xyz + u_xlat16_4.xyz;
    u_xlat2 = vs_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat2 = vec4(_Intensity) * u_xlat2 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1.xyz = (-u_xlat10_0.xyz) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat0 = u_xlat10_0 * u_xlat2;
    u_xlat19 = _Blending * _Intensity;
    u_xlat0.xyz = vec3(u_xlat19) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat0.w;
    u_xlat18 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat18) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "USE_COLOR_ADJUST" "USE_DISTORTION" "USE_VERT_ANI" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DistTex_ST;
uniform 	float _DistFlowX;
uniform 	float _DistFlowY;
uniform 	float _WaveScale;
uniform 	float _WaveSpd;
uniform 	float _WaveDist;
uniform 	float _TileIndex;
uniform 	float _FlipFactor;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = _Time.y * _WaveSpd;
    u_xlat0.x = in_POSITION0.y * _WaveDist + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _WaveScale;
    u_xlat0.x = in_POSITION0.x * _FlipFactor + u_xlat0.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat4 = u_xlat0.x * _TileIndex;
    u_xlatb4 = u_xlat4>=(-u_xlat4);
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2 = _TileIndex / u_xlat0.y;
    u_xlat2 = floor(u_xlat2);
    u_xlat1.y = (-u_xlat2) + in_TEXCOORD0.y;
    u_xlat2 = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat2 * _TileIndex;
    u_xlat2 = fract(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD0.xy * _DistTex_ST.xy + _DistTex_ST.zw;
    vs_TEXCOORD1.xy = _Time.yy * vec2(_DistFlowX, _DistFlowY) + u_xlat0.xy;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	float _Hue;
uniform 	float _Saturation;
uniform 	float _Lightness;
uniform 	float _Contrast;
uniform 	float _Invert;
uniform 	float _Blending;
uniform 	float _Intensity;
uniform 	vec4 _PostColor;
uniform 	float _Dist;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
uniform lowp sampler2D _DistTex;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
float u_xlat18;
float u_xlat19;
void main()
{
    u_xlat10_0.xy = texture2D(_DistTex, vs_TEXCOORD1.xy).xy;
    u_xlat0.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = u_xlat0.xy * vec2(_Dist) + vs_TEXCOORD0.xy;
    u_xlat10_0 = texture2D(_MainTex, u_xlat0.xy);
    u_xlat1.xyz = u_xlat10_0.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat1.xyz = u_xlat10_0.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat1.zxy);
    u_xlat19 = _Hue * 0.0174532924;
    u_xlat2.x = sin(u_xlat19);
    u_xlat3 = cos(u_xlat19);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xxx;
    u_xlat1.xyz = u_xlat10_0.xyz * vec3(u_xlat3) + u_xlat1.xyz;
    u_xlat19 = (-u_xlat3) + 1.0;
    u_xlat2.x = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat10_0.xyz);
    u_xlat2.x = u_xlat2.x * 0.57735002;
    u_xlat1.xyz = u_xlat2.xxx * vec3(u_xlat19) + u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat1.xyz = (-vec3(u_xlat19)) + u_xlat1.xyz;
    u_xlat2.x = _Saturation * 0.00999999978 + 1.0;
    u_xlat1.xyz = u_xlat2.xxx * u_xlat1.xyz + vec3(u_xlat19);
    u_xlat16_4.xyz = vec3(_Lightness) * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat1.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat1.x = _Contrast + 100.0;
    u_xlat1.x = u_xlat1.x * 0.00999999978;
    u_xlat16_4.xyz = u_xlat1.xxx * u_xlat16_4.xyz + vec3(0.5, 0.5, 0.5);
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_4.xyz * vec3(-2.0, -2.0, -2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = vec3(vec3(_Invert, _Invert, _Invert)) * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat1.xyz = u_xlat16_4.xyz * _PostColor.xyz + (-u_xlat16_4.xyz);
    u_xlat1.xyz = _PostColor.www * u_xlat1.xyz + u_xlat16_4.xyz;
    u_xlat2 = vs_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat2 = vec4(_Intensity) * u_xlat2 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1.xyz = (-u_xlat10_0.xyz) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat0 = u_xlat10_0 * u_xlat2;
    u_xlat19 = _Blending * _Intensity;
    u_xlat0.xyz = vec3(u_xlat19) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat0.w;
    u_xlat18 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat18) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "USE_COLOR_ADJUST" "USE_DISTORTION" "USE_VERT_ANI" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DistTex_ST;
uniform 	float _DistFlowX;
uniform 	float _DistFlowY;
uniform 	float _WaveScale;
uniform 	float _WaveSpd;
uniform 	float _WaveDist;
uniform 	float _TileIndex;
uniform 	float _FlipFactor;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = _Time.y * _WaveSpd;
    u_xlat0.x = in_POSITION0.y * _WaveDist + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _WaveScale;
    u_xlat0.x = in_POSITION0.x * _FlipFactor + u_xlat0.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat4 = u_xlat0.x * _TileIndex;
    u_xlatb4 = u_xlat4>=(-u_xlat4);
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2 = _TileIndex / u_xlat0.y;
    u_xlat2 = floor(u_xlat2);
    u_xlat1.y = (-u_xlat2) + in_TEXCOORD0.y;
    u_xlat2 = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat2 * _TileIndex;
    u_xlat2 = fract(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD0.xy * _DistTex_ST.xy + _DistTex_ST.zw;
    vs_TEXCOORD1.xy = _Time.yy * vec2(_DistFlowX, _DistFlowY) + u_xlat0.xy;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	float _Hue;
uniform 	float _Saturation;
uniform 	float _Lightness;
uniform 	float _Contrast;
uniform 	float _Invert;
uniform 	float _Blending;
uniform 	float _Intensity;
uniform 	vec4 _PostColor;
uniform 	float _Dist;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
uniform lowp sampler2D _DistTex;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec3 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
float u_xlat18;
float u_xlat19;
void main()
{
    u_xlat10_0.xy = texture2D(_DistTex, vs_TEXCOORD1.xy).xy;
    u_xlat0.xy = u_xlat10_0.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = u_xlat0.xy * vec2(_Dist) + vs_TEXCOORD0.xy;
    u_xlat10_0 = texture2D(_MainTex, u_xlat0.xy);
    u_xlat1.xyz = u_xlat10_0.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat1.xyz = u_xlat10_0.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat1.zxy);
    u_xlat19 = _Hue * 0.0174532924;
    u_xlat2.x = sin(u_xlat19);
    u_xlat3 = cos(u_xlat19);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xxx;
    u_xlat1.xyz = u_xlat10_0.xyz * vec3(u_xlat3) + u_xlat1.xyz;
    u_xlat19 = (-u_xlat3) + 1.0;
    u_xlat2.x = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat10_0.xyz);
    u_xlat2.x = u_xlat2.x * 0.57735002;
    u_xlat1.xyz = u_xlat2.xxx * vec3(u_xlat19) + u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat1.xyz = (-vec3(u_xlat19)) + u_xlat1.xyz;
    u_xlat2.x = _Saturation * 0.00999999978 + 1.0;
    u_xlat1.xyz = u_xlat2.xxx * u_xlat1.xyz + vec3(u_xlat19);
    u_xlat16_4.xyz = vec3(_Lightness) * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat1.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat1.x = _Contrast + 100.0;
    u_xlat1.x = u_xlat1.x * 0.00999999978;
    u_xlat16_4.xyz = u_xlat1.xxx * u_xlat16_4.xyz + vec3(0.5, 0.5, 0.5);
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
    u_xlat16_5.xyz = u_xlat16_4.xyz * vec3(-2.0, -2.0, -2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = vec3(vec3(_Invert, _Invert, _Invert)) * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat1.xyz = u_xlat16_4.xyz * _PostColor.xyz + (-u_xlat16_4.xyz);
    u_xlat1.xyz = _PostColor.www * u_xlat1.xyz + u_xlat16_4.xyz;
    u_xlat2 = vs_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat2 = vec4(_Intensity) * u_xlat2 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1.xyz = (-u_xlat10_0.xyz) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat0 = u_xlat10_0 * u_xlat2;
    u_xlat19 = _Blending * _Intensity;
    u_xlat0.xyz = vec3(u_xlat19) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat0.w;
    u_xlat18 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat18) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "INSTANCING_ON" "USE_AUTO_COLOR_CHANGE" "USE_COLOR_ADJUST" "USE_DISTORTION" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DistTex_ST;
uniform 	float _DistFlowX;
uniform 	float _DistFlowY;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
struct PropsArray_Type {
	float _Dist;
	float _TileIndex;
	float _FlipFactor;
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_Props {
#endif
	UNITY_UNIFORM PropsArray_Type PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
vec2 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
float u_xlat6;
int u_xlati6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat3.x = in_POSITION0.x * PropsArray[u_xlati0]._FlipFactor;
    u_xlati6 = int(u_xlati0 << 3);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat3.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat3.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat9 = u_xlat3.x * PropsArray[u_xlati0]._TileIndex;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat9>=(-u_xlat9));
#else
    u_xlatb9 = u_xlat9>=(-u_xlat9);
#endif
    u_xlat3.x = (u_xlatb9) ? u_xlat3.x : (-u_xlat3.x);
    u_xlat6 = PropsArray[u_xlati0]._TileIndex / u_xlat3.y;
    u_xlat6 = floor(u_xlat6);
    u_xlat1.y = (-u_xlat6) + in_TEXCOORD0.y;
    u_xlat6 = float(1.0) / u_xlat3.x;
    u_xlat0.x = u_xlat6 * PropsArray[u_xlati0]._TileIndex;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD0.xy * _DistTex_ST.xy + _DistTex_ST.zw;
    vs_TEXCOORD1.xy = vec2(_DistFlowX, _DistFlowY) * _Time.yy + u_xlat0.xy;
    vs_COLOR0 = in_COLOR0;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	int unity_BaseInstanceID;
uniform 	float _Hue;
uniform 	float _Saturation;
uniform 	float _Lightness;
uniform 	float _Contrast;
uniform 	float _Invert;
uniform 	float _Blending;
uniform 	float _Intensity;
uniform 	vec4 _PostColor;
uniform 	float _AutoColChangeSpeed;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
struct PropsArray_Type {
	float _Dist;
	float _TileIndex;
	float _FlipFactor;
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_Props {
#endif
	UNITY_UNIFORM PropsArray_Type PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _DistTex;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec2 u_xlat16_5;
float u_xlat15;
int u_xlati15;
void main()
{
    u_xlat0.x = _Hue + 180.0;
    u_xlat5.x = _Time.x * _AutoColChangeSpeed;
    u_xlat0.x = u_xlat5.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * 0.0174532924;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat16_5.xy = texture(_DistTex, vs_TEXCOORD1.xy).xy;
    u_xlat5.xy = u_xlat16_5.xy + vec2(-0.5, -0.5);
    u_xlati15 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat5.xy = u_xlat5.xy * vec2(PropsArray[u_xlati15]._Dist) + vs_TEXCOORD0.xy;
    u_xlat16_2 = texture(_MainTex, u_xlat5.xy);
    u_xlat5.xyz = u_xlat16_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat5.xyz = u_xlat16_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat5.zxy);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * u_xlat1.xxx + u_xlat0.xyz;
    u_xlat15 = (-u_xlat1.x) + 1.0;
    u_xlat1.x = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat16_2.xyz);
    u_xlat1.x = u_xlat1.x * 0.57735002;
    u_xlat0.xyz = u_xlat1.xxx * vec3(u_xlat15) + u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat0.xyz = (-vec3(u_xlat15)) + u_xlat0.xyz;
    u_xlat1.x = _Saturation * 0.00999999978 + 1.0;
    u_xlat0.xyz = u_xlat1.xxx * u_xlat0.xyz + vec3(u_xlat15);
    u_xlat16_3.xyz = vec3(_Lightness) * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat0.x = _Contrast + 100.0;
    u_xlat0.x = u_xlat0.x * 0.00999999978;
    u_xlat16_3.xyz = u_xlat0.xxx * u_xlat16_3.xyz + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.xyz = min(max(u_xlat16_3.xyz, 0.0), 1.0);
#else
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = u_xlat16_3.xyz * vec3(-2.0, -2.0, -2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vec3(vec3(_Invert, _Invert, _Invert)) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * _PostColor.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = _PostColor.www * u_xlat0.xyz + u_xlat16_3.xyz;
    u_xlat1 = vs_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = vec4(_Intensity) * u_xlat1 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0.xyz = (-u_xlat16_2.xyz) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1 = u_xlat1 * u_xlat16_2;
    u_xlat15 = _Blending * _Intensity;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat1.w;
    u_xlat15 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat15) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "INSTANCING_ON" "USE_AUTO_COLOR_CHANGE" "USE_COLOR_ADJUST" "USE_DISTORTION" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DistTex_ST;
uniform 	float _DistFlowX;
uniform 	float _DistFlowY;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
struct PropsArray_Type {
	float _Dist;
	float _TileIndex;
	float _FlipFactor;
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_Props {
#endif
	UNITY_UNIFORM PropsArray_Type PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
vec2 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
float u_xlat6;
int u_xlati6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat3.x = in_POSITION0.x * PropsArray[u_xlati0]._FlipFactor;
    u_xlati6 = int(u_xlati0 << 3);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat3.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat3.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat9 = u_xlat3.x * PropsArray[u_xlati0]._TileIndex;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat9>=(-u_xlat9));
#else
    u_xlatb9 = u_xlat9>=(-u_xlat9);
#endif
    u_xlat3.x = (u_xlatb9) ? u_xlat3.x : (-u_xlat3.x);
    u_xlat6 = PropsArray[u_xlati0]._TileIndex / u_xlat3.y;
    u_xlat6 = floor(u_xlat6);
    u_xlat1.y = (-u_xlat6) + in_TEXCOORD0.y;
    u_xlat6 = float(1.0) / u_xlat3.x;
    u_xlat0.x = u_xlat6 * PropsArray[u_xlati0]._TileIndex;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD0.xy * _DistTex_ST.xy + _DistTex_ST.zw;
    vs_TEXCOORD1.xy = vec2(_DistFlowX, _DistFlowY) * _Time.yy + u_xlat0.xy;
    vs_COLOR0 = in_COLOR0;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	int unity_BaseInstanceID;
uniform 	float _Hue;
uniform 	float _Saturation;
uniform 	float _Lightness;
uniform 	float _Contrast;
uniform 	float _Invert;
uniform 	float _Blending;
uniform 	float _Intensity;
uniform 	vec4 _PostColor;
uniform 	float _AutoColChangeSpeed;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
struct PropsArray_Type {
	float _Dist;
	float _TileIndex;
	float _FlipFactor;
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_Props {
#endif
	UNITY_UNIFORM PropsArray_Type PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _DistTex;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec2 u_xlat16_5;
float u_xlat15;
int u_xlati15;
void main()
{
    u_xlat0.x = _Hue + 180.0;
    u_xlat5.x = _Time.x * _AutoColChangeSpeed;
    u_xlat0.x = u_xlat5.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * 0.0174532924;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat16_5.xy = texture(_DistTex, vs_TEXCOORD1.xy).xy;
    u_xlat5.xy = u_xlat16_5.xy + vec2(-0.5, -0.5);
    u_xlati15 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat5.xy = u_xlat5.xy * vec2(PropsArray[u_xlati15]._Dist) + vs_TEXCOORD0.xy;
    u_xlat16_2 = texture(_MainTex, u_xlat5.xy);
    u_xlat5.xyz = u_xlat16_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat5.xyz = u_xlat16_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat5.zxy);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * u_xlat1.xxx + u_xlat0.xyz;
    u_xlat15 = (-u_xlat1.x) + 1.0;
    u_xlat1.x = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat16_2.xyz);
    u_xlat1.x = u_xlat1.x * 0.57735002;
    u_xlat0.xyz = u_xlat1.xxx * vec3(u_xlat15) + u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat0.xyz = (-vec3(u_xlat15)) + u_xlat0.xyz;
    u_xlat1.x = _Saturation * 0.00999999978 + 1.0;
    u_xlat0.xyz = u_xlat1.xxx * u_xlat0.xyz + vec3(u_xlat15);
    u_xlat16_3.xyz = vec3(_Lightness) * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat0.x = _Contrast + 100.0;
    u_xlat0.x = u_xlat0.x * 0.00999999978;
    u_xlat16_3.xyz = u_xlat0.xxx * u_xlat16_3.xyz + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.xyz = min(max(u_xlat16_3.xyz, 0.0), 1.0);
#else
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = u_xlat16_3.xyz * vec3(-2.0, -2.0, -2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vec3(vec3(_Invert, _Invert, _Invert)) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * _PostColor.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = _PostColor.www * u_xlat0.xyz + u_xlat16_3.xyz;
    u_xlat1 = vs_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = vec4(_Intensity) * u_xlat1 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0.xyz = (-u_xlat16_2.xyz) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1 = u_xlat1 * u_xlat16_2;
    u_xlat15 = _Blending * _Intensity;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat1.w;
    u_xlat15 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat15) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "INSTANCING_ON" "USE_AUTO_COLOR_CHANGE" "USE_COLOR_ADJUST" "USE_DISTORTION" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DistTex_ST;
uniform 	float _DistFlowX;
uniform 	float _DistFlowY;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
struct PropsArray_Type {
	float _Dist;
	float _TileIndex;
	float _FlipFactor;
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_Props {
#endif
	UNITY_UNIFORM PropsArray_Type PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
vec2 u_xlat0;
int u_xlati0;
vec4 u_xlat1;
vec4 u_xlat2;
vec2 u_xlat3;
float u_xlat6;
int u_xlati6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlati0 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat3.x = in_POSITION0.x * PropsArray[u_xlati0]._FlipFactor;
    u_xlati6 = int(u_xlati0 << 3);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat3.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat3.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat9 = u_xlat3.x * PropsArray[u_xlati0]._TileIndex;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat9>=(-u_xlat9));
#else
    u_xlatb9 = u_xlat9>=(-u_xlat9);
#endif
    u_xlat3.x = (u_xlatb9) ? u_xlat3.x : (-u_xlat3.x);
    u_xlat6 = PropsArray[u_xlati0]._TileIndex / u_xlat3.y;
    u_xlat6 = floor(u_xlat6);
    u_xlat1.y = (-u_xlat6) + in_TEXCOORD0.y;
    u_xlat6 = float(1.0) / u_xlat3.x;
    u_xlat0.x = u_xlat6 * PropsArray[u_xlati0]._TileIndex;
    u_xlat0.x = fract(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * u_xlat3.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD0.xy * _DistTex_ST.xy + _DistTex_ST.zw;
    vs_TEXCOORD1.xy = vec2(_DistFlowX, _DistFlowY) * _Time.yy + u_xlat0.xy;
    vs_COLOR0 = in_COLOR0;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	int unity_BaseInstanceID;
uniform 	float _Hue;
uniform 	float _Saturation;
uniform 	float _Lightness;
uniform 	float _Contrast;
uniform 	float _Invert;
uniform 	float _Blending;
uniform 	float _Intensity;
uniform 	vec4 _PostColor;
uniform 	float _AutoColChangeSpeed;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
struct PropsArray_Type {
	float _Dist;
	float _TileIndex;
	float _FlipFactor;
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_Props {
#endif
	UNITY_UNIFORM PropsArray_Type PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _DistTex;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec2 u_xlat16_5;
float u_xlat15;
int u_xlati15;
void main()
{
    u_xlat0.x = _Hue + 180.0;
    u_xlat5.x = _Time.x * _AutoColChangeSpeed;
    u_xlat0.x = u_xlat5.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * 0.0174532924;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat16_5.xy = texture(_DistTex, vs_TEXCOORD1.xy).xy;
    u_xlat5.xy = u_xlat16_5.xy + vec2(-0.5, -0.5);
    u_xlati15 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat5.xy = u_xlat5.xy * vec2(PropsArray[u_xlati15]._Dist) + vs_TEXCOORD0.xy;
    u_xlat16_2 = texture(_MainTex, u_xlat5.xy);
    u_xlat5.xyz = u_xlat16_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat5.xyz = u_xlat16_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat5.zxy);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * u_xlat1.xxx + u_xlat0.xyz;
    u_xlat15 = (-u_xlat1.x) + 1.0;
    u_xlat1.x = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat16_2.xyz);
    u_xlat1.x = u_xlat1.x * 0.57735002;
    u_xlat0.xyz = u_xlat1.xxx * vec3(u_xlat15) + u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat0.xyz = (-vec3(u_xlat15)) + u_xlat0.xyz;
    u_xlat1.x = _Saturation * 0.00999999978 + 1.0;
    u_xlat0.xyz = u_xlat1.xxx * u_xlat0.xyz + vec3(u_xlat15);
    u_xlat16_3.xyz = vec3(_Lightness) * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat0.x = _Contrast + 100.0;
    u_xlat0.x = u_xlat0.x * 0.00999999978;
    u_xlat16_3.xyz = u_xlat0.xxx * u_xlat16_3.xyz + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.xyz = min(max(u_xlat16_3.xyz, 0.0), 1.0);
#else
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = u_xlat16_3.xyz * vec3(-2.0, -2.0, -2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vec3(vec3(_Invert, _Invert, _Invert)) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * _PostColor.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = _PostColor.www * u_xlat0.xyz + u_xlat16_3.xyz;
    u_xlat1 = vs_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = vec4(_Intensity) * u_xlat1 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0.xyz = (-u_xlat16_2.xyz) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1 = u_xlat1 * u_xlat16_2;
    u_xlat15 = _Blending * _Intensity;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat1.w;
    u_xlat15 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat15) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "USE_AUTO_COLOR_CHANGE" "USE_COLOR_ADJUST" "USE_DISTORTION" "USE_VERT_ANI" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DistTex_ST;
uniform 	float _DistFlowX;
uniform 	float _DistFlowY;
uniform 	float _WaveScale;
uniform 	float _WaveSpd;
uniform 	float _WaveDist;
uniform 	float _TileIndex;
uniform 	float _FlipFactor;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = _Time.y * _WaveSpd;
    u_xlat0.x = in_POSITION0.y * _WaveDist + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _WaveScale;
    u_xlat0.x = in_POSITION0.x * _FlipFactor + u_xlat0.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat4 = u_xlat0.x * _TileIndex;
    u_xlatb4 = u_xlat4>=(-u_xlat4);
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2 = _TileIndex / u_xlat0.y;
    u_xlat2 = floor(u_xlat2);
    u_xlat1.y = (-u_xlat2) + in_TEXCOORD0.y;
    u_xlat2 = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat2 * _TileIndex;
    u_xlat2 = fract(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD0.xy * _DistTex_ST.xy + _DistTex_ST.zw;
    vs_TEXCOORD1.xy = _Time.yy * vec2(_DistFlowX, _DistFlowY) + u_xlat0.xy;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec4 _Time;
uniform 	float _Hue;
uniform 	float _Saturation;
uniform 	float _Lightness;
uniform 	float _Contrast;
uniform 	float _Invert;
uniform 	float _Blending;
uniform 	float _Intensity;
uniform 	vec4 _PostColor;
uniform 	float _AutoColChangeSpeed;
uniform 	float _Dist;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
uniform lowp sampler2D _DistTex;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
vec4 u_xlat1;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
lowp vec2 u_xlat10_5;
float u_xlat15;
void main()
{
    u_xlat0.x = _Hue + 180.0;
    u_xlat5.x = _Time.x * _AutoColChangeSpeed;
    u_xlat0.x = u_xlat5.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * 0.0174532924;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat10_5.xy = texture2D(_DistTex, vs_TEXCOORD1.xy).xy;
    u_xlat5.xy = u_xlat10_5.xy + vec2(-0.5, -0.5);
    u_xlat5.xy = u_xlat5.xy * vec2(vec2(_Dist, _Dist)) + vs_TEXCOORD0.xy;
    u_xlat10_2 = texture2D(_MainTex, u_xlat5.xy);
    u_xlat5.xyz = u_xlat10_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat5.xyz = u_xlat10_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat5.zxy);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz;
    u_xlat0.xyz = u_xlat10_2.xyz * u_xlat1.xxx + u_xlat0.xyz;
    u_xlat15 = (-u_xlat1.x) + 1.0;
    u_xlat1.x = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat10_2.xyz);
    u_xlat1.x = u_xlat1.x * 0.57735002;
    u_xlat0.xyz = u_xlat1.xxx * vec3(u_xlat15) + u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat0.xyz = (-vec3(u_xlat15)) + u_xlat0.xyz;
    u_xlat1.x = _Saturation * 0.00999999978 + 1.0;
    u_xlat0.xyz = u_xlat1.xxx * u_xlat0.xyz + vec3(u_xlat15);
    u_xlat16_3.xyz = vec3(_Lightness) * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat0.x = _Contrast + 100.0;
    u_xlat0.x = u_xlat0.x * 0.00999999978;
    u_xlat16_3.xyz = u_xlat0.xxx * u_xlat16_3.xyz + vec3(0.5, 0.5, 0.5);
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_3.xyz * vec3(-2.0, -2.0, -2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vec3(vec3(_Invert, _Invert, _Invert)) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * _PostColor.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = _PostColor.www * u_xlat0.xyz + u_xlat16_3.xyz;
    u_xlat1 = vs_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = vec4(_Intensity) * u_xlat1 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0.xyz = (-u_xlat10_2.xyz) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1 = u_xlat1 * u_xlat10_2;
    u_xlat15 = _Blending * _Intensity;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat1.w;
    u_xlat15 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat15) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "USE_AUTO_COLOR_CHANGE" "USE_COLOR_ADJUST" "USE_DISTORTION" "USE_VERT_ANI" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DistTex_ST;
uniform 	float _DistFlowX;
uniform 	float _DistFlowY;
uniform 	float _WaveScale;
uniform 	float _WaveSpd;
uniform 	float _WaveDist;
uniform 	float _TileIndex;
uniform 	float _FlipFactor;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = _Time.y * _WaveSpd;
    u_xlat0.x = in_POSITION0.y * _WaveDist + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _WaveScale;
    u_xlat0.x = in_POSITION0.x * _FlipFactor + u_xlat0.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat4 = u_xlat0.x * _TileIndex;
    u_xlatb4 = u_xlat4>=(-u_xlat4);
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2 = _TileIndex / u_xlat0.y;
    u_xlat2 = floor(u_xlat2);
    u_xlat1.y = (-u_xlat2) + in_TEXCOORD0.y;
    u_xlat2 = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat2 * _TileIndex;
    u_xlat2 = fract(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD0.xy * _DistTex_ST.xy + _DistTex_ST.zw;
    vs_TEXCOORD1.xy = _Time.yy * vec2(_DistFlowX, _DistFlowY) + u_xlat0.xy;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec4 _Time;
uniform 	float _Hue;
uniform 	float _Saturation;
uniform 	float _Lightness;
uniform 	float _Contrast;
uniform 	float _Invert;
uniform 	float _Blending;
uniform 	float _Intensity;
uniform 	vec4 _PostColor;
uniform 	float _AutoColChangeSpeed;
uniform 	float _Dist;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
uniform lowp sampler2D _DistTex;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
vec4 u_xlat1;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
lowp vec2 u_xlat10_5;
float u_xlat15;
void main()
{
    u_xlat0.x = _Hue + 180.0;
    u_xlat5.x = _Time.x * _AutoColChangeSpeed;
    u_xlat0.x = u_xlat5.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * 0.0174532924;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat10_5.xy = texture2D(_DistTex, vs_TEXCOORD1.xy).xy;
    u_xlat5.xy = u_xlat10_5.xy + vec2(-0.5, -0.5);
    u_xlat5.xy = u_xlat5.xy * vec2(vec2(_Dist, _Dist)) + vs_TEXCOORD0.xy;
    u_xlat10_2 = texture2D(_MainTex, u_xlat5.xy);
    u_xlat5.xyz = u_xlat10_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat5.xyz = u_xlat10_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat5.zxy);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz;
    u_xlat0.xyz = u_xlat10_2.xyz * u_xlat1.xxx + u_xlat0.xyz;
    u_xlat15 = (-u_xlat1.x) + 1.0;
    u_xlat1.x = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat10_2.xyz);
    u_xlat1.x = u_xlat1.x * 0.57735002;
    u_xlat0.xyz = u_xlat1.xxx * vec3(u_xlat15) + u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat0.xyz = (-vec3(u_xlat15)) + u_xlat0.xyz;
    u_xlat1.x = _Saturation * 0.00999999978 + 1.0;
    u_xlat0.xyz = u_xlat1.xxx * u_xlat0.xyz + vec3(u_xlat15);
    u_xlat16_3.xyz = vec3(_Lightness) * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat0.x = _Contrast + 100.0;
    u_xlat0.x = u_xlat0.x * 0.00999999978;
    u_xlat16_3.xyz = u_xlat0.xxx * u_xlat16_3.xyz + vec3(0.5, 0.5, 0.5);
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_3.xyz * vec3(-2.0, -2.0, -2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vec3(vec3(_Invert, _Invert, _Invert)) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * _PostColor.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = _PostColor.www * u_xlat0.xyz + u_xlat16_3.xyz;
    u_xlat1 = vs_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = vec4(_Intensity) * u_xlat1 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0.xyz = (-u_xlat10_2.xyz) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1 = u_xlat1 * u_xlat10_2;
    u_xlat15 = _Blending * _Intensity;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat1.w;
    u_xlat15 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat15) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "USE_AUTO_COLOR_CHANGE" "USE_COLOR_ADJUST" "USE_DISTORTION" "USE_VERT_ANI" }
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DistTex_ST;
uniform 	float _DistFlowX;
uniform 	float _DistFlowY;
uniform 	float _WaveScale;
uniform 	float _WaveSpd;
uniform 	float _WaveDist;
uniform 	float _TileIndex;
uniform 	float _FlipFactor;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = _Time.y * _WaveSpd;
    u_xlat0.x = in_POSITION0.y * _WaveDist + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _WaveScale;
    u_xlat0.x = in_POSITION0.x * _FlipFactor + u_xlat0.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat4 = u_xlat0.x * _TileIndex;
    u_xlatb4 = u_xlat4>=(-u_xlat4);
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2 = _TileIndex / u_xlat0.y;
    u_xlat2 = floor(u_xlat2);
    u_xlat1.y = (-u_xlat2) + in_TEXCOORD0.y;
    u_xlat2 = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat2 * _TileIndex;
    u_xlat2 = fract(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD0.xy * _DistTex_ST.xy + _DistTex_ST.zw;
    vs_TEXCOORD1.xy = _Time.yy * vec2(_DistFlowX, _DistFlowY) + u_xlat0.xy;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 100

#ifdef GL_FRAGMENT_PRECISION_HIGH
    precision highp float;
#else
    precision mediump float;
#endif
precision highp int;
uniform 	vec4 _Time;
uniform 	float _Hue;
uniform 	float _Saturation;
uniform 	float _Lightness;
uniform 	float _Contrast;
uniform 	float _Invert;
uniform 	float _Blending;
uniform 	float _Intensity;
uniform 	vec4 _PostColor;
uniform 	float _AutoColChangeSpeed;
uniform 	float _Dist;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
uniform lowp sampler2D _DistTex;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying mediump vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec3 u_xlat0;
vec4 u_xlat1;
lowp vec4 u_xlat10_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
lowp vec2 u_xlat10_5;
float u_xlat15;
void main()
{
    u_xlat0.x = _Hue + 180.0;
    u_xlat5.x = _Time.x * _AutoColChangeSpeed;
    u_xlat0.x = u_xlat5.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * 0.0174532924;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat10_5.xy = texture2D(_DistTex, vs_TEXCOORD1.xy).xy;
    u_xlat5.xy = u_xlat10_5.xy + vec2(-0.5, -0.5);
    u_xlat5.xy = u_xlat5.xy * vec2(vec2(_Dist, _Dist)) + vs_TEXCOORD0.xy;
    u_xlat10_2 = texture2D(_MainTex, u_xlat5.xy);
    u_xlat5.xyz = u_xlat10_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat5.xyz = u_xlat10_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat5.zxy);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz;
    u_xlat0.xyz = u_xlat10_2.xyz * u_xlat1.xxx + u_xlat0.xyz;
    u_xlat15 = (-u_xlat1.x) + 1.0;
    u_xlat1.x = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat10_2.xyz);
    u_xlat1.x = u_xlat1.x * 0.57735002;
    u_xlat0.xyz = u_xlat1.xxx * vec3(u_xlat15) + u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat0.xyz = (-vec3(u_xlat15)) + u_xlat0.xyz;
    u_xlat1.x = _Saturation * 0.00999999978 + 1.0;
    u_xlat0.xyz = u_xlat1.xxx * u_xlat0.xyz + vec3(u_xlat15);
    u_xlat16_3.xyz = vec3(_Lightness) * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat0.x = _Contrast + 100.0;
    u_xlat0.x = u_xlat0.x * 0.00999999978;
    u_xlat16_3.xyz = u_xlat0.xxx * u_xlat16_3.xyz + vec3(0.5, 0.5, 0.5);
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
    u_xlat16_4.xyz = u_xlat16_3.xyz * vec3(-2.0, -2.0, -2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vec3(vec3(_Invert, _Invert, _Invert)) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * _PostColor.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = _PostColor.www * u_xlat0.xyz + u_xlat16_3.xyz;
    u_xlat1 = vs_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = vec4(_Intensity) * u_xlat1 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0.xyz = (-u_xlat10_2.xyz) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1 = u_xlat1 * u_xlat10_2;
    u_xlat15 = _Blending * _Intensity;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat1.w;
    u_xlat15 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat15) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "USE_VERT_ANI" }
"#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _WaveScale;
uniform 	float _WaveSpd;
uniform 	float _WaveDist;
uniform 	float _TileIndex;
uniform 	float _FlipFactor;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = _Time.y * _WaveSpd;
    u_xlat0.x = in_POSITION0.y * _WaveDist + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _WaveScale;
    u_xlat0.x = in_POSITION0.x * _FlipFactor + u_xlat0.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat4 = u_xlat0.x * _TileIndex;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4>=(-u_xlat4));
#else
    u_xlatb4 = u_xlat4>=(-u_xlat4);
#endif
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2 = _TileIndex / u_xlat0.y;
    u_xlat2 = floor(u_xlat2);
    u_xlat1.y = (-u_xlat2) + in_TEXCOORD0.y;
    u_xlat2 = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat2 * _TileIndex;
    u_xlat2 = fract(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
float u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
void main()
{
    u_xlat0 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat16_1 * vs_COLOR0;
    u_xlat2.xyz = _AdditiveColor.xyz * u_xlat1.www + (-u_xlat1.xyz);
    u_xlat2.xyz = _AdditiveColor.www * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat1.www + (-u_xlat2.xyz);
    SV_Target0.xyz = vec3(u_xlat0) * u_xlat1.xyz + u_xlat2.xyz;
    SV_Target0.w = u_xlat1.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "USE_VERT_ANI" }
"#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _WaveScale;
uniform 	float _WaveSpd;
uniform 	float _WaveDist;
uniform 	float _TileIndex;
uniform 	float _FlipFactor;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = _Time.y * _WaveSpd;
    u_xlat0.x = in_POSITION0.y * _WaveDist + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _WaveScale;
    u_xlat0.x = in_POSITION0.x * _FlipFactor + u_xlat0.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat4 = u_xlat0.x * _TileIndex;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4>=(-u_xlat4));
#else
    u_xlatb4 = u_xlat4>=(-u_xlat4);
#endif
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2 = _TileIndex / u_xlat0.y;
    u_xlat2 = floor(u_xlat2);
    u_xlat1.y = (-u_xlat2) + in_TEXCOORD0.y;
    u_xlat2 = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat2 * _TileIndex;
    u_xlat2 = fract(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
float u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
void main()
{
    u_xlat0 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat16_1 * vs_COLOR0;
    u_xlat2.xyz = _AdditiveColor.xyz * u_xlat1.www + (-u_xlat1.xyz);
    u_xlat2.xyz = _AdditiveColor.www * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat1.www + (-u_xlat2.xyz);
    SV_Target0.xyz = vec3(u_xlat0) * u_xlat1.xyz + u_xlat2.xyz;
    SV_Target0.w = u_xlat1.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "USE_VERT_ANI" }
"#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _WaveScale;
uniform 	float _WaveSpd;
uniform 	float _WaveDist;
uniform 	float _TileIndex;
uniform 	float _FlipFactor;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = _Time.y * _WaveSpd;
    u_xlat0.x = in_POSITION0.y * _WaveDist + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _WaveScale;
    u_xlat0.x = in_POSITION0.x * _FlipFactor + u_xlat0.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat4 = u_xlat0.x * _TileIndex;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4>=(-u_xlat4));
#else
    u_xlatb4 = u_xlat4>=(-u_xlat4);
#endif
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2 = _TileIndex / u_xlat0.y;
    u_xlat2 = floor(u_xlat2);
    u_xlat1.y = (-u_xlat2) + in_TEXCOORD0.y;
    u_xlat2 = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat2 * _TileIndex;
    u_xlat2 = fract(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
float u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
void main()
{
    u_xlat0 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat16_1 * vs_COLOR0;
    u_xlat2.xyz = _AdditiveColor.xyz * u_xlat1.www + (-u_xlat1.xyz);
    u_xlat2.xyz = _AdditiveColor.www * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat1.www + (-u_xlat2.xyz);
    SV_Target0.xyz = vec3(u_xlat0) * u_xlat1.xyz + u_xlat2.xyz;
    SV_Target0.w = u_xlat1.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "INSTANCING_ON" "USE_VERT_ANI" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
uniform 	float _WaveScale;
uniform 	float _WaveSpd;
uniform 	float _WaveDist;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
struct PropsArray_Type {
	float _TileIndex;
	float _FlipFactor;
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityInstancing_Props {
#endif
	UNITY_UNIFORM PropsArray_Type PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
int u_xlati3;
float u_xlat6;
int u_xlati6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = _Time.y * _WaveSpd;
    u_xlat0.x = in_POSITION0.y * _WaveDist + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _WaveScale;
    u_xlati3 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat0.x = in_POSITION0.x * PropsArray[u_xlati3]._FlipFactor + u_xlat0.x;
    u_xlati6 = int(u_xlati3 << 3);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat0.xz = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat9 = u_xlat0.x * PropsArray[u_xlati3]._TileIndex;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat9>=(-u_xlat9));
#else
    u_xlatb9 = u_xlat9>=(-u_xlat9);
#endif
    u_xlat0.x = (u_xlatb9) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat6 = PropsArray[u_xlati3]._TileIndex / u_xlat0.z;
    u_xlat6 = floor(u_xlat6);
    u_xlat1.y = (-u_xlat6) + in_TEXCOORD0.y;
    u_xlat6 = float(1.0) / u_xlat0.x;
    u_xlat3 = u_xlat6 * PropsArray[u_xlati3]._TileIndex;
    u_xlat3 = fract(u_xlat3);
    u_xlat0.x = u_xlat3 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
float u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
void main()
{
    u_xlat0 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat16_1 * vs_COLOR0;
    u_xlat2.xyz = _AdditiveColor.xyz * u_xlat1.www + (-u_xlat1.xyz);
    u_xlat2.xyz = _AdditiveColor.www * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat1.www + (-u_xlat2.xyz);
    SV_Target0.xyz = vec3(u_xlat0) * u_xlat1.xyz + u_xlat2.xyz;
    SV_Target0.w = u_xlat1.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "INSTANCING_ON" "USE_VERT_ANI" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
uniform 	float _WaveScale;
uniform 	float _WaveSpd;
uniform 	float _WaveDist;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
struct PropsArray_Type {
	float _TileIndex;
	float _FlipFactor;
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityInstancing_Props {
#endif
	UNITY_UNIFORM PropsArray_Type PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
int u_xlati3;
float u_xlat6;
int u_xlati6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = _Time.y * _WaveSpd;
    u_xlat0.x = in_POSITION0.y * _WaveDist + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _WaveScale;
    u_xlati3 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat0.x = in_POSITION0.x * PropsArray[u_xlati3]._FlipFactor + u_xlat0.x;
    u_xlati6 = int(u_xlati3 << 3);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat0.xz = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat9 = u_xlat0.x * PropsArray[u_xlati3]._TileIndex;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat9>=(-u_xlat9));
#else
    u_xlatb9 = u_xlat9>=(-u_xlat9);
#endif
    u_xlat0.x = (u_xlatb9) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat6 = PropsArray[u_xlati3]._TileIndex / u_xlat0.z;
    u_xlat6 = floor(u_xlat6);
    u_xlat1.y = (-u_xlat6) + in_TEXCOORD0.y;
    u_xlat6 = float(1.0) / u_xlat0.x;
    u_xlat3 = u_xlat6 * PropsArray[u_xlati3]._TileIndex;
    u_xlat3 = fract(u_xlat3);
    u_xlat0.x = u_xlat3 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
float u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
void main()
{
    u_xlat0 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat16_1 * vs_COLOR0;
    u_xlat2.xyz = _AdditiveColor.xyz * u_xlat1.www + (-u_xlat1.xyz);
    u_xlat2.xyz = _AdditiveColor.www * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat1.www + (-u_xlat2.xyz);
    SV_Target0.xyz = vec3(u_xlat0) * u_xlat1.xyz + u_xlat2.xyz;
    SV_Target0.w = u_xlat1.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "INSTANCING_ON" "USE_VERT_ANI" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
uniform 	float _WaveScale;
uniform 	float _WaveSpd;
uniform 	float _WaveDist;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
struct PropsArray_Type {
	float _TileIndex;
	float _FlipFactor;
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityInstancing_Props {
#endif
	UNITY_UNIFORM PropsArray_Type PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
int u_xlati3;
float u_xlat6;
int u_xlati6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = _Time.y * _WaveSpd;
    u_xlat0.x = in_POSITION0.y * _WaveDist + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _WaveScale;
    u_xlati3 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat0.x = in_POSITION0.x * PropsArray[u_xlati3]._FlipFactor + u_xlat0.x;
    u_xlati6 = int(u_xlati3 << 3);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat0.xz = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat9 = u_xlat0.x * PropsArray[u_xlati3]._TileIndex;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat9>=(-u_xlat9));
#else
    u_xlatb9 = u_xlat9>=(-u_xlat9);
#endif
    u_xlat0.x = (u_xlatb9) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat6 = PropsArray[u_xlati3]._TileIndex / u_xlat0.z;
    u_xlat6 = floor(u_xlat6);
    u_xlat1.y = (-u_xlat6) + in_TEXCOORD0.y;
    u_xlat6 = float(1.0) / u_xlat0.x;
    u_xlat3 = u_xlat6 * PropsArray[u_xlati3]._TileIndex;
    u_xlat3 = fract(u_xlat3);
    u_xlat0.x = u_xlat3 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
float u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
void main()
{
    u_xlat0 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat16_1 * vs_COLOR0;
    u_xlat2.xyz = _AdditiveColor.xyz * u_xlat1.www + (-u_xlat1.xyz);
    u_xlat2.xyz = _AdditiveColor.www * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat1.www + (-u_xlat2.xyz);
    SV_Target0.xyz = vec3(u_xlat0) * u_xlat1.xyz + u_xlat2.xyz;
    SV_Target0.w = u_xlat1.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "USE_AUTO_COLOR_CHANGE" "USE_VERT_ANI" }
"#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _WaveScale;
uniform 	float _WaveSpd;
uniform 	float _WaveDist;
uniform 	float _TileIndex;
uniform 	float _FlipFactor;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = _Time.y * _WaveSpd;
    u_xlat0.x = in_POSITION0.y * _WaveDist + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _WaveScale;
    u_xlat0.x = in_POSITION0.x * _FlipFactor + u_xlat0.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat4 = u_xlat0.x * _TileIndex;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4>=(-u_xlat4));
#else
    u_xlatb4 = u_xlat4>=(-u_xlat4);
#endif
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2 = _TileIndex / u_xlat0.y;
    u_xlat2 = floor(u_xlat2);
    u_xlat1.y = (-u_xlat2) + in_TEXCOORD0.y;
    u_xlat2 = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat2 * _TileIndex;
    u_xlat2 = fract(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
float u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
void main()
{
    u_xlat0 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat16_1 * vs_COLOR0;
    u_xlat2.xyz = _AdditiveColor.xyz * u_xlat1.www + (-u_xlat1.xyz);
    u_xlat2.xyz = _AdditiveColor.www * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat1.www + (-u_xlat2.xyz);
    SV_Target0.xyz = vec3(u_xlat0) * u_xlat1.xyz + u_xlat2.xyz;
    SV_Target0.w = u_xlat1.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "USE_AUTO_COLOR_CHANGE" "USE_VERT_ANI" }
"#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _WaveScale;
uniform 	float _WaveSpd;
uniform 	float _WaveDist;
uniform 	float _TileIndex;
uniform 	float _FlipFactor;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = _Time.y * _WaveSpd;
    u_xlat0.x = in_POSITION0.y * _WaveDist + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _WaveScale;
    u_xlat0.x = in_POSITION0.x * _FlipFactor + u_xlat0.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat4 = u_xlat0.x * _TileIndex;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4>=(-u_xlat4));
#else
    u_xlatb4 = u_xlat4>=(-u_xlat4);
#endif
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2 = _TileIndex / u_xlat0.y;
    u_xlat2 = floor(u_xlat2);
    u_xlat1.y = (-u_xlat2) + in_TEXCOORD0.y;
    u_xlat2 = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat2 * _TileIndex;
    u_xlat2 = fract(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
float u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
void main()
{
    u_xlat0 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat16_1 * vs_COLOR0;
    u_xlat2.xyz = _AdditiveColor.xyz * u_xlat1.www + (-u_xlat1.xyz);
    u_xlat2.xyz = _AdditiveColor.www * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat1.www + (-u_xlat2.xyz);
    SV_Target0.xyz = vec3(u_xlat0) * u_xlat1.xyz + u_xlat2.xyz;
    SV_Target0.w = u_xlat1.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "USE_AUTO_COLOR_CHANGE" "USE_VERT_ANI" }
"#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _WaveScale;
uniform 	float _WaveSpd;
uniform 	float _WaveDist;
uniform 	float _TileIndex;
uniform 	float _FlipFactor;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = _Time.y * _WaveSpd;
    u_xlat0.x = in_POSITION0.y * _WaveDist + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _WaveScale;
    u_xlat0.x = in_POSITION0.x * _FlipFactor + u_xlat0.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat4 = u_xlat0.x * _TileIndex;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4>=(-u_xlat4));
#else
    u_xlatb4 = u_xlat4>=(-u_xlat4);
#endif
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2 = _TileIndex / u_xlat0.y;
    u_xlat2 = floor(u_xlat2);
    u_xlat1.y = (-u_xlat2) + in_TEXCOORD0.y;
    u_xlat2 = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat2 * _TileIndex;
    u_xlat2 = fract(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
float u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
void main()
{
    u_xlat0 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat16_1 * vs_COLOR0;
    u_xlat2.xyz = _AdditiveColor.xyz * u_xlat1.www + (-u_xlat1.xyz);
    u_xlat2.xyz = _AdditiveColor.www * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat1.www + (-u_xlat2.xyz);
    SV_Target0.xyz = vec3(u_xlat0) * u_xlat1.xyz + u_xlat2.xyz;
    SV_Target0.w = u_xlat1.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "INSTANCING_ON" "USE_AUTO_COLOR_CHANGE" "USE_VERT_ANI" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
uniform 	float _WaveScale;
uniform 	float _WaveSpd;
uniform 	float _WaveDist;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
struct PropsArray_Type {
	float _TileIndex;
	float _FlipFactor;
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityInstancing_Props {
#endif
	UNITY_UNIFORM PropsArray_Type PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
int u_xlati3;
float u_xlat6;
int u_xlati6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = _Time.y * _WaveSpd;
    u_xlat0.x = in_POSITION0.y * _WaveDist + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _WaveScale;
    u_xlati3 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat0.x = in_POSITION0.x * PropsArray[u_xlati3]._FlipFactor + u_xlat0.x;
    u_xlati6 = int(u_xlati3 << 3);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat0.xz = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat9 = u_xlat0.x * PropsArray[u_xlati3]._TileIndex;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat9>=(-u_xlat9));
#else
    u_xlatb9 = u_xlat9>=(-u_xlat9);
#endif
    u_xlat0.x = (u_xlatb9) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat6 = PropsArray[u_xlati3]._TileIndex / u_xlat0.z;
    u_xlat6 = floor(u_xlat6);
    u_xlat1.y = (-u_xlat6) + in_TEXCOORD0.y;
    u_xlat6 = float(1.0) / u_xlat0.x;
    u_xlat3 = u_xlat6 * PropsArray[u_xlati3]._TileIndex;
    u_xlat3 = fract(u_xlat3);
    u_xlat0.x = u_xlat3 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
float u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
void main()
{
    u_xlat0 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat16_1 * vs_COLOR0;
    u_xlat2.xyz = _AdditiveColor.xyz * u_xlat1.www + (-u_xlat1.xyz);
    u_xlat2.xyz = _AdditiveColor.www * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat1.www + (-u_xlat2.xyz);
    SV_Target0.xyz = vec3(u_xlat0) * u_xlat1.xyz + u_xlat2.xyz;
    SV_Target0.w = u_xlat1.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "INSTANCING_ON" "USE_AUTO_COLOR_CHANGE" "USE_VERT_ANI" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
uniform 	float _WaveScale;
uniform 	float _WaveSpd;
uniform 	float _WaveDist;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
struct PropsArray_Type {
	float _TileIndex;
	float _FlipFactor;
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityInstancing_Props {
#endif
	UNITY_UNIFORM PropsArray_Type PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
int u_xlati3;
float u_xlat6;
int u_xlati6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = _Time.y * _WaveSpd;
    u_xlat0.x = in_POSITION0.y * _WaveDist + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _WaveScale;
    u_xlati3 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat0.x = in_POSITION0.x * PropsArray[u_xlati3]._FlipFactor + u_xlat0.x;
    u_xlati6 = int(u_xlati3 << 3);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat0.xz = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat9 = u_xlat0.x * PropsArray[u_xlati3]._TileIndex;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat9>=(-u_xlat9));
#else
    u_xlatb9 = u_xlat9>=(-u_xlat9);
#endif
    u_xlat0.x = (u_xlatb9) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat6 = PropsArray[u_xlati3]._TileIndex / u_xlat0.z;
    u_xlat6 = floor(u_xlat6);
    u_xlat1.y = (-u_xlat6) + in_TEXCOORD0.y;
    u_xlat6 = float(1.0) / u_xlat0.x;
    u_xlat3 = u_xlat6 * PropsArray[u_xlati3]._TileIndex;
    u_xlat3 = fract(u_xlat3);
    u_xlat0.x = u_xlat3 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
float u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
void main()
{
    u_xlat0 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat16_1 * vs_COLOR0;
    u_xlat2.xyz = _AdditiveColor.xyz * u_xlat1.www + (-u_xlat1.xyz);
    u_xlat2.xyz = _AdditiveColor.www * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat1.www + (-u_xlat2.xyz);
    SV_Target0.xyz = vec3(u_xlat0) * u_xlat1.xyz + u_xlat2.xyz;
    SV_Target0.w = u_xlat1.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "INSTANCING_ON" "USE_AUTO_COLOR_CHANGE" "USE_VERT_ANI" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
uniform 	float _WaveScale;
uniform 	float _WaveSpd;
uniform 	float _WaveDist;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
struct PropsArray_Type {
	float _TileIndex;
	float _FlipFactor;
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityInstancing_Props {
#endif
	UNITY_UNIFORM PropsArray_Type PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
int u_xlati3;
float u_xlat6;
int u_xlati6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = _Time.y * _WaveSpd;
    u_xlat0.x = in_POSITION0.y * _WaveDist + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _WaveScale;
    u_xlati3 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat0.x = in_POSITION0.x * PropsArray[u_xlati3]._FlipFactor + u_xlat0.x;
    u_xlati6 = int(u_xlati3 << 3);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat0.xz = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat9 = u_xlat0.x * PropsArray[u_xlati3]._TileIndex;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat9>=(-u_xlat9));
#else
    u_xlatb9 = u_xlat9>=(-u_xlat9);
#endif
    u_xlat0.x = (u_xlatb9) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat6 = PropsArray[u_xlati3]._TileIndex / u_xlat0.z;
    u_xlat6 = floor(u_xlat6);
    u_xlat1.y = (-u_xlat6) + in_TEXCOORD0.y;
    u_xlat6 = float(1.0) / u_xlat0.x;
    u_xlat3 = u_xlat6 * PropsArray[u_xlati3]._TileIndex;
    u_xlat3 = fract(u_xlat3);
    u_xlat0.x = u_xlat3 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
float u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
void main()
{
    u_xlat0 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    u_xlat16_1 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat1 = u_xlat16_1 * vs_COLOR0;
    u_xlat2.xyz = _AdditiveColor.xyz * u_xlat1.www + (-u_xlat1.xyz);
    u_xlat2.xyz = _AdditiveColor.www * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat1.www + (-u_xlat2.xyz);
    SV_Target0.xyz = vec3(u_xlat0) * u_xlat1.xyz + u_xlat2.xyz;
    SV_Target0.w = u_xlat1.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "USE_COLOR_ADJUST" "USE_VERT_ANI" }
"#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _WaveScale;
uniform 	float _WaveSpd;
uniform 	float _WaveDist;
uniform 	float _TileIndex;
uniform 	float _FlipFactor;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = _Time.y * _WaveSpd;
    u_xlat0.x = in_POSITION0.y * _WaveDist + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _WaveScale;
    u_xlat0.x = in_POSITION0.x * _FlipFactor + u_xlat0.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat4 = u_xlat0.x * _TileIndex;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4>=(-u_xlat4));
#else
    u_xlatb4 = u_xlat4>=(-u_xlat4);
#endif
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2 = _TileIndex / u_xlat0.y;
    u_xlat2 = floor(u_xlat2);
    u_xlat1.y = (-u_xlat2) + in_TEXCOORD0.y;
    u_xlat2 = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat2 * _TileIndex;
    u_xlat2 = fract(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	float _Hue;
uniform 	float _Saturation;
uniform 	float _Lightness;
uniform 	float _Contrast;
uniform 	float _Invert;
uniform 	float _Blending;
uniform 	float _Intensity;
uniform 	vec4 _PostColor;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
float u_xlat15;
void main()
{
    u_xlat0.x = _Hue * 0.0174532924;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat5.xyz = u_xlat16_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat5.xyz = u_xlat16_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat5.zxy);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * u_xlat1.xxx + u_xlat0.xyz;
    u_xlat15 = (-u_xlat1.x) + 1.0;
    u_xlat1.x = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat16_2.xyz);
    u_xlat1.x = u_xlat1.x * 0.57735002;
    u_xlat0.xyz = u_xlat1.xxx * vec3(u_xlat15) + u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat0.xyz = (-vec3(u_xlat15)) + u_xlat0.xyz;
    u_xlat1.x = _Saturation * 0.00999999978 + 1.0;
    u_xlat0.xyz = u_xlat1.xxx * u_xlat0.xyz + vec3(u_xlat15);
    u_xlat16_3.xyz = vec3(vec3(_Lightness, _Lightness, _Lightness)) * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat0.x = _Contrast + 100.0;
    u_xlat0.x = u_xlat0.x * 0.00999999978;
    u_xlat16_3.xyz = u_xlat0.xxx * u_xlat16_3.xyz + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.xyz = min(max(u_xlat16_3.xyz, 0.0), 1.0);
#else
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = u_xlat16_3.xyz * vec3(-2.0, -2.0, -2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vec3(_Invert) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * _PostColor.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = _PostColor.www * u_xlat0.xyz + u_xlat16_3.xyz;
    u_xlat1 = vs_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = vec4(vec4(_Intensity, _Intensity, _Intensity, _Intensity)) * u_xlat1 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0.xyz = (-u_xlat16_2.xyz) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1 = u_xlat1 * u_xlat16_2;
    u_xlat15 = _Intensity * _Blending;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat1.w;
    u_xlat15 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat15) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "USE_COLOR_ADJUST" "USE_VERT_ANI" }
"#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _WaveScale;
uniform 	float _WaveSpd;
uniform 	float _WaveDist;
uniform 	float _TileIndex;
uniform 	float _FlipFactor;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = _Time.y * _WaveSpd;
    u_xlat0.x = in_POSITION0.y * _WaveDist + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _WaveScale;
    u_xlat0.x = in_POSITION0.x * _FlipFactor + u_xlat0.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat4 = u_xlat0.x * _TileIndex;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4>=(-u_xlat4));
#else
    u_xlatb4 = u_xlat4>=(-u_xlat4);
#endif
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2 = _TileIndex / u_xlat0.y;
    u_xlat2 = floor(u_xlat2);
    u_xlat1.y = (-u_xlat2) + in_TEXCOORD0.y;
    u_xlat2 = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat2 * _TileIndex;
    u_xlat2 = fract(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	float _Hue;
uniform 	float _Saturation;
uniform 	float _Lightness;
uniform 	float _Contrast;
uniform 	float _Invert;
uniform 	float _Blending;
uniform 	float _Intensity;
uniform 	vec4 _PostColor;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
float u_xlat15;
void main()
{
    u_xlat0.x = _Hue * 0.0174532924;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat5.xyz = u_xlat16_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat5.xyz = u_xlat16_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat5.zxy);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * u_xlat1.xxx + u_xlat0.xyz;
    u_xlat15 = (-u_xlat1.x) + 1.0;
    u_xlat1.x = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat16_2.xyz);
    u_xlat1.x = u_xlat1.x * 0.57735002;
    u_xlat0.xyz = u_xlat1.xxx * vec3(u_xlat15) + u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat0.xyz = (-vec3(u_xlat15)) + u_xlat0.xyz;
    u_xlat1.x = _Saturation * 0.00999999978 + 1.0;
    u_xlat0.xyz = u_xlat1.xxx * u_xlat0.xyz + vec3(u_xlat15);
    u_xlat16_3.xyz = vec3(vec3(_Lightness, _Lightness, _Lightness)) * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat0.x = _Contrast + 100.0;
    u_xlat0.x = u_xlat0.x * 0.00999999978;
    u_xlat16_3.xyz = u_xlat0.xxx * u_xlat16_3.xyz + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.xyz = min(max(u_xlat16_3.xyz, 0.0), 1.0);
#else
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = u_xlat16_3.xyz * vec3(-2.0, -2.0, -2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vec3(_Invert) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * _PostColor.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = _PostColor.www * u_xlat0.xyz + u_xlat16_3.xyz;
    u_xlat1 = vs_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = vec4(vec4(_Intensity, _Intensity, _Intensity, _Intensity)) * u_xlat1 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0.xyz = (-u_xlat16_2.xyz) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1 = u_xlat1 * u_xlat16_2;
    u_xlat15 = _Intensity * _Blending;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat1.w;
    u_xlat15 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat15) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "USE_COLOR_ADJUST" "USE_VERT_ANI" }
"#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _WaveScale;
uniform 	float _WaveSpd;
uniform 	float _WaveDist;
uniform 	float _TileIndex;
uniform 	float _FlipFactor;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = _Time.y * _WaveSpd;
    u_xlat0.x = in_POSITION0.y * _WaveDist + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _WaveScale;
    u_xlat0.x = in_POSITION0.x * _FlipFactor + u_xlat0.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat4 = u_xlat0.x * _TileIndex;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4>=(-u_xlat4));
#else
    u_xlatb4 = u_xlat4>=(-u_xlat4);
#endif
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2 = _TileIndex / u_xlat0.y;
    u_xlat2 = floor(u_xlat2);
    u_xlat1.y = (-u_xlat2) + in_TEXCOORD0.y;
    u_xlat2 = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat2 * _TileIndex;
    u_xlat2 = fract(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	float _Hue;
uniform 	float _Saturation;
uniform 	float _Lightness;
uniform 	float _Contrast;
uniform 	float _Invert;
uniform 	float _Blending;
uniform 	float _Intensity;
uniform 	vec4 _PostColor;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
float u_xlat15;
void main()
{
    u_xlat0.x = _Hue * 0.0174532924;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat5.xyz = u_xlat16_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat5.xyz = u_xlat16_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat5.zxy);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * u_xlat1.xxx + u_xlat0.xyz;
    u_xlat15 = (-u_xlat1.x) + 1.0;
    u_xlat1.x = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat16_2.xyz);
    u_xlat1.x = u_xlat1.x * 0.57735002;
    u_xlat0.xyz = u_xlat1.xxx * vec3(u_xlat15) + u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat0.xyz = (-vec3(u_xlat15)) + u_xlat0.xyz;
    u_xlat1.x = _Saturation * 0.00999999978 + 1.0;
    u_xlat0.xyz = u_xlat1.xxx * u_xlat0.xyz + vec3(u_xlat15);
    u_xlat16_3.xyz = vec3(vec3(_Lightness, _Lightness, _Lightness)) * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat0.x = _Contrast + 100.0;
    u_xlat0.x = u_xlat0.x * 0.00999999978;
    u_xlat16_3.xyz = u_xlat0.xxx * u_xlat16_3.xyz + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.xyz = min(max(u_xlat16_3.xyz, 0.0), 1.0);
#else
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = u_xlat16_3.xyz * vec3(-2.0, -2.0, -2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vec3(_Invert) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * _PostColor.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = _PostColor.www * u_xlat0.xyz + u_xlat16_3.xyz;
    u_xlat1 = vs_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = vec4(vec4(_Intensity, _Intensity, _Intensity, _Intensity)) * u_xlat1 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0.xyz = (-u_xlat16_2.xyz) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1 = u_xlat1 * u_xlat16_2;
    u_xlat15 = _Intensity * _Blending;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat1.w;
    u_xlat15 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat15) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "INSTANCING_ON" "USE_COLOR_ADJUST" "USE_VERT_ANI" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
uniform 	float _WaveScale;
uniform 	float _WaveSpd;
uniform 	float _WaveDist;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
struct PropsArray_Type {
	float _TileIndex;
	float _FlipFactor;
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityInstancing_Props {
#endif
	UNITY_UNIFORM PropsArray_Type PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
int u_xlati3;
float u_xlat6;
int u_xlati6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = _Time.y * _WaveSpd;
    u_xlat0.x = in_POSITION0.y * _WaveDist + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _WaveScale;
    u_xlati3 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat0.x = in_POSITION0.x * PropsArray[u_xlati3]._FlipFactor + u_xlat0.x;
    u_xlati6 = int(u_xlati3 << 3);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat0.xz = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat9 = u_xlat0.x * PropsArray[u_xlati3]._TileIndex;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat9>=(-u_xlat9));
#else
    u_xlatb9 = u_xlat9>=(-u_xlat9);
#endif
    u_xlat0.x = (u_xlatb9) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat6 = PropsArray[u_xlati3]._TileIndex / u_xlat0.z;
    u_xlat6 = floor(u_xlat6);
    u_xlat1.y = (-u_xlat6) + in_TEXCOORD0.y;
    u_xlat6 = float(1.0) / u_xlat0.x;
    u_xlat3 = u_xlat6 * PropsArray[u_xlati3]._TileIndex;
    u_xlat3 = fract(u_xlat3);
    u_xlat0.x = u_xlat3 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	float _Hue;
uniform 	float _Saturation;
uniform 	float _Lightness;
uniform 	float _Contrast;
uniform 	float _Invert;
uniform 	float _Blending;
uniform 	float _Intensity;
uniform 	vec4 _PostColor;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
float u_xlat15;
void main()
{
    u_xlat0.x = _Hue * 0.0174532924;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat5.xyz = u_xlat16_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat5.xyz = u_xlat16_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat5.zxy);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * u_xlat1.xxx + u_xlat0.xyz;
    u_xlat15 = (-u_xlat1.x) + 1.0;
    u_xlat1.x = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat16_2.xyz);
    u_xlat1.x = u_xlat1.x * 0.57735002;
    u_xlat0.xyz = u_xlat1.xxx * vec3(u_xlat15) + u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat0.xyz = (-vec3(u_xlat15)) + u_xlat0.xyz;
    u_xlat1.x = _Saturation * 0.00999999978 + 1.0;
    u_xlat0.xyz = u_xlat1.xxx * u_xlat0.xyz + vec3(u_xlat15);
    u_xlat16_3.xyz = vec3(vec3(_Lightness, _Lightness, _Lightness)) * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat0.x = _Contrast + 100.0;
    u_xlat0.x = u_xlat0.x * 0.00999999978;
    u_xlat16_3.xyz = u_xlat0.xxx * u_xlat16_3.xyz + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.xyz = min(max(u_xlat16_3.xyz, 0.0), 1.0);
#else
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = u_xlat16_3.xyz * vec3(-2.0, -2.0, -2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vec3(_Invert) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * _PostColor.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = _PostColor.www * u_xlat0.xyz + u_xlat16_3.xyz;
    u_xlat1 = vs_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = vec4(vec4(_Intensity, _Intensity, _Intensity, _Intensity)) * u_xlat1 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0.xyz = (-u_xlat16_2.xyz) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1 = u_xlat1 * u_xlat16_2;
    u_xlat15 = _Intensity * _Blending;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat1.w;
    u_xlat15 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat15) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "INSTANCING_ON" "USE_COLOR_ADJUST" "USE_VERT_ANI" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
uniform 	float _WaveScale;
uniform 	float _WaveSpd;
uniform 	float _WaveDist;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
struct PropsArray_Type {
	float _TileIndex;
	float _FlipFactor;
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityInstancing_Props {
#endif
	UNITY_UNIFORM PropsArray_Type PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
int u_xlati3;
float u_xlat6;
int u_xlati6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = _Time.y * _WaveSpd;
    u_xlat0.x = in_POSITION0.y * _WaveDist + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _WaveScale;
    u_xlati3 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat0.x = in_POSITION0.x * PropsArray[u_xlati3]._FlipFactor + u_xlat0.x;
    u_xlati6 = int(u_xlati3 << 3);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat0.xz = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat9 = u_xlat0.x * PropsArray[u_xlati3]._TileIndex;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat9>=(-u_xlat9));
#else
    u_xlatb9 = u_xlat9>=(-u_xlat9);
#endif
    u_xlat0.x = (u_xlatb9) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat6 = PropsArray[u_xlati3]._TileIndex / u_xlat0.z;
    u_xlat6 = floor(u_xlat6);
    u_xlat1.y = (-u_xlat6) + in_TEXCOORD0.y;
    u_xlat6 = float(1.0) / u_xlat0.x;
    u_xlat3 = u_xlat6 * PropsArray[u_xlati3]._TileIndex;
    u_xlat3 = fract(u_xlat3);
    u_xlat0.x = u_xlat3 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	float _Hue;
uniform 	float _Saturation;
uniform 	float _Lightness;
uniform 	float _Contrast;
uniform 	float _Invert;
uniform 	float _Blending;
uniform 	float _Intensity;
uniform 	vec4 _PostColor;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
float u_xlat15;
void main()
{
    u_xlat0.x = _Hue * 0.0174532924;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat5.xyz = u_xlat16_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat5.xyz = u_xlat16_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat5.zxy);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * u_xlat1.xxx + u_xlat0.xyz;
    u_xlat15 = (-u_xlat1.x) + 1.0;
    u_xlat1.x = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat16_2.xyz);
    u_xlat1.x = u_xlat1.x * 0.57735002;
    u_xlat0.xyz = u_xlat1.xxx * vec3(u_xlat15) + u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat0.xyz = (-vec3(u_xlat15)) + u_xlat0.xyz;
    u_xlat1.x = _Saturation * 0.00999999978 + 1.0;
    u_xlat0.xyz = u_xlat1.xxx * u_xlat0.xyz + vec3(u_xlat15);
    u_xlat16_3.xyz = vec3(vec3(_Lightness, _Lightness, _Lightness)) * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat0.x = _Contrast + 100.0;
    u_xlat0.x = u_xlat0.x * 0.00999999978;
    u_xlat16_3.xyz = u_xlat0.xxx * u_xlat16_3.xyz + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.xyz = min(max(u_xlat16_3.xyz, 0.0), 1.0);
#else
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = u_xlat16_3.xyz * vec3(-2.0, -2.0, -2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vec3(_Invert) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * _PostColor.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = _PostColor.www * u_xlat0.xyz + u_xlat16_3.xyz;
    u_xlat1 = vs_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = vec4(vec4(_Intensity, _Intensity, _Intensity, _Intensity)) * u_xlat1 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0.xyz = (-u_xlat16_2.xyz) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1 = u_xlat1 * u_xlat16_2;
    u_xlat15 = _Intensity * _Blending;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat1.w;
    u_xlat15 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat15) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "INSTANCING_ON" "USE_COLOR_ADJUST" "USE_VERT_ANI" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
uniform 	float _WaveScale;
uniform 	float _WaveSpd;
uniform 	float _WaveDist;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
struct PropsArray_Type {
	float _TileIndex;
	float _FlipFactor;
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityInstancing_Props {
#endif
	UNITY_UNIFORM PropsArray_Type PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
int u_xlati3;
float u_xlat6;
int u_xlati6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = _Time.y * _WaveSpd;
    u_xlat0.x = in_POSITION0.y * _WaveDist + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _WaveScale;
    u_xlati3 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat0.x = in_POSITION0.x * PropsArray[u_xlati3]._FlipFactor + u_xlat0.x;
    u_xlati6 = int(u_xlati3 << 3);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat0.xz = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat9 = u_xlat0.x * PropsArray[u_xlati3]._TileIndex;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat9>=(-u_xlat9));
#else
    u_xlatb9 = u_xlat9>=(-u_xlat9);
#endif
    u_xlat0.x = (u_xlatb9) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat6 = PropsArray[u_xlati3]._TileIndex / u_xlat0.z;
    u_xlat6 = floor(u_xlat6);
    u_xlat1.y = (-u_xlat6) + in_TEXCOORD0.y;
    u_xlat6 = float(1.0) / u_xlat0.x;
    u_xlat3 = u_xlat6 * PropsArray[u_xlati3]._TileIndex;
    u_xlat3 = fract(u_xlat3);
    u_xlat0.x = u_xlat3 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	float _Hue;
uniform 	float _Saturation;
uniform 	float _Lightness;
uniform 	float _Contrast;
uniform 	float _Invert;
uniform 	float _Blending;
uniform 	float _Intensity;
uniform 	vec4 _PostColor;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
float u_xlat15;
void main()
{
    u_xlat0.x = _Hue * 0.0174532924;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat5.xyz = u_xlat16_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat5.xyz = u_xlat16_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat5.zxy);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * u_xlat1.xxx + u_xlat0.xyz;
    u_xlat15 = (-u_xlat1.x) + 1.0;
    u_xlat1.x = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat16_2.xyz);
    u_xlat1.x = u_xlat1.x * 0.57735002;
    u_xlat0.xyz = u_xlat1.xxx * vec3(u_xlat15) + u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat0.xyz = (-vec3(u_xlat15)) + u_xlat0.xyz;
    u_xlat1.x = _Saturation * 0.00999999978 + 1.0;
    u_xlat0.xyz = u_xlat1.xxx * u_xlat0.xyz + vec3(u_xlat15);
    u_xlat16_3.xyz = vec3(vec3(_Lightness, _Lightness, _Lightness)) * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat0.x = _Contrast + 100.0;
    u_xlat0.x = u_xlat0.x * 0.00999999978;
    u_xlat16_3.xyz = u_xlat0.xxx * u_xlat16_3.xyz + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.xyz = min(max(u_xlat16_3.xyz, 0.0), 1.0);
#else
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = u_xlat16_3.xyz * vec3(-2.0, -2.0, -2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vec3(_Invert) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * _PostColor.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = _PostColor.www * u_xlat0.xyz + u_xlat16_3.xyz;
    u_xlat1 = vs_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = vec4(vec4(_Intensity, _Intensity, _Intensity, _Intensity)) * u_xlat1 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0.xyz = (-u_xlat16_2.xyz) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1 = u_xlat1 * u_xlat16_2;
    u_xlat15 = _Intensity * _Blending;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat1.w;
    u_xlat15 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat15) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "USE_AUTO_COLOR_CHANGE" "USE_COLOR_ADJUST" "USE_VERT_ANI" }
"#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _WaveScale;
uniform 	float _WaveSpd;
uniform 	float _WaveDist;
uniform 	float _TileIndex;
uniform 	float _FlipFactor;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = _Time.y * _WaveSpd;
    u_xlat0.x = in_POSITION0.y * _WaveDist + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _WaveScale;
    u_xlat0.x = in_POSITION0.x * _FlipFactor + u_xlat0.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat4 = u_xlat0.x * _TileIndex;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4>=(-u_xlat4));
#else
    u_xlatb4 = u_xlat4>=(-u_xlat4);
#endif
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2 = _TileIndex / u_xlat0.y;
    u_xlat2 = floor(u_xlat2);
    u_xlat1.y = (-u_xlat2) + in_TEXCOORD0.y;
    u_xlat2 = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat2 * _TileIndex;
    u_xlat2 = fract(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	float _Hue;
uniform 	float _Saturation;
uniform 	float _Lightness;
uniform 	float _Contrast;
uniform 	float _Invert;
uniform 	float _Blending;
uniform 	float _Intensity;
uniform 	vec4 _PostColor;
uniform 	float _AutoColChangeSpeed;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat6;
float u_xlat15;
void main()
{
    u_xlat0.x = _Time.x * _AutoColChangeSpeed;
    u_xlat0.yz = vec2(_Hue, _Contrast) + vec2(180.0, 100.0);
    u_xlat0.x = u_xlat0.x * u_xlat0.y;
    u_xlat0.xy = u_xlat0.xz * vec2(0.0174532924, 0.00999999978);
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat6.xyz = u_xlat16_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat6.xyz = u_xlat16_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat6.zxy);
    u_xlat0.xzw = u_xlat0.xxx * u_xlat6.xyz;
    u_xlat0.xzw = u_xlat16_2.xyz * u_xlat1.xxx + u_xlat0.xzw;
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat6.x = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat16_2.xyz);
    u_xlat6.x = u_xlat6.x * 0.57735002;
    u_xlat0.xzw = u_xlat6.xxx * u_xlat1.xxx + u_xlat0.xzw;
    u_xlat1.x = dot(u_xlat0.xzw, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat0.xzw = u_xlat0.xzw + (-u_xlat1.xxx);
    u_xlat6.x = _Saturation * 0.00999999978 + 1.0;
    u_xlat0.xzw = u_xlat6.xxx * u_xlat0.xzw + u_xlat1.xxx;
    u_xlat16_3.xyz = vec3(vec3(_Lightness, _Lightness, _Lightness)) * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat0.xzw;
    u_xlat16_3.xyz = u_xlat16_3.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat16_3.xyz = u_xlat0.yyy * u_xlat16_3.xyz + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.xyz = min(max(u_xlat16_3.xyz, 0.0), 1.0);
#else
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = u_xlat16_3.xyz * vec3(-2.0, -2.0, -2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vec3(_Invert) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * _PostColor.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = _PostColor.www * u_xlat0.xyz + u_xlat16_3.xyz;
    u_xlat1 = vs_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = vec4(vec4(_Intensity, _Intensity, _Intensity, _Intensity)) * u_xlat1 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0.xyz = (-u_xlat16_2.xyz) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1 = u_xlat1 * u_xlat16_2;
    u_xlat15 = _Intensity * _Blending;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat1.w;
    u_xlat15 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat15) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "USE_AUTO_COLOR_CHANGE" "USE_COLOR_ADJUST" "USE_VERT_ANI" }
"#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _WaveScale;
uniform 	float _WaveSpd;
uniform 	float _WaveDist;
uniform 	float _TileIndex;
uniform 	float _FlipFactor;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = _Time.y * _WaveSpd;
    u_xlat0.x = in_POSITION0.y * _WaveDist + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _WaveScale;
    u_xlat0.x = in_POSITION0.x * _FlipFactor + u_xlat0.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat4 = u_xlat0.x * _TileIndex;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4>=(-u_xlat4));
#else
    u_xlatb4 = u_xlat4>=(-u_xlat4);
#endif
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2 = _TileIndex / u_xlat0.y;
    u_xlat2 = floor(u_xlat2);
    u_xlat1.y = (-u_xlat2) + in_TEXCOORD0.y;
    u_xlat2 = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat2 * _TileIndex;
    u_xlat2 = fract(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	float _Hue;
uniform 	float _Saturation;
uniform 	float _Lightness;
uniform 	float _Contrast;
uniform 	float _Invert;
uniform 	float _Blending;
uniform 	float _Intensity;
uniform 	vec4 _PostColor;
uniform 	float _AutoColChangeSpeed;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat6;
float u_xlat15;
void main()
{
    u_xlat0.x = _Time.x * _AutoColChangeSpeed;
    u_xlat0.yz = vec2(_Hue, _Contrast) + vec2(180.0, 100.0);
    u_xlat0.x = u_xlat0.x * u_xlat0.y;
    u_xlat0.xy = u_xlat0.xz * vec2(0.0174532924, 0.00999999978);
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat6.xyz = u_xlat16_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat6.xyz = u_xlat16_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat6.zxy);
    u_xlat0.xzw = u_xlat0.xxx * u_xlat6.xyz;
    u_xlat0.xzw = u_xlat16_2.xyz * u_xlat1.xxx + u_xlat0.xzw;
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat6.x = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat16_2.xyz);
    u_xlat6.x = u_xlat6.x * 0.57735002;
    u_xlat0.xzw = u_xlat6.xxx * u_xlat1.xxx + u_xlat0.xzw;
    u_xlat1.x = dot(u_xlat0.xzw, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat0.xzw = u_xlat0.xzw + (-u_xlat1.xxx);
    u_xlat6.x = _Saturation * 0.00999999978 + 1.0;
    u_xlat0.xzw = u_xlat6.xxx * u_xlat0.xzw + u_xlat1.xxx;
    u_xlat16_3.xyz = vec3(vec3(_Lightness, _Lightness, _Lightness)) * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat0.xzw;
    u_xlat16_3.xyz = u_xlat16_3.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat16_3.xyz = u_xlat0.yyy * u_xlat16_3.xyz + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.xyz = min(max(u_xlat16_3.xyz, 0.0), 1.0);
#else
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = u_xlat16_3.xyz * vec3(-2.0, -2.0, -2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vec3(_Invert) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * _PostColor.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = _PostColor.www * u_xlat0.xyz + u_xlat16_3.xyz;
    u_xlat1 = vs_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = vec4(vec4(_Intensity, _Intensity, _Intensity, _Intensity)) * u_xlat1 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0.xyz = (-u_xlat16_2.xyz) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1 = u_xlat1 * u_xlat16_2;
    u_xlat15 = _Intensity * _Blending;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat1.w;
    u_xlat15 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat15) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "USE_AUTO_COLOR_CHANGE" "USE_COLOR_ADJUST" "USE_VERT_ANI" }
"#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _WaveScale;
uniform 	float _WaveSpd;
uniform 	float _WaveDist;
uniform 	float _TileIndex;
uniform 	float _FlipFactor;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = _Time.y * _WaveSpd;
    u_xlat0.x = in_POSITION0.y * _WaveDist + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _WaveScale;
    u_xlat0.x = in_POSITION0.x * _FlipFactor + u_xlat0.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat4 = u_xlat0.x * _TileIndex;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4>=(-u_xlat4));
#else
    u_xlatb4 = u_xlat4>=(-u_xlat4);
#endif
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2 = _TileIndex / u_xlat0.y;
    u_xlat2 = floor(u_xlat2);
    u_xlat1.y = (-u_xlat2) + in_TEXCOORD0.y;
    u_xlat2 = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat2 * _TileIndex;
    u_xlat2 = fract(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	float _Hue;
uniform 	float _Saturation;
uniform 	float _Lightness;
uniform 	float _Contrast;
uniform 	float _Invert;
uniform 	float _Blending;
uniform 	float _Intensity;
uniform 	vec4 _PostColor;
uniform 	float _AutoColChangeSpeed;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat6;
float u_xlat15;
void main()
{
    u_xlat0.x = _Time.x * _AutoColChangeSpeed;
    u_xlat0.yz = vec2(_Hue, _Contrast) + vec2(180.0, 100.0);
    u_xlat0.x = u_xlat0.x * u_xlat0.y;
    u_xlat0.xy = u_xlat0.xz * vec2(0.0174532924, 0.00999999978);
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat6.xyz = u_xlat16_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat6.xyz = u_xlat16_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat6.zxy);
    u_xlat0.xzw = u_xlat0.xxx * u_xlat6.xyz;
    u_xlat0.xzw = u_xlat16_2.xyz * u_xlat1.xxx + u_xlat0.xzw;
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat6.x = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat16_2.xyz);
    u_xlat6.x = u_xlat6.x * 0.57735002;
    u_xlat0.xzw = u_xlat6.xxx * u_xlat1.xxx + u_xlat0.xzw;
    u_xlat1.x = dot(u_xlat0.xzw, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat0.xzw = u_xlat0.xzw + (-u_xlat1.xxx);
    u_xlat6.x = _Saturation * 0.00999999978 + 1.0;
    u_xlat0.xzw = u_xlat6.xxx * u_xlat0.xzw + u_xlat1.xxx;
    u_xlat16_3.xyz = vec3(vec3(_Lightness, _Lightness, _Lightness)) * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat0.xzw;
    u_xlat16_3.xyz = u_xlat16_3.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat16_3.xyz = u_xlat0.yyy * u_xlat16_3.xyz + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.xyz = min(max(u_xlat16_3.xyz, 0.0), 1.0);
#else
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = u_xlat16_3.xyz * vec3(-2.0, -2.0, -2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vec3(_Invert) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * _PostColor.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = _PostColor.www * u_xlat0.xyz + u_xlat16_3.xyz;
    u_xlat1 = vs_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = vec4(vec4(_Intensity, _Intensity, _Intensity, _Intensity)) * u_xlat1 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0.xyz = (-u_xlat16_2.xyz) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1 = u_xlat1 * u_xlat16_2;
    u_xlat15 = _Intensity * _Blending;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat1.w;
    u_xlat15 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat15) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "INSTANCING_ON" "USE_AUTO_COLOR_CHANGE" "USE_COLOR_ADJUST" "USE_VERT_ANI" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
uniform 	float _WaveScale;
uniform 	float _WaveSpd;
uniform 	float _WaveDist;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
struct PropsArray_Type {
	float _TileIndex;
	float _FlipFactor;
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityInstancing_Props {
#endif
	UNITY_UNIFORM PropsArray_Type PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
int u_xlati3;
float u_xlat6;
int u_xlati6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = _Time.y * _WaveSpd;
    u_xlat0.x = in_POSITION0.y * _WaveDist + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _WaveScale;
    u_xlati3 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat0.x = in_POSITION0.x * PropsArray[u_xlati3]._FlipFactor + u_xlat0.x;
    u_xlati6 = int(u_xlati3 << 3);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat0.xz = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat9 = u_xlat0.x * PropsArray[u_xlati3]._TileIndex;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat9>=(-u_xlat9));
#else
    u_xlatb9 = u_xlat9>=(-u_xlat9);
#endif
    u_xlat0.x = (u_xlatb9) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat6 = PropsArray[u_xlati3]._TileIndex / u_xlat0.z;
    u_xlat6 = floor(u_xlat6);
    u_xlat1.y = (-u_xlat6) + in_TEXCOORD0.y;
    u_xlat6 = float(1.0) / u_xlat0.x;
    u_xlat3 = u_xlat6 * PropsArray[u_xlati3]._TileIndex;
    u_xlat3 = fract(u_xlat3);
    u_xlat0.x = u_xlat3 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	float _Hue;
uniform 	float _Saturation;
uniform 	float _Lightness;
uniform 	float _Contrast;
uniform 	float _Invert;
uniform 	float _Blending;
uniform 	float _Intensity;
uniform 	vec4 _PostColor;
uniform 	float _AutoColChangeSpeed;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat6;
float u_xlat15;
void main()
{
    u_xlat0.x = _Time.x * _AutoColChangeSpeed;
    u_xlat0.yz = vec2(_Hue, _Contrast) + vec2(180.0, 100.0);
    u_xlat0.x = u_xlat0.x * u_xlat0.y;
    u_xlat0.xy = u_xlat0.xz * vec2(0.0174532924, 0.00999999978);
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat6.xyz = u_xlat16_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat6.xyz = u_xlat16_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat6.zxy);
    u_xlat0.xzw = u_xlat0.xxx * u_xlat6.xyz;
    u_xlat0.xzw = u_xlat16_2.xyz * u_xlat1.xxx + u_xlat0.xzw;
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat6.x = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat16_2.xyz);
    u_xlat6.x = u_xlat6.x * 0.57735002;
    u_xlat0.xzw = u_xlat6.xxx * u_xlat1.xxx + u_xlat0.xzw;
    u_xlat1.x = dot(u_xlat0.xzw, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat0.xzw = u_xlat0.xzw + (-u_xlat1.xxx);
    u_xlat6.x = _Saturation * 0.00999999978 + 1.0;
    u_xlat0.xzw = u_xlat6.xxx * u_xlat0.xzw + u_xlat1.xxx;
    u_xlat16_3.xyz = vec3(vec3(_Lightness, _Lightness, _Lightness)) * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat0.xzw;
    u_xlat16_3.xyz = u_xlat16_3.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat16_3.xyz = u_xlat0.yyy * u_xlat16_3.xyz + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.xyz = min(max(u_xlat16_3.xyz, 0.0), 1.0);
#else
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = u_xlat16_3.xyz * vec3(-2.0, -2.0, -2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vec3(_Invert) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * _PostColor.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = _PostColor.www * u_xlat0.xyz + u_xlat16_3.xyz;
    u_xlat1 = vs_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = vec4(vec4(_Intensity, _Intensity, _Intensity, _Intensity)) * u_xlat1 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0.xyz = (-u_xlat16_2.xyz) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1 = u_xlat1 * u_xlat16_2;
    u_xlat15 = _Intensity * _Blending;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat1.w;
    u_xlat15 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat15) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "INSTANCING_ON" "USE_AUTO_COLOR_CHANGE" "USE_COLOR_ADJUST" "USE_VERT_ANI" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
uniform 	float _WaveScale;
uniform 	float _WaveSpd;
uniform 	float _WaveDist;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
struct PropsArray_Type {
	float _TileIndex;
	float _FlipFactor;
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityInstancing_Props {
#endif
	UNITY_UNIFORM PropsArray_Type PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
int u_xlati3;
float u_xlat6;
int u_xlati6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = _Time.y * _WaveSpd;
    u_xlat0.x = in_POSITION0.y * _WaveDist + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _WaveScale;
    u_xlati3 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat0.x = in_POSITION0.x * PropsArray[u_xlati3]._FlipFactor + u_xlat0.x;
    u_xlati6 = int(u_xlati3 << 3);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat0.xz = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat9 = u_xlat0.x * PropsArray[u_xlati3]._TileIndex;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat9>=(-u_xlat9));
#else
    u_xlatb9 = u_xlat9>=(-u_xlat9);
#endif
    u_xlat0.x = (u_xlatb9) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat6 = PropsArray[u_xlati3]._TileIndex / u_xlat0.z;
    u_xlat6 = floor(u_xlat6);
    u_xlat1.y = (-u_xlat6) + in_TEXCOORD0.y;
    u_xlat6 = float(1.0) / u_xlat0.x;
    u_xlat3 = u_xlat6 * PropsArray[u_xlati3]._TileIndex;
    u_xlat3 = fract(u_xlat3);
    u_xlat0.x = u_xlat3 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	float _Hue;
uniform 	float _Saturation;
uniform 	float _Lightness;
uniform 	float _Contrast;
uniform 	float _Invert;
uniform 	float _Blending;
uniform 	float _Intensity;
uniform 	vec4 _PostColor;
uniform 	float _AutoColChangeSpeed;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat6;
float u_xlat15;
void main()
{
    u_xlat0.x = _Time.x * _AutoColChangeSpeed;
    u_xlat0.yz = vec2(_Hue, _Contrast) + vec2(180.0, 100.0);
    u_xlat0.x = u_xlat0.x * u_xlat0.y;
    u_xlat0.xy = u_xlat0.xz * vec2(0.0174532924, 0.00999999978);
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat6.xyz = u_xlat16_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat6.xyz = u_xlat16_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat6.zxy);
    u_xlat0.xzw = u_xlat0.xxx * u_xlat6.xyz;
    u_xlat0.xzw = u_xlat16_2.xyz * u_xlat1.xxx + u_xlat0.xzw;
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat6.x = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat16_2.xyz);
    u_xlat6.x = u_xlat6.x * 0.57735002;
    u_xlat0.xzw = u_xlat6.xxx * u_xlat1.xxx + u_xlat0.xzw;
    u_xlat1.x = dot(u_xlat0.xzw, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat0.xzw = u_xlat0.xzw + (-u_xlat1.xxx);
    u_xlat6.x = _Saturation * 0.00999999978 + 1.0;
    u_xlat0.xzw = u_xlat6.xxx * u_xlat0.xzw + u_xlat1.xxx;
    u_xlat16_3.xyz = vec3(vec3(_Lightness, _Lightness, _Lightness)) * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat0.xzw;
    u_xlat16_3.xyz = u_xlat16_3.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat16_3.xyz = u_xlat0.yyy * u_xlat16_3.xyz + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.xyz = min(max(u_xlat16_3.xyz, 0.0), 1.0);
#else
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = u_xlat16_3.xyz * vec3(-2.0, -2.0, -2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vec3(_Invert) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * _PostColor.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = _PostColor.www * u_xlat0.xyz + u_xlat16_3.xyz;
    u_xlat1 = vs_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = vec4(vec4(_Intensity, _Intensity, _Intensity, _Intensity)) * u_xlat1 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0.xyz = (-u_xlat16_2.xyz) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1 = u_xlat1 * u_xlat16_2;
    u_xlat15 = _Intensity * _Blending;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat1.w;
    u_xlat15 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat15) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "INSTANCING_ON" "USE_AUTO_COLOR_CHANGE" "USE_COLOR_ADJUST" "USE_VERT_ANI" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
uniform 	float _WaveScale;
uniform 	float _WaveSpd;
uniform 	float _WaveDist;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
struct PropsArray_Type {
	float _TileIndex;
	float _FlipFactor;
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityInstancing_Props {
#endif
	UNITY_UNIFORM PropsArray_Type PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
int u_xlati3;
float u_xlat6;
int u_xlati6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = _Time.y * _WaveSpd;
    u_xlat0.x = in_POSITION0.y * _WaveDist + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _WaveScale;
    u_xlati3 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat0.x = in_POSITION0.x * PropsArray[u_xlati3]._FlipFactor + u_xlat0.x;
    u_xlati6 = int(u_xlati3 << 3);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat0.xz = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat9 = u_xlat0.x * PropsArray[u_xlati3]._TileIndex;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat9>=(-u_xlat9));
#else
    u_xlatb9 = u_xlat9>=(-u_xlat9);
#endif
    u_xlat0.x = (u_xlatb9) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat6 = PropsArray[u_xlati3]._TileIndex / u_xlat0.z;
    u_xlat6 = floor(u_xlat6);
    u_xlat1.y = (-u_xlat6) + in_TEXCOORD0.y;
    u_xlat6 = float(1.0) / u_xlat0.x;
    u_xlat3 = u_xlat6 * PropsArray[u_xlati3]._TileIndex;
    u_xlat3 = fract(u_xlat3);
    u_xlat0.x = u_xlat3 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_COLOR0 = in_COLOR0;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	float _Hue;
uniform 	float _Saturation;
uniform 	float _Lightness;
uniform 	float _Contrast;
uniform 	float _Invert;
uniform 	float _Blending;
uniform 	float _Intensity;
uniform 	vec4 _PostColor;
uniform 	float _AutoColChangeSpeed;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in mediump vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat6;
float u_xlat15;
void main()
{
    u_xlat0.x = _Time.x * _AutoColChangeSpeed;
    u_xlat0.yz = vec2(_Hue, _Contrast) + vec2(180.0, 100.0);
    u_xlat0.x = u_xlat0.x * u_xlat0.y;
    u_xlat0.xy = u_xlat0.xz * vec2(0.0174532924, 0.00999999978);
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat6.xyz = u_xlat16_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat6.xyz = u_xlat16_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat6.zxy);
    u_xlat0.xzw = u_xlat0.xxx * u_xlat6.xyz;
    u_xlat0.xzw = u_xlat16_2.xyz * u_xlat1.xxx + u_xlat0.xzw;
    u_xlat1.x = (-u_xlat1.x) + 1.0;
    u_xlat6.x = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat16_2.xyz);
    u_xlat6.x = u_xlat6.x * 0.57735002;
    u_xlat0.xzw = u_xlat6.xxx * u_xlat1.xxx + u_xlat0.xzw;
    u_xlat1.x = dot(u_xlat0.xzw, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat0.xzw = u_xlat0.xzw + (-u_xlat1.xxx);
    u_xlat6.x = _Saturation * 0.00999999978 + 1.0;
    u_xlat0.xzw = u_xlat6.xxx * u_xlat0.xzw + u_xlat1.xxx;
    u_xlat16_3.xyz = vec3(vec3(_Lightness, _Lightness, _Lightness)) * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat0.xzw;
    u_xlat16_3.xyz = u_xlat16_3.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat16_3.xyz = u_xlat0.yyy * u_xlat16_3.xyz + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.xyz = min(max(u_xlat16_3.xyz, 0.0), 1.0);
#else
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = u_xlat16_3.xyz * vec3(-2.0, -2.0, -2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vec3(_Invert) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * _PostColor.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = _PostColor.www * u_xlat0.xyz + u_xlat16_3.xyz;
    u_xlat1 = vs_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = vec4(vec4(_Intensity, _Intensity, _Intensity, _Intensity)) * u_xlat1 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0.xyz = (-u_xlat16_2.xyz) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1 = u_xlat1 * u_xlat16_2;
    u_xlat15 = _Intensity * _Blending;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat1.w;
    u_xlat15 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat15) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "USE_DISTORTION" "USE_VERT_ANI" }
"#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DistTex_ST;
uniform 	float _DistFlowX;
uniform 	float _DistFlowY;
uniform 	float _WaveScale;
uniform 	float _WaveSpd;
uniform 	float _WaveDist;
uniform 	float _TileIndex;
uniform 	float _FlipFactor;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = _Time.y * _WaveSpd;
    u_xlat0.x = in_POSITION0.y * _WaveDist + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _WaveScale;
    u_xlat0.x = in_POSITION0.x * _FlipFactor + u_xlat0.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat4 = u_xlat0.x * _TileIndex;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4>=(-u_xlat4));
#else
    u_xlatb4 = u_xlat4>=(-u_xlat4);
#endif
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2 = _TileIndex / u_xlat0.y;
    u_xlat2 = floor(u_xlat2);
    u_xlat1.y = (-u_xlat2) + in_TEXCOORD0.y;
    u_xlat2 = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat2 * _TileIndex;
    u_xlat2 = fract(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD0.xy * _DistTex_ST.xy + _DistTex_ST.zw;
    vs_TEXCOORD1.xy = _Time.yy * vec2(_DistFlowX, _DistFlowY) + u_xlat0.xy;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	float _Dist;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
UNITY_LOCATION(0) uniform mediump sampler2D _DistTex;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat16_0.xy = texture(_DistTex, vs_TEXCOORD1.xy).xy;
    u_xlat0.xy = u_xlat16_0.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_Dist, _Dist)) + vs_TEXCOORD0.xy;
    u_xlat16_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat0.w;
    u_xlat6 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat6) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "USE_DISTORTION" "USE_VERT_ANI" }
"#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DistTex_ST;
uniform 	float _DistFlowX;
uniform 	float _DistFlowY;
uniform 	float _WaveScale;
uniform 	float _WaveSpd;
uniform 	float _WaveDist;
uniform 	float _TileIndex;
uniform 	float _FlipFactor;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = _Time.y * _WaveSpd;
    u_xlat0.x = in_POSITION0.y * _WaveDist + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _WaveScale;
    u_xlat0.x = in_POSITION0.x * _FlipFactor + u_xlat0.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat4 = u_xlat0.x * _TileIndex;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4>=(-u_xlat4));
#else
    u_xlatb4 = u_xlat4>=(-u_xlat4);
#endif
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2 = _TileIndex / u_xlat0.y;
    u_xlat2 = floor(u_xlat2);
    u_xlat1.y = (-u_xlat2) + in_TEXCOORD0.y;
    u_xlat2 = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat2 * _TileIndex;
    u_xlat2 = fract(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD0.xy * _DistTex_ST.xy + _DistTex_ST.zw;
    vs_TEXCOORD1.xy = _Time.yy * vec2(_DistFlowX, _DistFlowY) + u_xlat0.xy;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	float _Dist;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
UNITY_LOCATION(0) uniform mediump sampler2D _DistTex;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat16_0.xy = texture(_DistTex, vs_TEXCOORD1.xy).xy;
    u_xlat0.xy = u_xlat16_0.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_Dist, _Dist)) + vs_TEXCOORD0.xy;
    u_xlat16_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat0.w;
    u_xlat6 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat6) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "USE_DISTORTION" "USE_VERT_ANI" }
"#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DistTex_ST;
uniform 	float _DistFlowX;
uniform 	float _DistFlowY;
uniform 	float _WaveScale;
uniform 	float _WaveSpd;
uniform 	float _WaveDist;
uniform 	float _TileIndex;
uniform 	float _FlipFactor;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = _Time.y * _WaveSpd;
    u_xlat0.x = in_POSITION0.y * _WaveDist + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _WaveScale;
    u_xlat0.x = in_POSITION0.x * _FlipFactor + u_xlat0.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat4 = u_xlat0.x * _TileIndex;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4>=(-u_xlat4));
#else
    u_xlatb4 = u_xlat4>=(-u_xlat4);
#endif
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2 = _TileIndex / u_xlat0.y;
    u_xlat2 = floor(u_xlat2);
    u_xlat1.y = (-u_xlat2) + in_TEXCOORD0.y;
    u_xlat2 = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat2 * _TileIndex;
    u_xlat2 = fract(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD0.xy * _DistTex_ST.xy + _DistTex_ST.zw;
    vs_TEXCOORD1.xy = _Time.yy * vec2(_DistFlowX, _DistFlowY) + u_xlat0.xy;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	float _Dist;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
UNITY_LOCATION(0) uniform mediump sampler2D _DistTex;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat16_0.xy = texture(_DistTex, vs_TEXCOORD1.xy).xy;
    u_xlat0.xy = u_xlat16_0.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_Dist, _Dist)) + vs_TEXCOORD0.xy;
    u_xlat16_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat0.w;
    u_xlat6 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat6) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "INSTANCING_ON" "USE_DISTORTION" "USE_VERT_ANI" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DistTex_ST;
uniform 	float _DistFlowX;
uniform 	float _DistFlowY;
uniform 	float _WaveScale;
uniform 	float _WaveSpd;
uniform 	float _WaveDist;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
struct PropsArray_Type {
	float _Dist;
	float _TileIndex;
	float _FlipFactor;
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_Props {
#endif
	UNITY_UNIFORM PropsArray_Type PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
int u_xlati3;
float u_xlat6;
int u_xlati6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = _Time.y * _WaveSpd;
    u_xlat0.x = in_POSITION0.y * _WaveDist + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _WaveScale;
    u_xlati3 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat0.x = in_POSITION0.x * PropsArray[u_xlati3]._FlipFactor + u_xlat0.x;
    u_xlati6 = int(u_xlati3 << 3);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat0.xz = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat9 = u_xlat0.x * PropsArray[u_xlati3]._TileIndex;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat9>=(-u_xlat9));
#else
    u_xlatb9 = u_xlat9>=(-u_xlat9);
#endif
    u_xlat0.x = (u_xlatb9) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat6 = PropsArray[u_xlati3]._TileIndex / u_xlat0.z;
    u_xlat6 = floor(u_xlat6);
    u_xlat1.y = (-u_xlat6) + in_TEXCOORD0.y;
    u_xlat6 = float(1.0) / u_xlat0.x;
    u_xlat3 = u_xlat6 * PropsArray[u_xlati3]._TileIndex;
    u_xlat3 = fract(u_xlat3);
    u_xlat0.x = u_xlat3 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD0.xy * _DistTex_ST.xy + _DistTex_ST.zw;
    vs_TEXCOORD1.xy = _Time.yy * vec2(_DistFlowX, _DistFlowY) + u_xlat0.xy;
    vs_COLOR0 = in_COLOR0;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
struct PropsArray_Type {
	float _Dist;
	float _TileIndex;
	float _FlipFactor;
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_Props {
#endif
	UNITY_UNIFORM PropsArray_Type PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _DistTex;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
int u_xlati4;
float u_xlat6;
void main()
{
    u_xlat16_0.xy = texture(_DistTex, vs_TEXCOORD1.xy).xy;
    u_xlat0.xy = u_xlat16_0.xy + vec2(-0.5, -0.5);
    u_xlati4 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat0.xy = u_xlat0.xy * vec2(PropsArray[u_xlati4]._Dist) + vs_TEXCOORD0.xy;
    u_xlat16_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat0.w;
    u_xlat6 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat6) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "INSTANCING_ON" "USE_DISTORTION" "USE_VERT_ANI" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DistTex_ST;
uniform 	float _DistFlowX;
uniform 	float _DistFlowY;
uniform 	float _WaveScale;
uniform 	float _WaveSpd;
uniform 	float _WaveDist;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
struct PropsArray_Type {
	float _Dist;
	float _TileIndex;
	float _FlipFactor;
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_Props {
#endif
	UNITY_UNIFORM PropsArray_Type PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
int u_xlati3;
float u_xlat6;
int u_xlati6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = _Time.y * _WaveSpd;
    u_xlat0.x = in_POSITION0.y * _WaveDist + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _WaveScale;
    u_xlati3 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat0.x = in_POSITION0.x * PropsArray[u_xlati3]._FlipFactor + u_xlat0.x;
    u_xlati6 = int(u_xlati3 << 3);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat0.xz = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat9 = u_xlat0.x * PropsArray[u_xlati3]._TileIndex;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat9>=(-u_xlat9));
#else
    u_xlatb9 = u_xlat9>=(-u_xlat9);
#endif
    u_xlat0.x = (u_xlatb9) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat6 = PropsArray[u_xlati3]._TileIndex / u_xlat0.z;
    u_xlat6 = floor(u_xlat6);
    u_xlat1.y = (-u_xlat6) + in_TEXCOORD0.y;
    u_xlat6 = float(1.0) / u_xlat0.x;
    u_xlat3 = u_xlat6 * PropsArray[u_xlati3]._TileIndex;
    u_xlat3 = fract(u_xlat3);
    u_xlat0.x = u_xlat3 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD0.xy * _DistTex_ST.xy + _DistTex_ST.zw;
    vs_TEXCOORD1.xy = _Time.yy * vec2(_DistFlowX, _DistFlowY) + u_xlat0.xy;
    vs_COLOR0 = in_COLOR0;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
struct PropsArray_Type {
	float _Dist;
	float _TileIndex;
	float _FlipFactor;
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_Props {
#endif
	UNITY_UNIFORM PropsArray_Type PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _DistTex;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
int u_xlati4;
float u_xlat6;
void main()
{
    u_xlat16_0.xy = texture(_DistTex, vs_TEXCOORD1.xy).xy;
    u_xlat0.xy = u_xlat16_0.xy + vec2(-0.5, -0.5);
    u_xlati4 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat0.xy = u_xlat0.xy * vec2(PropsArray[u_xlati4]._Dist) + vs_TEXCOORD0.xy;
    u_xlat16_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat0.w;
    u_xlat6 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat6) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "INSTANCING_ON" "USE_DISTORTION" "USE_VERT_ANI" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DistTex_ST;
uniform 	float _DistFlowX;
uniform 	float _DistFlowY;
uniform 	float _WaveScale;
uniform 	float _WaveSpd;
uniform 	float _WaveDist;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
struct PropsArray_Type {
	float _Dist;
	float _TileIndex;
	float _FlipFactor;
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_Props {
#endif
	UNITY_UNIFORM PropsArray_Type PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
int u_xlati3;
float u_xlat6;
int u_xlati6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = _Time.y * _WaveSpd;
    u_xlat0.x = in_POSITION0.y * _WaveDist + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _WaveScale;
    u_xlati3 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat0.x = in_POSITION0.x * PropsArray[u_xlati3]._FlipFactor + u_xlat0.x;
    u_xlati6 = int(u_xlati3 << 3);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat0.xz = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat9 = u_xlat0.x * PropsArray[u_xlati3]._TileIndex;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat9>=(-u_xlat9));
#else
    u_xlatb9 = u_xlat9>=(-u_xlat9);
#endif
    u_xlat0.x = (u_xlatb9) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat6 = PropsArray[u_xlati3]._TileIndex / u_xlat0.z;
    u_xlat6 = floor(u_xlat6);
    u_xlat1.y = (-u_xlat6) + in_TEXCOORD0.y;
    u_xlat6 = float(1.0) / u_xlat0.x;
    u_xlat3 = u_xlat6 * PropsArray[u_xlati3]._TileIndex;
    u_xlat3 = fract(u_xlat3);
    u_xlat0.x = u_xlat3 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD0.xy * _DistTex_ST.xy + _DistTex_ST.zw;
    vs_TEXCOORD1.xy = _Time.yy * vec2(_DistFlowX, _DistFlowY) + u_xlat0.xy;
    vs_COLOR0 = in_COLOR0;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
struct PropsArray_Type {
	float _Dist;
	float _TileIndex;
	float _FlipFactor;
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_Props {
#endif
	UNITY_UNIFORM PropsArray_Type PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _DistTex;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
int u_xlati4;
float u_xlat6;
void main()
{
    u_xlat16_0.xy = texture(_DistTex, vs_TEXCOORD1.xy).xy;
    u_xlat0.xy = u_xlat16_0.xy + vec2(-0.5, -0.5);
    u_xlati4 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat0.xy = u_xlat0.xy * vec2(PropsArray[u_xlati4]._Dist) + vs_TEXCOORD0.xy;
    u_xlat16_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat0.w;
    u_xlat6 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat6) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "USE_AUTO_COLOR_CHANGE" "USE_DISTORTION" "USE_VERT_ANI" }
"#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DistTex_ST;
uniform 	float _DistFlowX;
uniform 	float _DistFlowY;
uniform 	float _WaveScale;
uniform 	float _WaveSpd;
uniform 	float _WaveDist;
uniform 	float _TileIndex;
uniform 	float _FlipFactor;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = _Time.y * _WaveSpd;
    u_xlat0.x = in_POSITION0.y * _WaveDist + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _WaveScale;
    u_xlat0.x = in_POSITION0.x * _FlipFactor + u_xlat0.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat4 = u_xlat0.x * _TileIndex;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4>=(-u_xlat4));
#else
    u_xlatb4 = u_xlat4>=(-u_xlat4);
#endif
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2 = _TileIndex / u_xlat0.y;
    u_xlat2 = floor(u_xlat2);
    u_xlat1.y = (-u_xlat2) + in_TEXCOORD0.y;
    u_xlat2 = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat2 * _TileIndex;
    u_xlat2 = fract(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD0.xy * _DistTex_ST.xy + _DistTex_ST.zw;
    vs_TEXCOORD1.xy = _Time.yy * vec2(_DistFlowX, _DistFlowY) + u_xlat0.xy;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	float _Dist;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
UNITY_LOCATION(0) uniform mediump sampler2D _DistTex;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat16_0.xy = texture(_DistTex, vs_TEXCOORD1.xy).xy;
    u_xlat0.xy = u_xlat16_0.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_Dist, _Dist)) + vs_TEXCOORD0.xy;
    u_xlat16_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat0.w;
    u_xlat6 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat6) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "USE_AUTO_COLOR_CHANGE" "USE_DISTORTION" "USE_VERT_ANI" }
"#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DistTex_ST;
uniform 	float _DistFlowX;
uniform 	float _DistFlowY;
uniform 	float _WaveScale;
uniform 	float _WaveSpd;
uniform 	float _WaveDist;
uniform 	float _TileIndex;
uniform 	float _FlipFactor;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = _Time.y * _WaveSpd;
    u_xlat0.x = in_POSITION0.y * _WaveDist + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _WaveScale;
    u_xlat0.x = in_POSITION0.x * _FlipFactor + u_xlat0.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat4 = u_xlat0.x * _TileIndex;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4>=(-u_xlat4));
#else
    u_xlatb4 = u_xlat4>=(-u_xlat4);
#endif
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2 = _TileIndex / u_xlat0.y;
    u_xlat2 = floor(u_xlat2);
    u_xlat1.y = (-u_xlat2) + in_TEXCOORD0.y;
    u_xlat2 = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat2 * _TileIndex;
    u_xlat2 = fract(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD0.xy * _DistTex_ST.xy + _DistTex_ST.zw;
    vs_TEXCOORD1.xy = _Time.yy * vec2(_DistFlowX, _DistFlowY) + u_xlat0.xy;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	float _Dist;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
UNITY_LOCATION(0) uniform mediump sampler2D _DistTex;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat16_0.xy = texture(_DistTex, vs_TEXCOORD1.xy).xy;
    u_xlat0.xy = u_xlat16_0.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_Dist, _Dist)) + vs_TEXCOORD0.xy;
    u_xlat16_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat0.w;
    u_xlat6 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat6) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "USE_AUTO_COLOR_CHANGE" "USE_DISTORTION" "USE_VERT_ANI" }
"#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DistTex_ST;
uniform 	float _DistFlowX;
uniform 	float _DistFlowY;
uniform 	float _WaveScale;
uniform 	float _WaveSpd;
uniform 	float _WaveDist;
uniform 	float _TileIndex;
uniform 	float _FlipFactor;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = _Time.y * _WaveSpd;
    u_xlat0.x = in_POSITION0.y * _WaveDist + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _WaveScale;
    u_xlat0.x = in_POSITION0.x * _FlipFactor + u_xlat0.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat4 = u_xlat0.x * _TileIndex;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4>=(-u_xlat4));
#else
    u_xlatb4 = u_xlat4>=(-u_xlat4);
#endif
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2 = _TileIndex / u_xlat0.y;
    u_xlat2 = floor(u_xlat2);
    u_xlat1.y = (-u_xlat2) + in_TEXCOORD0.y;
    u_xlat2 = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat2 * _TileIndex;
    u_xlat2 = fract(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD0.xy * _DistTex_ST.xy + _DistTex_ST.zw;
    vs_TEXCOORD1.xy = _Time.yy * vec2(_DistFlowX, _DistFlowY) + u_xlat0.xy;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	float _Dist;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
UNITY_LOCATION(0) uniform mediump sampler2D _DistTex;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
float u_xlat6;
void main()
{
    u_xlat16_0.xy = texture(_DistTex, vs_TEXCOORD1.xy).xy;
    u_xlat0.xy = u_xlat16_0.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = u_xlat0.xy * vec2(vec2(_Dist, _Dist)) + vs_TEXCOORD0.xy;
    u_xlat16_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat0.w;
    u_xlat6 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat6) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "INSTANCING_ON" "USE_AUTO_COLOR_CHANGE" "USE_DISTORTION" "USE_VERT_ANI" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DistTex_ST;
uniform 	float _DistFlowX;
uniform 	float _DistFlowY;
uniform 	float _WaveScale;
uniform 	float _WaveSpd;
uniform 	float _WaveDist;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
struct PropsArray_Type {
	float _Dist;
	float _TileIndex;
	float _FlipFactor;
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_Props {
#endif
	UNITY_UNIFORM PropsArray_Type PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
int u_xlati3;
float u_xlat6;
int u_xlati6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = _Time.y * _WaveSpd;
    u_xlat0.x = in_POSITION0.y * _WaveDist + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _WaveScale;
    u_xlati3 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat0.x = in_POSITION0.x * PropsArray[u_xlati3]._FlipFactor + u_xlat0.x;
    u_xlati6 = int(u_xlati3 << 3);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat0.xz = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat9 = u_xlat0.x * PropsArray[u_xlati3]._TileIndex;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat9>=(-u_xlat9));
#else
    u_xlatb9 = u_xlat9>=(-u_xlat9);
#endif
    u_xlat0.x = (u_xlatb9) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat6 = PropsArray[u_xlati3]._TileIndex / u_xlat0.z;
    u_xlat6 = floor(u_xlat6);
    u_xlat1.y = (-u_xlat6) + in_TEXCOORD0.y;
    u_xlat6 = float(1.0) / u_xlat0.x;
    u_xlat3 = u_xlat6 * PropsArray[u_xlati3]._TileIndex;
    u_xlat3 = fract(u_xlat3);
    u_xlat0.x = u_xlat3 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD0.xy * _DistTex_ST.xy + _DistTex_ST.zw;
    vs_TEXCOORD1.xy = _Time.yy * vec2(_DistFlowX, _DistFlowY) + u_xlat0.xy;
    vs_COLOR0 = in_COLOR0;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
struct PropsArray_Type {
	float _Dist;
	float _TileIndex;
	float _FlipFactor;
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_Props {
#endif
	UNITY_UNIFORM PropsArray_Type PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _DistTex;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
int u_xlati4;
float u_xlat6;
void main()
{
    u_xlat16_0.xy = texture(_DistTex, vs_TEXCOORD1.xy).xy;
    u_xlat0.xy = u_xlat16_0.xy + vec2(-0.5, -0.5);
    u_xlati4 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat0.xy = u_xlat0.xy * vec2(PropsArray[u_xlati4]._Dist) + vs_TEXCOORD0.xy;
    u_xlat16_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat0.w;
    u_xlat6 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat6) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "INSTANCING_ON" "USE_AUTO_COLOR_CHANGE" "USE_DISTORTION" "USE_VERT_ANI" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DistTex_ST;
uniform 	float _DistFlowX;
uniform 	float _DistFlowY;
uniform 	float _WaveScale;
uniform 	float _WaveSpd;
uniform 	float _WaveDist;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
struct PropsArray_Type {
	float _Dist;
	float _TileIndex;
	float _FlipFactor;
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_Props {
#endif
	UNITY_UNIFORM PropsArray_Type PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
int u_xlati3;
float u_xlat6;
int u_xlati6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = _Time.y * _WaveSpd;
    u_xlat0.x = in_POSITION0.y * _WaveDist + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _WaveScale;
    u_xlati3 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat0.x = in_POSITION0.x * PropsArray[u_xlati3]._FlipFactor + u_xlat0.x;
    u_xlati6 = int(u_xlati3 << 3);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat0.xz = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat9 = u_xlat0.x * PropsArray[u_xlati3]._TileIndex;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat9>=(-u_xlat9));
#else
    u_xlatb9 = u_xlat9>=(-u_xlat9);
#endif
    u_xlat0.x = (u_xlatb9) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat6 = PropsArray[u_xlati3]._TileIndex / u_xlat0.z;
    u_xlat6 = floor(u_xlat6);
    u_xlat1.y = (-u_xlat6) + in_TEXCOORD0.y;
    u_xlat6 = float(1.0) / u_xlat0.x;
    u_xlat3 = u_xlat6 * PropsArray[u_xlati3]._TileIndex;
    u_xlat3 = fract(u_xlat3);
    u_xlat0.x = u_xlat3 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD0.xy * _DistTex_ST.xy + _DistTex_ST.zw;
    vs_TEXCOORD1.xy = _Time.yy * vec2(_DistFlowX, _DistFlowY) + u_xlat0.xy;
    vs_COLOR0 = in_COLOR0;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
struct PropsArray_Type {
	float _Dist;
	float _TileIndex;
	float _FlipFactor;
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_Props {
#endif
	UNITY_UNIFORM PropsArray_Type PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _DistTex;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
int u_xlati4;
float u_xlat6;
void main()
{
    u_xlat16_0.xy = texture(_DistTex, vs_TEXCOORD1.xy).xy;
    u_xlat0.xy = u_xlat16_0.xy + vec2(-0.5, -0.5);
    u_xlati4 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat0.xy = u_xlat0.xy * vec2(PropsArray[u_xlati4]._Dist) + vs_TEXCOORD0.xy;
    u_xlat16_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat0.w;
    u_xlat6 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat6) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "INSTANCING_ON" "USE_AUTO_COLOR_CHANGE" "USE_DISTORTION" "USE_VERT_ANI" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DistTex_ST;
uniform 	float _DistFlowX;
uniform 	float _DistFlowY;
uniform 	float _WaveScale;
uniform 	float _WaveSpd;
uniform 	float _WaveDist;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
struct PropsArray_Type {
	float _Dist;
	float _TileIndex;
	float _FlipFactor;
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_Props {
#endif
	UNITY_UNIFORM PropsArray_Type PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
int u_xlati3;
float u_xlat6;
int u_xlati6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = _Time.y * _WaveSpd;
    u_xlat0.x = in_POSITION0.y * _WaveDist + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _WaveScale;
    u_xlati3 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat0.x = in_POSITION0.x * PropsArray[u_xlati3]._FlipFactor + u_xlat0.x;
    u_xlati6 = int(u_xlati3 << 3);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat0.xz = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat9 = u_xlat0.x * PropsArray[u_xlati3]._TileIndex;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat9>=(-u_xlat9));
#else
    u_xlatb9 = u_xlat9>=(-u_xlat9);
#endif
    u_xlat0.x = (u_xlatb9) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat6 = PropsArray[u_xlati3]._TileIndex / u_xlat0.z;
    u_xlat6 = floor(u_xlat6);
    u_xlat1.y = (-u_xlat6) + in_TEXCOORD0.y;
    u_xlat6 = float(1.0) / u_xlat0.x;
    u_xlat3 = u_xlat6 * PropsArray[u_xlati3]._TileIndex;
    u_xlat3 = fract(u_xlat3);
    u_xlat0.x = u_xlat3 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD0.xy * _DistTex_ST.xy + _DistTex_ST.zw;
    vs_TEXCOORD1.xy = _Time.yy * vec2(_DistFlowX, _DistFlowY) + u_xlat0.xy;
    vs_COLOR0 = in_COLOR0;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
struct PropsArray_Type {
	float _Dist;
	float _TileIndex;
	float _FlipFactor;
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_Props {
#endif
	UNITY_UNIFORM PropsArray_Type PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _DistTex;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
int u_xlati4;
float u_xlat6;
void main()
{
    u_xlat16_0.xy = texture(_DistTex, vs_TEXCOORD1.xy).xy;
    u_xlat0.xy = u_xlat16_0.xy + vec2(-0.5, -0.5);
    u_xlati4 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat0.xy = u_xlat0.xy * vec2(PropsArray[u_xlati4]._Dist) + vs_TEXCOORD0.xy;
    u_xlat16_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat0 = u_xlat16_0 * vs_COLOR0;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat0.w;
    u_xlat6 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat6) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "USE_COLOR_ADJUST" "USE_DISTORTION" "USE_VERT_ANI" }
"#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DistTex_ST;
uniform 	float _DistFlowX;
uniform 	float _DistFlowY;
uniform 	float _WaveScale;
uniform 	float _WaveSpd;
uniform 	float _WaveDist;
uniform 	float _TileIndex;
uniform 	float _FlipFactor;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = _Time.y * _WaveSpd;
    u_xlat0.x = in_POSITION0.y * _WaveDist + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _WaveScale;
    u_xlat0.x = in_POSITION0.x * _FlipFactor + u_xlat0.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat4 = u_xlat0.x * _TileIndex;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4>=(-u_xlat4));
#else
    u_xlatb4 = u_xlat4>=(-u_xlat4);
#endif
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2 = _TileIndex / u_xlat0.y;
    u_xlat2 = floor(u_xlat2);
    u_xlat1.y = (-u_xlat2) + in_TEXCOORD0.y;
    u_xlat2 = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat2 * _TileIndex;
    u_xlat2 = fract(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD0.xy * _DistTex_ST.xy + _DistTex_ST.zw;
    vs_TEXCOORD1.xy = _Time.yy * vec2(_DistFlowX, _DistFlowY) + u_xlat0.xy;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	float _Hue;
uniform 	float _Saturation;
uniform 	float _Lightness;
uniform 	float _Contrast;
uniform 	float _Invert;
uniform 	float _Blending;
uniform 	float _Intensity;
uniform 	vec4 _PostColor;
uniform 	float _Dist;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
UNITY_LOCATION(0) uniform mediump sampler2D _DistTex;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
float u_xlat18;
float u_xlat19;
void main()
{
    u_xlat16_0.xy = texture(_DistTex, vs_TEXCOORD1.xy).xy;
    u_xlat0.xy = u_xlat16_0.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = u_xlat0.xy * vec2(_Dist) + vs_TEXCOORD0.xy;
    u_xlat16_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat1.xyz = u_xlat16_0.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat1.xyz = u_xlat16_0.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat1.zxy);
    u_xlat19 = _Hue * 0.0174532924;
    u_xlat2.x = sin(u_xlat19);
    u_xlat3 = cos(u_xlat19);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xxx;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(u_xlat3) + u_xlat1.xyz;
    u_xlat19 = (-u_xlat3) + 1.0;
    u_xlat2.x = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat16_0.xyz);
    u_xlat2.x = u_xlat2.x * 0.57735002;
    u_xlat1.xyz = u_xlat2.xxx * vec3(u_xlat19) + u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat1.xyz = (-vec3(u_xlat19)) + u_xlat1.xyz;
    u_xlat2.x = _Saturation * 0.00999999978 + 1.0;
    u_xlat1.xyz = u_xlat2.xxx * u_xlat1.xyz + vec3(u_xlat19);
    u_xlat16_4.xyz = vec3(_Lightness) * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat1.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat1.x = _Contrast + 100.0;
    u_xlat1.x = u_xlat1.x * 0.00999999978;
    u_xlat16_4.xyz = u_xlat1.xxx * u_xlat16_4.xyz + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.xyz = min(max(u_xlat16_4.xyz, 0.0), 1.0);
#else
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = u_xlat16_4.xyz * vec3(-2.0, -2.0, -2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = vec3(vec3(_Invert, _Invert, _Invert)) * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat1.xyz = u_xlat16_4.xyz * _PostColor.xyz + (-u_xlat16_4.xyz);
    u_xlat1.xyz = _PostColor.www * u_xlat1.xyz + u_xlat16_4.xyz;
    u_xlat2 = vs_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat2 = vec4(_Intensity) * u_xlat2 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1.xyz = (-u_xlat16_0.xyz) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat0 = u_xlat16_0 * u_xlat2;
    u_xlat19 = _Blending * _Intensity;
    u_xlat0.xyz = vec3(u_xlat19) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat0.w;
    u_xlat18 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat18) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "USE_COLOR_ADJUST" "USE_DISTORTION" "USE_VERT_ANI" }
"#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DistTex_ST;
uniform 	float _DistFlowX;
uniform 	float _DistFlowY;
uniform 	float _WaveScale;
uniform 	float _WaveSpd;
uniform 	float _WaveDist;
uniform 	float _TileIndex;
uniform 	float _FlipFactor;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = _Time.y * _WaveSpd;
    u_xlat0.x = in_POSITION0.y * _WaveDist + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _WaveScale;
    u_xlat0.x = in_POSITION0.x * _FlipFactor + u_xlat0.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat4 = u_xlat0.x * _TileIndex;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4>=(-u_xlat4));
#else
    u_xlatb4 = u_xlat4>=(-u_xlat4);
#endif
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2 = _TileIndex / u_xlat0.y;
    u_xlat2 = floor(u_xlat2);
    u_xlat1.y = (-u_xlat2) + in_TEXCOORD0.y;
    u_xlat2 = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat2 * _TileIndex;
    u_xlat2 = fract(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD0.xy * _DistTex_ST.xy + _DistTex_ST.zw;
    vs_TEXCOORD1.xy = _Time.yy * vec2(_DistFlowX, _DistFlowY) + u_xlat0.xy;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	float _Hue;
uniform 	float _Saturation;
uniform 	float _Lightness;
uniform 	float _Contrast;
uniform 	float _Invert;
uniform 	float _Blending;
uniform 	float _Intensity;
uniform 	vec4 _PostColor;
uniform 	float _Dist;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
UNITY_LOCATION(0) uniform mediump sampler2D _DistTex;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
float u_xlat18;
float u_xlat19;
void main()
{
    u_xlat16_0.xy = texture(_DistTex, vs_TEXCOORD1.xy).xy;
    u_xlat0.xy = u_xlat16_0.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = u_xlat0.xy * vec2(_Dist) + vs_TEXCOORD0.xy;
    u_xlat16_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat1.xyz = u_xlat16_0.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat1.xyz = u_xlat16_0.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat1.zxy);
    u_xlat19 = _Hue * 0.0174532924;
    u_xlat2.x = sin(u_xlat19);
    u_xlat3 = cos(u_xlat19);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xxx;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(u_xlat3) + u_xlat1.xyz;
    u_xlat19 = (-u_xlat3) + 1.0;
    u_xlat2.x = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat16_0.xyz);
    u_xlat2.x = u_xlat2.x * 0.57735002;
    u_xlat1.xyz = u_xlat2.xxx * vec3(u_xlat19) + u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat1.xyz = (-vec3(u_xlat19)) + u_xlat1.xyz;
    u_xlat2.x = _Saturation * 0.00999999978 + 1.0;
    u_xlat1.xyz = u_xlat2.xxx * u_xlat1.xyz + vec3(u_xlat19);
    u_xlat16_4.xyz = vec3(_Lightness) * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat1.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat1.x = _Contrast + 100.0;
    u_xlat1.x = u_xlat1.x * 0.00999999978;
    u_xlat16_4.xyz = u_xlat1.xxx * u_xlat16_4.xyz + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.xyz = min(max(u_xlat16_4.xyz, 0.0), 1.0);
#else
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = u_xlat16_4.xyz * vec3(-2.0, -2.0, -2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = vec3(vec3(_Invert, _Invert, _Invert)) * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat1.xyz = u_xlat16_4.xyz * _PostColor.xyz + (-u_xlat16_4.xyz);
    u_xlat1.xyz = _PostColor.www * u_xlat1.xyz + u_xlat16_4.xyz;
    u_xlat2 = vs_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat2 = vec4(_Intensity) * u_xlat2 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1.xyz = (-u_xlat16_0.xyz) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat0 = u_xlat16_0 * u_xlat2;
    u_xlat19 = _Blending * _Intensity;
    u_xlat0.xyz = vec3(u_xlat19) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat0.w;
    u_xlat18 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat18) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "USE_COLOR_ADJUST" "USE_DISTORTION" "USE_VERT_ANI" }
"#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DistTex_ST;
uniform 	float _DistFlowX;
uniform 	float _DistFlowY;
uniform 	float _WaveScale;
uniform 	float _WaveSpd;
uniform 	float _WaveDist;
uniform 	float _TileIndex;
uniform 	float _FlipFactor;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = _Time.y * _WaveSpd;
    u_xlat0.x = in_POSITION0.y * _WaveDist + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _WaveScale;
    u_xlat0.x = in_POSITION0.x * _FlipFactor + u_xlat0.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat4 = u_xlat0.x * _TileIndex;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4>=(-u_xlat4));
#else
    u_xlatb4 = u_xlat4>=(-u_xlat4);
#endif
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2 = _TileIndex / u_xlat0.y;
    u_xlat2 = floor(u_xlat2);
    u_xlat1.y = (-u_xlat2) + in_TEXCOORD0.y;
    u_xlat2 = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat2 * _TileIndex;
    u_xlat2 = fract(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD0.xy * _DistTex_ST.xy + _DistTex_ST.zw;
    vs_TEXCOORD1.xy = _Time.yy * vec2(_DistFlowX, _DistFlowY) + u_xlat0.xy;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	float _Hue;
uniform 	float _Saturation;
uniform 	float _Lightness;
uniform 	float _Contrast;
uniform 	float _Invert;
uniform 	float _Blending;
uniform 	float _Intensity;
uniform 	vec4 _PostColor;
uniform 	float _Dist;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
UNITY_LOCATION(0) uniform mediump sampler2D _DistTex;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
float u_xlat18;
float u_xlat19;
void main()
{
    u_xlat16_0.xy = texture(_DistTex, vs_TEXCOORD1.xy).xy;
    u_xlat0.xy = u_xlat16_0.xy + vec2(-0.5, -0.5);
    u_xlat0.xy = u_xlat0.xy * vec2(_Dist) + vs_TEXCOORD0.xy;
    u_xlat16_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat1.xyz = u_xlat16_0.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat1.xyz = u_xlat16_0.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat1.zxy);
    u_xlat19 = _Hue * 0.0174532924;
    u_xlat2.x = sin(u_xlat19);
    u_xlat3 = cos(u_xlat19);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xxx;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(u_xlat3) + u_xlat1.xyz;
    u_xlat19 = (-u_xlat3) + 1.0;
    u_xlat2.x = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat16_0.xyz);
    u_xlat2.x = u_xlat2.x * 0.57735002;
    u_xlat1.xyz = u_xlat2.xxx * vec3(u_xlat19) + u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat1.xyz = (-vec3(u_xlat19)) + u_xlat1.xyz;
    u_xlat2.x = _Saturation * 0.00999999978 + 1.0;
    u_xlat1.xyz = u_xlat2.xxx * u_xlat1.xyz + vec3(u_xlat19);
    u_xlat16_4.xyz = vec3(_Lightness) * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat1.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat1.x = _Contrast + 100.0;
    u_xlat1.x = u_xlat1.x * 0.00999999978;
    u_xlat16_4.xyz = u_xlat1.xxx * u_xlat16_4.xyz + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.xyz = min(max(u_xlat16_4.xyz, 0.0), 1.0);
#else
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = u_xlat16_4.xyz * vec3(-2.0, -2.0, -2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = vec3(vec3(_Invert, _Invert, _Invert)) * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat1.xyz = u_xlat16_4.xyz * _PostColor.xyz + (-u_xlat16_4.xyz);
    u_xlat1.xyz = _PostColor.www * u_xlat1.xyz + u_xlat16_4.xyz;
    u_xlat2 = vs_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat2 = vec4(_Intensity) * u_xlat2 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1.xyz = (-u_xlat16_0.xyz) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat0 = u_xlat16_0 * u_xlat2;
    u_xlat19 = _Blending * _Intensity;
    u_xlat0.xyz = vec3(u_xlat19) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat0.w;
    u_xlat18 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat18) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "INSTANCING_ON" "USE_COLOR_ADJUST" "USE_DISTORTION" "USE_VERT_ANI" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DistTex_ST;
uniform 	float _DistFlowX;
uniform 	float _DistFlowY;
uniform 	float _WaveScale;
uniform 	float _WaveSpd;
uniform 	float _WaveDist;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
struct PropsArray_Type {
	float _Dist;
	float _TileIndex;
	float _FlipFactor;
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_Props {
#endif
	UNITY_UNIFORM PropsArray_Type PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
int u_xlati3;
float u_xlat6;
int u_xlati6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = _Time.y * _WaveSpd;
    u_xlat0.x = in_POSITION0.y * _WaveDist + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _WaveScale;
    u_xlati3 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat0.x = in_POSITION0.x * PropsArray[u_xlati3]._FlipFactor + u_xlat0.x;
    u_xlati6 = int(u_xlati3 << 3);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat0.xz = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat9 = u_xlat0.x * PropsArray[u_xlati3]._TileIndex;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat9>=(-u_xlat9));
#else
    u_xlatb9 = u_xlat9>=(-u_xlat9);
#endif
    u_xlat0.x = (u_xlatb9) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat6 = PropsArray[u_xlati3]._TileIndex / u_xlat0.z;
    u_xlat6 = floor(u_xlat6);
    u_xlat1.y = (-u_xlat6) + in_TEXCOORD0.y;
    u_xlat6 = float(1.0) / u_xlat0.x;
    u_xlat3 = u_xlat6 * PropsArray[u_xlati3]._TileIndex;
    u_xlat3 = fract(u_xlat3);
    u_xlat0.x = u_xlat3 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD0.xy * _DistTex_ST.xy + _DistTex_ST.zw;
    vs_TEXCOORD1.xy = _Time.yy * vec2(_DistFlowX, _DistFlowY) + u_xlat0.xy;
    vs_COLOR0 = in_COLOR0;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	int unity_BaseInstanceID;
uniform 	float _Hue;
uniform 	float _Saturation;
uniform 	float _Lightness;
uniform 	float _Contrast;
uniform 	float _Invert;
uniform 	float _Blending;
uniform 	float _Intensity;
uniform 	vec4 _PostColor;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
struct PropsArray_Type {
	float _Dist;
	float _TileIndex;
	float _FlipFactor;
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_Props {
#endif
	UNITY_UNIFORM PropsArray_Type PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _DistTex;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
int u_xlati12;
float u_xlat18;
float u_xlat19;
void main()
{
    u_xlat16_0.xy = texture(_DistTex, vs_TEXCOORD1.xy).xy;
    u_xlat0.xy = u_xlat16_0.xy + vec2(-0.5, -0.5);
    u_xlati12 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat0.xy = u_xlat0.xy * vec2(PropsArray[u_xlati12]._Dist) + vs_TEXCOORD0.xy;
    u_xlat16_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat1.xyz = u_xlat16_0.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat1.xyz = u_xlat16_0.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat1.zxy);
    u_xlat19 = _Hue * 0.0174532924;
    u_xlat2.x = sin(u_xlat19);
    u_xlat3 = cos(u_xlat19);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xxx;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(u_xlat3) + u_xlat1.xyz;
    u_xlat19 = (-u_xlat3) + 1.0;
    u_xlat2.x = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat16_0.xyz);
    u_xlat2.x = u_xlat2.x * 0.57735002;
    u_xlat1.xyz = u_xlat2.xxx * vec3(u_xlat19) + u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat1.xyz = (-vec3(u_xlat19)) + u_xlat1.xyz;
    u_xlat2.x = _Saturation * 0.00999999978 + 1.0;
    u_xlat1.xyz = u_xlat2.xxx * u_xlat1.xyz + vec3(u_xlat19);
    u_xlat16_4.xyz = vec3(_Lightness) * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat1.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat1.x = _Contrast + 100.0;
    u_xlat1.x = u_xlat1.x * 0.00999999978;
    u_xlat16_4.xyz = u_xlat1.xxx * u_xlat16_4.xyz + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.xyz = min(max(u_xlat16_4.xyz, 0.0), 1.0);
#else
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = u_xlat16_4.xyz * vec3(-2.0, -2.0, -2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = vec3(vec3(_Invert, _Invert, _Invert)) * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat1.xyz = u_xlat16_4.xyz * _PostColor.xyz + (-u_xlat16_4.xyz);
    u_xlat1.xyz = _PostColor.www * u_xlat1.xyz + u_xlat16_4.xyz;
    u_xlat2 = vs_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat2 = vec4(_Intensity) * u_xlat2 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1.xyz = (-u_xlat16_0.xyz) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat0 = u_xlat16_0 * u_xlat2;
    u_xlat19 = _Blending * _Intensity;
    u_xlat0.xyz = vec3(u_xlat19) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat0.w;
    u_xlat18 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat18) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "INSTANCING_ON" "USE_COLOR_ADJUST" "USE_DISTORTION" "USE_VERT_ANI" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DistTex_ST;
uniform 	float _DistFlowX;
uniform 	float _DistFlowY;
uniform 	float _WaveScale;
uniform 	float _WaveSpd;
uniform 	float _WaveDist;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
struct PropsArray_Type {
	float _Dist;
	float _TileIndex;
	float _FlipFactor;
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_Props {
#endif
	UNITY_UNIFORM PropsArray_Type PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
int u_xlati3;
float u_xlat6;
int u_xlati6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = _Time.y * _WaveSpd;
    u_xlat0.x = in_POSITION0.y * _WaveDist + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _WaveScale;
    u_xlati3 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat0.x = in_POSITION0.x * PropsArray[u_xlati3]._FlipFactor + u_xlat0.x;
    u_xlati6 = int(u_xlati3 << 3);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat0.xz = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat9 = u_xlat0.x * PropsArray[u_xlati3]._TileIndex;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat9>=(-u_xlat9));
#else
    u_xlatb9 = u_xlat9>=(-u_xlat9);
#endif
    u_xlat0.x = (u_xlatb9) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat6 = PropsArray[u_xlati3]._TileIndex / u_xlat0.z;
    u_xlat6 = floor(u_xlat6);
    u_xlat1.y = (-u_xlat6) + in_TEXCOORD0.y;
    u_xlat6 = float(1.0) / u_xlat0.x;
    u_xlat3 = u_xlat6 * PropsArray[u_xlati3]._TileIndex;
    u_xlat3 = fract(u_xlat3);
    u_xlat0.x = u_xlat3 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD0.xy * _DistTex_ST.xy + _DistTex_ST.zw;
    vs_TEXCOORD1.xy = _Time.yy * vec2(_DistFlowX, _DistFlowY) + u_xlat0.xy;
    vs_COLOR0 = in_COLOR0;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	int unity_BaseInstanceID;
uniform 	float _Hue;
uniform 	float _Saturation;
uniform 	float _Lightness;
uniform 	float _Contrast;
uniform 	float _Invert;
uniform 	float _Blending;
uniform 	float _Intensity;
uniform 	vec4 _PostColor;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
struct PropsArray_Type {
	float _Dist;
	float _TileIndex;
	float _FlipFactor;
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_Props {
#endif
	UNITY_UNIFORM PropsArray_Type PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _DistTex;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
int u_xlati12;
float u_xlat18;
float u_xlat19;
void main()
{
    u_xlat16_0.xy = texture(_DistTex, vs_TEXCOORD1.xy).xy;
    u_xlat0.xy = u_xlat16_0.xy + vec2(-0.5, -0.5);
    u_xlati12 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat0.xy = u_xlat0.xy * vec2(PropsArray[u_xlati12]._Dist) + vs_TEXCOORD0.xy;
    u_xlat16_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat1.xyz = u_xlat16_0.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat1.xyz = u_xlat16_0.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat1.zxy);
    u_xlat19 = _Hue * 0.0174532924;
    u_xlat2.x = sin(u_xlat19);
    u_xlat3 = cos(u_xlat19);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xxx;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(u_xlat3) + u_xlat1.xyz;
    u_xlat19 = (-u_xlat3) + 1.0;
    u_xlat2.x = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat16_0.xyz);
    u_xlat2.x = u_xlat2.x * 0.57735002;
    u_xlat1.xyz = u_xlat2.xxx * vec3(u_xlat19) + u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat1.xyz = (-vec3(u_xlat19)) + u_xlat1.xyz;
    u_xlat2.x = _Saturation * 0.00999999978 + 1.0;
    u_xlat1.xyz = u_xlat2.xxx * u_xlat1.xyz + vec3(u_xlat19);
    u_xlat16_4.xyz = vec3(_Lightness) * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat1.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat1.x = _Contrast + 100.0;
    u_xlat1.x = u_xlat1.x * 0.00999999978;
    u_xlat16_4.xyz = u_xlat1.xxx * u_xlat16_4.xyz + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.xyz = min(max(u_xlat16_4.xyz, 0.0), 1.0);
#else
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = u_xlat16_4.xyz * vec3(-2.0, -2.0, -2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = vec3(vec3(_Invert, _Invert, _Invert)) * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat1.xyz = u_xlat16_4.xyz * _PostColor.xyz + (-u_xlat16_4.xyz);
    u_xlat1.xyz = _PostColor.www * u_xlat1.xyz + u_xlat16_4.xyz;
    u_xlat2 = vs_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat2 = vec4(_Intensity) * u_xlat2 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1.xyz = (-u_xlat16_0.xyz) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat0 = u_xlat16_0 * u_xlat2;
    u_xlat19 = _Blending * _Intensity;
    u_xlat0.xyz = vec3(u_xlat19) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat0.w;
    u_xlat18 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat18) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "INSTANCING_ON" "USE_COLOR_ADJUST" "USE_DISTORTION" "USE_VERT_ANI" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DistTex_ST;
uniform 	float _DistFlowX;
uniform 	float _DistFlowY;
uniform 	float _WaveScale;
uniform 	float _WaveSpd;
uniform 	float _WaveDist;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
struct PropsArray_Type {
	float _Dist;
	float _TileIndex;
	float _FlipFactor;
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_Props {
#endif
	UNITY_UNIFORM PropsArray_Type PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
int u_xlati3;
float u_xlat6;
int u_xlati6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = _Time.y * _WaveSpd;
    u_xlat0.x = in_POSITION0.y * _WaveDist + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _WaveScale;
    u_xlati3 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat0.x = in_POSITION0.x * PropsArray[u_xlati3]._FlipFactor + u_xlat0.x;
    u_xlati6 = int(u_xlati3 << 3);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat0.xz = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat9 = u_xlat0.x * PropsArray[u_xlati3]._TileIndex;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat9>=(-u_xlat9));
#else
    u_xlatb9 = u_xlat9>=(-u_xlat9);
#endif
    u_xlat0.x = (u_xlatb9) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat6 = PropsArray[u_xlati3]._TileIndex / u_xlat0.z;
    u_xlat6 = floor(u_xlat6);
    u_xlat1.y = (-u_xlat6) + in_TEXCOORD0.y;
    u_xlat6 = float(1.0) / u_xlat0.x;
    u_xlat3 = u_xlat6 * PropsArray[u_xlati3]._TileIndex;
    u_xlat3 = fract(u_xlat3);
    u_xlat0.x = u_xlat3 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD0.xy * _DistTex_ST.xy + _DistTex_ST.zw;
    vs_TEXCOORD1.xy = _Time.yy * vec2(_DistFlowX, _DistFlowY) + u_xlat0.xy;
    vs_COLOR0 = in_COLOR0;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	int unity_BaseInstanceID;
uniform 	float _Hue;
uniform 	float _Saturation;
uniform 	float _Lightness;
uniform 	float _Contrast;
uniform 	float _Invert;
uniform 	float _Blending;
uniform 	float _Intensity;
uniform 	vec4 _PostColor;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
struct PropsArray_Type {
	float _Dist;
	float _TileIndex;
	float _FlipFactor;
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_Props {
#endif
	UNITY_UNIFORM PropsArray_Type PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _DistTex;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec3 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
mediump vec3 u_xlat16_4;
mediump vec3 u_xlat16_5;
int u_xlati12;
float u_xlat18;
float u_xlat19;
void main()
{
    u_xlat16_0.xy = texture(_DistTex, vs_TEXCOORD1.xy).xy;
    u_xlat0.xy = u_xlat16_0.xy + vec2(-0.5, -0.5);
    u_xlati12 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat0.xy = u_xlat0.xy * vec2(PropsArray[u_xlati12]._Dist) + vs_TEXCOORD0.xy;
    u_xlat16_0 = texture(_MainTex, u_xlat0.xy);
    u_xlat1.xyz = u_xlat16_0.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat1.xyz = u_xlat16_0.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat1.zxy);
    u_xlat19 = _Hue * 0.0174532924;
    u_xlat2.x = sin(u_xlat19);
    u_xlat3 = cos(u_xlat19);
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xxx;
    u_xlat1.xyz = u_xlat16_0.xyz * vec3(u_xlat3) + u_xlat1.xyz;
    u_xlat19 = (-u_xlat3) + 1.0;
    u_xlat2.x = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat16_0.xyz);
    u_xlat2.x = u_xlat2.x * 0.57735002;
    u_xlat1.xyz = u_xlat2.xxx * vec3(u_xlat19) + u_xlat1.xyz;
    u_xlat19 = dot(u_xlat1.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat1.xyz = (-vec3(u_xlat19)) + u_xlat1.xyz;
    u_xlat2.x = _Saturation * 0.00999999978 + 1.0;
    u_xlat1.xyz = u_xlat2.xxx * u_xlat1.xyz + vec3(u_xlat19);
    u_xlat16_4.xyz = vec3(_Lightness) * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat1.xyz;
    u_xlat16_4.xyz = u_xlat16_4.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat1.x = _Contrast + 100.0;
    u_xlat1.x = u_xlat1.x * 0.00999999978;
    u_xlat16_4.xyz = u_xlat1.xxx * u_xlat16_4.xyz + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_4.xyz = min(max(u_xlat16_4.xyz, 0.0), 1.0);
#else
    u_xlat16_4.xyz = clamp(u_xlat16_4.xyz, 0.0, 1.0);
#endif
    u_xlat16_5.xyz = u_xlat16_4.xyz * vec3(-2.0, -2.0, -2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_4.xyz = vec3(vec3(_Invert, _Invert, _Invert)) * u_xlat16_5.xyz + u_xlat16_4.xyz;
    u_xlat1.xyz = u_xlat16_4.xyz * _PostColor.xyz + (-u_xlat16_4.xyz);
    u_xlat1.xyz = _PostColor.www * u_xlat1.xyz + u_xlat16_4.xyz;
    u_xlat2 = vs_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat2 = vec4(_Intensity) * u_xlat2 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat1.xyz = (-u_xlat16_0.xyz) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat0 = u_xlat16_0 * u_xlat2;
    u_xlat19 = _Blending * _Intensity;
    u_xlat0.xyz = vec3(u_xlat19) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat0.w;
    u_xlat18 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat18) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "USE_AUTO_COLOR_CHANGE" "USE_COLOR_ADJUST" "USE_DISTORTION" "USE_VERT_ANI" }
"#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DistTex_ST;
uniform 	float _DistFlowX;
uniform 	float _DistFlowY;
uniform 	float _WaveScale;
uniform 	float _WaveSpd;
uniform 	float _WaveDist;
uniform 	float _TileIndex;
uniform 	float _FlipFactor;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = _Time.y * _WaveSpd;
    u_xlat0.x = in_POSITION0.y * _WaveDist + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _WaveScale;
    u_xlat0.x = in_POSITION0.x * _FlipFactor + u_xlat0.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat4 = u_xlat0.x * _TileIndex;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4>=(-u_xlat4));
#else
    u_xlatb4 = u_xlat4>=(-u_xlat4);
#endif
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2 = _TileIndex / u_xlat0.y;
    u_xlat2 = floor(u_xlat2);
    u_xlat1.y = (-u_xlat2) + in_TEXCOORD0.y;
    u_xlat2 = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat2 * _TileIndex;
    u_xlat2 = fract(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD0.xy * _DistTex_ST.xy + _DistTex_ST.zw;
    vs_TEXCOORD1.xy = _Time.yy * vec2(_DistFlowX, _DistFlowY) + u_xlat0.xy;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	float _Hue;
uniform 	float _Saturation;
uniform 	float _Lightness;
uniform 	float _Contrast;
uniform 	float _Invert;
uniform 	float _Blending;
uniform 	float _Intensity;
uniform 	vec4 _PostColor;
uniform 	float _AutoColChangeSpeed;
uniform 	float _Dist;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
UNITY_LOCATION(0) uniform mediump sampler2D _DistTex;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec2 u_xlat16_5;
float u_xlat15;
void main()
{
    u_xlat0.x = _Hue + 180.0;
    u_xlat5.x = _Time.x * _AutoColChangeSpeed;
    u_xlat0.x = u_xlat5.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * 0.0174532924;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat16_5.xy = texture(_DistTex, vs_TEXCOORD1.xy).xy;
    u_xlat5.xy = u_xlat16_5.xy + vec2(-0.5, -0.5);
    u_xlat5.xy = u_xlat5.xy * vec2(vec2(_Dist, _Dist)) + vs_TEXCOORD0.xy;
    u_xlat16_2 = texture(_MainTex, u_xlat5.xy);
    u_xlat5.xyz = u_xlat16_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat5.xyz = u_xlat16_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat5.zxy);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * u_xlat1.xxx + u_xlat0.xyz;
    u_xlat15 = (-u_xlat1.x) + 1.0;
    u_xlat1.x = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat16_2.xyz);
    u_xlat1.x = u_xlat1.x * 0.57735002;
    u_xlat0.xyz = u_xlat1.xxx * vec3(u_xlat15) + u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat0.xyz = (-vec3(u_xlat15)) + u_xlat0.xyz;
    u_xlat1.x = _Saturation * 0.00999999978 + 1.0;
    u_xlat0.xyz = u_xlat1.xxx * u_xlat0.xyz + vec3(u_xlat15);
    u_xlat16_3.xyz = vec3(_Lightness) * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat0.x = _Contrast + 100.0;
    u_xlat0.x = u_xlat0.x * 0.00999999978;
    u_xlat16_3.xyz = u_xlat0.xxx * u_xlat16_3.xyz + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.xyz = min(max(u_xlat16_3.xyz, 0.0), 1.0);
#else
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = u_xlat16_3.xyz * vec3(-2.0, -2.0, -2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vec3(vec3(_Invert, _Invert, _Invert)) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * _PostColor.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = _PostColor.www * u_xlat0.xyz + u_xlat16_3.xyz;
    u_xlat1 = vs_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = vec4(_Intensity) * u_xlat1 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0.xyz = (-u_xlat16_2.xyz) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1 = u_xlat1 * u_xlat16_2;
    u_xlat15 = _Blending * _Intensity;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat1.w;
    u_xlat15 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat15) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "USE_AUTO_COLOR_CHANGE" "USE_COLOR_ADJUST" "USE_DISTORTION" "USE_VERT_ANI" }
"#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DistTex_ST;
uniform 	float _DistFlowX;
uniform 	float _DistFlowY;
uniform 	float _WaveScale;
uniform 	float _WaveSpd;
uniform 	float _WaveDist;
uniform 	float _TileIndex;
uniform 	float _FlipFactor;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = _Time.y * _WaveSpd;
    u_xlat0.x = in_POSITION0.y * _WaveDist + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _WaveScale;
    u_xlat0.x = in_POSITION0.x * _FlipFactor + u_xlat0.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat4 = u_xlat0.x * _TileIndex;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4>=(-u_xlat4));
#else
    u_xlatb4 = u_xlat4>=(-u_xlat4);
#endif
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2 = _TileIndex / u_xlat0.y;
    u_xlat2 = floor(u_xlat2);
    u_xlat1.y = (-u_xlat2) + in_TEXCOORD0.y;
    u_xlat2 = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat2 * _TileIndex;
    u_xlat2 = fract(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD0.xy * _DistTex_ST.xy + _DistTex_ST.zw;
    vs_TEXCOORD1.xy = _Time.yy * vec2(_DistFlowX, _DistFlowY) + u_xlat0.xy;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	float _Hue;
uniform 	float _Saturation;
uniform 	float _Lightness;
uniform 	float _Contrast;
uniform 	float _Invert;
uniform 	float _Blending;
uniform 	float _Intensity;
uniform 	vec4 _PostColor;
uniform 	float _AutoColChangeSpeed;
uniform 	float _Dist;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
UNITY_LOCATION(0) uniform mediump sampler2D _DistTex;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec2 u_xlat16_5;
float u_xlat15;
void main()
{
    u_xlat0.x = _Hue + 180.0;
    u_xlat5.x = _Time.x * _AutoColChangeSpeed;
    u_xlat0.x = u_xlat5.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * 0.0174532924;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat16_5.xy = texture(_DistTex, vs_TEXCOORD1.xy).xy;
    u_xlat5.xy = u_xlat16_5.xy + vec2(-0.5, -0.5);
    u_xlat5.xy = u_xlat5.xy * vec2(vec2(_Dist, _Dist)) + vs_TEXCOORD0.xy;
    u_xlat16_2 = texture(_MainTex, u_xlat5.xy);
    u_xlat5.xyz = u_xlat16_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat5.xyz = u_xlat16_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat5.zxy);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * u_xlat1.xxx + u_xlat0.xyz;
    u_xlat15 = (-u_xlat1.x) + 1.0;
    u_xlat1.x = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat16_2.xyz);
    u_xlat1.x = u_xlat1.x * 0.57735002;
    u_xlat0.xyz = u_xlat1.xxx * vec3(u_xlat15) + u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat0.xyz = (-vec3(u_xlat15)) + u_xlat0.xyz;
    u_xlat1.x = _Saturation * 0.00999999978 + 1.0;
    u_xlat0.xyz = u_xlat1.xxx * u_xlat0.xyz + vec3(u_xlat15);
    u_xlat16_3.xyz = vec3(_Lightness) * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat0.x = _Contrast + 100.0;
    u_xlat0.x = u_xlat0.x * 0.00999999978;
    u_xlat16_3.xyz = u_xlat0.xxx * u_xlat16_3.xyz + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.xyz = min(max(u_xlat16_3.xyz, 0.0), 1.0);
#else
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = u_xlat16_3.xyz * vec3(-2.0, -2.0, -2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vec3(vec3(_Invert, _Invert, _Invert)) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * _PostColor.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = _PostColor.www * u_xlat0.xyz + u_xlat16_3.xyz;
    u_xlat1 = vs_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = vec4(_Intensity) * u_xlat1 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0.xyz = (-u_xlat16_2.xyz) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1 = u_xlat1 * u_xlat16_2;
    u_xlat15 = _Blending * _Intensity;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat1.w;
    u_xlat15 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat15) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "USE_AUTO_COLOR_CHANGE" "USE_COLOR_ADJUST" "USE_DISTORTION" "USE_VERT_ANI" }
"#ifdef VERTEX
#version 300 es

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DistTex_ST;
uniform 	float _DistFlowX;
uniform 	float _DistFlowY;
uniform 	float _WaveScale;
uniform 	float _WaveSpd;
uniform 	float _WaveDist;
uniform 	float _TileIndex;
uniform 	float _FlipFactor;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
vec4 u_xlat0;
vec4 u_xlat1;
float u_xlat2;
float u_xlat4;
bool u_xlatb4;
void main()
{
    u_xlat0.x = _Time.y * _WaveSpd;
    u_xlat0.x = in_POSITION0.y * _WaveDist + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _WaveScale;
    u_xlat0.x = in_POSITION0.x * _FlipFactor + u_xlat0.x;
    u_xlat1 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    u_xlat0 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    gl_Position = u_xlat0;
    u_xlat0.xy = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat4 = u_xlat0.x * _TileIndex;
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat4>=(-u_xlat4));
#else
    u_xlatb4 = u_xlat4>=(-u_xlat4);
#endif
    u_xlat0.x = (u_xlatb4) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat2 = _TileIndex / u_xlat0.y;
    u_xlat2 = floor(u_xlat2);
    u_xlat1.y = (-u_xlat2) + in_TEXCOORD0.y;
    u_xlat2 = float(1.0) / u_xlat0.x;
    u_xlat2 = u_xlat2 * _TileIndex;
    u_xlat2 = fract(u_xlat2);
    u_xlat0.x = u_xlat2 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD0.xy * _DistTex_ST.xy + _DistTex_ST.zw;
    vs_TEXCOORD1.xy = _Time.yy * vec2(_DistFlowX, _DistFlowY) + u_xlat0.xy;
    vs_COLOR0 = in_COLOR0;
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	float _Hue;
uniform 	float _Saturation;
uniform 	float _Lightness;
uniform 	float _Contrast;
uniform 	float _Invert;
uniform 	float _Blending;
uniform 	float _Intensity;
uniform 	vec4 _PostColor;
uniform 	float _AutoColChangeSpeed;
uniform 	float _Dist;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
UNITY_LOCATION(0) uniform mediump sampler2D _DistTex;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec2 u_xlat16_5;
float u_xlat15;
void main()
{
    u_xlat0.x = _Hue + 180.0;
    u_xlat5.x = _Time.x * _AutoColChangeSpeed;
    u_xlat0.x = u_xlat5.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * 0.0174532924;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat16_5.xy = texture(_DistTex, vs_TEXCOORD1.xy).xy;
    u_xlat5.xy = u_xlat16_5.xy + vec2(-0.5, -0.5);
    u_xlat5.xy = u_xlat5.xy * vec2(vec2(_Dist, _Dist)) + vs_TEXCOORD0.xy;
    u_xlat16_2 = texture(_MainTex, u_xlat5.xy);
    u_xlat5.xyz = u_xlat16_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat5.xyz = u_xlat16_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat5.zxy);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * u_xlat1.xxx + u_xlat0.xyz;
    u_xlat15 = (-u_xlat1.x) + 1.0;
    u_xlat1.x = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat16_2.xyz);
    u_xlat1.x = u_xlat1.x * 0.57735002;
    u_xlat0.xyz = u_xlat1.xxx * vec3(u_xlat15) + u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat0.xyz = (-vec3(u_xlat15)) + u_xlat0.xyz;
    u_xlat1.x = _Saturation * 0.00999999978 + 1.0;
    u_xlat0.xyz = u_xlat1.xxx * u_xlat0.xyz + vec3(u_xlat15);
    u_xlat16_3.xyz = vec3(_Lightness) * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat0.x = _Contrast + 100.0;
    u_xlat0.x = u_xlat0.x * 0.00999999978;
    u_xlat16_3.xyz = u_xlat0.xxx * u_xlat16_3.xyz + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.xyz = min(max(u_xlat16_3.xyz, 0.0), 1.0);
#else
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = u_xlat16_3.xyz * vec3(-2.0, -2.0, -2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vec3(vec3(_Invert, _Invert, _Invert)) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * _PostColor.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = _PostColor.www * u_xlat0.xyz + u_xlat16_3.xyz;
    u_xlat1 = vs_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = vec4(_Intensity) * u_xlat1 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0.xyz = (-u_xlat16_2.xyz) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1 = u_xlat1 * u_xlat16_2;
    u_xlat15 = _Blending * _Intensity;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat1.w;
    u_xlat15 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat15) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "INSTANCING_ON" "USE_AUTO_COLOR_CHANGE" "USE_COLOR_ADJUST" "USE_DISTORTION" "USE_VERT_ANI" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DistTex_ST;
uniform 	float _DistFlowX;
uniform 	float _DistFlowY;
uniform 	float _WaveScale;
uniform 	float _WaveSpd;
uniform 	float _WaveDist;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
struct PropsArray_Type {
	float _Dist;
	float _TileIndex;
	float _FlipFactor;
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_Props {
#endif
	UNITY_UNIFORM PropsArray_Type PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
int u_xlati3;
float u_xlat6;
int u_xlati6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = _Time.y * _WaveSpd;
    u_xlat0.x = in_POSITION0.y * _WaveDist + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _WaveScale;
    u_xlati3 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat0.x = in_POSITION0.x * PropsArray[u_xlati3]._FlipFactor + u_xlat0.x;
    u_xlati6 = int(u_xlati3 << 3);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat0.xz = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat9 = u_xlat0.x * PropsArray[u_xlati3]._TileIndex;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat9>=(-u_xlat9));
#else
    u_xlatb9 = u_xlat9>=(-u_xlat9);
#endif
    u_xlat0.x = (u_xlatb9) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat6 = PropsArray[u_xlati3]._TileIndex / u_xlat0.z;
    u_xlat6 = floor(u_xlat6);
    u_xlat1.y = (-u_xlat6) + in_TEXCOORD0.y;
    u_xlat6 = float(1.0) / u_xlat0.x;
    u_xlat3 = u_xlat6 * PropsArray[u_xlati3]._TileIndex;
    u_xlat3 = fract(u_xlat3);
    u_xlat0.x = u_xlat3 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD0.xy * _DistTex_ST.xy + _DistTex_ST.zw;
    vs_TEXCOORD1.xy = _Time.yy * vec2(_DistFlowX, _DistFlowY) + u_xlat0.xy;
    vs_COLOR0 = in_COLOR0;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	int unity_BaseInstanceID;
uniform 	float _Hue;
uniform 	float _Saturation;
uniform 	float _Lightness;
uniform 	float _Contrast;
uniform 	float _Invert;
uniform 	float _Blending;
uniform 	float _Intensity;
uniform 	vec4 _PostColor;
uniform 	float _AutoColChangeSpeed;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
struct PropsArray_Type {
	float _Dist;
	float _TileIndex;
	float _FlipFactor;
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_Props {
#endif
	UNITY_UNIFORM PropsArray_Type PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _DistTex;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec2 u_xlat16_5;
float u_xlat15;
int u_xlati15;
void main()
{
    u_xlat0.x = _Hue + 180.0;
    u_xlat5.x = _Time.x * _AutoColChangeSpeed;
    u_xlat0.x = u_xlat5.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * 0.0174532924;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat16_5.xy = texture(_DistTex, vs_TEXCOORD1.xy).xy;
    u_xlat5.xy = u_xlat16_5.xy + vec2(-0.5, -0.5);
    u_xlati15 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat5.xy = u_xlat5.xy * vec2(PropsArray[u_xlati15]._Dist) + vs_TEXCOORD0.xy;
    u_xlat16_2 = texture(_MainTex, u_xlat5.xy);
    u_xlat5.xyz = u_xlat16_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat5.xyz = u_xlat16_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat5.zxy);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * u_xlat1.xxx + u_xlat0.xyz;
    u_xlat15 = (-u_xlat1.x) + 1.0;
    u_xlat1.x = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat16_2.xyz);
    u_xlat1.x = u_xlat1.x * 0.57735002;
    u_xlat0.xyz = u_xlat1.xxx * vec3(u_xlat15) + u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat0.xyz = (-vec3(u_xlat15)) + u_xlat0.xyz;
    u_xlat1.x = _Saturation * 0.00999999978 + 1.0;
    u_xlat0.xyz = u_xlat1.xxx * u_xlat0.xyz + vec3(u_xlat15);
    u_xlat16_3.xyz = vec3(_Lightness) * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat0.x = _Contrast + 100.0;
    u_xlat0.x = u_xlat0.x * 0.00999999978;
    u_xlat16_3.xyz = u_xlat0.xxx * u_xlat16_3.xyz + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.xyz = min(max(u_xlat16_3.xyz, 0.0), 1.0);
#else
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = u_xlat16_3.xyz * vec3(-2.0, -2.0, -2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vec3(vec3(_Invert, _Invert, _Invert)) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * _PostColor.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = _PostColor.www * u_xlat0.xyz + u_xlat16_3.xyz;
    u_xlat1 = vs_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = vec4(_Intensity) * u_xlat1 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0.xyz = (-u_xlat16_2.xyz) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1 = u_xlat1 * u_xlat16_2;
    u_xlat15 = _Blending * _Intensity;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat1.w;
    u_xlat15 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat15) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "INSTANCING_ON" "USE_AUTO_COLOR_CHANGE" "USE_COLOR_ADJUST" "USE_DISTORTION" "USE_VERT_ANI" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DistTex_ST;
uniform 	float _DistFlowX;
uniform 	float _DistFlowY;
uniform 	float _WaveScale;
uniform 	float _WaveSpd;
uniform 	float _WaveDist;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
struct PropsArray_Type {
	float _Dist;
	float _TileIndex;
	float _FlipFactor;
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_Props {
#endif
	UNITY_UNIFORM PropsArray_Type PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
int u_xlati3;
float u_xlat6;
int u_xlati6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = _Time.y * _WaveSpd;
    u_xlat0.x = in_POSITION0.y * _WaveDist + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _WaveScale;
    u_xlati3 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat0.x = in_POSITION0.x * PropsArray[u_xlati3]._FlipFactor + u_xlat0.x;
    u_xlati6 = int(u_xlati3 << 3);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat0.xz = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat9 = u_xlat0.x * PropsArray[u_xlati3]._TileIndex;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat9>=(-u_xlat9));
#else
    u_xlatb9 = u_xlat9>=(-u_xlat9);
#endif
    u_xlat0.x = (u_xlatb9) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat6 = PropsArray[u_xlati3]._TileIndex / u_xlat0.z;
    u_xlat6 = floor(u_xlat6);
    u_xlat1.y = (-u_xlat6) + in_TEXCOORD0.y;
    u_xlat6 = float(1.0) / u_xlat0.x;
    u_xlat3 = u_xlat6 * PropsArray[u_xlati3]._TileIndex;
    u_xlat3 = fract(u_xlat3);
    u_xlat0.x = u_xlat3 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD0.xy * _DistTex_ST.xy + _DistTex_ST.zw;
    vs_TEXCOORD1.xy = _Time.yy * vec2(_DistFlowX, _DistFlowY) + u_xlat0.xy;
    vs_COLOR0 = in_COLOR0;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	int unity_BaseInstanceID;
uniform 	float _Hue;
uniform 	float _Saturation;
uniform 	float _Lightness;
uniform 	float _Contrast;
uniform 	float _Invert;
uniform 	float _Blending;
uniform 	float _Intensity;
uniform 	vec4 _PostColor;
uniform 	float _AutoColChangeSpeed;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
struct PropsArray_Type {
	float _Dist;
	float _TileIndex;
	float _FlipFactor;
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_Props {
#endif
	UNITY_UNIFORM PropsArray_Type PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _DistTex;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec2 u_xlat16_5;
float u_xlat15;
int u_xlati15;
void main()
{
    u_xlat0.x = _Hue + 180.0;
    u_xlat5.x = _Time.x * _AutoColChangeSpeed;
    u_xlat0.x = u_xlat5.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * 0.0174532924;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat16_5.xy = texture(_DistTex, vs_TEXCOORD1.xy).xy;
    u_xlat5.xy = u_xlat16_5.xy + vec2(-0.5, -0.5);
    u_xlati15 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat5.xy = u_xlat5.xy * vec2(PropsArray[u_xlati15]._Dist) + vs_TEXCOORD0.xy;
    u_xlat16_2 = texture(_MainTex, u_xlat5.xy);
    u_xlat5.xyz = u_xlat16_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat5.xyz = u_xlat16_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat5.zxy);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * u_xlat1.xxx + u_xlat0.xyz;
    u_xlat15 = (-u_xlat1.x) + 1.0;
    u_xlat1.x = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat16_2.xyz);
    u_xlat1.x = u_xlat1.x * 0.57735002;
    u_xlat0.xyz = u_xlat1.xxx * vec3(u_xlat15) + u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat0.xyz = (-vec3(u_xlat15)) + u_xlat0.xyz;
    u_xlat1.x = _Saturation * 0.00999999978 + 1.0;
    u_xlat0.xyz = u_xlat1.xxx * u_xlat0.xyz + vec3(u_xlat15);
    u_xlat16_3.xyz = vec3(_Lightness) * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat0.x = _Contrast + 100.0;
    u_xlat0.x = u_xlat0.x * 0.00999999978;
    u_xlat16_3.xyz = u_xlat0.xxx * u_xlat16_3.xyz + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.xyz = min(max(u_xlat16_3.xyz, 0.0), 1.0);
#else
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = u_xlat16_3.xyz * vec3(-2.0, -2.0, -2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vec3(vec3(_Invert, _Invert, _Invert)) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * _PostColor.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = _PostColor.www * u_xlat0.xyz + u_xlat16_3.xyz;
    u_xlat1 = vs_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = vec4(_Intensity) * u_xlat1 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0.xyz = (-u_xlat16_2.xyz) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1 = u_xlat1 * u_xlat16_2;
    u_xlat15 = _Blending * _Intensity;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat1.w;
    u_xlat15 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat15) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "INSTANCING_ON" "USE_AUTO_COLOR_CHANGE" "USE_COLOR_ADJUST" "USE_DISTORTION" "USE_VERT_ANI" }
"#ifdef VERTEX
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	int unity_BaseInstanceID;
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DistTex_ST;
uniform 	float _DistFlowX;
uniform 	float _DistFlowY;
uniform 	float _WaveScale;
uniform 	float _WaveSpd;
uniform 	float _WaveDist;
struct unity_Builtins0Array_Type {
	vec4 hlslcc_mtx4x4unity_ObjectToWorldArray[4];
	vec4 hlslcc_mtx4x4unity_WorldToObjectArray[4];
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(1) uniform UnityInstancing_PerDraw0 {
#endif
	UNITY_UNIFORM unity_Builtins0Array_Type unity_Builtins0Array[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
struct PropsArray_Type {
	float _Dist;
	float _TileIndex;
	float _FlipFactor;
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_Props {
#endif
	UNITY_UNIFORM PropsArray_Type PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out mediump vec4 vs_COLOR0;
flat out highp uint vs_SV_InstanceID0;
vec3 u_xlat0;
vec4 u_xlat1;
vec4 u_xlat2;
float u_xlat3;
int u_xlati3;
float u_xlat6;
int u_xlati6;
float u_xlat9;
bool u_xlatb9;
void main()
{
    u_xlat0.x = _Time.y * _WaveSpd;
    u_xlat0.x = in_POSITION0.y * _WaveDist + u_xlat0.x;
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * _WaveScale;
    u_xlati3 = gl_InstanceID + unity_BaseInstanceID;
    u_xlat0.x = in_POSITION0.x * PropsArray[u_xlati3]._FlipFactor + u_xlat0.x;
    u_xlati6 = int(u_xlati3 << 3);
    u_xlat1 = in_POSITION0.yyyy * unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[1];
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[2] * in_POSITION0.zzzz + u_xlat1;
    u_xlat1 = u_xlat1 + unity_Builtins0Array[u_xlati6 / 8].hlslcc_mtx4x4unity_ObjectToWorldArray[3];
    u_xlat2 = u_xlat1.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
    u_xlat2 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
    gl_Position = u_xlat1;
    u_xlat0.xz = vec2(1.0, 1.0) / _MainTex_ST.xy;
    u_xlat9 = u_xlat0.x * PropsArray[u_xlati3]._TileIndex;
#ifdef UNITY_ADRENO_ES3
    u_xlatb9 = !!(u_xlat9>=(-u_xlat9));
#else
    u_xlatb9 = u_xlat9>=(-u_xlat9);
#endif
    u_xlat0.x = (u_xlatb9) ? u_xlat0.x : (-u_xlat0.x);
    u_xlat6 = PropsArray[u_xlati3]._TileIndex / u_xlat0.z;
    u_xlat6 = floor(u_xlat6);
    u_xlat1.y = (-u_xlat6) + in_TEXCOORD0.y;
    u_xlat6 = float(1.0) / u_xlat0.x;
    u_xlat3 = u_xlat6 * PropsArray[u_xlati3]._TileIndex;
    u_xlat3 = fract(u_xlat3);
    u_xlat0.x = u_xlat3 * u_xlat0.x;
    u_xlat0.x = floor(u_xlat0.x);
    u_xlat1.x = u_xlat0.x + in_TEXCOORD0.x;
    vs_TEXCOORD0.xy = u_xlat1.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD0.xy * _DistTex_ST.xy + _DistTex_ST.zw;
    vs_TEXCOORD1.xy = _Time.yy * vec2(_DistFlowX, _DistFlowY) + u_xlat0.xy;
    vs_COLOR0 = in_COLOR0;
    vs_SV_InstanceID0 = uint(gl_InstanceID);
    return;
}

#endif
#ifdef FRAGMENT
#version 300 es
#ifndef UNITY_RUNTIME_INSTANCING_ARRAY_SIZE
	#define UNITY_RUNTIME_INSTANCING_ARRAY_SIZE 2
#endif

precision highp float;
precision highp int;
#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
#define UNITY_UNIFORM
#else
#define UNITY_UNIFORM uniform
#endif
#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
#if UNITY_SUPPORTS_UNIFORM_LOCATION
#define UNITY_LOCATION(x) layout(location = x)
#define UNITY_BINDING(x) layout(binding = x, std140)
#else
#define UNITY_LOCATION(x)
#define UNITY_BINDING(x) layout(std140)
#endif
uniform 	vec4 _Time;
uniform 	int unity_BaseInstanceID;
uniform 	float _Hue;
uniform 	float _Saturation;
uniform 	float _Lightness;
uniform 	float _Contrast;
uniform 	float _Invert;
uniform 	float _Blending;
uniform 	float _Intensity;
uniform 	vec4 _PostColor;
uniform 	float _AutoColChangeSpeed;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
struct PropsArray_Type {
	float _Dist;
	float _TileIndex;
	float _FlipFactor;
};
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
UNITY_BINDING(0) uniform UnityInstancing_Props {
#endif
	UNITY_UNIFORM PropsArray_Type PropsArray[UNITY_RUNTIME_INSTANCING_ARRAY_SIZE];
#if HLSLCC_ENABLE_UNIFORM_BUFFERS
};
#endif
UNITY_LOCATION(0) uniform mediump sampler2D _DistTex;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in mediump vec4 vs_COLOR0;
flat in highp uint vs_SV_InstanceID0;
layout(location = 0) out highp vec4 SV_Target0;
vec3 u_xlat0;
vec4 u_xlat1;
mediump vec4 u_xlat16_2;
mediump vec3 u_xlat16_3;
mediump vec3 u_xlat16_4;
vec3 u_xlat5;
mediump vec2 u_xlat16_5;
float u_xlat15;
int u_xlati15;
void main()
{
    u_xlat0.x = _Hue + 180.0;
    u_xlat5.x = _Time.x * _AutoColChangeSpeed;
    u_xlat0.x = u_xlat5.x * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * 0.0174532924;
    u_xlat1.x = cos(u_xlat0.x);
    u_xlat0.x = sin(u_xlat0.x);
    u_xlat16_5.xy = texture(_DistTex, vs_TEXCOORD1.xy).xy;
    u_xlat5.xy = u_xlat16_5.xy + vec2(-0.5, -0.5);
    u_xlati15 = int(vs_SV_InstanceID0) + unity_BaseInstanceID;
    u_xlat5.xy = u_xlat5.xy * vec2(PropsArray[u_xlati15]._Dist) + vs_TEXCOORD0.xy;
    u_xlat16_2 = texture(_MainTex, u_xlat5.xy);
    u_xlat5.xyz = u_xlat16_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat5.xyz = u_xlat16_2.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat5.zxy);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat5.xyz;
    u_xlat0.xyz = u_xlat16_2.xyz * u_xlat1.xxx + u_xlat0.xyz;
    u_xlat15 = (-u_xlat1.x) + 1.0;
    u_xlat1.x = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat16_2.xyz);
    u_xlat1.x = u_xlat1.x * 0.57735002;
    u_xlat0.xyz = u_xlat1.xxx * vec3(u_xlat15) + u_xlat0.xyz;
    u_xlat15 = dot(u_xlat0.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat0.xyz = (-vec3(u_xlat15)) + u_xlat0.xyz;
    u_xlat1.x = _Saturation * 0.00999999978 + 1.0;
    u_xlat0.xyz = u_xlat1.xxx * u_xlat0.xyz + vec3(u_xlat15);
    u_xlat16_3.xyz = vec3(_Lightness) * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat0.xyz;
    u_xlat16_3.xyz = u_xlat16_3.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat0.x = _Contrast + 100.0;
    u_xlat0.x = u_xlat0.x * 0.00999999978;
    u_xlat16_3.xyz = u_xlat0.xxx * u_xlat16_3.xyz + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_3.xyz = min(max(u_xlat16_3.xyz, 0.0), 1.0);
#else
    u_xlat16_3.xyz = clamp(u_xlat16_3.xyz, 0.0, 1.0);
#endif
    u_xlat16_4.xyz = u_xlat16_3.xyz * vec3(-2.0, -2.0, -2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_3.xyz = vec3(vec3(_Invert, _Invert, _Invert)) * u_xlat16_4.xyz + u_xlat16_3.xyz;
    u_xlat0.xyz = u_xlat16_3.xyz * _PostColor.xyz + (-u_xlat16_3.xyz);
    u_xlat0.xyz = _PostColor.www * u_xlat0.xyz + u_xlat16_3.xyz;
    u_xlat1 = vs_COLOR0 + vec4(-1.0, -1.0, -1.0, -1.0);
    u_xlat1 = vec4(_Intensity) * u_xlat1 + vec4(1.0, 1.0, 1.0, 1.0);
    u_xlat0.xyz = (-u_xlat16_2.xyz) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1 = u_xlat1 * u_xlat16_2;
    u_xlat15 = _Blending * _Intensity;
    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    u_xlat0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _GlobalAdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    SV_Target0.w = u_xlat1.w;
    u_xlat15 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    SV_Target0.xyz = vec3(u_xlat15) * u_xlat1.xyz + u_xlat0.xyz;
    return;
}

#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier00 " {
""
}
SubProgram "gles hw_tier01 " {
""
}
SubProgram "gles hw_tier02 " {
""
}
SubProgram "gles3 hw_tier00 " {
""
}
SubProgram "gles3 hw_tier01 " {
""
}
SubProgram "gles3 hw_tier02 " {
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "INSTANCING_ON" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "INSTANCING_ON" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "INSTANCING_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "USE_AUTO_COLOR_CHANGE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "USE_AUTO_COLOR_CHANGE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "USE_AUTO_COLOR_CHANGE" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "USE_AUTO_COLOR_CHANGE" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "USE_AUTO_COLOR_CHANGE" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "USE_AUTO_COLOR_CHANGE" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "INSTANCING_ON" "USE_AUTO_COLOR_CHANGE" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "INSTANCING_ON" "USE_AUTO_COLOR_CHANGE" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "INSTANCING_ON" "USE_AUTO_COLOR_CHANGE" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "USE_COLOR_ADJUST" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "USE_COLOR_ADJUST" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "USE_COLOR_ADJUST" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "USE_COLOR_ADJUST" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "USE_COLOR_ADJUST" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "USE_COLOR_ADJUST" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "INSTANCING_ON" "USE_COLOR_ADJUST" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "INSTANCING_ON" "USE_COLOR_ADJUST" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "INSTANCING_ON" "USE_COLOR_ADJUST" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "USE_AUTO_COLOR_CHANGE" "USE_COLOR_ADJUST" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "USE_AUTO_COLOR_CHANGE" "USE_COLOR_ADJUST" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "USE_AUTO_COLOR_CHANGE" "USE_COLOR_ADJUST" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "USE_AUTO_COLOR_CHANGE" "USE_COLOR_ADJUST" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "USE_AUTO_COLOR_CHANGE" "USE_COLOR_ADJUST" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "USE_AUTO_COLOR_CHANGE" "USE_COLOR_ADJUST" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "INSTANCING_ON" "USE_AUTO_COLOR_CHANGE" "USE_COLOR_ADJUST" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "INSTANCING_ON" "USE_AUTO_COLOR_CHANGE" "USE_COLOR_ADJUST" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "INSTANCING_ON" "USE_AUTO_COLOR_CHANGE" "USE_COLOR_ADJUST" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "USE_DISTORTION" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "USE_DISTORTION" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "USE_DISTORTION" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "USE_DISTORTION" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "USE_DISTORTION" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "USE_DISTORTION" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "INSTANCING_ON" "USE_DISTORTION" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "INSTANCING_ON" "USE_DISTORTION" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "INSTANCING_ON" "USE_DISTORTION" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "USE_AUTO_COLOR_CHANGE" "USE_DISTORTION" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "USE_AUTO_COLOR_CHANGE" "USE_DISTORTION" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "USE_AUTO_COLOR_CHANGE" "USE_DISTORTION" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "USE_AUTO_COLOR_CHANGE" "USE_DISTORTION" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "USE_AUTO_COLOR_CHANGE" "USE_DISTORTION" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "USE_AUTO_COLOR_CHANGE" "USE_DISTORTION" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "INSTANCING_ON" "USE_AUTO_COLOR_CHANGE" "USE_DISTORTION" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "INSTANCING_ON" "USE_AUTO_COLOR_CHANGE" "USE_DISTORTION" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "INSTANCING_ON" "USE_AUTO_COLOR_CHANGE" "USE_DISTORTION" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "USE_COLOR_ADJUST" "USE_DISTORTION" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "USE_COLOR_ADJUST" "USE_DISTORTION" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "USE_COLOR_ADJUST" "USE_DISTORTION" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "USE_COLOR_ADJUST" "USE_DISTORTION" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "USE_COLOR_ADJUST" "USE_DISTORTION" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "USE_COLOR_ADJUST" "USE_DISTORTION" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "INSTANCING_ON" "USE_COLOR_ADJUST" "USE_DISTORTION" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "INSTANCING_ON" "USE_COLOR_ADJUST" "USE_DISTORTION" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "INSTANCING_ON" "USE_COLOR_ADJUST" "USE_DISTORTION" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "USE_AUTO_COLOR_CHANGE" "USE_COLOR_ADJUST" "USE_DISTORTION" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "USE_AUTO_COLOR_CHANGE" "USE_COLOR_ADJUST" "USE_DISTORTION" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "USE_AUTO_COLOR_CHANGE" "USE_COLOR_ADJUST" "USE_DISTORTION" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "USE_AUTO_COLOR_CHANGE" "USE_COLOR_ADJUST" "USE_DISTORTION" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "USE_AUTO_COLOR_CHANGE" "USE_COLOR_ADJUST" "USE_DISTORTION" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "USE_AUTO_COLOR_CHANGE" "USE_COLOR_ADJUST" "USE_DISTORTION" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "INSTANCING_ON" "USE_AUTO_COLOR_CHANGE" "USE_COLOR_ADJUST" "USE_DISTORTION" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "INSTANCING_ON" "USE_AUTO_COLOR_CHANGE" "USE_COLOR_ADJUST" "USE_DISTORTION" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "INSTANCING_ON" "USE_AUTO_COLOR_CHANGE" "USE_COLOR_ADJUST" "USE_DISTORTION" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "USE_VERT_ANI" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "USE_VERT_ANI" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "USE_VERT_ANI" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "USE_VERT_ANI" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "USE_VERT_ANI" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "USE_VERT_ANI" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "INSTANCING_ON" "USE_VERT_ANI" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "INSTANCING_ON" "USE_VERT_ANI" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "INSTANCING_ON" "USE_VERT_ANI" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "USE_AUTO_COLOR_CHANGE" "USE_VERT_ANI" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "USE_AUTO_COLOR_CHANGE" "USE_VERT_ANI" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "USE_AUTO_COLOR_CHANGE" "USE_VERT_ANI" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "USE_AUTO_COLOR_CHANGE" "USE_VERT_ANI" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "USE_AUTO_COLOR_CHANGE" "USE_VERT_ANI" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "USE_AUTO_COLOR_CHANGE" "USE_VERT_ANI" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "INSTANCING_ON" "USE_AUTO_COLOR_CHANGE" "USE_VERT_ANI" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "INSTANCING_ON" "USE_AUTO_COLOR_CHANGE" "USE_VERT_ANI" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "INSTANCING_ON" "USE_AUTO_COLOR_CHANGE" "USE_VERT_ANI" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "USE_COLOR_ADJUST" "USE_VERT_ANI" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "USE_COLOR_ADJUST" "USE_VERT_ANI" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "USE_COLOR_ADJUST" "USE_VERT_ANI" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "USE_COLOR_ADJUST" "USE_VERT_ANI" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "USE_COLOR_ADJUST" "USE_VERT_ANI" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "USE_COLOR_ADJUST" "USE_VERT_ANI" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "INSTANCING_ON" "USE_COLOR_ADJUST" "USE_VERT_ANI" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "INSTANCING_ON" "USE_COLOR_ADJUST" "USE_VERT_ANI" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "INSTANCING_ON" "USE_COLOR_ADJUST" "USE_VERT_ANI" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "USE_AUTO_COLOR_CHANGE" "USE_COLOR_ADJUST" "USE_VERT_ANI" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "USE_AUTO_COLOR_CHANGE" "USE_COLOR_ADJUST" "USE_VERT_ANI" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "USE_AUTO_COLOR_CHANGE" "USE_COLOR_ADJUST" "USE_VERT_ANI" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "USE_AUTO_COLOR_CHANGE" "USE_COLOR_ADJUST" "USE_VERT_ANI" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "USE_AUTO_COLOR_CHANGE" "USE_COLOR_ADJUST" "USE_VERT_ANI" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "USE_AUTO_COLOR_CHANGE" "USE_COLOR_ADJUST" "USE_VERT_ANI" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "INSTANCING_ON" "USE_AUTO_COLOR_CHANGE" "USE_COLOR_ADJUST" "USE_VERT_ANI" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "INSTANCING_ON" "USE_AUTO_COLOR_CHANGE" "USE_COLOR_ADJUST" "USE_VERT_ANI" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "INSTANCING_ON" "USE_AUTO_COLOR_CHANGE" "USE_COLOR_ADJUST" "USE_VERT_ANI" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "USE_DISTORTION" "USE_VERT_ANI" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "USE_DISTORTION" "USE_VERT_ANI" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "USE_DISTORTION" "USE_VERT_ANI" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "USE_DISTORTION" "USE_VERT_ANI" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "USE_DISTORTION" "USE_VERT_ANI" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "USE_DISTORTION" "USE_VERT_ANI" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "INSTANCING_ON" "USE_DISTORTION" "USE_VERT_ANI" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "INSTANCING_ON" "USE_DISTORTION" "USE_VERT_ANI" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "INSTANCING_ON" "USE_DISTORTION" "USE_VERT_ANI" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "USE_AUTO_COLOR_CHANGE" "USE_DISTORTION" "USE_VERT_ANI" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "USE_AUTO_COLOR_CHANGE" "USE_DISTORTION" "USE_VERT_ANI" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "USE_AUTO_COLOR_CHANGE" "USE_DISTORTION" "USE_VERT_ANI" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "USE_AUTO_COLOR_CHANGE" "USE_DISTORTION" "USE_VERT_ANI" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "USE_AUTO_COLOR_CHANGE" "USE_DISTORTION" "USE_VERT_ANI" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "USE_AUTO_COLOR_CHANGE" "USE_DISTORTION" "USE_VERT_ANI" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "INSTANCING_ON" "USE_AUTO_COLOR_CHANGE" "USE_DISTORTION" "USE_VERT_ANI" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "INSTANCING_ON" "USE_AUTO_COLOR_CHANGE" "USE_DISTORTION" "USE_VERT_ANI" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "INSTANCING_ON" "USE_AUTO_COLOR_CHANGE" "USE_DISTORTION" "USE_VERT_ANI" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "USE_COLOR_ADJUST" "USE_DISTORTION" "USE_VERT_ANI" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "USE_COLOR_ADJUST" "USE_DISTORTION" "USE_VERT_ANI" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "USE_COLOR_ADJUST" "USE_DISTORTION" "USE_VERT_ANI" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "USE_COLOR_ADJUST" "USE_DISTORTION" "USE_VERT_ANI" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "USE_COLOR_ADJUST" "USE_DISTORTION" "USE_VERT_ANI" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "USE_COLOR_ADJUST" "USE_DISTORTION" "USE_VERT_ANI" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "INSTANCING_ON" "USE_COLOR_ADJUST" "USE_DISTORTION" "USE_VERT_ANI" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "INSTANCING_ON" "USE_COLOR_ADJUST" "USE_DISTORTION" "USE_VERT_ANI" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "INSTANCING_ON" "USE_COLOR_ADJUST" "USE_DISTORTION" "USE_VERT_ANI" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "USE_AUTO_COLOR_CHANGE" "USE_COLOR_ADJUST" "USE_DISTORTION" "USE_VERT_ANI" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "USE_AUTO_COLOR_CHANGE" "USE_COLOR_ADJUST" "USE_DISTORTION" "USE_VERT_ANI" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "USE_AUTO_COLOR_CHANGE" "USE_COLOR_ADJUST" "USE_DISTORTION" "USE_VERT_ANI" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "USE_AUTO_COLOR_CHANGE" "USE_COLOR_ADJUST" "USE_DISTORTION" "USE_VERT_ANI" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "USE_AUTO_COLOR_CHANGE" "USE_COLOR_ADJUST" "USE_DISTORTION" "USE_VERT_ANI" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "USE_AUTO_COLOR_CHANGE" "USE_COLOR_ADJUST" "USE_DISTORTION" "USE_VERT_ANI" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "INSTANCING_ON" "USE_AUTO_COLOR_CHANGE" "USE_COLOR_ADJUST" "USE_DISTORTION" "USE_VERT_ANI" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "INSTANCING_ON" "USE_AUTO_COLOR_CHANGE" "USE_COLOR_ADJUST" "USE_DISTORTION" "USE_VERT_ANI" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "INSTANCING_ON" "USE_AUTO_COLOR_CHANGE" "USE_COLOR_ADJUST" "USE_DISTORTION" "USE_VERT_ANI" }
""
}
}
}
}
}