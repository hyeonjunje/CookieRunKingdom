//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "CK/kingdom_particle" {
Properties {
[Enum(UnityEngine.Rendering.BlendMode)] _SrcMode ("SrcMode", Float) = 5
[Enum(Alpha Blend, 10, Additive, 1)] _DstMode ("Blend Mode", Float) = 10
[Enum(2Side, 0, Front, 2, Back, 1)] _Culling ("Show Mesh", Float) = 0
[Enum(Off, 0, On, 1)] _Zwrite ("ZWrite", Float) = 0
_HdrColor ("Hdr Color", Color) = (1,1,1,1)
_MainTex ("Main Texture", 2D) = "white" { }
_MainTexScrollX ("Main Texture Flow Speed X", Range(-10, 10)) = 0
_MainTexScrollY ("Main Texture Flow Speed Y", Range(-10, 10)) = 0
_ATex ("Alpha Texture", 2D) = "white" { }
_ATexScrollX ("Alpha Flow Speed X", Range(-10, 10)) = 0
_ATexScrollY ("Alpha Flow Speed Y", Range(-10, 10)) = 0
_DTex ("Distortion Texture", 2D) = "white" { }
_DTexScrollX ("Distortion Flow Speed X", Range(-10, 10)) = 0
_DTexScrollY ("Distortion Flow Speed Y", Range(-10, 10)) = 0
_DsTex ("Dissolve Texture", 2D) = "white" { }
_DsTexScrollX ("Dissolve Flow Speed X", Range(-10, 10)) = 0
_DsTexScrollY ("Dissolve Flow Speed Y", Range(-10, 10)) = 0
_Fade ("Fade", Range(0, 1)) = 1
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "PerformanceChecks" = "False" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "PerformanceChecks" = "False" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend Zero Zero, Zero Zero
  ZWrite Off
  Cull Off
  GpuProgramID 46651
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
attribute highp vec4 in_TEXCOORD2;
attribute highp vec4 in_TEXCOORD3;
varying highp vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
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
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_TEXCOORD3 = in_TEXCOORD3;
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
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DTex_ST;
uniform 	vec4 _DsTex_ST;
uniform 	vec4 _ATex_ST;
uniform 	float _MainTexScrollX;
uniform 	float _MainTexScrollY;
uniform 	float _ATexScrollX;
uniform 	float _ATexScrollY;
uniform 	float _DTexScrollX;
uniform 	float _DTexScrollY;
uniform 	float _DsTexScrollX;
uniform 	float _DsTexScrollY;
uniform 	vec4 _HdrColor;
uniform 	float _Fade;
uniform lowp sampler2D _DTex;
uniform lowp sampler2D _DsTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ATex;
varying highp vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
lowp float u_xlat10_0;
vec2 u_xlat1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
lowp float u_xlat10_2;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.zw * _DsTex_ST.xy + _DsTex_ST.zw;
    u_xlat0.xy = vec2(_DsTexScrollX, _DsTexScrollY) * _Time.yy + u_xlat0.xy;
    u_xlat10_0 = texture2D(_DsTex, u_xlat0.xy).x;
    u_xlat0.x = u_xlat10_0 + (-vs_TEXCOORD2.y);
    u_xlat0.x = ceil(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy;
    u_xlat1.xy = vs_TEXCOORD3.xy + vec2(1.0, 1.0);
    u_xlat2.xy = u_xlat2.xy * u_xlat1.xy + _MainTex_ST.zw;
    u_xlat1.xy = vec2(_MainTexScrollX, _MainTexScrollY) * _Time.yy + vs_TEXCOORD2.zw;
    u_xlat2.xy = u_xlat2.xy + u_xlat1.xy;
    u_xlat1.xy = vs_TEXCOORD0.xy * _DTex_ST.xy + _DTex_ST.zw;
    u_xlat1.xy = vec2(_DTexScrollX, _DTexScrollY) * _Time.yy + u_xlat1.xy;
    u_xlat10_1.xy = texture2D(_DTex, u_xlat1.xy).xy;
    u_xlat1.xy = u_xlat10_1.xy + vec2(-0.5, -0.5);
    u_xlat2.xy = u_xlat1.xy * vs_TEXCOORD2.xx + u_xlat2.xy;
    u_xlat10_1 = texture2D(_MainTex, u_xlat2.xy);
    u_xlat0.x = u_xlat0.x * u_xlat10_1.w;
    u_xlat2.xyz = u_xlat10_1.xyz * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat2.xyz * _HdrColor.xyz;
    u_xlat2.xy = vec2(_ATexScrollX, _ATexScrollY) * _Time.yy + vs_TEXCOORD3.zw;
    u_xlat1.xy = vs_TEXCOORD0.zw * _ATex_ST.xy + _ATex_ST.zw;
    u_xlat2.xy = u_xlat2.xy + u_xlat1.xy;
    u_xlat10_2 = texture2D(_ATex, u_xlat2.xy).x;
    u_xlat0.x = u_xlat10_2 * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    u_xlat0.x = u_xlat0.x * _HdrColor.w;
    SV_Target0.w = u_xlat0.x * _Fade;
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
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
attribute highp vec4 in_TEXCOORD2;
attribute highp vec4 in_TEXCOORD3;
varying highp vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
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
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_TEXCOORD3 = in_TEXCOORD3;
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
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DTex_ST;
uniform 	vec4 _DsTex_ST;
uniform 	vec4 _ATex_ST;
uniform 	float _MainTexScrollX;
uniform 	float _MainTexScrollY;
uniform 	float _ATexScrollX;
uniform 	float _ATexScrollY;
uniform 	float _DTexScrollX;
uniform 	float _DTexScrollY;
uniform 	float _DsTexScrollX;
uniform 	float _DsTexScrollY;
uniform 	vec4 _HdrColor;
uniform 	float _Fade;
uniform lowp sampler2D _DTex;
uniform lowp sampler2D _DsTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ATex;
varying highp vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
lowp float u_xlat10_0;
vec2 u_xlat1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
lowp float u_xlat10_2;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.zw * _DsTex_ST.xy + _DsTex_ST.zw;
    u_xlat0.xy = vec2(_DsTexScrollX, _DsTexScrollY) * _Time.yy + u_xlat0.xy;
    u_xlat10_0 = texture2D(_DsTex, u_xlat0.xy).x;
    u_xlat0.x = u_xlat10_0 + (-vs_TEXCOORD2.y);
    u_xlat0.x = ceil(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy;
    u_xlat1.xy = vs_TEXCOORD3.xy + vec2(1.0, 1.0);
    u_xlat2.xy = u_xlat2.xy * u_xlat1.xy + _MainTex_ST.zw;
    u_xlat1.xy = vec2(_MainTexScrollX, _MainTexScrollY) * _Time.yy + vs_TEXCOORD2.zw;
    u_xlat2.xy = u_xlat2.xy + u_xlat1.xy;
    u_xlat1.xy = vs_TEXCOORD0.xy * _DTex_ST.xy + _DTex_ST.zw;
    u_xlat1.xy = vec2(_DTexScrollX, _DTexScrollY) * _Time.yy + u_xlat1.xy;
    u_xlat10_1.xy = texture2D(_DTex, u_xlat1.xy).xy;
    u_xlat1.xy = u_xlat10_1.xy + vec2(-0.5, -0.5);
    u_xlat2.xy = u_xlat1.xy * vs_TEXCOORD2.xx + u_xlat2.xy;
    u_xlat10_1 = texture2D(_MainTex, u_xlat2.xy);
    u_xlat0.x = u_xlat0.x * u_xlat10_1.w;
    u_xlat2.xyz = u_xlat10_1.xyz * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat2.xyz * _HdrColor.xyz;
    u_xlat2.xy = vec2(_ATexScrollX, _ATexScrollY) * _Time.yy + vs_TEXCOORD3.zw;
    u_xlat1.xy = vs_TEXCOORD0.zw * _ATex_ST.xy + _ATex_ST.zw;
    u_xlat2.xy = u_xlat2.xy + u_xlat1.xy;
    u_xlat10_2 = texture2D(_ATex, u_xlat2.xy).x;
    u_xlat0.x = u_xlat10_2 * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    u_xlat0.x = u_xlat0.x * _HdrColor.w;
    SV_Target0.w = u_xlat0.x * _Fade;
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
attribute highp vec4 in_POSITION0;
attribute highp vec4 in_COLOR0;
attribute highp vec4 in_TEXCOORD0;
attribute highp vec4 in_TEXCOORD1;
attribute highp vec4 in_TEXCOORD2;
attribute highp vec4 in_TEXCOORD3;
varying highp vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD1;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
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
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_TEXCOORD3 = in_TEXCOORD3;
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
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DTex_ST;
uniform 	vec4 _DsTex_ST;
uniform 	vec4 _ATex_ST;
uniform 	float _MainTexScrollX;
uniform 	float _MainTexScrollY;
uniform 	float _ATexScrollX;
uniform 	float _ATexScrollY;
uniform 	float _DTexScrollX;
uniform 	float _DTexScrollY;
uniform 	float _DsTexScrollX;
uniform 	float _DsTexScrollY;
uniform 	vec4 _HdrColor;
uniform 	float _Fade;
uniform lowp sampler2D _DTex;
uniform lowp sampler2D _DsTex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _ATex;
varying highp vec4 vs_COLOR0;
varying highp vec4 vs_TEXCOORD0;
varying highp vec4 vs_TEXCOORD2;
varying highp vec4 vs_TEXCOORD3;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
lowp float u_xlat10_0;
vec2 u_xlat1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
lowp float u_xlat10_2;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.zw * _DsTex_ST.xy + _DsTex_ST.zw;
    u_xlat0.xy = vec2(_DsTexScrollX, _DsTexScrollY) * _Time.yy + u_xlat0.xy;
    u_xlat10_0 = texture2D(_DsTex, u_xlat0.xy).x;
    u_xlat0.x = u_xlat10_0 + (-vs_TEXCOORD2.y);
    u_xlat0.x = ceil(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy;
    u_xlat1.xy = vs_TEXCOORD3.xy + vec2(1.0, 1.0);
    u_xlat2.xy = u_xlat2.xy * u_xlat1.xy + _MainTex_ST.zw;
    u_xlat1.xy = vec2(_MainTexScrollX, _MainTexScrollY) * _Time.yy + vs_TEXCOORD2.zw;
    u_xlat2.xy = u_xlat2.xy + u_xlat1.xy;
    u_xlat1.xy = vs_TEXCOORD0.xy * _DTex_ST.xy + _DTex_ST.zw;
    u_xlat1.xy = vec2(_DTexScrollX, _DTexScrollY) * _Time.yy + u_xlat1.xy;
    u_xlat10_1.xy = texture2D(_DTex, u_xlat1.xy).xy;
    u_xlat1.xy = u_xlat10_1.xy + vec2(-0.5, -0.5);
    u_xlat2.xy = u_xlat1.xy * vs_TEXCOORD2.xx + u_xlat2.xy;
    u_xlat10_1 = texture2D(_MainTex, u_xlat2.xy);
    u_xlat0.x = u_xlat0.x * u_xlat10_1.w;
    u_xlat2.xyz = u_xlat10_1.xyz * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat2.xyz * _HdrColor.xyz;
    u_xlat2.xy = vec2(_ATexScrollX, _ATexScrollY) * _Time.yy + vs_TEXCOORD3.zw;
    u_xlat1.xy = vs_TEXCOORD0.zw * _ATex_ST.xy + _ATex_ST.zw;
    u_xlat2.xy = u_xlat2.xy + u_xlat1.xy;
    u_xlat10_2 = texture2D(_ATex, u_xlat2.xy).x;
    u_xlat0.x = u_xlat10_2 * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    u_xlat0.x = u_xlat0.x * _HdrColor.w;
    SV_Target0.w = u_xlat0.x * _Fade;
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
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in highp vec4 in_TEXCOORD3;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
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
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_TEXCOORD3 = in_TEXCOORD3;
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
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DTex_ST;
uniform 	vec4 _DsTex_ST;
uniform 	vec4 _ATex_ST;
uniform 	float _MainTexScrollX;
uniform 	float _MainTexScrollY;
uniform 	float _ATexScrollX;
uniform 	float _ATexScrollY;
uniform 	float _DTexScrollX;
uniform 	float _DTexScrollY;
uniform 	float _DsTexScrollX;
uniform 	float _DsTexScrollY;
uniform 	vec4 _HdrColor;
uniform 	float _Fade;
UNITY_LOCATION(0) uniform mediump sampler2D _DTex;
UNITY_LOCATION(1) uniform mediump sampler2D _DsTex;
UNITY_LOCATION(2) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(3) uniform mediump sampler2D _ATex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out highp vec4 SV_Target0;
vec2 u_xlat0;
mediump float u_xlat16_0;
vec2 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump float u_xlat16_2;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.zw * _DsTex_ST.xy + _DsTex_ST.zw;
    u_xlat0.xy = vec2(_DsTexScrollX, _DsTexScrollY) * _Time.yy + u_xlat0.xy;
    u_xlat16_0 = texture(_DsTex, u_xlat0.xy).x;
    u_xlat0.x = u_xlat16_0 + (-vs_TEXCOORD2.y);
    u_xlat0.x = ceil(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy;
    u_xlat1.xy = vs_TEXCOORD3.xy + vec2(1.0, 1.0);
    u_xlat2.xy = u_xlat2.xy * u_xlat1.xy + _MainTex_ST.zw;
    u_xlat1.xy = vec2(_MainTexScrollX, _MainTexScrollY) * _Time.yy + vs_TEXCOORD2.zw;
    u_xlat2.xy = u_xlat2.xy + u_xlat1.xy;
    u_xlat1.xy = vs_TEXCOORD0.xy * _DTex_ST.xy + _DTex_ST.zw;
    u_xlat1.xy = vec2(_DTexScrollX, _DTexScrollY) * _Time.yy + u_xlat1.xy;
    u_xlat16_1.xy = texture(_DTex, u_xlat1.xy).xy;
    u_xlat1.xy = u_xlat16_1.xy + vec2(-0.5, -0.5);
    u_xlat2.xy = u_xlat1.xy * vs_TEXCOORD2.xx + u_xlat2.xy;
    u_xlat16_1 = texture(_MainTex, u_xlat2.xy);
    u_xlat0.x = u_xlat0.x * u_xlat16_1.w;
    u_xlat2.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat2.xyz * _HdrColor.xyz;
    u_xlat2.xy = vec2(_ATexScrollX, _ATexScrollY) * _Time.yy + vs_TEXCOORD3.zw;
    u_xlat1.xy = vs_TEXCOORD0.zw * _ATex_ST.xy + _ATex_ST.zw;
    u_xlat2.xy = u_xlat2.xy + u_xlat1.xy;
    u_xlat16_2 = texture(_ATex, u_xlat2.xy).x;
    u_xlat0.x = u_xlat16_2 * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    u_xlat0.x = u_xlat0.x * _HdrColor.w;
    SV_Target0.w = u_xlat0.x * _Fade;
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
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in highp vec4 in_TEXCOORD3;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
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
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_TEXCOORD3 = in_TEXCOORD3;
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
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DTex_ST;
uniform 	vec4 _DsTex_ST;
uniform 	vec4 _ATex_ST;
uniform 	float _MainTexScrollX;
uniform 	float _MainTexScrollY;
uniform 	float _ATexScrollX;
uniform 	float _ATexScrollY;
uniform 	float _DTexScrollX;
uniform 	float _DTexScrollY;
uniform 	float _DsTexScrollX;
uniform 	float _DsTexScrollY;
uniform 	vec4 _HdrColor;
uniform 	float _Fade;
UNITY_LOCATION(0) uniform mediump sampler2D _DTex;
UNITY_LOCATION(1) uniform mediump sampler2D _DsTex;
UNITY_LOCATION(2) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(3) uniform mediump sampler2D _ATex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out highp vec4 SV_Target0;
vec2 u_xlat0;
mediump float u_xlat16_0;
vec2 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump float u_xlat16_2;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.zw * _DsTex_ST.xy + _DsTex_ST.zw;
    u_xlat0.xy = vec2(_DsTexScrollX, _DsTexScrollY) * _Time.yy + u_xlat0.xy;
    u_xlat16_0 = texture(_DsTex, u_xlat0.xy).x;
    u_xlat0.x = u_xlat16_0 + (-vs_TEXCOORD2.y);
    u_xlat0.x = ceil(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy;
    u_xlat1.xy = vs_TEXCOORD3.xy + vec2(1.0, 1.0);
    u_xlat2.xy = u_xlat2.xy * u_xlat1.xy + _MainTex_ST.zw;
    u_xlat1.xy = vec2(_MainTexScrollX, _MainTexScrollY) * _Time.yy + vs_TEXCOORD2.zw;
    u_xlat2.xy = u_xlat2.xy + u_xlat1.xy;
    u_xlat1.xy = vs_TEXCOORD0.xy * _DTex_ST.xy + _DTex_ST.zw;
    u_xlat1.xy = vec2(_DTexScrollX, _DTexScrollY) * _Time.yy + u_xlat1.xy;
    u_xlat16_1.xy = texture(_DTex, u_xlat1.xy).xy;
    u_xlat1.xy = u_xlat16_1.xy + vec2(-0.5, -0.5);
    u_xlat2.xy = u_xlat1.xy * vs_TEXCOORD2.xx + u_xlat2.xy;
    u_xlat16_1 = texture(_MainTex, u_xlat2.xy);
    u_xlat0.x = u_xlat0.x * u_xlat16_1.w;
    u_xlat2.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat2.xyz * _HdrColor.xyz;
    u_xlat2.xy = vec2(_ATexScrollX, _ATexScrollY) * _Time.yy + vs_TEXCOORD3.zw;
    u_xlat1.xy = vs_TEXCOORD0.zw * _ATex_ST.xy + _ATex_ST.zw;
    u_xlat2.xy = u_xlat2.xy + u_xlat1.xy;
    u_xlat16_2 = texture(_ATex, u_xlat2.xy).x;
    u_xlat0.x = u_xlat16_2 * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    u_xlat0.x = u_xlat0.x * _HdrColor.w;
    SV_Target0.w = u_xlat0.x * _Fade;
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
in highp vec4 in_POSITION0;
in highp vec4 in_COLOR0;
in highp vec4 in_TEXCOORD0;
in highp vec4 in_TEXCOORD1;
in highp vec4 in_TEXCOORD2;
in highp vec4 in_TEXCOORD3;
out highp vec4 vs_COLOR0;
out highp vec4 vs_TEXCOORD0;
out highp vec4 vs_TEXCOORD1;
out highp vec4 vs_TEXCOORD2;
out highp vec4 vs_TEXCOORD3;
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
    vs_TEXCOORD0 = in_TEXCOORD0;
    vs_TEXCOORD1 = in_TEXCOORD1;
    vs_TEXCOORD2 = in_TEXCOORD2;
    vs_TEXCOORD3 = in_TEXCOORD3;
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
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _DTex_ST;
uniform 	vec4 _DsTex_ST;
uniform 	vec4 _ATex_ST;
uniform 	float _MainTexScrollX;
uniform 	float _MainTexScrollY;
uniform 	float _ATexScrollX;
uniform 	float _ATexScrollY;
uniform 	float _DTexScrollX;
uniform 	float _DTexScrollY;
uniform 	float _DsTexScrollX;
uniform 	float _DsTexScrollY;
uniform 	vec4 _HdrColor;
uniform 	float _Fade;
UNITY_LOCATION(0) uniform mediump sampler2D _DTex;
UNITY_LOCATION(1) uniform mediump sampler2D _DsTex;
UNITY_LOCATION(2) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(3) uniform mediump sampler2D _ATex;
in highp vec4 vs_COLOR0;
in highp vec4 vs_TEXCOORD0;
in highp vec4 vs_TEXCOORD2;
in highp vec4 vs_TEXCOORD3;
layout(location = 0) out highp vec4 SV_Target0;
vec2 u_xlat0;
mediump float u_xlat16_0;
vec2 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump float u_xlat16_2;
void main()
{
    u_xlat0.xy = vs_TEXCOORD0.zw * _DsTex_ST.xy + _DsTex_ST.zw;
    u_xlat0.xy = vec2(_DsTexScrollX, _DsTexScrollY) * _Time.yy + u_xlat0.xy;
    u_xlat16_0 = texture(_DsTex, u_xlat0.xy).x;
    u_xlat0.x = u_xlat16_0 + (-vs_TEXCOORD2.y);
    u_xlat0.x = ceil(u_xlat0.x);
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    u_xlat2.xy = vs_TEXCOORD0.xy * _MainTex_ST.xy;
    u_xlat1.xy = vs_TEXCOORD3.xy + vec2(1.0, 1.0);
    u_xlat2.xy = u_xlat2.xy * u_xlat1.xy + _MainTex_ST.zw;
    u_xlat1.xy = vec2(_MainTexScrollX, _MainTexScrollY) * _Time.yy + vs_TEXCOORD2.zw;
    u_xlat2.xy = u_xlat2.xy + u_xlat1.xy;
    u_xlat1.xy = vs_TEXCOORD0.xy * _DTex_ST.xy + _DTex_ST.zw;
    u_xlat1.xy = vec2(_DTexScrollX, _DTexScrollY) * _Time.yy + u_xlat1.xy;
    u_xlat16_1.xy = texture(_DTex, u_xlat1.xy).xy;
    u_xlat1.xy = u_xlat16_1.xy + vec2(-0.5, -0.5);
    u_xlat2.xy = u_xlat1.xy * vs_TEXCOORD2.xx + u_xlat2.xy;
    u_xlat16_1 = texture(_MainTex, u_xlat2.xy);
    u_xlat0.x = u_xlat0.x * u_xlat16_1.w;
    u_xlat2.xyz = u_xlat16_1.xyz * vs_COLOR0.xyz;
    SV_Target0.xyz = u_xlat2.xyz * _HdrColor.xyz;
    u_xlat2.xy = vec2(_ATexScrollX, _ATexScrollY) * _Time.yy + vs_TEXCOORD3.zw;
    u_xlat1.xy = vs_TEXCOORD0.zw * _ATex_ST.xy + _ATex_ST.zw;
    u_xlat2.xy = u_xlat2.xy + u_xlat1.xy;
    u_xlat16_2 = texture(_ATex, u_xlat2.xy).x;
    u_xlat0.x = u_xlat16_2 * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * vs_COLOR0.w;
    u_xlat0.x = u_xlat0.x * _HdrColor.w;
    SV_Target0.w = u_xlat0.x * _Fade;
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