//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "CK/kingdom_worldmap" {
Properties {
[Enum(UnityEngine.Rendering.BlendMode)] _SrcMode ("SrcMode", Float) = 5
[Enum(Alpha Blend, 10, Additive, 1)] _DstMode ("Blend Mode", Float) = 10
[Enum(2Side, 0, Front, 2, Back, 1)] _Culling ("Show Mesh", Float) = 0
[Enum(Off, 0, On, 1)] _Zwrite ("ZWrite", Float) = 0
_HdrColor ("Hdr Color", Color) = (1,1,1,1)
_MainTex ("Main Texture", 2D) = "white" { }
_Fade ("Fade", Range(0, 1)) = 1
_FrontColor ("Front Color Layer", Color) = (1,1,1,1)
_Hue ("Hue", Range(-180, 180)) = 0
_Saturation ("Saturation", Range(-100, 100)) = 0
_Lightness ("Lightness", Range(-100, 100)) = 0
_Contrast ("Contrast", Range(-100, 100)) = 0
_Invert ("Invert", Range(0, 1)) = 0
_PostColor ("Post Color Layer", Color) = (1,1,1,1)
_Blending ("Original Color & Adjust Color Blending", Range(0, 1)) = 1
_Intensity ("All Properties Intensity", Range(0, 1)) = 1
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "PerformanceChecks" = "False" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "PerformanceChecks" = "False" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend Zero Zero, Zero Zero
  ZWrite Off
  Cull Off
  GpuProgramID 40374
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	vec4 _HdrColor;
uniform 	float _Fade;
uniform 	mediump float _Hue;
uniform 	mediump float _Saturation;
uniform 	mediump float _Lightness;
uniform 	mediump float _Contrast;
uniform 	mediump float _Invert;
uniform 	mediump float _Blending;
uniform 	mediump float _Intensity;
uniform 	mediump vec4 _FrontColor;
uniform 	mediump vec4 _PostColor;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat4;
float u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
float u_xlat24;
mediump float u_xlat16_30;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat10_0 * _HdrColor;
    u_xlat1 = u_xlat0 * vs_COLOR0;
    u_xlat2.xyz = u_xlat1.xyz * _FrontColor.xyz + (-u_xlat1.xyz);
    u_xlat2.xyz = _FrontColor.www * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat3.xyz = u_xlat2.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat3.xyz = u_xlat2.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat3.zxy);
    u_xlat24 = _Hue * 0.0174532924;
    u_xlat4 = sin(u_xlat24);
    u_xlat5 = cos(u_xlat24);
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat4);
    u_xlat3.xyz = u_xlat2.xyz * vec3(u_xlat5) + u_xlat3.xyz;
    u_xlat24 = (-u_xlat5) + 1.0;
    u_xlat2.x = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat2.xyz);
    u_xlat2.x = u_xlat2.x * 0.57735002;
    u_xlat2.xyz = u_xlat2.xxx * vec3(u_xlat24) + u_xlat3.xyz;
    u_xlat24 = dot(u_xlat2.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat2.xyz = (-vec3(u_xlat24)) + u_xlat2.xyz;
    u_xlat16_6.x = _Saturation * 0.00999999978 + 1.0;
    u_xlat2.xyz = u_xlat16_6.xxx * u_xlat2.xyz + vec3(u_xlat24);
    u_xlat16_6.xyz = vec3(vec3(_Lightness, _Lightness, _Lightness)) * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat2.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat16_30 = _Contrast + 100.0;
    u_xlat16_30 = u_xlat16_30 * 0.00999999978;
    u_xlat16_6.xyz = vec3(u_xlat16_30) * u_xlat16_6.xyz + vec3(0.5, 0.5, 0.5);
    u_xlat16_6.xyz = clamp(u_xlat16_6.xyz, 0.0, 1.0);
    u_xlat16_7.xyz = u_xlat16_6.xyz * vec3(-2.0, -2.0, -2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = vec3(_Invert) * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_7.xyz = u_xlat16_6.xyz * _PostColor.xyz + (-u_xlat16_6.xyz);
    u_xlat16_6.xyz = _PostColor.www * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_6.xyz = (-u_xlat0.xyz) * vs_COLOR0.xyz + u_xlat16_6.xyz;
    u_xlat16_30 = _Blending * _Intensity;
    u_xlat16_6.xyz = vec3(u_xlat16_30) * u_xlat16_6.xyz + u_xlat1.xyz;
    SV_Target0.w = u_xlat1.w * _Fade;
    SV_Target0.xyz = u_xlat16_6.xyz;
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
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	vec4 _HdrColor;
uniform 	float _Fade;
uniform 	mediump float _Hue;
uniform 	mediump float _Saturation;
uniform 	mediump float _Lightness;
uniform 	mediump float _Contrast;
uniform 	mediump float _Invert;
uniform 	mediump float _Blending;
uniform 	mediump float _Intensity;
uniform 	mediump vec4 _FrontColor;
uniform 	mediump vec4 _PostColor;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat4;
float u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
float u_xlat24;
mediump float u_xlat16_30;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat10_0 * _HdrColor;
    u_xlat1 = u_xlat0 * vs_COLOR0;
    u_xlat2.xyz = u_xlat1.xyz * _FrontColor.xyz + (-u_xlat1.xyz);
    u_xlat2.xyz = _FrontColor.www * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat3.xyz = u_xlat2.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat3.xyz = u_xlat2.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat3.zxy);
    u_xlat24 = _Hue * 0.0174532924;
    u_xlat4 = sin(u_xlat24);
    u_xlat5 = cos(u_xlat24);
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat4);
    u_xlat3.xyz = u_xlat2.xyz * vec3(u_xlat5) + u_xlat3.xyz;
    u_xlat24 = (-u_xlat5) + 1.0;
    u_xlat2.x = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat2.xyz);
    u_xlat2.x = u_xlat2.x * 0.57735002;
    u_xlat2.xyz = u_xlat2.xxx * vec3(u_xlat24) + u_xlat3.xyz;
    u_xlat24 = dot(u_xlat2.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat2.xyz = (-vec3(u_xlat24)) + u_xlat2.xyz;
    u_xlat16_6.x = _Saturation * 0.00999999978 + 1.0;
    u_xlat2.xyz = u_xlat16_6.xxx * u_xlat2.xyz + vec3(u_xlat24);
    u_xlat16_6.xyz = vec3(vec3(_Lightness, _Lightness, _Lightness)) * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat2.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat16_30 = _Contrast + 100.0;
    u_xlat16_30 = u_xlat16_30 * 0.00999999978;
    u_xlat16_6.xyz = vec3(u_xlat16_30) * u_xlat16_6.xyz + vec3(0.5, 0.5, 0.5);
    u_xlat16_6.xyz = clamp(u_xlat16_6.xyz, 0.0, 1.0);
    u_xlat16_7.xyz = u_xlat16_6.xyz * vec3(-2.0, -2.0, -2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = vec3(_Invert) * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_7.xyz = u_xlat16_6.xyz * _PostColor.xyz + (-u_xlat16_6.xyz);
    u_xlat16_6.xyz = _PostColor.www * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_6.xyz = (-u_xlat0.xyz) * vs_COLOR0.xyz + u_xlat16_6.xyz;
    u_xlat16_30 = _Blending * _Intensity;
    u_xlat16_6.xyz = vec3(u_xlat16_30) * u_xlat16_6.xyz + u_xlat1.xyz;
    SV_Target0.w = u_xlat1.w * _Fade;
    SV_Target0.xyz = u_xlat16_6.xyz;
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
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec4 in_TEXCOORD0;
varying highp vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	vec4 _HdrColor;
uniform 	float _Fade;
uniform 	mediump float _Hue;
uniform 	mediump float _Saturation;
uniform 	mediump float _Lightness;
uniform 	mediump float _Contrast;
uniform 	mediump float _Invert;
uniform 	mediump float _Blending;
uniform 	mediump float _Intensity;
uniform 	mediump vec4 _FrontColor;
uniform 	mediump vec4 _PostColor;
uniform lowp sampler2D _MainTex;
varying highp vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat4;
float u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
float u_xlat24;
mediump float u_xlat16_30;
void main()
{
    u_xlat10_0 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat10_0 * _HdrColor;
    u_xlat1 = u_xlat0 * vs_COLOR0;
    u_xlat2.xyz = u_xlat1.xyz * _FrontColor.xyz + (-u_xlat1.xyz);
    u_xlat2.xyz = _FrontColor.www * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat3.xyz = u_xlat2.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat3.xyz = u_xlat2.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat3.zxy);
    u_xlat24 = _Hue * 0.0174532924;
    u_xlat4 = sin(u_xlat24);
    u_xlat5 = cos(u_xlat24);
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat4);
    u_xlat3.xyz = u_xlat2.xyz * vec3(u_xlat5) + u_xlat3.xyz;
    u_xlat24 = (-u_xlat5) + 1.0;
    u_xlat2.x = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat2.xyz);
    u_xlat2.x = u_xlat2.x * 0.57735002;
    u_xlat2.xyz = u_xlat2.xxx * vec3(u_xlat24) + u_xlat3.xyz;
    u_xlat24 = dot(u_xlat2.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat2.xyz = (-vec3(u_xlat24)) + u_xlat2.xyz;
    u_xlat16_6.x = _Saturation * 0.00999999978 + 1.0;
    u_xlat2.xyz = u_xlat16_6.xxx * u_xlat2.xyz + vec3(u_xlat24);
    u_xlat16_6.xyz = vec3(vec3(_Lightness, _Lightness, _Lightness)) * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat2.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat16_30 = _Contrast + 100.0;
    u_xlat16_30 = u_xlat16_30 * 0.00999999978;
    u_xlat16_6.xyz = vec3(u_xlat16_30) * u_xlat16_6.xyz + vec3(0.5, 0.5, 0.5);
    u_xlat16_6.xyz = clamp(u_xlat16_6.xyz, 0.0, 1.0);
    u_xlat16_7.xyz = u_xlat16_6.xyz * vec3(-2.0, -2.0, -2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = vec3(_Invert) * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_7.xyz = u_xlat16_6.xyz * _PostColor.xyz + (-u_xlat16_6.xyz);
    u_xlat16_6.xyz = _PostColor.www * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_6.xyz = (-u_xlat0.xyz) * vs_COLOR0.xyz + u_xlat16_6.xyz;
    u_xlat16_30 = _Blending * _Intensity;
    u_xlat16_6.xyz = vec3(u_xlat16_30) * u_xlat16_6.xyz + u_xlat1.xyz;
    SV_Target0.w = u_xlat1.w * _Fade;
    SV_Target0.xyz = u_xlat16_6.xyz;
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
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	vec4 _HdrColor;
uniform 	float _Fade;
uniform 	mediump float _Hue;
uniform 	mediump float _Saturation;
uniform 	mediump float _Lightness;
uniform 	mediump float _Contrast;
uniform 	mediump float _Invert;
uniform 	mediump float _Blending;
uniform 	mediump float _Intensity;
uniform 	mediump vec4 _FrontColor;
uniform 	mediump vec4 _PostColor;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat4;
float u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
float u_xlat24;
mediump float u_xlat16_30;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat16_0 * _HdrColor;
    u_xlat1 = u_xlat0 * vs_COLOR0;
    u_xlat2.xyz = u_xlat1.xyz * _FrontColor.xyz + (-u_xlat1.xyz);
    u_xlat2.xyz = _FrontColor.www * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat3.xyz = u_xlat2.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat3.xyz = u_xlat2.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat3.zxy);
    u_xlat24 = _Hue * 0.0174532924;
    u_xlat4 = sin(u_xlat24);
    u_xlat5 = cos(u_xlat24);
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat4);
    u_xlat3.xyz = u_xlat2.xyz * vec3(u_xlat5) + u_xlat3.xyz;
    u_xlat24 = (-u_xlat5) + 1.0;
    u_xlat2.x = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat2.xyz);
    u_xlat2.x = u_xlat2.x * 0.57735002;
    u_xlat2.xyz = u_xlat2.xxx * vec3(u_xlat24) + u_xlat3.xyz;
    u_xlat24 = dot(u_xlat2.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat2.xyz = (-vec3(u_xlat24)) + u_xlat2.xyz;
    u_xlat16_6.x = _Saturation * 0.00999999978 + 1.0;
    u_xlat2.xyz = u_xlat16_6.xxx * u_xlat2.xyz + vec3(u_xlat24);
    u_xlat16_6.xyz = vec3(vec3(_Lightness, _Lightness, _Lightness)) * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat2.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat16_30 = _Contrast + 100.0;
    u_xlat16_30 = u_xlat16_30 * 0.00999999978;
    u_xlat16_6.xyz = vec3(u_xlat16_30) * u_xlat16_6.xyz + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6.xyz = min(max(u_xlat16_6.xyz, 0.0), 1.0);
#else
    u_xlat16_6.xyz = clamp(u_xlat16_6.xyz, 0.0, 1.0);
#endif
    u_xlat16_7.xyz = u_xlat16_6.xyz * vec3(-2.0, -2.0, -2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = vec3(_Invert) * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_7.xyz = u_xlat16_6.xyz * _PostColor.xyz + (-u_xlat16_6.xyz);
    u_xlat16_6.xyz = _PostColor.www * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_6.xyz = (-u_xlat0.xyz) * vs_COLOR0.xyz + u_xlat16_6.xyz;
    u_xlat16_30 = _Blending * _Intensity;
    u_xlat16_6.xyz = vec3(u_xlat16_30) * u_xlat16_6.xyz + u_xlat1.xyz;
    SV_Target0.w = u_xlat1.w * _Fade;
    SV_Target0.xyz = u_xlat16_6.xyz;
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
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	vec4 _HdrColor;
uniform 	float _Fade;
uniform 	mediump float _Hue;
uniform 	mediump float _Saturation;
uniform 	mediump float _Lightness;
uniform 	mediump float _Contrast;
uniform 	mediump float _Invert;
uniform 	mediump float _Blending;
uniform 	mediump float _Intensity;
uniform 	mediump vec4 _FrontColor;
uniform 	mediump vec4 _PostColor;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat4;
float u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
float u_xlat24;
mediump float u_xlat16_30;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat16_0 * _HdrColor;
    u_xlat1 = u_xlat0 * vs_COLOR0;
    u_xlat2.xyz = u_xlat1.xyz * _FrontColor.xyz + (-u_xlat1.xyz);
    u_xlat2.xyz = _FrontColor.www * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat3.xyz = u_xlat2.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat3.xyz = u_xlat2.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat3.zxy);
    u_xlat24 = _Hue * 0.0174532924;
    u_xlat4 = sin(u_xlat24);
    u_xlat5 = cos(u_xlat24);
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat4);
    u_xlat3.xyz = u_xlat2.xyz * vec3(u_xlat5) + u_xlat3.xyz;
    u_xlat24 = (-u_xlat5) + 1.0;
    u_xlat2.x = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat2.xyz);
    u_xlat2.x = u_xlat2.x * 0.57735002;
    u_xlat2.xyz = u_xlat2.xxx * vec3(u_xlat24) + u_xlat3.xyz;
    u_xlat24 = dot(u_xlat2.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat2.xyz = (-vec3(u_xlat24)) + u_xlat2.xyz;
    u_xlat16_6.x = _Saturation * 0.00999999978 + 1.0;
    u_xlat2.xyz = u_xlat16_6.xxx * u_xlat2.xyz + vec3(u_xlat24);
    u_xlat16_6.xyz = vec3(vec3(_Lightness, _Lightness, _Lightness)) * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat2.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat16_30 = _Contrast + 100.0;
    u_xlat16_30 = u_xlat16_30 * 0.00999999978;
    u_xlat16_6.xyz = vec3(u_xlat16_30) * u_xlat16_6.xyz + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6.xyz = min(max(u_xlat16_6.xyz, 0.0), 1.0);
#else
    u_xlat16_6.xyz = clamp(u_xlat16_6.xyz, 0.0, 1.0);
#endif
    u_xlat16_7.xyz = u_xlat16_6.xyz * vec3(-2.0, -2.0, -2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = vec3(_Invert) * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_7.xyz = u_xlat16_6.xyz * _PostColor.xyz + (-u_xlat16_6.xyz);
    u_xlat16_6.xyz = _PostColor.www * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_6.xyz = (-u_xlat0.xyz) * vs_COLOR0.xyz + u_xlat16_6.xyz;
    u_xlat16_30 = _Blending * _Intensity;
    u_xlat16_6.xyz = vec3(u_xlat16_30) * u_xlat16_6.xyz + u_xlat1.xyz;
    SV_Target0.w = u_xlat1.w * _Fade;
    SV_Target0.xyz = u_xlat16_6.xyz;
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
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_COLOR0 = in_COLOR0;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
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
uniform 	vec4 _HdrColor;
uniform 	float _Fade;
uniform 	mediump float _Hue;
uniform 	mediump float _Saturation;
uniform 	mediump float _Lightness;
uniform 	mediump float _Contrast;
uniform 	mediump float _Invert;
uniform 	mediump float _Blending;
uniform 	mediump float _Intensity;
uniform 	mediump vec4 _FrontColor;
uniform 	mediump vec4 _PostColor;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
vec3 u_xlat2;
vec3 u_xlat3;
float u_xlat4;
float u_xlat5;
mediump vec3 u_xlat16_6;
mediump vec3 u_xlat16_7;
float u_xlat24;
mediump float u_xlat16_30;
void main()
{
    u_xlat16_0 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat0 = u_xlat16_0 * _HdrColor;
    u_xlat1 = u_xlat0 * vs_COLOR0;
    u_xlat2.xyz = u_xlat1.xyz * _FrontColor.xyz + (-u_xlat1.xyz);
    u_xlat2.xyz = _FrontColor.www * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat3.xyz = u_xlat2.zxy * vec3(0.57735002, 0.57735002, 0.57735002);
    u_xlat3.xyz = u_xlat2.zxy * vec3(0.57735002, 0.57735002, 0.57735002) + (-u_xlat3.zxy);
    u_xlat24 = _Hue * 0.0174532924;
    u_xlat4 = sin(u_xlat24);
    u_xlat5 = cos(u_xlat24);
    u_xlat3.xyz = u_xlat3.xyz * vec3(u_xlat4);
    u_xlat3.xyz = u_xlat2.xyz * vec3(u_xlat5) + u_xlat3.xyz;
    u_xlat24 = (-u_xlat5) + 1.0;
    u_xlat2.x = dot(vec3(0.57735002, 0.57735002, 0.57735002), u_xlat2.xyz);
    u_xlat2.x = u_xlat2.x * 0.57735002;
    u_xlat2.xyz = u_xlat2.xxx * vec3(u_xlat24) + u_xlat3.xyz;
    u_xlat24 = dot(u_xlat2.xyz, vec3(0.298999995, 0.587000012, 0.114));
    u_xlat2.xyz = (-vec3(u_xlat24)) + u_xlat2.xyz;
    u_xlat16_6.x = _Saturation * 0.00999999978 + 1.0;
    u_xlat2.xyz = u_xlat16_6.xxx * u_xlat2.xyz + vec3(u_xlat24);
    u_xlat16_6.xyz = vec3(vec3(_Lightness, _Lightness, _Lightness)) * vec3(0.00999999978, 0.00999999978, 0.00999999978) + u_xlat2.xyz;
    u_xlat16_6.xyz = u_xlat16_6.xyz + vec3(-0.5, -0.5, -0.5);
    u_xlat16_30 = _Contrast + 100.0;
    u_xlat16_30 = u_xlat16_30 * 0.00999999978;
    u_xlat16_6.xyz = vec3(u_xlat16_30) * u_xlat16_6.xyz + vec3(0.5, 0.5, 0.5);
#ifdef UNITY_ADRENO_ES3
    u_xlat16_6.xyz = min(max(u_xlat16_6.xyz, 0.0), 1.0);
#else
    u_xlat16_6.xyz = clamp(u_xlat16_6.xyz, 0.0, 1.0);
#endif
    u_xlat16_7.xyz = u_xlat16_6.xyz * vec3(-2.0, -2.0, -2.0) + vec3(1.0, 1.0, 1.0);
    u_xlat16_6.xyz = vec3(_Invert) * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_7.xyz = u_xlat16_6.xyz * _PostColor.xyz + (-u_xlat16_6.xyz);
    u_xlat16_6.xyz = _PostColor.www * u_xlat16_7.xyz + u_xlat16_6.xyz;
    u_xlat16_6.xyz = (-u_xlat0.xyz) * vs_COLOR0.xyz + u_xlat16_6.xyz;
    u_xlat16_30 = _Blending * _Intensity;
    u_xlat16_6.xyz = vec3(u_xlat16_30) * u_xlat16_6.xyz + u_xlat1.xyz;
    SV_Target0.w = u_xlat1.w * _Fade;
    SV_Target0.xyz = u_xlat16_6.xyz;
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
}
}
}
}