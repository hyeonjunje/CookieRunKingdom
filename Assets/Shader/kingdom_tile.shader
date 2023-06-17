//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "kingdom_tile" {
Properties {
[Enum(UnityEngine.Rendering.BlendMode)] _SrcMode ("SrcMode", Float) = 5
[Enum(Alpha Blend, 10, Additive, 1)] _DstMode ("Blend Mode", Float) = 10
[Enum(2Side, 0, Front, 2, Back, 1)] _Culling ("Show Mesh", Float) = 0
[Enum(Off, 0, On, 1)] _Zwrite ("ZWrite", Float) = 0
_MainTex ("Main Texture", 2D) = "white" { }
_MtexC ("   - MTex Color", Color) = (1,1,1,1)
_SubTex ("Sub Texture", 2D) = "white" { }
_SBMix ("   - SBTex Mix", Range(0, 1)) = 0
_SBtexC ("   - SBTex Color", Color) = (1,1,1,1)
_SubTex1 ("Sub1 Texture", 2D) = "white" { }
_SBMix1 ("   - SBTex1 Mix", Range(0, 1)) = 0
_SBtexC1 ("   - SBTex1 Color", Color) = (1,1,1,1)
_SubTex2 ("Sub2 Texture", 2D) = "white" { }
_SBMix2 ("   - SBTex2 Mix", Range(0, 1)) = 0
_SBtexC2 ("   - SBTex2 Color", Color) = (1,1,1,1)
_Atex ("Alphamask Texture", 2D) = "white" { }
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "PerformanceChecks" = "False" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "PerformanceChecks" = "False" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend Zero Zero, Zero Zero
  ZWrite Off
  Cull Off
  GpuProgramID 57099
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	vec4 _SubTex_ST;
uniform 	vec4 _SubTex1_ST;
uniform 	vec4 _SubTex2_ST;
uniform 	vec4 _Atex_ST;
attribute highp vec4 in_COLOR0;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec2 in_TEXCOORD1;
attribute highp vec2 in_TEXCOORD2;
attribute highp vec2 in_TEXCOORD3;
attribute highp vec2 in_TEXCOORD4;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
varying highp vec2 vs_TEXCOORD3;
varying highp vec2 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_COLOR0 = in_COLOR0;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _SubTex_ST.xy + _SubTex_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD2.xy * _SubTex1_ST.xy + _SubTex1_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD3.xy * _SubTex2_ST.xy + _SubTex2_ST.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD4.xy * _Atex_ST.xy + _Atex_ST.zw;
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
uniform 	vec4 _MtexC;
uniform 	vec4 _SBtexC;
uniform 	float _SBMix;
uniform 	vec4 _SBtexC1;
uniform 	float _SBMix1;
uniform 	vec4 _SBtexC2;
uniform 	float _SBMix2;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Atex;
uniform lowp sampler2D _SubTex;
uniform lowp sampler2D _SubTex1;
uniform lowp sampler2D _SubTex2;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
varying highp vec2 vs_TEXCOORD3;
varying highp vec2 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
float u_xlat3;
lowp vec3 u_xlat10_3;
float u_xlat6;
void main()
{
    u_xlat10_0 = texture2D(_SubTex1, vs_TEXCOORD2.xy);
    u_xlat10_1 = texture2D(_SubTex, vs_TEXCOORD1.xy);
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2 = u_xlat10_2 * vs_COLOR0;
    u_xlat1 = u_xlat10_1 * _SBtexC + (-u_xlat2);
    u_xlat10_3.xyz = texture2D(_Atex, vs_TEXCOORD4.xy).xyz;
    u_xlat3 = u_xlat10_3.x * _SBMix;
    u_xlat1 = vec4(u_xlat3) * u_xlat1 + u_xlat2;
    u_xlat0 = u_xlat10_0 * _SBtexC1 + (-u_xlat1);
    u_xlat2.x = u_xlat10_3.y * _SBMix1;
    u_xlat6 = u_xlat10_3.z * _SBMix2;
    u_xlat0 = u_xlat2.xxxx * u_xlat0 + u_xlat1;
    u_xlat10_1 = texture2D(_SubTex2, vs_TEXCOORD3.xy);
    u_xlat1 = u_xlat10_1 * _SBtexC2 + (-u_xlat0);
    u_xlat0 = vec4(u_xlat6) * u_xlat1 + u_xlat0;
    SV_Target0 = u_xlat0 * _MtexC;
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
uniform 	vec4 _SubTex_ST;
uniform 	vec4 _SubTex1_ST;
uniform 	vec4 _SubTex2_ST;
uniform 	vec4 _Atex_ST;
attribute highp vec4 in_COLOR0;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec2 in_TEXCOORD1;
attribute highp vec2 in_TEXCOORD2;
attribute highp vec2 in_TEXCOORD3;
attribute highp vec2 in_TEXCOORD4;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
varying highp vec2 vs_TEXCOORD3;
varying highp vec2 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_COLOR0 = in_COLOR0;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _SubTex_ST.xy + _SubTex_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD2.xy * _SubTex1_ST.xy + _SubTex1_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD3.xy * _SubTex2_ST.xy + _SubTex2_ST.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD4.xy * _Atex_ST.xy + _Atex_ST.zw;
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
uniform 	vec4 _MtexC;
uniform 	vec4 _SBtexC;
uniform 	float _SBMix;
uniform 	vec4 _SBtexC1;
uniform 	float _SBMix1;
uniform 	vec4 _SBtexC2;
uniform 	float _SBMix2;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Atex;
uniform lowp sampler2D _SubTex;
uniform lowp sampler2D _SubTex1;
uniform lowp sampler2D _SubTex2;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
varying highp vec2 vs_TEXCOORD3;
varying highp vec2 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
float u_xlat3;
lowp vec3 u_xlat10_3;
float u_xlat6;
void main()
{
    u_xlat10_0 = texture2D(_SubTex1, vs_TEXCOORD2.xy);
    u_xlat10_1 = texture2D(_SubTex, vs_TEXCOORD1.xy);
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2 = u_xlat10_2 * vs_COLOR0;
    u_xlat1 = u_xlat10_1 * _SBtexC + (-u_xlat2);
    u_xlat10_3.xyz = texture2D(_Atex, vs_TEXCOORD4.xy).xyz;
    u_xlat3 = u_xlat10_3.x * _SBMix;
    u_xlat1 = vec4(u_xlat3) * u_xlat1 + u_xlat2;
    u_xlat0 = u_xlat10_0 * _SBtexC1 + (-u_xlat1);
    u_xlat2.x = u_xlat10_3.y * _SBMix1;
    u_xlat6 = u_xlat10_3.z * _SBMix2;
    u_xlat0 = u_xlat2.xxxx * u_xlat0 + u_xlat1;
    u_xlat10_1 = texture2D(_SubTex2, vs_TEXCOORD3.xy);
    u_xlat1 = u_xlat10_1 * _SBtexC2 + (-u_xlat0);
    u_xlat0 = vec4(u_xlat6) * u_xlat1 + u_xlat0;
    SV_Target0 = u_xlat0 * _MtexC;
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
uniform 	vec4 _SubTex_ST;
uniform 	vec4 _SubTex1_ST;
uniform 	vec4 _SubTex2_ST;
uniform 	vec4 _Atex_ST;
attribute highp vec4 in_COLOR0;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec2 in_TEXCOORD1;
attribute highp vec2 in_TEXCOORD2;
attribute highp vec2 in_TEXCOORD3;
attribute highp vec2 in_TEXCOORD4;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
varying highp vec2 vs_TEXCOORD3;
varying highp vec2 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_COLOR0 = in_COLOR0;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _SubTex_ST.xy + _SubTex_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD2.xy * _SubTex1_ST.xy + _SubTex1_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD3.xy * _SubTex2_ST.xy + _SubTex2_ST.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD4.xy * _Atex_ST.xy + _Atex_ST.zw;
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
uniform 	vec4 _MtexC;
uniform 	vec4 _SBtexC;
uniform 	float _SBMix;
uniform 	vec4 _SBtexC1;
uniform 	float _SBMix1;
uniform 	vec4 _SBtexC2;
uniform 	float _SBMix2;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _Atex;
uniform lowp sampler2D _SubTex;
uniform lowp sampler2D _SubTex1;
uniform lowp sampler2D _SubTex2;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
varying highp vec2 vs_TEXCOORD3;
varying highp vec2 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
float u_xlat3;
lowp vec3 u_xlat10_3;
float u_xlat6;
void main()
{
    u_xlat10_0 = texture2D(_SubTex1, vs_TEXCOORD2.xy);
    u_xlat10_1 = texture2D(_SubTex, vs_TEXCOORD1.xy);
    u_xlat10_2 = texture2D(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2 = u_xlat10_2 * vs_COLOR0;
    u_xlat1 = u_xlat10_1 * _SBtexC + (-u_xlat2);
    u_xlat10_3.xyz = texture2D(_Atex, vs_TEXCOORD4.xy).xyz;
    u_xlat3 = u_xlat10_3.x * _SBMix;
    u_xlat1 = vec4(u_xlat3) * u_xlat1 + u_xlat2;
    u_xlat0 = u_xlat10_0 * _SBtexC1 + (-u_xlat1);
    u_xlat2.x = u_xlat10_3.y * _SBMix1;
    u_xlat6 = u_xlat10_3.z * _SBMix2;
    u_xlat0 = u_xlat2.xxxx * u_xlat0 + u_xlat1;
    u_xlat10_1 = texture2D(_SubTex2, vs_TEXCOORD3.xy);
    u_xlat1 = u_xlat10_1 * _SBtexC2 + (-u_xlat0);
    u_xlat0 = vec4(u_xlat6) * u_xlat1 + u_xlat0;
    SV_Target0 = u_xlat0 * _MtexC;
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
uniform 	vec4 _SubTex_ST;
uniform 	vec4 _SubTex1_ST;
uniform 	vec4 _SubTex2_ST;
uniform 	vec4 _Atex_ST;
in highp vec4 in_COLOR0;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec2 in_TEXCOORD3;
in highp vec2 in_TEXCOORD4;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD3;
out highp vec2 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_COLOR0 = in_COLOR0;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _SubTex_ST.xy + _SubTex_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD2.xy * _SubTex1_ST.xy + _SubTex1_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD3.xy * _SubTex2_ST.xy + _SubTex2_ST.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD4.xy * _Atex_ST.xy + _Atex_ST.zw;
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
uniform 	vec4 _MtexC;
uniform 	vec4 _SBtexC;
uniform 	float _SBMix;
uniform 	vec4 _SBtexC1;
uniform 	float _SBMix1;
uniform 	vec4 _SBtexC2;
uniform 	float _SBMix2;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _Atex;
UNITY_LOCATION(2) uniform mediump sampler2D _SubTex;
UNITY_LOCATION(3) uniform mediump sampler2D _SubTex1;
UNITY_LOCATION(4) uniform mediump sampler2D _SubTex2;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD3;
in highp vec2 vs_TEXCOORD4;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
float u_xlat3;
mediump vec3 u_xlat16_3;
float u_xlat6;
void main()
{
    u_xlat16_0 = texture(_SubTex1, vs_TEXCOORD2.xy);
    u_xlat16_1 = texture(_SubTex, vs_TEXCOORD1.xy);
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2 = u_xlat16_2 * vs_COLOR0;
    u_xlat1 = u_xlat16_1 * _SBtexC + (-u_xlat2);
    u_xlat16_3.xyz = texture(_Atex, vs_TEXCOORD4.xy).xyz;
    u_xlat3 = u_xlat16_3.x * _SBMix;
    u_xlat1 = vec4(u_xlat3) * u_xlat1 + u_xlat2;
    u_xlat0 = u_xlat16_0 * _SBtexC1 + (-u_xlat1);
    u_xlat2.x = u_xlat16_3.y * _SBMix1;
    u_xlat6 = u_xlat16_3.z * _SBMix2;
    u_xlat0 = u_xlat2.xxxx * u_xlat0 + u_xlat1;
    u_xlat16_1 = texture(_SubTex2, vs_TEXCOORD3.xy);
    u_xlat1 = u_xlat16_1 * _SBtexC2 + (-u_xlat0);
    u_xlat0 = vec4(u_xlat6) * u_xlat1 + u_xlat0;
    SV_Target0 = u_xlat0 * _MtexC;
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
uniform 	vec4 _SubTex_ST;
uniform 	vec4 _SubTex1_ST;
uniform 	vec4 _SubTex2_ST;
uniform 	vec4 _Atex_ST;
in highp vec4 in_COLOR0;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec2 in_TEXCOORD3;
in highp vec2 in_TEXCOORD4;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD3;
out highp vec2 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_COLOR0 = in_COLOR0;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _SubTex_ST.xy + _SubTex_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD2.xy * _SubTex1_ST.xy + _SubTex1_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD3.xy * _SubTex2_ST.xy + _SubTex2_ST.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD4.xy * _Atex_ST.xy + _Atex_ST.zw;
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
uniform 	vec4 _MtexC;
uniform 	vec4 _SBtexC;
uniform 	float _SBMix;
uniform 	vec4 _SBtexC1;
uniform 	float _SBMix1;
uniform 	vec4 _SBtexC2;
uniform 	float _SBMix2;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _Atex;
UNITY_LOCATION(2) uniform mediump sampler2D _SubTex;
UNITY_LOCATION(3) uniform mediump sampler2D _SubTex1;
UNITY_LOCATION(4) uniform mediump sampler2D _SubTex2;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD3;
in highp vec2 vs_TEXCOORD4;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
float u_xlat3;
mediump vec3 u_xlat16_3;
float u_xlat6;
void main()
{
    u_xlat16_0 = texture(_SubTex1, vs_TEXCOORD2.xy);
    u_xlat16_1 = texture(_SubTex, vs_TEXCOORD1.xy);
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2 = u_xlat16_2 * vs_COLOR0;
    u_xlat1 = u_xlat16_1 * _SBtexC + (-u_xlat2);
    u_xlat16_3.xyz = texture(_Atex, vs_TEXCOORD4.xy).xyz;
    u_xlat3 = u_xlat16_3.x * _SBMix;
    u_xlat1 = vec4(u_xlat3) * u_xlat1 + u_xlat2;
    u_xlat0 = u_xlat16_0 * _SBtexC1 + (-u_xlat1);
    u_xlat2.x = u_xlat16_3.y * _SBMix1;
    u_xlat6 = u_xlat16_3.z * _SBMix2;
    u_xlat0 = u_xlat2.xxxx * u_xlat0 + u_xlat1;
    u_xlat16_1 = texture(_SubTex2, vs_TEXCOORD3.xy);
    u_xlat1 = u_xlat16_1 * _SBtexC2 + (-u_xlat0);
    u_xlat0 = vec4(u_xlat6) * u_xlat1 + u_xlat0;
    SV_Target0 = u_xlat0 * _MtexC;
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
uniform 	vec4 _SubTex_ST;
uniform 	vec4 _SubTex1_ST;
uniform 	vec4 _SubTex2_ST;
uniform 	vec4 _Atex_ST;
in highp vec4 in_COLOR0;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec2 in_TEXCOORD3;
in highp vec2 in_TEXCOORD4;
out highp vec4 vs_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD3;
out highp vec2 vs_TEXCOORD4;
vec4 u_xlat0;
vec4 u_xlat1;
void main()
{
    vs_COLOR0 = in_COLOR0;
    u_xlat0 = in_POSITION0.yyyy * hlslcc_mtx4x4unity_ObjectToWorld[1];
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
    u_xlat0 = hlslcc_mtx4x4unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
    u_xlat0 = u_xlat0 + hlslcc_mtx4x4unity_ObjectToWorld[3];
    u_xlat1 = u_xlat0.yyyy * hlslcc_mtx4x4unity_MatrixVP[1];
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
    u_xlat1 = hlslcc_mtx4x4unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
    gl_Position = hlslcc_mtx4x4unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy * _SubTex_ST.xy + _SubTex_ST.zw;
    vs_TEXCOORD2.xy = in_TEXCOORD2.xy * _SubTex1_ST.xy + _SubTex1_ST.zw;
    vs_TEXCOORD3.xy = in_TEXCOORD3.xy * _SubTex2_ST.xy + _SubTex2_ST.zw;
    vs_TEXCOORD4.xy = in_TEXCOORD4.xy * _Atex_ST.xy + _Atex_ST.zw;
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
uniform 	vec4 _MtexC;
uniform 	vec4 _SBtexC;
uniform 	float _SBMix;
uniform 	vec4 _SBtexC1;
uniform 	float _SBMix1;
uniform 	vec4 _SBtexC2;
uniform 	float _SBMix2;
UNITY_LOCATION(0) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(1) uniform mediump sampler2D _Atex;
UNITY_LOCATION(2) uniform mediump sampler2D _SubTex;
UNITY_LOCATION(3) uniform mediump sampler2D _SubTex1;
UNITY_LOCATION(4) uniform mediump sampler2D _SubTex2;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD3;
in highp vec2 vs_TEXCOORD4;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
float u_xlat3;
mediump vec3 u_xlat16_3;
float u_xlat6;
void main()
{
    u_xlat16_0 = texture(_SubTex1, vs_TEXCOORD2.xy);
    u_xlat16_1 = texture(_SubTex, vs_TEXCOORD1.xy);
    u_xlat16_2 = texture(_MainTex, vs_TEXCOORD0.xy);
    u_xlat2 = u_xlat16_2 * vs_COLOR0;
    u_xlat1 = u_xlat16_1 * _SBtexC + (-u_xlat2);
    u_xlat16_3.xyz = texture(_Atex, vs_TEXCOORD4.xy).xyz;
    u_xlat3 = u_xlat16_3.x * _SBMix;
    u_xlat1 = vec4(u_xlat3) * u_xlat1 + u_xlat2;
    u_xlat0 = u_xlat16_0 * _SBtexC1 + (-u_xlat1);
    u_xlat2.x = u_xlat16_3.y * _SBMix1;
    u_xlat6 = u_xlat16_3.z * _SBMix2;
    u_xlat0 = u_xlat2.xxxx * u_xlat0 + u_xlat1;
    u_xlat16_1 = texture(_SubTex2, vs_TEXCOORD3.xy);
    u_xlat1 = u_xlat16_1 * _SBtexC2 + (-u_xlat0);
    u_xlat0 = vec4(u_xlat6) * u_xlat1 + u_xlat0;
    SV_Target0 = u_xlat0 * _MtexC;
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