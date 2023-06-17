//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "CK/kingdom_sprite_common_effect" {
Properties {
[Enum(UnityEngine.Rendering.BlendMode)] _SrcMode ("SrcMode", Float) = 5
[Enum(Alpha Blend, 10, Additive, 1)] _DstMode ("Blend Mode", Float) = 10
[Enum(2Side, 0, Front, 2, Back, 1)] _Culling ("Show Mesh", Float) = 0
[Enum(Off, 0, On, 1)] _Zwrite ("ZWrite", Float) = 0
_MainTex ("Main Texture", 2D) = "white" { }
_MtexSpdX ("   - MTex Flow Speed X", Range(-10, 10)) = 0
_MtexSpdY ("   - MTex Flow Speed Y", Range(-10, 10)) = 0
_MtexC ("   - MTex Color", Color) = (1,1,1,1)
_SubTex ("Sub Texture", 2D) = "white" { }
_SBMix ("   - SBTex Mix", Range(0, 1)) = 0
_SBtexSpdX ("   - SBTex Flow Speed X", Range(-10, 10)) = 0
_SBtexSpdY ("   - SBTex Flow Speed Y", Range(-10, 10)) = 0
_SBtexC ("   - SBTex Color", Color) = (1,1,1,1)
_Atex ("Alphamask Texture", 2D) = "white" { }
_Ai ("   - ATex Intensity", Range(0, 1)) = 1
_AtexSpdX ("   - ATex Flow Speed X", Range(-10, 10)) = 0
_AtexSpdY ("   - ATex Flow Speed Y", Range(-10, 10)) = 0
_Dtex ("Distortion Texture", 2D) = "white" { }
_Di ("   - DTex Intensity", Range(0, 1)) = 0
_SBDi ("   - DTex Sub Intensity", Range(0, 1)) = 0
_DtexSpdX ("   - DTex Flow Speed X", Range(-10, 10)) = 0
_DtexSpdY ("   - DTex Flow Speed Y", Range(-10, 10)) = 0
_Dstex ("Dissolve Texture", 2D) = "white" { }
_Dsi ("   - DsTex Intensity", Range(0, 1)) = 0
_DsEdgeRange ("   - DsTex Edge Range", Range(0, 1)) = 0
_DsEdgeMul ("   - DsTex Edge Multiplier", Range(-10, 10)) = 0
_DsEdgeC ("   - DsTex Color", Color) = (1,1,1,1)
_DstexSpdX ("   - DsTex Flow Speed X", Range(-10, 10)) = 0
_DstexSpdY ("   - DsTex Flow Speed Y", Range(-10, 10)) = 0
_Fade ("Fade", Range(0, 1)) = 1
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "PerformanceChecks" = "False" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "PerformanceChecks" = "False" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend Zero Zero, Zero Zero
  ZWrite Off
  Cull Off
  GpuProgramID 32967
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _MtexSpdX;
uniform 	float _MtexSpdY;
uniform 	vec4 _SubTex_ST;
uniform 	float _SBtexSpdX;
uniform 	float _SBtexSpdY;
uniform 	vec4 _Atex_ST;
uniform 	float _AtexSpdX;
uniform 	float _AtexSpdY;
uniform 	vec4 _Dtex_ST;
uniform 	float _DtexSpdX;
uniform 	float _DtexSpdY;
uniform 	vec4 _Dstex_ST;
uniform 	float _DstexSpdX;
uniform 	float _DstexSpdY;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = vec2(_MtexSpdX, _MtexSpdY) * _Time.yy + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD1.xy * _SubTex_ST.xy + _SubTex_ST.zw;
    vs_TEXCOORD1.xy = vec2(_SBtexSpdX, _SBtexSpdY) * _Time.yy + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD2.xy * _Atex_ST.xy + _Atex_ST.zw;
    vs_TEXCOORD2.xy = vec2(_AtexSpdX, _AtexSpdY) * _Time.yy + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD3.xy * _Dtex_ST.xy + _Dtex_ST.zw;
    vs_TEXCOORD3.xy = vec2(_DtexSpdX, _DtexSpdY) * _Time.yy + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD4.xy * _Dstex_ST.xy + _Dstex_ST.zw;
    vs_TEXCOORD4.xy = vec2(_DstexSpdX, _DstexSpdY) * _Time.yy + u_xlat0.xy;
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
uniform 	float _Ai;
uniform 	float _Di;
uniform 	float _SBDi;
uniform 	float _Dsi;
uniform 	float _DsEdgeRange;
uniform 	vec4 _DsEdgeC;
uniform 	float _DsEdgeMul;
uniform 	float _Fade;
uniform lowp sampler2D _Dtex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _SubTex;
uniform lowp sampler2D _Atex;
uniform lowp sampler2D _Dstex;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
highp vec4 phase0_Input0_2;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
varying highp vec2 vs_TEXCOORD3;
varying highp vec2 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
vec4 u_xlat3;
vec3 u_xlat4;
lowp vec2 u_xlat10_4;
bool u_xlatb4;
float u_xlat12;
void main()
{
    phase0_Input0_2 = vec4(vs_TEXCOORD0, vs_TEXCOORD1);
    u_xlat10_0 = texture2D(_Dstex, vs_TEXCOORD4.xy).x;
    u_xlat0.x = u_xlat10_0 + (-_Dsi);
    u_xlatb4 = u_xlat0.x<0.0;
    u_xlat0.x = (-u_xlat0.x) + _DsEdgeRange;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = u_xlat0.x * _DsEdgeMul;
    u_xlat0.x = min(u_xlat0.x, 1.0);
    if(u_xlatb4){discard;}
    u_xlat10_4.xy = texture2D(_Dtex, vs_TEXCOORD3.xy).xy;
    u_xlat12 = _Di * 0.5;
    u_xlat1 = u_xlat10_4.xyxy * vec4(_Di) + (-vec4(u_xlat12));
    u_xlat1 = u_xlat1 * vec4(_Di, _Di, _SBDi, _SBDi) + phase0_Input0_2;
    u_xlat10_2 = texture2D(_SubTex, u_xlat1.zw);
    u_xlat10_1 = texture2D(_MainTex, u_xlat1.xy);
    u_xlat4.x = u_xlat10_2.w * _SBtexC.w;
    u_xlat4.x = u_xlat4.x * _SBMix;
    u_xlat3 = u_xlat10_1 * vs_COLOR0;
    u_xlat1.xyz = u_xlat10_2.xyz * _SBtexC.xyz + (-u_xlat3.xyz);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz + u_xlat3.xyz;
    u_xlat1.xyz = (-u_xlat4.xyz) + (-_DsEdgeC.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz + u_xlat4.xyz;
    u_xlat10_1.x = texture2D(_Atex, vs_TEXCOORD2.xy).x;
    u_xlat1.x = (-u_xlat10_1.w) * vs_COLOR0.w + u_xlat10_1.x;
    u_xlat1.x = _Ai * u_xlat1.x + u_xlat3.w;
    u_xlat0.w = u_xlat1.x * u_xlat3.w;
    u_xlat0 = u_xlat0 * _MtexC;
    SV_Target0.w = u_xlat0.w * _Fade;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _MtexSpdX;
uniform 	float _MtexSpdY;
uniform 	vec4 _SubTex_ST;
uniform 	float _SBtexSpdX;
uniform 	float _SBtexSpdY;
uniform 	vec4 _Atex_ST;
uniform 	float _AtexSpdX;
uniform 	float _AtexSpdY;
uniform 	vec4 _Dtex_ST;
uniform 	float _DtexSpdX;
uniform 	float _DtexSpdY;
uniform 	vec4 _Dstex_ST;
uniform 	float _DstexSpdX;
uniform 	float _DstexSpdY;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = vec2(_MtexSpdX, _MtexSpdY) * _Time.yy + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD1.xy * _SubTex_ST.xy + _SubTex_ST.zw;
    vs_TEXCOORD1.xy = vec2(_SBtexSpdX, _SBtexSpdY) * _Time.yy + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD2.xy * _Atex_ST.xy + _Atex_ST.zw;
    vs_TEXCOORD2.xy = vec2(_AtexSpdX, _AtexSpdY) * _Time.yy + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD3.xy * _Dtex_ST.xy + _Dtex_ST.zw;
    vs_TEXCOORD3.xy = vec2(_DtexSpdX, _DtexSpdY) * _Time.yy + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD4.xy * _Dstex_ST.xy + _Dstex_ST.zw;
    vs_TEXCOORD4.xy = vec2(_DstexSpdX, _DstexSpdY) * _Time.yy + u_xlat0.xy;
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
uniform 	float _Ai;
uniform 	float _Di;
uniform 	float _SBDi;
uniform 	float _Dsi;
uniform 	float _DsEdgeRange;
uniform 	vec4 _DsEdgeC;
uniform 	float _DsEdgeMul;
uniform 	float _Fade;
uniform lowp sampler2D _Dtex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _SubTex;
uniform lowp sampler2D _Atex;
uniform lowp sampler2D _Dstex;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
highp vec4 phase0_Input0_2;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
varying highp vec2 vs_TEXCOORD3;
varying highp vec2 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
vec4 u_xlat3;
vec3 u_xlat4;
lowp vec2 u_xlat10_4;
bool u_xlatb4;
float u_xlat12;
void main()
{
    phase0_Input0_2 = vec4(vs_TEXCOORD0, vs_TEXCOORD1);
    u_xlat10_0 = texture2D(_Dstex, vs_TEXCOORD4.xy).x;
    u_xlat0.x = u_xlat10_0 + (-_Dsi);
    u_xlatb4 = u_xlat0.x<0.0;
    u_xlat0.x = (-u_xlat0.x) + _DsEdgeRange;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = u_xlat0.x * _DsEdgeMul;
    u_xlat0.x = min(u_xlat0.x, 1.0);
    if(u_xlatb4){discard;}
    u_xlat10_4.xy = texture2D(_Dtex, vs_TEXCOORD3.xy).xy;
    u_xlat12 = _Di * 0.5;
    u_xlat1 = u_xlat10_4.xyxy * vec4(_Di) + (-vec4(u_xlat12));
    u_xlat1 = u_xlat1 * vec4(_Di, _Di, _SBDi, _SBDi) + phase0_Input0_2;
    u_xlat10_2 = texture2D(_SubTex, u_xlat1.zw);
    u_xlat10_1 = texture2D(_MainTex, u_xlat1.xy);
    u_xlat4.x = u_xlat10_2.w * _SBtexC.w;
    u_xlat4.x = u_xlat4.x * _SBMix;
    u_xlat3 = u_xlat10_1 * vs_COLOR0;
    u_xlat1.xyz = u_xlat10_2.xyz * _SBtexC.xyz + (-u_xlat3.xyz);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz + u_xlat3.xyz;
    u_xlat1.xyz = (-u_xlat4.xyz) + (-_DsEdgeC.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz + u_xlat4.xyz;
    u_xlat10_1.x = texture2D(_Atex, vs_TEXCOORD2.xy).x;
    u_xlat1.x = (-u_xlat10_1.w) * vs_COLOR0.w + u_xlat10_1.x;
    u_xlat1.x = _Ai * u_xlat1.x + u_xlat3.w;
    u_xlat0.w = u_xlat1.x * u_xlat3.w;
    u_xlat0 = u_xlat0 * _MtexC;
    SV_Target0.w = u_xlat0.w * _Fade;
    SV_Target0.xyz = u_xlat0.xyz;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _MtexSpdX;
uniform 	float _MtexSpdY;
uniform 	vec4 _SubTex_ST;
uniform 	float _SBtexSpdX;
uniform 	float _SBtexSpdY;
uniform 	vec4 _Atex_ST;
uniform 	float _AtexSpdX;
uniform 	float _AtexSpdY;
uniform 	vec4 _Dtex_ST;
uniform 	float _DtexSpdX;
uniform 	float _DtexSpdY;
uniform 	vec4 _Dstex_ST;
uniform 	float _DstexSpdX;
uniform 	float _DstexSpdY;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = vec2(_MtexSpdX, _MtexSpdY) * _Time.yy + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD1.xy * _SubTex_ST.xy + _SubTex_ST.zw;
    vs_TEXCOORD1.xy = vec2(_SBtexSpdX, _SBtexSpdY) * _Time.yy + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD2.xy * _Atex_ST.xy + _Atex_ST.zw;
    vs_TEXCOORD2.xy = vec2(_AtexSpdX, _AtexSpdY) * _Time.yy + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD3.xy * _Dtex_ST.xy + _Dtex_ST.zw;
    vs_TEXCOORD3.xy = vec2(_DtexSpdX, _DtexSpdY) * _Time.yy + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD4.xy * _Dstex_ST.xy + _Dstex_ST.zw;
    vs_TEXCOORD4.xy = vec2(_DstexSpdX, _DstexSpdY) * _Time.yy + u_xlat0.xy;
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
uniform 	float _Ai;
uniform 	float _Di;
uniform 	float _SBDi;
uniform 	float _Dsi;
uniform 	float _DsEdgeRange;
uniform 	vec4 _DsEdgeC;
uniform 	float _DsEdgeMul;
uniform 	float _Fade;
uniform lowp sampler2D _Dtex;
uniform lowp sampler2D _MainTex;
uniform lowp sampler2D _SubTex;
uniform lowp sampler2D _Atex;
uniform lowp sampler2D _Dstex;
varying highp vec4 vs_COLOR0;
varying highp vec2 vs_TEXCOORD0;
highp vec4 phase0_Input0_2;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
varying highp vec2 vs_TEXCOORD3;
varying highp vec2 vs_TEXCOORD4;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
lowp vec4 u_xlat10_2;
vec4 u_xlat3;
vec3 u_xlat4;
lowp vec2 u_xlat10_4;
bool u_xlatb4;
float u_xlat12;
void main()
{
    phase0_Input0_2 = vec4(vs_TEXCOORD0, vs_TEXCOORD1);
    u_xlat10_0 = texture2D(_Dstex, vs_TEXCOORD4.xy).x;
    u_xlat0.x = u_xlat10_0 + (-_Dsi);
    u_xlatb4 = u_xlat0.x<0.0;
    u_xlat0.x = (-u_xlat0.x) + _DsEdgeRange;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = u_xlat0.x * _DsEdgeMul;
    u_xlat0.x = min(u_xlat0.x, 1.0);
    if(u_xlatb4){discard;}
    u_xlat10_4.xy = texture2D(_Dtex, vs_TEXCOORD3.xy).xy;
    u_xlat12 = _Di * 0.5;
    u_xlat1 = u_xlat10_4.xyxy * vec4(_Di) + (-vec4(u_xlat12));
    u_xlat1 = u_xlat1 * vec4(_Di, _Di, _SBDi, _SBDi) + phase0_Input0_2;
    u_xlat10_2 = texture2D(_SubTex, u_xlat1.zw);
    u_xlat10_1 = texture2D(_MainTex, u_xlat1.xy);
    u_xlat4.x = u_xlat10_2.w * _SBtexC.w;
    u_xlat4.x = u_xlat4.x * _SBMix;
    u_xlat3 = u_xlat10_1 * vs_COLOR0;
    u_xlat1.xyz = u_xlat10_2.xyz * _SBtexC.xyz + (-u_xlat3.xyz);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz + u_xlat3.xyz;
    u_xlat1.xyz = (-u_xlat4.xyz) + (-_DsEdgeC.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz + u_xlat4.xyz;
    u_xlat10_1.x = texture2D(_Atex, vs_TEXCOORD2.xy).x;
    u_xlat1.x = (-u_xlat10_1.w) * vs_COLOR0.w + u_xlat10_1.x;
    u_xlat1.x = _Ai * u_xlat1.x + u_xlat3.w;
    u_xlat0.w = u_xlat1.x * u_xlat3.w;
    u_xlat0 = u_xlat0 * _MtexC;
    SV_Target0.w = u_xlat0.w * _Fade;
    SV_Target0.xyz = u_xlat0.xyz;
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
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _MtexSpdX;
uniform 	float _MtexSpdY;
uniform 	vec4 _SubTex_ST;
uniform 	float _SBtexSpdX;
uniform 	float _SBtexSpdY;
uniform 	vec4 _Atex_ST;
uniform 	float _AtexSpdX;
uniform 	float _AtexSpdY;
uniform 	vec4 _Dtex_ST;
uniform 	float _DtexSpdX;
uniform 	float _DtexSpdY;
uniform 	vec4 _Dstex_ST;
uniform 	float _DstexSpdX;
uniform 	float _DstexSpdY;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = vec2(_MtexSpdX, _MtexSpdY) * _Time.yy + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD1.xy * _SubTex_ST.xy + _SubTex_ST.zw;
    vs_TEXCOORD1.xy = vec2(_SBtexSpdX, _SBtexSpdY) * _Time.yy + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD2.xy * _Atex_ST.xy + _Atex_ST.zw;
    vs_TEXCOORD2.xy = vec2(_AtexSpdX, _AtexSpdY) * _Time.yy + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD3.xy * _Dtex_ST.xy + _Dtex_ST.zw;
    vs_TEXCOORD3.xy = vec2(_DtexSpdX, _DtexSpdY) * _Time.yy + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD4.xy * _Dstex_ST.xy + _Dstex_ST.zw;
    vs_TEXCOORD4.xy = vec2(_DstexSpdX, _DstexSpdY) * _Time.yy + u_xlat0.xy;
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
uniform 	float _Ai;
uniform 	float _Di;
uniform 	float _SBDi;
uniform 	float _Dsi;
uniform 	float _DsEdgeRange;
uniform 	vec4 _DsEdgeC;
uniform 	float _DsEdgeMul;
uniform 	float _Fade;
UNITY_LOCATION(0) uniform mediump sampler2D _Dtex;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(2) uniform mediump sampler2D _SubTex;
UNITY_LOCATION(3) uniform mediump sampler2D _Atex;
UNITY_LOCATION(4) uniform mediump sampler2D _Dstex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
highp vec4 phase0_Input0_2;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD3;
in highp vec2 vs_TEXCOORD4;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
vec3 u_xlat4;
mediump vec2 u_xlat16_4;
bool u_xlatb4;
float u_xlat12;
void main()
{
    phase0_Input0_2 = vec4(vs_TEXCOORD0, vs_TEXCOORD1);
    u_xlat16_0 = texture(_Dstex, vs_TEXCOORD4.xy).x;
    u_xlat0.x = u_xlat16_0 + (-_Dsi);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat0.x<0.0);
#else
    u_xlatb4 = u_xlat0.x<0.0;
#endif
    u_xlat0.x = (-u_xlat0.x) + _DsEdgeRange;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = u_xlat0.x * _DsEdgeMul;
    u_xlat0.x = min(u_xlat0.x, 1.0);
    if(u_xlatb4){discard;}
    u_xlat16_4.xy = texture(_Dtex, vs_TEXCOORD3.xy).xy;
    u_xlat12 = _Di * 0.5;
    u_xlat1 = u_xlat16_4.xyxy * vec4(_Di) + (-vec4(u_xlat12));
    u_xlat1 = u_xlat1 * vec4(_Di, _Di, _SBDi, _SBDi) + phase0_Input0_2;
    u_xlat16_2 = texture(_SubTex, u_xlat1.zw);
    u_xlat16_1 = texture(_MainTex, u_xlat1.xy);
    u_xlat4.x = u_xlat16_2.w * _SBtexC.w;
    u_xlat4.x = u_xlat4.x * _SBMix;
    u_xlat3 = u_xlat16_1 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_2.xyz * _SBtexC.xyz + (-u_xlat3.xyz);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz + u_xlat3.xyz;
    u_xlat1.xyz = (-u_xlat4.xyz) + (-_DsEdgeC.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz + u_xlat4.xyz;
    u_xlat16_1.x = texture(_Atex, vs_TEXCOORD2.xy).x;
    u_xlat1.x = (-u_xlat16_1.w) * vs_COLOR0.w + u_xlat16_1.x;
    u_xlat1.x = _Ai * u_xlat1.x + u_xlat3.w;
    u_xlat0.w = u_xlat1.x * u_xlat3.w;
    u_xlat0 = u_xlat0 * _MtexC;
    SV_Target0.w = u_xlat0.w * _Fade;
    SV_Target0.xyz = u_xlat0.xyz;
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
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _MtexSpdX;
uniform 	float _MtexSpdY;
uniform 	vec4 _SubTex_ST;
uniform 	float _SBtexSpdX;
uniform 	float _SBtexSpdY;
uniform 	vec4 _Atex_ST;
uniform 	float _AtexSpdX;
uniform 	float _AtexSpdY;
uniform 	vec4 _Dtex_ST;
uniform 	float _DtexSpdX;
uniform 	float _DtexSpdY;
uniform 	vec4 _Dstex_ST;
uniform 	float _DstexSpdX;
uniform 	float _DstexSpdY;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = vec2(_MtexSpdX, _MtexSpdY) * _Time.yy + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD1.xy * _SubTex_ST.xy + _SubTex_ST.zw;
    vs_TEXCOORD1.xy = vec2(_SBtexSpdX, _SBtexSpdY) * _Time.yy + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD2.xy * _Atex_ST.xy + _Atex_ST.zw;
    vs_TEXCOORD2.xy = vec2(_AtexSpdX, _AtexSpdY) * _Time.yy + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD3.xy * _Dtex_ST.xy + _Dtex_ST.zw;
    vs_TEXCOORD3.xy = vec2(_DtexSpdX, _DtexSpdY) * _Time.yy + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD4.xy * _Dstex_ST.xy + _Dstex_ST.zw;
    vs_TEXCOORD4.xy = vec2(_DstexSpdX, _DstexSpdY) * _Time.yy + u_xlat0.xy;
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
uniform 	float _Ai;
uniform 	float _Di;
uniform 	float _SBDi;
uniform 	float _Dsi;
uniform 	float _DsEdgeRange;
uniform 	vec4 _DsEdgeC;
uniform 	float _DsEdgeMul;
uniform 	float _Fade;
UNITY_LOCATION(0) uniform mediump sampler2D _Dtex;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(2) uniform mediump sampler2D _SubTex;
UNITY_LOCATION(3) uniform mediump sampler2D _Atex;
UNITY_LOCATION(4) uniform mediump sampler2D _Dstex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
highp vec4 phase0_Input0_2;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD3;
in highp vec2 vs_TEXCOORD4;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
vec3 u_xlat4;
mediump vec2 u_xlat16_4;
bool u_xlatb4;
float u_xlat12;
void main()
{
    phase0_Input0_2 = vec4(vs_TEXCOORD0, vs_TEXCOORD1);
    u_xlat16_0 = texture(_Dstex, vs_TEXCOORD4.xy).x;
    u_xlat0.x = u_xlat16_0 + (-_Dsi);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat0.x<0.0);
#else
    u_xlatb4 = u_xlat0.x<0.0;
#endif
    u_xlat0.x = (-u_xlat0.x) + _DsEdgeRange;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = u_xlat0.x * _DsEdgeMul;
    u_xlat0.x = min(u_xlat0.x, 1.0);
    if(u_xlatb4){discard;}
    u_xlat16_4.xy = texture(_Dtex, vs_TEXCOORD3.xy).xy;
    u_xlat12 = _Di * 0.5;
    u_xlat1 = u_xlat16_4.xyxy * vec4(_Di) + (-vec4(u_xlat12));
    u_xlat1 = u_xlat1 * vec4(_Di, _Di, _SBDi, _SBDi) + phase0_Input0_2;
    u_xlat16_2 = texture(_SubTex, u_xlat1.zw);
    u_xlat16_1 = texture(_MainTex, u_xlat1.xy);
    u_xlat4.x = u_xlat16_2.w * _SBtexC.w;
    u_xlat4.x = u_xlat4.x * _SBMix;
    u_xlat3 = u_xlat16_1 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_2.xyz * _SBtexC.xyz + (-u_xlat3.xyz);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz + u_xlat3.xyz;
    u_xlat1.xyz = (-u_xlat4.xyz) + (-_DsEdgeC.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz + u_xlat4.xyz;
    u_xlat16_1.x = texture(_Atex, vs_TEXCOORD2.xy).x;
    u_xlat1.x = (-u_xlat16_1.w) * vs_COLOR0.w + u_xlat16_1.x;
    u_xlat1.x = _Ai * u_xlat1.x + u_xlat3.w;
    u_xlat0.w = u_xlat1.x * u_xlat3.w;
    u_xlat0 = u_xlat0 * _MtexC;
    SV_Target0.w = u_xlat0.w * _Fade;
    SV_Target0.xyz = u_xlat0.xyz;
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
uniform 	vec4 _Time;
uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _MainTex_ST;
uniform 	float _MtexSpdX;
uniform 	float _MtexSpdY;
uniform 	vec4 _SubTex_ST;
uniform 	float _SBtexSpdX;
uniform 	float _SBtexSpdY;
uniform 	vec4 _Atex_ST;
uniform 	float _AtexSpdX;
uniform 	float _AtexSpdY;
uniform 	vec4 _Dtex_ST;
uniform 	float _DtexSpdX;
uniform 	float _DtexSpdY;
uniform 	vec4 _Dstex_ST;
uniform 	float _DstexSpdX;
uniform 	float _DstexSpdY;
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
    u_xlat0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
    vs_TEXCOORD0.xy = vec2(_MtexSpdX, _MtexSpdY) * _Time.yy + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD1.xy * _SubTex_ST.xy + _SubTex_ST.zw;
    vs_TEXCOORD1.xy = vec2(_SBtexSpdX, _SBtexSpdY) * _Time.yy + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD2.xy * _Atex_ST.xy + _Atex_ST.zw;
    vs_TEXCOORD2.xy = vec2(_AtexSpdX, _AtexSpdY) * _Time.yy + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD3.xy * _Dtex_ST.xy + _Dtex_ST.zw;
    vs_TEXCOORD3.xy = vec2(_DtexSpdX, _DtexSpdY) * _Time.yy + u_xlat0.xy;
    u_xlat0.xy = in_TEXCOORD4.xy * _Dstex_ST.xy + _Dstex_ST.zw;
    vs_TEXCOORD4.xy = vec2(_DstexSpdX, _DstexSpdY) * _Time.yy + u_xlat0.xy;
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
uniform 	float _Ai;
uniform 	float _Di;
uniform 	float _SBDi;
uniform 	float _Dsi;
uniform 	float _DsEdgeRange;
uniform 	vec4 _DsEdgeC;
uniform 	float _DsEdgeMul;
uniform 	float _Fade;
UNITY_LOCATION(0) uniform mediump sampler2D _Dtex;
UNITY_LOCATION(1) uniform mediump sampler2D _MainTex;
UNITY_LOCATION(2) uniform mediump sampler2D _SubTex;
UNITY_LOCATION(3) uniform mediump sampler2D _Atex;
UNITY_LOCATION(4) uniform mediump sampler2D _Dstex;
in highp vec4 vs_COLOR0;
in highp vec2 vs_TEXCOORD0;
highp vec4 phase0_Input0_2;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec2 vs_TEXCOORD3;
in highp vec2 vs_TEXCOORD4;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
vec3 u_xlat4;
mediump vec2 u_xlat16_4;
bool u_xlatb4;
float u_xlat12;
void main()
{
    phase0_Input0_2 = vec4(vs_TEXCOORD0, vs_TEXCOORD1);
    u_xlat16_0 = texture(_Dstex, vs_TEXCOORD4.xy).x;
    u_xlat0.x = u_xlat16_0 + (-_Dsi);
#ifdef UNITY_ADRENO_ES3
    u_xlatb4 = !!(u_xlat0.x<0.0);
#else
    u_xlatb4 = u_xlat0.x<0.0;
#endif
    u_xlat0.x = (-u_xlat0.x) + _DsEdgeRange;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = u_xlat0.x * _DsEdgeMul;
    u_xlat0.x = min(u_xlat0.x, 1.0);
    if(u_xlatb4){discard;}
    u_xlat16_4.xy = texture(_Dtex, vs_TEXCOORD3.xy).xy;
    u_xlat12 = _Di * 0.5;
    u_xlat1 = u_xlat16_4.xyxy * vec4(_Di) + (-vec4(u_xlat12));
    u_xlat1 = u_xlat1 * vec4(_Di, _Di, _SBDi, _SBDi) + phase0_Input0_2;
    u_xlat16_2 = texture(_SubTex, u_xlat1.zw);
    u_xlat16_1 = texture(_MainTex, u_xlat1.xy);
    u_xlat4.x = u_xlat16_2.w * _SBtexC.w;
    u_xlat4.x = u_xlat4.x * _SBMix;
    u_xlat3 = u_xlat16_1 * vs_COLOR0;
    u_xlat1.xyz = u_xlat16_2.xyz * _SBtexC.xyz + (-u_xlat3.xyz);
    u_xlat4.xyz = u_xlat4.xxx * u_xlat1.xyz + u_xlat3.xyz;
    u_xlat1.xyz = (-u_xlat4.xyz) + (-_DsEdgeC.xyz);
    u_xlat0.xyz = u_xlat0.xxx * u_xlat1.xyz + u_xlat4.xyz;
    u_xlat16_1.x = texture(_Atex, vs_TEXCOORD2.xy).x;
    u_xlat1.x = (-u_xlat16_1.w) * vs_COLOR0.w + u_xlat16_1.x;
    u_xlat1.x = _Ai * u_xlat1.x + u_xlat3.w;
    u_xlat0.w = u_xlat1.x * u_xlat3.w;
    u_xlat0 = u_xlat0 * _MtexC;
    SV_Target0.w = u_xlat0.w * _Fade;
    SV_Target0.xyz = u_xlat0.xyz;
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