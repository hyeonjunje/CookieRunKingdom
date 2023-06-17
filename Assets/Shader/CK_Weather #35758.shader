//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "CK/Weather" {
Properties {
_DsEdgeRange ("_DsEdgeRange", Range(-10, 10)) = 0
_DsEdgeMul ("_DsEdgeMul", Range(-10, 10)) = 0
_CanvasPositionFactor ("Canvas Position Factor X, Y, W, H", Vector) = (0,0,1,1)
[Enum(UnityEngine.Rendering.BlendMode)] _SrcMode ("SrcMode", Float) = 5
[Enum(Alpha Blend, 10, Additive, 1)] _DstMode ("Blend Mode", Float) = 10
[Enum(2Side, 0, Front, 2, Back, 1)] _Culling ("Show Mesh", Float) = 0
[Enum(Off, 0, On, 1)] _Zwrite ("ZWrite", Float) = 0
_MainTex ("Canvas", 2D) = "black" { }
[Header (CLOUD CONTROLL)] [Space (5)] _CloudTex ("Cloud Texture", 2D) = "black" { }
_CloudGroupCol ("Cloud Group Color", Color) = (1,1,1,1)
[Space (15)] _CloudPos0 ("Cloud Pos 0", Vector) = (0,0,1,1)
_CloudPos1 ("Cloud Pos 1", Vector) = (0,0,1,1)
_CloudPos2 ("Cloud Pos 2", Vector) = (0,0,1,1)
_CloudPos3 ("Cloud Pos 3", Vector) = (0,0,1,1)
_CloudPos4 ("Cloud Pos 4", Vector) = (0,0,1,1)
_CloudPos5 ("Cloud Pos 5", Vector) = (0,0,1,1)
_CloudPos6 ("Cloud Pos 6", Vector) = (0,0,1,1)
_CloudPos7 ("Cloud Pos 7", Vector) = (0,0,1,1)
_CloudPos8 ("Cloud Pos 8", Vector) = (0,0,1,1)
_CloudPos9 ("Cloud Pos 9", Vector) = (0,0,1,1)
_DData0 ("Distortion Data 0", Vector) = (0,0,0,0)
_DData1 ("Distortion Data 1", Vector) = (0,0,0,0)
_DData2 ("Distortion Data 2", Vector) = (0,0,0,0)
_DData3 ("Distortion Data 3", Vector) = (0,0,0,0)
_DData4 ("Distortion Data 4", Vector) = (0,0,0,0)
_DData5 ("Distortion Data 5", Vector) = (0,0,0,0)
_DData6 ("Distortion Data 6", Vector) = (0,0,0,0)
_DData7 ("Distortion Data 7", Vector) = (0,0,0,0)
_DData8 ("Distortion Data 8", Vector) = (0,0,0,0)
_DData9 ("Distortion Data 9", Vector) = (0,0,0,0)
_DSData0 ("Dssolve Data 0", Vector) = (0,0,0,0)
_DSData1 ("Dssolve Data 1", Vector) = (0,0,0,0)
_DSData2 ("Dssolve Data 2", Vector) = (0,0,0,0)
_DSData3 ("Dssolve Data 3", Vector) = (0,0,0,0)
_DSData4 ("Dssolve Data 4", Vector) = (0,0,0,0)
_DSData5 ("Dssolve Data 5", Vector) = (0,0,0,0)
_DSData6 ("Dssolve Data 6", Vector) = (0,0,0,0)
_DSData7 ("Dssolve Data 7", Vector) = (0,0,0,0)
_DSData8 ("Dssolve Data 8", Vector) = (0,0,0,0)
_DSData9 ("Dssolve Data 9", Vector) = (0,0,0,0)
_DTex ("Distortion Texture", 2D) = "black" { }
_DSTex ("Dssolve Texture", 2D) = "black" { }
[Header (LIGHT CONTROLL)] [Space (5)] _LTex ("Light Texture", 2D) = "black" { }
_Lcol ("Light Color", Color) = (1,1,1,1)
_Lcol2 ("Light2 Color", Color) = (1,1,1,1)
_LightPos0 ("Light Position 0", Vector) = (0,0,1,1)
_LightPos1 ("Light Position 1", Vector) = (0,0,1,1)
_LightPos2 ("Light Position 2", Vector) = (0,0,1,1)
_LightPos3 ("Light Position 3", Vector) = (0,0,1,1)
_LightPos4 ("Light Position 4", Vector) = (0,0,1,1)
_LightPos5 ("Light Position 5", Vector) = (0,0,1,1)
_LightPos6 ("Light Position 6", Vector) = (0,0,1,1)
_LightPos7 ("Light Position 7", Vector) = (0,0,1,1)
_LightPos8 ("Light Position 8", Vector) = (0,0,1,1)
_LightPos9 ("Light Position 9", Vector) = (0,0,1,1)
_LA0 ("Light Alpha 0", Range(0, 1)) = 1
_LA1 ("Light Alpha 1", Range(0, 1)) = 1
_LA2 ("Light Alpha 2", Range(0, 1)) = 1
_LA3 ("Light Alpha 3", Range(0, 1)) = 1
_LA4 ("Light Alpha 4", Range(0, 1)) = 1
_LA5 ("Light Alpha 5", Range(0, 1)) = 1
_LA6 ("Light Alpha 6", Range(0, 1)) = 1
_LA7 ("Light Alpha 7", Range(0, 1)) = 1
_LA8 ("Light Alpha 8", Range(0, 1)) = 1
_LA9 ("Light Alpha 9", Range(0, 1)) = 1
}
SubShader {
 LOD 100
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend Zero Zero, Zero Zero
  ZWrite Off
  Cull Off
  Fog {
   Mode Off
  }
  GpuProgramID 56527
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _CanvasPositionFactor;
uniform 	vec4 _CloudTex_ST;
uniform 	vec4 _DTex_ST;
uniform 	vec4 _DSTex_ST;
uniform 	vec4 _LTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec2 in_TEXCOORD1;
attribute highp vec2 in_TEXCOORD2;
attribute highp vec2 in_TEXCOORD3;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
varying highp vec2 vs_TEXCOORD3;
varying highp vec4 vs_COLOR0;
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
    u_xlat0.xy = in_TEXCOORD0.xy + _CanvasPositionFactor.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy * _CloudTex_ST.xy + _CloudTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD1.xy + _CanvasPositionFactor.xy;
    vs_TEXCOORD1.xy = u_xlat0.xy * _DTex_ST.xy + _DTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD3.xy + _CanvasPositionFactor.xy;
    vs_TEXCOORD3.xy = u_xlat0.xy * _LTex_ST.xy + _LTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD2.xy + _CanvasPositionFactor.xy;
    vs_TEXCOORD2.xy = u_xlat0.xy * _DSTex_ST.xy + _DSTex_ST.zw;
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
uniform 	vec4 _CloudGroupCol;
uniform 	vec4 _CloudPos0;
uniform 	vec4 _CloudPos1;
uniform 	vec4 _CloudPos2;
uniform 	vec4 _CloudPos3;
uniform 	vec4 _CloudPos4;
uniform 	vec4 _CloudPos5;
uniform 	vec4 _CloudPos6;
uniform 	vec4 _CloudPos7;
uniform 	vec4 _CloudPos8;
uniform 	vec4 _CloudPos9;
uniform 	vec4 _DData0;
uniform 	vec4 _DData1;
uniform 	vec4 _DData2;
uniform 	vec4 _DData3;
uniform 	vec4 _DData4;
uniform 	vec4 _DData5;
uniform 	vec4 _DData6;
uniform 	vec4 _DData7;
uniform 	vec4 _DData8;
uniform 	vec4 _DData9;
uniform 	vec4 _DSTex_ST;
uniform 	vec4 _DSData0;
uniform 	vec4 _DSData1;
uniform 	vec4 _DSData2;
uniform 	vec4 _DSData3;
uniform 	vec4 _DSData4;
uniform 	vec4 _DSData5;
uniform 	vec4 _DSData6;
uniform 	vec4 _DSData7;
uniform 	vec4 _DSData8;
uniform 	vec4 _DSData9;
uniform 	vec4 _DsEdgeC;
uniform 	float _DsEdgeRange;
uniform 	float _DsEdgeMul;
uniform lowp sampler2D _DTex;
uniform lowp sampler2D _CloudTex;
uniform lowp sampler2D _DSTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
vec2 u_xlat2;
vec2 u_xlat3;
lowp float u_xlat10_3;
vec2 u_xlat4;
vec2 u_xlat6;
lowp vec2 u_xlat10_6;
float u_xlat9;
lowp float u_xlat10_9;
void main()
{
    u_xlat0.xy = _DSData0.ww * vec2(1.0, -1.0) + vs_TEXCOORD2.xy;
    u_xlat6.xy = _CloudPos0.xy * _DSTex_ST.xy;
    u_xlat0.xy = u_xlat0.xy * _CloudPos0.zw + u_xlat6.xy;
    u_xlat6.xy = _DData0.xy * _Time.yy + vs_TEXCOORD1.xy;
    u_xlat10_6.xy = texture2D(_DTex, u_xlat6.xy).xy;
    u_xlat1.x = _DData0.z * 0.5;
    u_xlat0.xy = u_xlat10_6.xy * u_xlat1.xx + u_xlat0.xy;
    u_xlat10_0 = texture2D(_DSTex, u_xlat0.xy).x;
    u_xlat0.x = u_xlat10_0 + (-_DSData0.z);
    u_xlat0.x = (-u_xlat0.x) + _DsEdgeRange;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = u_xlat0.x * _DsEdgeMul;
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat4.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat2.xy = u_xlat4.xy * _CloudPos0.zw + _CloudPos0.xy;
    u_xlat3.xy = u_xlat10_6.xy * u_xlat1.xx + u_xlat2.xy;
    u_xlat3.xy = u_xlat3.xy + vec2(0.5, 0.5);
    u_xlat10_3 = texture2D(_CloudTex, u_xlat3.xy).w;
    u_xlat6.x = (-u_xlat10_3) + (-_DsEdgeC.w);
    u_xlat0.x = u_xlat0.x * u_xlat6.x + u_xlat10_3;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat3.xy = _DSData1.ww * vec2(1.0, -1.0) + vs_TEXCOORD2.xy;
    u_xlat1.xw = _CloudPos1.xy * _DSTex_ST.xy;
    u_xlat3.xy = u_xlat3.xy * _CloudPos1.zw + u_xlat1.xw;
    u_xlat1.xw = _DData1.xy * _Time.yy + vs_TEXCOORD1.xy;
    u_xlat10_1.xw = texture2D(_DTex, u_xlat1.xw).xy;
    u_xlat9 = _DData1.z * 0.5;
    u_xlat3.xy = u_xlat10_1.xw * vec2(u_xlat9) + u_xlat3.xy;
    u_xlat10_3 = texture2D(_DSTex, u_xlat3.xy).x;
    u_xlat3.x = u_xlat10_3 + (-_DSData1.z);
    u_xlat3.x = (-u_xlat3.x) + _DsEdgeRange;
    u_xlat3.x = max(u_xlat3.x, 0.0);
    u_xlat3.x = u_xlat3.x * _DsEdgeMul;
    u_xlat3.x = min(u_xlat3.x, 1.0);
    u_xlat2.xy = u_xlat4.xy * _CloudPos1.zw + _CloudPos1.xy;
    u_xlat6.xy = u_xlat10_1.xw * vec2(u_xlat9) + u_xlat2.xy;
    u_xlat6.xy = u_xlat6.xy + vec2(0.5, 0.5);
    u_xlat10_6.x = texture2D(_CloudTex, u_xlat6.xy).w;
    u_xlat9 = (-u_xlat10_6.x) + (-_DsEdgeC.w);
    u_xlat3.x = u_xlat3.x * u_xlat9 + u_xlat10_6.x;
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat0.x = u_xlat3.x + u_xlat0.x;
    u_xlat3.xy = _DSData2.ww * vec2(1.0, -1.0) + vs_TEXCOORD2.xy;
    u_xlat1.xw = _CloudPos2.xy * _DSTex_ST.xy;
    u_xlat3.xy = u_xlat3.xy * _CloudPos2.zw + u_xlat1.xw;
    u_xlat1.xw = _DData2.xy * _Time.yy + vs_TEXCOORD1.xy;
    u_xlat10_1.xw = texture2D(_DTex, u_xlat1.xw).xy;
    u_xlat9 = _DData2.z * 0.5;
    u_xlat3.xy = u_xlat10_1.xw * vec2(u_xlat9) + u_xlat3.xy;
    u_xlat10_3 = texture2D(_DSTex, u_xlat3.xy).x;
    u_xlat3.x = u_xlat10_3 + (-_DSData2.z);
    u_xlat3.x = (-u_xlat3.x) + _DsEdgeRange;
    u_xlat3.x = max(u_xlat3.x, 0.0);
    u_xlat3.x = u_xlat3.x * _DsEdgeMul;
    u_xlat3.x = min(u_xlat3.x, 1.0);
    u_xlat2.xy = u_xlat4.xy * _CloudPos2.zw + _CloudPos2.xy;
    u_xlat6.xy = u_xlat10_1.xw * vec2(u_xlat9) + u_xlat2.xy;
    u_xlat6.xy = u_xlat6.xy + vec2(0.5, 0.5);
    u_xlat10_6.x = texture2D(_CloudTex, u_xlat6.xy).w;
    u_xlat9 = (-u_xlat10_6.x) + (-_DsEdgeC.w);
    u_xlat3.x = u_xlat3.x * u_xlat9 + u_xlat10_6.x;
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat0.x = u_xlat3.x + u_xlat0.x;
    u_xlat3.xy = _DSData3.ww * vec2(1.0, -1.0) + vs_TEXCOORD2.xy;
    u_xlat1.xw = _CloudPos3.xy * _DSTex_ST.xy;
    u_xlat3.xy = u_xlat3.xy * _CloudPos3.zw + u_xlat1.xw;
    u_xlat1.xw = _DData3.xy * _Time.yy + vs_TEXCOORD1.xy;
    u_xlat10_1.xw = texture2D(_DTex, u_xlat1.xw).xy;
    u_xlat9 = _DData3.z * 0.5;
    u_xlat3.xy = u_xlat10_1.xw * vec2(u_xlat9) + u_xlat3.xy;
    u_xlat10_3 = texture2D(_DSTex, u_xlat3.xy).x;
    u_xlat3.x = u_xlat10_3 + (-_DSData3.z);
    u_xlat3.x = (-u_xlat3.x) + _DsEdgeRange;
    u_xlat3.x = max(u_xlat3.x, 0.0);
    u_xlat3.x = u_xlat3.x * _DsEdgeMul;
    u_xlat3.x = min(u_xlat3.x, 1.0);
    u_xlat2.xy = u_xlat4.xy * _CloudPos3.zw + _CloudPos3.xy;
    u_xlat6.xy = u_xlat10_1.xw * vec2(u_xlat9) + u_xlat2.xy;
    u_xlat6.xy = u_xlat6.xy + vec2(0.5, 0.5);
    u_xlat10_6.x = texture2D(_CloudTex, u_xlat6.xy).w;
    u_xlat9 = (-u_xlat10_6.x) + (-_DsEdgeC.w);
    u_xlat3.x = u_xlat3.x * u_xlat9 + u_xlat10_6.x;
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat0.x = u_xlat3.x + u_xlat0.x;
    u_xlat3.xy = _DSData4.ww * vec2(1.0, -1.0) + vs_TEXCOORD2.xy;
    u_xlat1.xw = _CloudPos4.xy * _DSTex_ST.xy;
    u_xlat3.xy = u_xlat3.xy * _CloudPos4.zw + u_xlat1.xw;
    u_xlat1.xw = _DData4.xy * _Time.yy + vs_TEXCOORD1.xy;
    u_xlat10_1.xw = texture2D(_DTex, u_xlat1.xw).xy;
    u_xlat9 = _DData4.z * 0.5;
    u_xlat3.xy = u_xlat10_1.xw * vec2(u_xlat9) + u_xlat3.xy;
    u_xlat10_3 = texture2D(_DSTex, u_xlat3.xy).x;
    u_xlat3.x = u_xlat10_3 + (-_DSData4.z);
    u_xlat3.x = (-u_xlat3.x) + _DsEdgeRange;
    u_xlat3.x = max(u_xlat3.x, 0.0);
    u_xlat3.x = u_xlat3.x * _DsEdgeMul;
    u_xlat3.x = min(u_xlat3.x, 1.0);
    u_xlat2.xy = u_xlat4.xy * _CloudPos4.zw + _CloudPos4.xy;
    u_xlat6.xy = u_xlat10_1.xw * vec2(u_xlat9) + u_xlat2.xy;
    u_xlat6.xy = u_xlat6.xy + vec2(0.5, 0.5);
    u_xlat10_6.x = texture2D(_CloudTex, u_xlat6.xy).w;
    u_xlat9 = (-u_xlat10_6.x) + (-_DsEdgeC.w);
    u_xlat3.x = u_xlat3.x * u_xlat9 + u_xlat10_6.x;
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat0.x = u_xlat3.x + u_xlat0.x;
    u_xlat3.xy = _DSData5.ww * vec2(1.0, -1.0) + vs_TEXCOORD2.xy;
    u_xlat1.xw = _CloudPos5.xy * _DSTex_ST.xy;
    u_xlat3.xy = u_xlat3.xy * _CloudPos5.zw + u_xlat1.xw;
    u_xlat1.xw = _DData5.xy * _Time.yy + vs_TEXCOORD1.xy;
    u_xlat10_1.xw = texture2D(_DTex, u_xlat1.xw).xy;
    u_xlat9 = _DData5.z * 0.5;
    u_xlat3.xy = u_xlat10_1.xw * vec2(u_xlat9) + u_xlat3.xy;
    u_xlat10_3 = texture2D(_DSTex, u_xlat3.xy).x;
    u_xlat3.x = u_xlat10_3 + (-_DSData5.z);
    u_xlat3.x = (-u_xlat3.x) + _DsEdgeRange;
    u_xlat3.x = max(u_xlat3.x, 0.0);
    u_xlat3.x = u_xlat3.x * _DsEdgeMul;
    u_xlat3.x = min(u_xlat3.x, 1.0);
    u_xlat2.xy = u_xlat4.xy * _CloudPos5.zw + _CloudPos5.xy;
    u_xlat6.xy = u_xlat10_1.xw * vec2(u_xlat9) + u_xlat2.xy;
    u_xlat6.xy = u_xlat6.xy + vec2(0.5, 0.5);
    u_xlat10_6.x = texture2D(_CloudTex, u_xlat6.xy).w;
    u_xlat9 = (-u_xlat10_6.x) + (-_DsEdgeC.w);
    u_xlat3.x = u_xlat3.x * u_xlat9 + u_xlat10_6.x;
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat0.x = u_xlat3.x + u_xlat0.x;
    u_xlat3.xy = _DSData6.ww * vec2(1.0, -1.0) + vs_TEXCOORD2.xy;
    u_xlat1.xw = _CloudPos6.xy * _DSTex_ST.xy;
    u_xlat3.xy = u_xlat3.xy * _CloudPos6.zw + u_xlat1.xw;
    u_xlat1.xw = _DData6.xy * _Time.yy + vs_TEXCOORD1.xy;
    u_xlat10_1.xw = texture2D(_DTex, u_xlat1.xw).xy;
    u_xlat9 = _DData6.z * 0.5;
    u_xlat3.xy = u_xlat10_1.xw * vec2(u_xlat9) + u_xlat3.xy;
    u_xlat10_3 = texture2D(_DSTex, u_xlat3.xy).x;
    u_xlat3.x = u_xlat10_3 + (-_DSData6.z);
    u_xlat3.x = (-u_xlat3.x) + _DsEdgeRange;
    u_xlat3.x = max(u_xlat3.x, 0.0);
    u_xlat3.x = u_xlat3.x * _DsEdgeMul;
    u_xlat3.x = min(u_xlat3.x, 1.0);
    u_xlat2.xy = u_xlat4.xy * _CloudPos6.zw + _CloudPos6.xy;
    u_xlat6.xy = u_xlat10_1.xw * vec2(u_xlat9) + u_xlat2.xy;
    u_xlat6.xy = u_xlat6.xy + vec2(0.5, 0.5);
    u_xlat10_6.x = texture2D(_CloudTex, u_xlat6.xy).w;
    u_xlat9 = (-u_xlat10_6.x) + (-_DsEdgeC.w);
    u_xlat3.x = u_xlat3.x * u_xlat9 + u_xlat10_6.x;
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat0.x = u_xlat3.x + u_xlat0.x;
    u_xlat3.xy = _DSData7.ww * vec2(1.0, -1.0) + vs_TEXCOORD2.xy;
    u_xlat1.xw = _CloudPos7.xy * _DSTex_ST.xy;
    u_xlat3.xy = u_xlat3.xy * _CloudPos7.zw + u_xlat1.xw;
    u_xlat1.xw = _DData7.xy * _Time.yy + vs_TEXCOORD1.xy;
    u_xlat10_1.xw = texture2D(_DTex, u_xlat1.xw).xy;
    u_xlat9 = _DData7.z * 0.5;
    u_xlat3.xy = u_xlat10_1.xw * vec2(u_xlat9) + u_xlat3.xy;
    u_xlat10_3 = texture2D(_DSTex, u_xlat3.xy).x;
    u_xlat3.x = u_xlat10_3 + (-_DSData7.z);
    u_xlat3.x = (-u_xlat3.x) + _DsEdgeRange;
    u_xlat3.x = max(u_xlat3.x, 0.0);
    u_xlat3.x = u_xlat3.x * _DsEdgeMul;
    u_xlat3.x = min(u_xlat3.x, 1.0);
    u_xlat2.xy = u_xlat4.xy * _CloudPos7.zw + _CloudPos7.xy;
    u_xlat6.xy = u_xlat10_1.xw * vec2(u_xlat9) + u_xlat2.xy;
    u_xlat6.xy = u_xlat6.xy + vec2(0.5, 0.5);
    u_xlat10_6.x = texture2D(_CloudTex, u_xlat6.xy).w;
    u_xlat9 = (-u_xlat10_6.x) + (-_DsEdgeC.w);
    u_xlat3.x = u_xlat3.x * u_xlat9 + u_xlat10_6.x;
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat0.x = u_xlat3.x + u_xlat0.x;
    u_xlat3.xy = _DSData8.ww * vec2(1.0, -1.0) + vs_TEXCOORD2.xy;
    u_xlat1.xw = _CloudPos8.xy * _DSTex_ST.xy;
    u_xlat3.xy = u_xlat3.xy * _CloudPos8.zw + u_xlat1.xw;
    u_xlat1.xw = _DData8.xy * _Time.yy + vs_TEXCOORD1.xy;
    u_xlat10_1.xw = texture2D(_DTex, u_xlat1.xw).xy;
    u_xlat9 = _DData8.z * 0.5;
    u_xlat3.xy = u_xlat10_1.xw * vec2(u_xlat9) + u_xlat3.xy;
    u_xlat10_3 = texture2D(_DSTex, u_xlat3.xy).x;
    u_xlat3.x = u_xlat10_3 + (-_DSData8.z);
    u_xlat3.x = (-u_xlat3.x) + _DsEdgeRange;
    u_xlat3.x = max(u_xlat3.x, 0.0);
    u_xlat3.x = u_xlat3.x * _DsEdgeMul;
    u_xlat3.x = min(u_xlat3.x, 1.0);
    u_xlat2.xy = u_xlat4.xy * _CloudPos8.zw + _CloudPos8.xy;
    u_xlat4.xy = u_xlat4.xy * _CloudPos9.zw + _CloudPos9.xy;
    u_xlat6.xy = u_xlat10_1.xw * vec2(u_xlat9) + u_xlat2.xy;
    u_xlat6.xy = u_xlat6.xy + vec2(0.5, 0.5);
    u_xlat10_6.x = texture2D(_CloudTex, u_xlat6.xy).w;
    u_xlat9 = (-u_xlat10_6.x) + (-_DsEdgeC.w);
    u_xlat3.x = u_xlat3.x * u_xlat9 + u_xlat10_6.x;
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat0.x = u_xlat3.x + u_xlat0.x;
    u_xlat3.xy = _DSData9.ww * vec2(1.0, -1.0) + vs_TEXCOORD2.xy;
    u_xlat1.xw = _CloudPos9.xy * _DSTex_ST.xy;
    u_xlat3.xy = u_xlat3.xy * _CloudPos9.zw + u_xlat1.xw;
    u_xlat1.xw = _DData9.xy * _Time.yy + vs_TEXCOORD1.xy;
    u_xlat10_1.xw = texture2D(_DTex, u_xlat1.xw).xy;
    u_xlat9 = _DData9.z * 0.5;
    u_xlat3.xy = u_xlat10_1.xw * vec2(u_xlat9) + u_xlat3.xy;
    u_xlat1.xy = u_xlat10_1.xw * vec2(u_xlat9) + u_xlat4.xy;
    u_xlat1.xy = u_xlat1.xy + vec2(0.5, 0.5);
    u_xlat10_9 = texture2D(_CloudTex, u_xlat1.xy).w;
    u_xlat10_3 = texture2D(_DSTex, u_xlat3.xy).x;
    u_xlat3.x = u_xlat10_3 + (-_DSData9.z);
    u_xlat3.x = (-u_xlat3.x) + _DsEdgeRange;
    u_xlat3.x = max(u_xlat3.x, 0.0);
    u_xlat3.x = u_xlat3.x * _DsEdgeMul;
    u_xlat3.x = min(u_xlat3.x, 1.0);
    u_xlat6.x = (-u_xlat10_9) + (-_DsEdgeC.w);
    u_xlat3.x = u_xlat3.x * u_xlat6.x + u_xlat10_9;
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat0.x = u_xlat3.x + u_xlat0.x;
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat3.x = (-_CloudGroupCol.w) + 1.0;
    SV_Target0.w = (-u_xlat0.x) * u_xlat3.x + u_xlat0.x;
    SV_Target0.xyz = _CloudGroupCol.xyz;
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
uniform 	vec4 _CanvasPositionFactor;
uniform 	vec4 _CloudTex_ST;
uniform 	vec4 _DTex_ST;
uniform 	vec4 _DSTex_ST;
uniform 	vec4 _LTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec2 in_TEXCOORD1;
attribute highp vec2 in_TEXCOORD2;
attribute highp vec2 in_TEXCOORD3;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
varying highp vec2 vs_TEXCOORD3;
varying highp vec4 vs_COLOR0;
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
    u_xlat0.xy = in_TEXCOORD0.xy + _CanvasPositionFactor.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy * _CloudTex_ST.xy + _CloudTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD1.xy + _CanvasPositionFactor.xy;
    vs_TEXCOORD1.xy = u_xlat0.xy * _DTex_ST.xy + _DTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD3.xy + _CanvasPositionFactor.xy;
    vs_TEXCOORD3.xy = u_xlat0.xy * _LTex_ST.xy + _LTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD2.xy + _CanvasPositionFactor.xy;
    vs_TEXCOORD2.xy = u_xlat0.xy * _DSTex_ST.xy + _DSTex_ST.zw;
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
uniform 	vec4 _CloudGroupCol;
uniform 	vec4 _CloudPos0;
uniform 	vec4 _CloudPos1;
uniform 	vec4 _CloudPos2;
uniform 	vec4 _CloudPos3;
uniform 	vec4 _CloudPos4;
uniform 	vec4 _CloudPos5;
uniform 	vec4 _CloudPos6;
uniform 	vec4 _CloudPos7;
uniform 	vec4 _CloudPos8;
uniform 	vec4 _CloudPos9;
uniform 	vec4 _DData0;
uniform 	vec4 _DData1;
uniform 	vec4 _DData2;
uniform 	vec4 _DData3;
uniform 	vec4 _DData4;
uniform 	vec4 _DData5;
uniform 	vec4 _DData6;
uniform 	vec4 _DData7;
uniform 	vec4 _DData8;
uniform 	vec4 _DData9;
uniform 	vec4 _DSTex_ST;
uniform 	vec4 _DSData0;
uniform 	vec4 _DSData1;
uniform 	vec4 _DSData2;
uniform 	vec4 _DSData3;
uniform 	vec4 _DSData4;
uniform 	vec4 _DSData5;
uniform 	vec4 _DSData6;
uniform 	vec4 _DSData7;
uniform 	vec4 _DSData8;
uniform 	vec4 _DSData9;
uniform 	vec4 _DsEdgeC;
uniform 	float _DsEdgeRange;
uniform 	float _DsEdgeMul;
uniform lowp sampler2D _DTex;
uniform lowp sampler2D _CloudTex;
uniform lowp sampler2D _DSTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
vec2 u_xlat2;
vec2 u_xlat3;
lowp float u_xlat10_3;
vec2 u_xlat4;
vec2 u_xlat6;
lowp vec2 u_xlat10_6;
float u_xlat9;
lowp float u_xlat10_9;
void main()
{
    u_xlat0.xy = _DSData0.ww * vec2(1.0, -1.0) + vs_TEXCOORD2.xy;
    u_xlat6.xy = _CloudPos0.xy * _DSTex_ST.xy;
    u_xlat0.xy = u_xlat0.xy * _CloudPos0.zw + u_xlat6.xy;
    u_xlat6.xy = _DData0.xy * _Time.yy + vs_TEXCOORD1.xy;
    u_xlat10_6.xy = texture2D(_DTex, u_xlat6.xy).xy;
    u_xlat1.x = _DData0.z * 0.5;
    u_xlat0.xy = u_xlat10_6.xy * u_xlat1.xx + u_xlat0.xy;
    u_xlat10_0 = texture2D(_DSTex, u_xlat0.xy).x;
    u_xlat0.x = u_xlat10_0 + (-_DSData0.z);
    u_xlat0.x = (-u_xlat0.x) + _DsEdgeRange;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = u_xlat0.x * _DsEdgeMul;
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat4.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat2.xy = u_xlat4.xy * _CloudPos0.zw + _CloudPos0.xy;
    u_xlat3.xy = u_xlat10_6.xy * u_xlat1.xx + u_xlat2.xy;
    u_xlat3.xy = u_xlat3.xy + vec2(0.5, 0.5);
    u_xlat10_3 = texture2D(_CloudTex, u_xlat3.xy).w;
    u_xlat6.x = (-u_xlat10_3) + (-_DsEdgeC.w);
    u_xlat0.x = u_xlat0.x * u_xlat6.x + u_xlat10_3;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat3.xy = _DSData1.ww * vec2(1.0, -1.0) + vs_TEXCOORD2.xy;
    u_xlat1.xw = _CloudPos1.xy * _DSTex_ST.xy;
    u_xlat3.xy = u_xlat3.xy * _CloudPos1.zw + u_xlat1.xw;
    u_xlat1.xw = _DData1.xy * _Time.yy + vs_TEXCOORD1.xy;
    u_xlat10_1.xw = texture2D(_DTex, u_xlat1.xw).xy;
    u_xlat9 = _DData1.z * 0.5;
    u_xlat3.xy = u_xlat10_1.xw * vec2(u_xlat9) + u_xlat3.xy;
    u_xlat10_3 = texture2D(_DSTex, u_xlat3.xy).x;
    u_xlat3.x = u_xlat10_3 + (-_DSData1.z);
    u_xlat3.x = (-u_xlat3.x) + _DsEdgeRange;
    u_xlat3.x = max(u_xlat3.x, 0.0);
    u_xlat3.x = u_xlat3.x * _DsEdgeMul;
    u_xlat3.x = min(u_xlat3.x, 1.0);
    u_xlat2.xy = u_xlat4.xy * _CloudPos1.zw + _CloudPos1.xy;
    u_xlat6.xy = u_xlat10_1.xw * vec2(u_xlat9) + u_xlat2.xy;
    u_xlat6.xy = u_xlat6.xy + vec2(0.5, 0.5);
    u_xlat10_6.x = texture2D(_CloudTex, u_xlat6.xy).w;
    u_xlat9 = (-u_xlat10_6.x) + (-_DsEdgeC.w);
    u_xlat3.x = u_xlat3.x * u_xlat9 + u_xlat10_6.x;
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat0.x = u_xlat3.x + u_xlat0.x;
    u_xlat3.xy = _DSData2.ww * vec2(1.0, -1.0) + vs_TEXCOORD2.xy;
    u_xlat1.xw = _CloudPos2.xy * _DSTex_ST.xy;
    u_xlat3.xy = u_xlat3.xy * _CloudPos2.zw + u_xlat1.xw;
    u_xlat1.xw = _DData2.xy * _Time.yy + vs_TEXCOORD1.xy;
    u_xlat10_1.xw = texture2D(_DTex, u_xlat1.xw).xy;
    u_xlat9 = _DData2.z * 0.5;
    u_xlat3.xy = u_xlat10_1.xw * vec2(u_xlat9) + u_xlat3.xy;
    u_xlat10_3 = texture2D(_DSTex, u_xlat3.xy).x;
    u_xlat3.x = u_xlat10_3 + (-_DSData2.z);
    u_xlat3.x = (-u_xlat3.x) + _DsEdgeRange;
    u_xlat3.x = max(u_xlat3.x, 0.0);
    u_xlat3.x = u_xlat3.x * _DsEdgeMul;
    u_xlat3.x = min(u_xlat3.x, 1.0);
    u_xlat2.xy = u_xlat4.xy * _CloudPos2.zw + _CloudPos2.xy;
    u_xlat6.xy = u_xlat10_1.xw * vec2(u_xlat9) + u_xlat2.xy;
    u_xlat6.xy = u_xlat6.xy + vec2(0.5, 0.5);
    u_xlat10_6.x = texture2D(_CloudTex, u_xlat6.xy).w;
    u_xlat9 = (-u_xlat10_6.x) + (-_DsEdgeC.w);
    u_xlat3.x = u_xlat3.x * u_xlat9 + u_xlat10_6.x;
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat0.x = u_xlat3.x + u_xlat0.x;
    u_xlat3.xy = _DSData3.ww * vec2(1.0, -1.0) + vs_TEXCOORD2.xy;
    u_xlat1.xw = _CloudPos3.xy * _DSTex_ST.xy;
    u_xlat3.xy = u_xlat3.xy * _CloudPos3.zw + u_xlat1.xw;
    u_xlat1.xw = _DData3.xy * _Time.yy + vs_TEXCOORD1.xy;
    u_xlat10_1.xw = texture2D(_DTex, u_xlat1.xw).xy;
    u_xlat9 = _DData3.z * 0.5;
    u_xlat3.xy = u_xlat10_1.xw * vec2(u_xlat9) + u_xlat3.xy;
    u_xlat10_3 = texture2D(_DSTex, u_xlat3.xy).x;
    u_xlat3.x = u_xlat10_3 + (-_DSData3.z);
    u_xlat3.x = (-u_xlat3.x) + _DsEdgeRange;
    u_xlat3.x = max(u_xlat3.x, 0.0);
    u_xlat3.x = u_xlat3.x * _DsEdgeMul;
    u_xlat3.x = min(u_xlat3.x, 1.0);
    u_xlat2.xy = u_xlat4.xy * _CloudPos3.zw + _CloudPos3.xy;
    u_xlat6.xy = u_xlat10_1.xw * vec2(u_xlat9) + u_xlat2.xy;
    u_xlat6.xy = u_xlat6.xy + vec2(0.5, 0.5);
    u_xlat10_6.x = texture2D(_CloudTex, u_xlat6.xy).w;
    u_xlat9 = (-u_xlat10_6.x) + (-_DsEdgeC.w);
    u_xlat3.x = u_xlat3.x * u_xlat9 + u_xlat10_6.x;
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat0.x = u_xlat3.x + u_xlat0.x;
    u_xlat3.xy = _DSData4.ww * vec2(1.0, -1.0) + vs_TEXCOORD2.xy;
    u_xlat1.xw = _CloudPos4.xy * _DSTex_ST.xy;
    u_xlat3.xy = u_xlat3.xy * _CloudPos4.zw + u_xlat1.xw;
    u_xlat1.xw = _DData4.xy * _Time.yy + vs_TEXCOORD1.xy;
    u_xlat10_1.xw = texture2D(_DTex, u_xlat1.xw).xy;
    u_xlat9 = _DData4.z * 0.5;
    u_xlat3.xy = u_xlat10_1.xw * vec2(u_xlat9) + u_xlat3.xy;
    u_xlat10_3 = texture2D(_DSTex, u_xlat3.xy).x;
    u_xlat3.x = u_xlat10_3 + (-_DSData4.z);
    u_xlat3.x = (-u_xlat3.x) + _DsEdgeRange;
    u_xlat3.x = max(u_xlat3.x, 0.0);
    u_xlat3.x = u_xlat3.x * _DsEdgeMul;
    u_xlat3.x = min(u_xlat3.x, 1.0);
    u_xlat2.xy = u_xlat4.xy * _CloudPos4.zw + _CloudPos4.xy;
    u_xlat6.xy = u_xlat10_1.xw * vec2(u_xlat9) + u_xlat2.xy;
    u_xlat6.xy = u_xlat6.xy + vec2(0.5, 0.5);
    u_xlat10_6.x = texture2D(_CloudTex, u_xlat6.xy).w;
    u_xlat9 = (-u_xlat10_6.x) + (-_DsEdgeC.w);
    u_xlat3.x = u_xlat3.x * u_xlat9 + u_xlat10_6.x;
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat0.x = u_xlat3.x + u_xlat0.x;
    u_xlat3.xy = _DSData5.ww * vec2(1.0, -1.0) + vs_TEXCOORD2.xy;
    u_xlat1.xw = _CloudPos5.xy * _DSTex_ST.xy;
    u_xlat3.xy = u_xlat3.xy * _CloudPos5.zw + u_xlat1.xw;
    u_xlat1.xw = _DData5.xy * _Time.yy + vs_TEXCOORD1.xy;
    u_xlat10_1.xw = texture2D(_DTex, u_xlat1.xw).xy;
    u_xlat9 = _DData5.z * 0.5;
    u_xlat3.xy = u_xlat10_1.xw * vec2(u_xlat9) + u_xlat3.xy;
    u_xlat10_3 = texture2D(_DSTex, u_xlat3.xy).x;
    u_xlat3.x = u_xlat10_3 + (-_DSData5.z);
    u_xlat3.x = (-u_xlat3.x) + _DsEdgeRange;
    u_xlat3.x = max(u_xlat3.x, 0.0);
    u_xlat3.x = u_xlat3.x * _DsEdgeMul;
    u_xlat3.x = min(u_xlat3.x, 1.0);
    u_xlat2.xy = u_xlat4.xy * _CloudPos5.zw + _CloudPos5.xy;
    u_xlat6.xy = u_xlat10_1.xw * vec2(u_xlat9) + u_xlat2.xy;
    u_xlat6.xy = u_xlat6.xy + vec2(0.5, 0.5);
    u_xlat10_6.x = texture2D(_CloudTex, u_xlat6.xy).w;
    u_xlat9 = (-u_xlat10_6.x) + (-_DsEdgeC.w);
    u_xlat3.x = u_xlat3.x * u_xlat9 + u_xlat10_6.x;
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat0.x = u_xlat3.x + u_xlat0.x;
    u_xlat3.xy = _DSData6.ww * vec2(1.0, -1.0) + vs_TEXCOORD2.xy;
    u_xlat1.xw = _CloudPos6.xy * _DSTex_ST.xy;
    u_xlat3.xy = u_xlat3.xy * _CloudPos6.zw + u_xlat1.xw;
    u_xlat1.xw = _DData6.xy * _Time.yy + vs_TEXCOORD1.xy;
    u_xlat10_1.xw = texture2D(_DTex, u_xlat1.xw).xy;
    u_xlat9 = _DData6.z * 0.5;
    u_xlat3.xy = u_xlat10_1.xw * vec2(u_xlat9) + u_xlat3.xy;
    u_xlat10_3 = texture2D(_DSTex, u_xlat3.xy).x;
    u_xlat3.x = u_xlat10_3 + (-_DSData6.z);
    u_xlat3.x = (-u_xlat3.x) + _DsEdgeRange;
    u_xlat3.x = max(u_xlat3.x, 0.0);
    u_xlat3.x = u_xlat3.x * _DsEdgeMul;
    u_xlat3.x = min(u_xlat3.x, 1.0);
    u_xlat2.xy = u_xlat4.xy * _CloudPos6.zw + _CloudPos6.xy;
    u_xlat6.xy = u_xlat10_1.xw * vec2(u_xlat9) + u_xlat2.xy;
    u_xlat6.xy = u_xlat6.xy + vec2(0.5, 0.5);
    u_xlat10_6.x = texture2D(_CloudTex, u_xlat6.xy).w;
    u_xlat9 = (-u_xlat10_6.x) + (-_DsEdgeC.w);
    u_xlat3.x = u_xlat3.x * u_xlat9 + u_xlat10_6.x;
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat0.x = u_xlat3.x + u_xlat0.x;
    u_xlat3.xy = _DSData7.ww * vec2(1.0, -1.0) + vs_TEXCOORD2.xy;
    u_xlat1.xw = _CloudPos7.xy * _DSTex_ST.xy;
    u_xlat3.xy = u_xlat3.xy * _CloudPos7.zw + u_xlat1.xw;
    u_xlat1.xw = _DData7.xy * _Time.yy + vs_TEXCOORD1.xy;
    u_xlat10_1.xw = texture2D(_DTex, u_xlat1.xw).xy;
    u_xlat9 = _DData7.z * 0.5;
    u_xlat3.xy = u_xlat10_1.xw * vec2(u_xlat9) + u_xlat3.xy;
    u_xlat10_3 = texture2D(_DSTex, u_xlat3.xy).x;
    u_xlat3.x = u_xlat10_3 + (-_DSData7.z);
    u_xlat3.x = (-u_xlat3.x) + _DsEdgeRange;
    u_xlat3.x = max(u_xlat3.x, 0.0);
    u_xlat3.x = u_xlat3.x * _DsEdgeMul;
    u_xlat3.x = min(u_xlat3.x, 1.0);
    u_xlat2.xy = u_xlat4.xy * _CloudPos7.zw + _CloudPos7.xy;
    u_xlat6.xy = u_xlat10_1.xw * vec2(u_xlat9) + u_xlat2.xy;
    u_xlat6.xy = u_xlat6.xy + vec2(0.5, 0.5);
    u_xlat10_6.x = texture2D(_CloudTex, u_xlat6.xy).w;
    u_xlat9 = (-u_xlat10_6.x) + (-_DsEdgeC.w);
    u_xlat3.x = u_xlat3.x * u_xlat9 + u_xlat10_6.x;
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat0.x = u_xlat3.x + u_xlat0.x;
    u_xlat3.xy = _DSData8.ww * vec2(1.0, -1.0) + vs_TEXCOORD2.xy;
    u_xlat1.xw = _CloudPos8.xy * _DSTex_ST.xy;
    u_xlat3.xy = u_xlat3.xy * _CloudPos8.zw + u_xlat1.xw;
    u_xlat1.xw = _DData8.xy * _Time.yy + vs_TEXCOORD1.xy;
    u_xlat10_1.xw = texture2D(_DTex, u_xlat1.xw).xy;
    u_xlat9 = _DData8.z * 0.5;
    u_xlat3.xy = u_xlat10_1.xw * vec2(u_xlat9) + u_xlat3.xy;
    u_xlat10_3 = texture2D(_DSTex, u_xlat3.xy).x;
    u_xlat3.x = u_xlat10_3 + (-_DSData8.z);
    u_xlat3.x = (-u_xlat3.x) + _DsEdgeRange;
    u_xlat3.x = max(u_xlat3.x, 0.0);
    u_xlat3.x = u_xlat3.x * _DsEdgeMul;
    u_xlat3.x = min(u_xlat3.x, 1.0);
    u_xlat2.xy = u_xlat4.xy * _CloudPos8.zw + _CloudPos8.xy;
    u_xlat4.xy = u_xlat4.xy * _CloudPos9.zw + _CloudPos9.xy;
    u_xlat6.xy = u_xlat10_1.xw * vec2(u_xlat9) + u_xlat2.xy;
    u_xlat6.xy = u_xlat6.xy + vec2(0.5, 0.5);
    u_xlat10_6.x = texture2D(_CloudTex, u_xlat6.xy).w;
    u_xlat9 = (-u_xlat10_6.x) + (-_DsEdgeC.w);
    u_xlat3.x = u_xlat3.x * u_xlat9 + u_xlat10_6.x;
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat0.x = u_xlat3.x + u_xlat0.x;
    u_xlat3.xy = _DSData9.ww * vec2(1.0, -1.0) + vs_TEXCOORD2.xy;
    u_xlat1.xw = _CloudPos9.xy * _DSTex_ST.xy;
    u_xlat3.xy = u_xlat3.xy * _CloudPos9.zw + u_xlat1.xw;
    u_xlat1.xw = _DData9.xy * _Time.yy + vs_TEXCOORD1.xy;
    u_xlat10_1.xw = texture2D(_DTex, u_xlat1.xw).xy;
    u_xlat9 = _DData9.z * 0.5;
    u_xlat3.xy = u_xlat10_1.xw * vec2(u_xlat9) + u_xlat3.xy;
    u_xlat1.xy = u_xlat10_1.xw * vec2(u_xlat9) + u_xlat4.xy;
    u_xlat1.xy = u_xlat1.xy + vec2(0.5, 0.5);
    u_xlat10_9 = texture2D(_CloudTex, u_xlat1.xy).w;
    u_xlat10_3 = texture2D(_DSTex, u_xlat3.xy).x;
    u_xlat3.x = u_xlat10_3 + (-_DSData9.z);
    u_xlat3.x = (-u_xlat3.x) + _DsEdgeRange;
    u_xlat3.x = max(u_xlat3.x, 0.0);
    u_xlat3.x = u_xlat3.x * _DsEdgeMul;
    u_xlat3.x = min(u_xlat3.x, 1.0);
    u_xlat6.x = (-u_xlat10_9) + (-_DsEdgeC.w);
    u_xlat3.x = u_xlat3.x * u_xlat6.x + u_xlat10_9;
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat0.x = u_xlat3.x + u_xlat0.x;
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat3.x = (-_CloudGroupCol.w) + 1.0;
    SV_Target0.w = (-u_xlat0.x) * u_xlat3.x + u_xlat0.x;
    SV_Target0.xyz = _CloudGroupCol.xyz;
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
uniform 	vec4 _CanvasPositionFactor;
uniform 	vec4 _CloudTex_ST;
uniform 	vec4 _DTex_ST;
uniform 	vec4 _DSTex_ST;
uniform 	vec4 _LTex_ST;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec2 in_TEXCOORD1;
attribute highp vec2 in_TEXCOORD2;
attribute highp vec2 in_TEXCOORD3;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
varying highp vec2 vs_TEXCOORD3;
varying highp vec4 vs_COLOR0;
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
    u_xlat0.xy = in_TEXCOORD0.xy + _CanvasPositionFactor.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy * _CloudTex_ST.xy + _CloudTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD1.xy + _CanvasPositionFactor.xy;
    vs_TEXCOORD1.xy = u_xlat0.xy * _DTex_ST.xy + _DTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD3.xy + _CanvasPositionFactor.xy;
    vs_TEXCOORD3.xy = u_xlat0.xy * _LTex_ST.xy + _LTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD2.xy + _CanvasPositionFactor.xy;
    vs_TEXCOORD2.xy = u_xlat0.xy * _DSTex_ST.xy + _DSTex_ST.zw;
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
uniform 	vec4 _CloudGroupCol;
uniform 	vec4 _CloudPos0;
uniform 	vec4 _CloudPos1;
uniform 	vec4 _CloudPos2;
uniform 	vec4 _CloudPos3;
uniform 	vec4 _CloudPos4;
uniform 	vec4 _CloudPos5;
uniform 	vec4 _CloudPos6;
uniform 	vec4 _CloudPos7;
uniform 	vec4 _CloudPos8;
uniform 	vec4 _CloudPos9;
uniform 	vec4 _DData0;
uniform 	vec4 _DData1;
uniform 	vec4 _DData2;
uniform 	vec4 _DData3;
uniform 	vec4 _DData4;
uniform 	vec4 _DData5;
uniform 	vec4 _DData6;
uniform 	vec4 _DData7;
uniform 	vec4 _DData8;
uniform 	vec4 _DData9;
uniform 	vec4 _DSTex_ST;
uniform 	vec4 _DSData0;
uniform 	vec4 _DSData1;
uniform 	vec4 _DSData2;
uniform 	vec4 _DSData3;
uniform 	vec4 _DSData4;
uniform 	vec4 _DSData5;
uniform 	vec4 _DSData6;
uniform 	vec4 _DSData7;
uniform 	vec4 _DSData8;
uniform 	vec4 _DSData9;
uniform 	vec4 _DsEdgeC;
uniform 	float _DsEdgeRange;
uniform 	float _DsEdgeMul;
uniform lowp sampler2D _DTex;
uniform lowp sampler2D _CloudTex;
uniform lowp sampler2D _DSTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
#define SV_Target0 gl_FragData[0]
vec2 u_xlat0;
lowp float u_xlat10_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
vec2 u_xlat2;
vec2 u_xlat3;
lowp float u_xlat10_3;
vec2 u_xlat4;
vec2 u_xlat6;
lowp vec2 u_xlat10_6;
float u_xlat9;
lowp float u_xlat10_9;
void main()
{
    u_xlat0.xy = _DSData0.ww * vec2(1.0, -1.0) + vs_TEXCOORD2.xy;
    u_xlat6.xy = _CloudPos0.xy * _DSTex_ST.xy;
    u_xlat0.xy = u_xlat0.xy * _CloudPos0.zw + u_xlat6.xy;
    u_xlat6.xy = _DData0.xy * _Time.yy + vs_TEXCOORD1.xy;
    u_xlat10_6.xy = texture2D(_DTex, u_xlat6.xy).xy;
    u_xlat1.x = _DData0.z * 0.5;
    u_xlat0.xy = u_xlat10_6.xy * u_xlat1.xx + u_xlat0.xy;
    u_xlat10_0 = texture2D(_DSTex, u_xlat0.xy).x;
    u_xlat0.x = u_xlat10_0 + (-_DSData0.z);
    u_xlat0.x = (-u_xlat0.x) + _DsEdgeRange;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = u_xlat0.x * _DsEdgeMul;
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat4.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat2.xy = u_xlat4.xy * _CloudPos0.zw + _CloudPos0.xy;
    u_xlat3.xy = u_xlat10_6.xy * u_xlat1.xx + u_xlat2.xy;
    u_xlat3.xy = u_xlat3.xy + vec2(0.5, 0.5);
    u_xlat10_3 = texture2D(_CloudTex, u_xlat3.xy).w;
    u_xlat6.x = (-u_xlat10_3) + (-_DsEdgeC.w);
    u_xlat0.x = u_xlat0.x * u_xlat6.x + u_xlat10_3;
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
    u_xlat3.xy = _DSData1.ww * vec2(1.0, -1.0) + vs_TEXCOORD2.xy;
    u_xlat1.xw = _CloudPos1.xy * _DSTex_ST.xy;
    u_xlat3.xy = u_xlat3.xy * _CloudPos1.zw + u_xlat1.xw;
    u_xlat1.xw = _DData1.xy * _Time.yy + vs_TEXCOORD1.xy;
    u_xlat10_1.xw = texture2D(_DTex, u_xlat1.xw).xy;
    u_xlat9 = _DData1.z * 0.5;
    u_xlat3.xy = u_xlat10_1.xw * vec2(u_xlat9) + u_xlat3.xy;
    u_xlat10_3 = texture2D(_DSTex, u_xlat3.xy).x;
    u_xlat3.x = u_xlat10_3 + (-_DSData1.z);
    u_xlat3.x = (-u_xlat3.x) + _DsEdgeRange;
    u_xlat3.x = max(u_xlat3.x, 0.0);
    u_xlat3.x = u_xlat3.x * _DsEdgeMul;
    u_xlat3.x = min(u_xlat3.x, 1.0);
    u_xlat2.xy = u_xlat4.xy * _CloudPos1.zw + _CloudPos1.xy;
    u_xlat6.xy = u_xlat10_1.xw * vec2(u_xlat9) + u_xlat2.xy;
    u_xlat6.xy = u_xlat6.xy + vec2(0.5, 0.5);
    u_xlat10_6.x = texture2D(_CloudTex, u_xlat6.xy).w;
    u_xlat9 = (-u_xlat10_6.x) + (-_DsEdgeC.w);
    u_xlat3.x = u_xlat3.x * u_xlat9 + u_xlat10_6.x;
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat0.x = u_xlat3.x + u_xlat0.x;
    u_xlat3.xy = _DSData2.ww * vec2(1.0, -1.0) + vs_TEXCOORD2.xy;
    u_xlat1.xw = _CloudPos2.xy * _DSTex_ST.xy;
    u_xlat3.xy = u_xlat3.xy * _CloudPos2.zw + u_xlat1.xw;
    u_xlat1.xw = _DData2.xy * _Time.yy + vs_TEXCOORD1.xy;
    u_xlat10_1.xw = texture2D(_DTex, u_xlat1.xw).xy;
    u_xlat9 = _DData2.z * 0.5;
    u_xlat3.xy = u_xlat10_1.xw * vec2(u_xlat9) + u_xlat3.xy;
    u_xlat10_3 = texture2D(_DSTex, u_xlat3.xy).x;
    u_xlat3.x = u_xlat10_3 + (-_DSData2.z);
    u_xlat3.x = (-u_xlat3.x) + _DsEdgeRange;
    u_xlat3.x = max(u_xlat3.x, 0.0);
    u_xlat3.x = u_xlat3.x * _DsEdgeMul;
    u_xlat3.x = min(u_xlat3.x, 1.0);
    u_xlat2.xy = u_xlat4.xy * _CloudPos2.zw + _CloudPos2.xy;
    u_xlat6.xy = u_xlat10_1.xw * vec2(u_xlat9) + u_xlat2.xy;
    u_xlat6.xy = u_xlat6.xy + vec2(0.5, 0.5);
    u_xlat10_6.x = texture2D(_CloudTex, u_xlat6.xy).w;
    u_xlat9 = (-u_xlat10_6.x) + (-_DsEdgeC.w);
    u_xlat3.x = u_xlat3.x * u_xlat9 + u_xlat10_6.x;
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat0.x = u_xlat3.x + u_xlat0.x;
    u_xlat3.xy = _DSData3.ww * vec2(1.0, -1.0) + vs_TEXCOORD2.xy;
    u_xlat1.xw = _CloudPos3.xy * _DSTex_ST.xy;
    u_xlat3.xy = u_xlat3.xy * _CloudPos3.zw + u_xlat1.xw;
    u_xlat1.xw = _DData3.xy * _Time.yy + vs_TEXCOORD1.xy;
    u_xlat10_1.xw = texture2D(_DTex, u_xlat1.xw).xy;
    u_xlat9 = _DData3.z * 0.5;
    u_xlat3.xy = u_xlat10_1.xw * vec2(u_xlat9) + u_xlat3.xy;
    u_xlat10_3 = texture2D(_DSTex, u_xlat3.xy).x;
    u_xlat3.x = u_xlat10_3 + (-_DSData3.z);
    u_xlat3.x = (-u_xlat3.x) + _DsEdgeRange;
    u_xlat3.x = max(u_xlat3.x, 0.0);
    u_xlat3.x = u_xlat3.x * _DsEdgeMul;
    u_xlat3.x = min(u_xlat3.x, 1.0);
    u_xlat2.xy = u_xlat4.xy * _CloudPos3.zw + _CloudPos3.xy;
    u_xlat6.xy = u_xlat10_1.xw * vec2(u_xlat9) + u_xlat2.xy;
    u_xlat6.xy = u_xlat6.xy + vec2(0.5, 0.5);
    u_xlat10_6.x = texture2D(_CloudTex, u_xlat6.xy).w;
    u_xlat9 = (-u_xlat10_6.x) + (-_DsEdgeC.w);
    u_xlat3.x = u_xlat3.x * u_xlat9 + u_xlat10_6.x;
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat0.x = u_xlat3.x + u_xlat0.x;
    u_xlat3.xy = _DSData4.ww * vec2(1.0, -1.0) + vs_TEXCOORD2.xy;
    u_xlat1.xw = _CloudPos4.xy * _DSTex_ST.xy;
    u_xlat3.xy = u_xlat3.xy * _CloudPos4.zw + u_xlat1.xw;
    u_xlat1.xw = _DData4.xy * _Time.yy + vs_TEXCOORD1.xy;
    u_xlat10_1.xw = texture2D(_DTex, u_xlat1.xw).xy;
    u_xlat9 = _DData4.z * 0.5;
    u_xlat3.xy = u_xlat10_1.xw * vec2(u_xlat9) + u_xlat3.xy;
    u_xlat10_3 = texture2D(_DSTex, u_xlat3.xy).x;
    u_xlat3.x = u_xlat10_3 + (-_DSData4.z);
    u_xlat3.x = (-u_xlat3.x) + _DsEdgeRange;
    u_xlat3.x = max(u_xlat3.x, 0.0);
    u_xlat3.x = u_xlat3.x * _DsEdgeMul;
    u_xlat3.x = min(u_xlat3.x, 1.0);
    u_xlat2.xy = u_xlat4.xy * _CloudPos4.zw + _CloudPos4.xy;
    u_xlat6.xy = u_xlat10_1.xw * vec2(u_xlat9) + u_xlat2.xy;
    u_xlat6.xy = u_xlat6.xy + vec2(0.5, 0.5);
    u_xlat10_6.x = texture2D(_CloudTex, u_xlat6.xy).w;
    u_xlat9 = (-u_xlat10_6.x) + (-_DsEdgeC.w);
    u_xlat3.x = u_xlat3.x * u_xlat9 + u_xlat10_6.x;
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat0.x = u_xlat3.x + u_xlat0.x;
    u_xlat3.xy = _DSData5.ww * vec2(1.0, -1.0) + vs_TEXCOORD2.xy;
    u_xlat1.xw = _CloudPos5.xy * _DSTex_ST.xy;
    u_xlat3.xy = u_xlat3.xy * _CloudPos5.zw + u_xlat1.xw;
    u_xlat1.xw = _DData5.xy * _Time.yy + vs_TEXCOORD1.xy;
    u_xlat10_1.xw = texture2D(_DTex, u_xlat1.xw).xy;
    u_xlat9 = _DData5.z * 0.5;
    u_xlat3.xy = u_xlat10_1.xw * vec2(u_xlat9) + u_xlat3.xy;
    u_xlat10_3 = texture2D(_DSTex, u_xlat3.xy).x;
    u_xlat3.x = u_xlat10_3 + (-_DSData5.z);
    u_xlat3.x = (-u_xlat3.x) + _DsEdgeRange;
    u_xlat3.x = max(u_xlat3.x, 0.0);
    u_xlat3.x = u_xlat3.x * _DsEdgeMul;
    u_xlat3.x = min(u_xlat3.x, 1.0);
    u_xlat2.xy = u_xlat4.xy * _CloudPos5.zw + _CloudPos5.xy;
    u_xlat6.xy = u_xlat10_1.xw * vec2(u_xlat9) + u_xlat2.xy;
    u_xlat6.xy = u_xlat6.xy + vec2(0.5, 0.5);
    u_xlat10_6.x = texture2D(_CloudTex, u_xlat6.xy).w;
    u_xlat9 = (-u_xlat10_6.x) + (-_DsEdgeC.w);
    u_xlat3.x = u_xlat3.x * u_xlat9 + u_xlat10_6.x;
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat0.x = u_xlat3.x + u_xlat0.x;
    u_xlat3.xy = _DSData6.ww * vec2(1.0, -1.0) + vs_TEXCOORD2.xy;
    u_xlat1.xw = _CloudPos6.xy * _DSTex_ST.xy;
    u_xlat3.xy = u_xlat3.xy * _CloudPos6.zw + u_xlat1.xw;
    u_xlat1.xw = _DData6.xy * _Time.yy + vs_TEXCOORD1.xy;
    u_xlat10_1.xw = texture2D(_DTex, u_xlat1.xw).xy;
    u_xlat9 = _DData6.z * 0.5;
    u_xlat3.xy = u_xlat10_1.xw * vec2(u_xlat9) + u_xlat3.xy;
    u_xlat10_3 = texture2D(_DSTex, u_xlat3.xy).x;
    u_xlat3.x = u_xlat10_3 + (-_DSData6.z);
    u_xlat3.x = (-u_xlat3.x) + _DsEdgeRange;
    u_xlat3.x = max(u_xlat3.x, 0.0);
    u_xlat3.x = u_xlat3.x * _DsEdgeMul;
    u_xlat3.x = min(u_xlat3.x, 1.0);
    u_xlat2.xy = u_xlat4.xy * _CloudPos6.zw + _CloudPos6.xy;
    u_xlat6.xy = u_xlat10_1.xw * vec2(u_xlat9) + u_xlat2.xy;
    u_xlat6.xy = u_xlat6.xy + vec2(0.5, 0.5);
    u_xlat10_6.x = texture2D(_CloudTex, u_xlat6.xy).w;
    u_xlat9 = (-u_xlat10_6.x) + (-_DsEdgeC.w);
    u_xlat3.x = u_xlat3.x * u_xlat9 + u_xlat10_6.x;
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat0.x = u_xlat3.x + u_xlat0.x;
    u_xlat3.xy = _DSData7.ww * vec2(1.0, -1.0) + vs_TEXCOORD2.xy;
    u_xlat1.xw = _CloudPos7.xy * _DSTex_ST.xy;
    u_xlat3.xy = u_xlat3.xy * _CloudPos7.zw + u_xlat1.xw;
    u_xlat1.xw = _DData7.xy * _Time.yy + vs_TEXCOORD1.xy;
    u_xlat10_1.xw = texture2D(_DTex, u_xlat1.xw).xy;
    u_xlat9 = _DData7.z * 0.5;
    u_xlat3.xy = u_xlat10_1.xw * vec2(u_xlat9) + u_xlat3.xy;
    u_xlat10_3 = texture2D(_DSTex, u_xlat3.xy).x;
    u_xlat3.x = u_xlat10_3 + (-_DSData7.z);
    u_xlat3.x = (-u_xlat3.x) + _DsEdgeRange;
    u_xlat3.x = max(u_xlat3.x, 0.0);
    u_xlat3.x = u_xlat3.x * _DsEdgeMul;
    u_xlat3.x = min(u_xlat3.x, 1.0);
    u_xlat2.xy = u_xlat4.xy * _CloudPos7.zw + _CloudPos7.xy;
    u_xlat6.xy = u_xlat10_1.xw * vec2(u_xlat9) + u_xlat2.xy;
    u_xlat6.xy = u_xlat6.xy + vec2(0.5, 0.5);
    u_xlat10_6.x = texture2D(_CloudTex, u_xlat6.xy).w;
    u_xlat9 = (-u_xlat10_6.x) + (-_DsEdgeC.w);
    u_xlat3.x = u_xlat3.x * u_xlat9 + u_xlat10_6.x;
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat0.x = u_xlat3.x + u_xlat0.x;
    u_xlat3.xy = _DSData8.ww * vec2(1.0, -1.0) + vs_TEXCOORD2.xy;
    u_xlat1.xw = _CloudPos8.xy * _DSTex_ST.xy;
    u_xlat3.xy = u_xlat3.xy * _CloudPos8.zw + u_xlat1.xw;
    u_xlat1.xw = _DData8.xy * _Time.yy + vs_TEXCOORD1.xy;
    u_xlat10_1.xw = texture2D(_DTex, u_xlat1.xw).xy;
    u_xlat9 = _DData8.z * 0.5;
    u_xlat3.xy = u_xlat10_1.xw * vec2(u_xlat9) + u_xlat3.xy;
    u_xlat10_3 = texture2D(_DSTex, u_xlat3.xy).x;
    u_xlat3.x = u_xlat10_3 + (-_DSData8.z);
    u_xlat3.x = (-u_xlat3.x) + _DsEdgeRange;
    u_xlat3.x = max(u_xlat3.x, 0.0);
    u_xlat3.x = u_xlat3.x * _DsEdgeMul;
    u_xlat3.x = min(u_xlat3.x, 1.0);
    u_xlat2.xy = u_xlat4.xy * _CloudPos8.zw + _CloudPos8.xy;
    u_xlat4.xy = u_xlat4.xy * _CloudPos9.zw + _CloudPos9.xy;
    u_xlat6.xy = u_xlat10_1.xw * vec2(u_xlat9) + u_xlat2.xy;
    u_xlat6.xy = u_xlat6.xy + vec2(0.5, 0.5);
    u_xlat10_6.x = texture2D(_CloudTex, u_xlat6.xy).w;
    u_xlat9 = (-u_xlat10_6.x) + (-_DsEdgeC.w);
    u_xlat3.x = u_xlat3.x * u_xlat9 + u_xlat10_6.x;
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat0.x = u_xlat3.x + u_xlat0.x;
    u_xlat3.xy = _DSData9.ww * vec2(1.0, -1.0) + vs_TEXCOORD2.xy;
    u_xlat1.xw = _CloudPos9.xy * _DSTex_ST.xy;
    u_xlat3.xy = u_xlat3.xy * _CloudPos9.zw + u_xlat1.xw;
    u_xlat1.xw = _DData9.xy * _Time.yy + vs_TEXCOORD1.xy;
    u_xlat10_1.xw = texture2D(_DTex, u_xlat1.xw).xy;
    u_xlat9 = _DData9.z * 0.5;
    u_xlat3.xy = u_xlat10_1.xw * vec2(u_xlat9) + u_xlat3.xy;
    u_xlat1.xy = u_xlat10_1.xw * vec2(u_xlat9) + u_xlat4.xy;
    u_xlat1.xy = u_xlat1.xy + vec2(0.5, 0.5);
    u_xlat10_9 = texture2D(_CloudTex, u_xlat1.xy).w;
    u_xlat10_3 = texture2D(_DSTex, u_xlat3.xy).x;
    u_xlat3.x = u_xlat10_3 + (-_DSData9.z);
    u_xlat3.x = (-u_xlat3.x) + _DsEdgeRange;
    u_xlat3.x = max(u_xlat3.x, 0.0);
    u_xlat3.x = u_xlat3.x * _DsEdgeMul;
    u_xlat3.x = min(u_xlat3.x, 1.0);
    u_xlat6.x = (-u_xlat10_9) + (-_DsEdgeC.w);
    u_xlat3.x = u_xlat3.x * u_xlat6.x + u_xlat10_9;
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
    u_xlat0.x = u_xlat3.x + u_xlat0.x;
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat3.x = (-_CloudGroupCol.w) + 1.0;
    SV_Target0.w = (-u_xlat0.x) * u_xlat3.x + u_xlat0.x;
    SV_Target0.xyz = _CloudGroupCol.xyz;
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
uniform 	vec4 _CanvasPositionFactor;
uniform 	vec4 _CloudTex_ST;
uniform 	vec4 _DTex_ST;
uniform 	vec4 _DSTex_ST;
uniform 	vec4 _LTex_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec2 in_TEXCOORD3;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD3;
out highp vec4 vs_COLOR0;
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
    u_xlat0.xy = in_TEXCOORD0.xy + _CanvasPositionFactor.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy * _CloudTex_ST.xy + _CloudTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD1.xy + _CanvasPositionFactor.xy;
    vs_TEXCOORD1.xy = u_xlat0.xy * _DTex_ST.xy + _DTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD3.xy + _CanvasPositionFactor.xy;
    vs_TEXCOORD3.xy = u_xlat0.xy * _LTex_ST.xy + _LTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD2.xy + _CanvasPositionFactor.xy;
    vs_TEXCOORD2.xy = u_xlat0.xy * _DSTex_ST.xy + _DSTex_ST.zw;
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
uniform 	vec4 _CloudGroupCol;
uniform 	vec4 _CloudPos0;
uniform 	vec4 _CloudPos1;
uniform 	vec4 _CloudPos2;
uniform 	vec4 _CloudPos3;
uniform 	vec4 _CloudPos4;
uniform 	vec4 _CloudPos5;
uniform 	vec4 _CloudPos6;
uniform 	vec4 _CloudPos7;
uniform 	vec4 _CloudPos8;
uniform 	vec4 _CloudPos9;
uniform 	vec4 _DData0;
uniform 	vec4 _DData1;
uniform 	vec4 _DData2;
uniform 	vec4 _DData3;
uniform 	vec4 _DData4;
uniform 	vec4 _DData5;
uniform 	vec4 _DData6;
uniform 	vec4 _DData7;
uniform 	vec4 _DData8;
uniform 	vec4 _DData9;
uniform 	vec4 _DSTex_ST;
uniform 	vec4 _DSData0;
uniform 	vec4 _DSData1;
uniform 	vec4 _DSData2;
uniform 	vec4 _DSData3;
uniform 	vec4 _DSData4;
uniform 	vec4 _DSData5;
uniform 	vec4 _DSData6;
uniform 	vec4 _DSData7;
uniform 	vec4 _DSData8;
uniform 	vec4 _DSData9;
uniform 	vec4 _DsEdgeC;
uniform 	float _DsEdgeRange;
uniform 	float _DsEdgeMul;
UNITY_LOCATION(0) uniform mediump sampler2D _DTex;
UNITY_LOCATION(1) uniform mediump sampler2D _CloudTex;
UNITY_LOCATION(2) uniform mediump sampler2D _DSTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
layout(location = 0) out highp vec4 SV_Target0;
vec2 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec2 u_xlat2;
vec2 u_xlat3;
mediump float u_xlat16_3;
vec2 u_xlat4;
vec2 u_xlat6;
mediump vec2 u_xlat16_6;
float u_xlat9;
mediump float u_xlat16_9;
void main()
{
    u_xlat0.xy = _DSData0.ww * vec2(1.0, -1.0) + vs_TEXCOORD2.xy;
    u_xlat6.xy = _CloudPos0.xy * _DSTex_ST.xy;
    u_xlat0.xy = u_xlat0.xy * _CloudPos0.zw + u_xlat6.xy;
    u_xlat6.xy = _DData0.xy * _Time.yy + vs_TEXCOORD1.xy;
    u_xlat16_6.xy = texture(_DTex, u_xlat6.xy).xy;
    u_xlat1.x = _DData0.z * 0.5;
    u_xlat0.xy = u_xlat16_6.xy * u_xlat1.xx + u_xlat0.xy;
    u_xlat16_0 = texture(_DSTex, u_xlat0.xy).x;
    u_xlat0.x = u_xlat16_0 + (-_DSData0.z);
    u_xlat0.x = (-u_xlat0.x) + _DsEdgeRange;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = u_xlat0.x * _DsEdgeMul;
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat4.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat2.xy = u_xlat4.xy * _CloudPos0.zw + _CloudPos0.xy;
    u_xlat3.xy = u_xlat16_6.xy * u_xlat1.xx + u_xlat2.xy;
    u_xlat3.xy = u_xlat3.xy + vec2(0.5, 0.5);
    u_xlat16_3 = texture(_CloudTex, u_xlat3.xy).w;
    u_xlat6.x = (-u_xlat16_3) + (-_DsEdgeC.w);
    u_xlat0.x = u_xlat0.x * u_xlat6.x + u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.xy = _DSData1.ww * vec2(1.0, -1.0) + vs_TEXCOORD2.xy;
    u_xlat1.xw = _CloudPos1.xy * _DSTex_ST.xy;
    u_xlat3.xy = u_xlat3.xy * _CloudPos1.zw + u_xlat1.xw;
    u_xlat1.xw = _DData1.xy * _Time.yy + vs_TEXCOORD1.xy;
    u_xlat16_1.xw = texture(_DTex, u_xlat1.xw).xy;
    u_xlat9 = _DData1.z * 0.5;
    u_xlat3.xy = u_xlat16_1.xw * vec2(u_xlat9) + u_xlat3.xy;
    u_xlat16_3 = texture(_DSTex, u_xlat3.xy).x;
    u_xlat3.x = u_xlat16_3 + (-_DSData1.z);
    u_xlat3.x = (-u_xlat3.x) + _DsEdgeRange;
    u_xlat3.x = max(u_xlat3.x, 0.0);
    u_xlat3.x = u_xlat3.x * _DsEdgeMul;
    u_xlat3.x = min(u_xlat3.x, 1.0);
    u_xlat2.xy = u_xlat4.xy * _CloudPos1.zw + _CloudPos1.xy;
    u_xlat6.xy = u_xlat16_1.xw * vec2(u_xlat9) + u_xlat2.xy;
    u_xlat6.xy = u_xlat6.xy + vec2(0.5, 0.5);
    u_xlat16_6.x = texture(_CloudTex, u_xlat6.xy).w;
    u_xlat9 = (-u_xlat16_6.x) + (-_DsEdgeC.w);
    u_xlat3.x = u_xlat3.x * u_xlat9 + u_xlat16_6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat3.x + u_xlat0.x;
    u_xlat3.xy = _DSData2.ww * vec2(1.0, -1.0) + vs_TEXCOORD2.xy;
    u_xlat1.xw = _CloudPos2.xy * _DSTex_ST.xy;
    u_xlat3.xy = u_xlat3.xy * _CloudPos2.zw + u_xlat1.xw;
    u_xlat1.xw = _DData2.xy * _Time.yy + vs_TEXCOORD1.xy;
    u_xlat16_1.xw = texture(_DTex, u_xlat1.xw).xy;
    u_xlat9 = _DData2.z * 0.5;
    u_xlat3.xy = u_xlat16_1.xw * vec2(u_xlat9) + u_xlat3.xy;
    u_xlat16_3 = texture(_DSTex, u_xlat3.xy).x;
    u_xlat3.x = u_xlat16_3 + (-_DSData2.z);
    u_xlat3.x = (-u_xlat3.x) + _DsEdgeRange;
    u_xlat3.x = max(u_xlat3.x, 0.0);
    u_xlat3.x = u_xlat3.x * _DsEdgeMul;
    u_xlat3.x = min(u_xlat3.x, 1.0);
    u_xlat2.xy = u_xlat4.xy * _CloudPos2.zw + _CloudPos2.xy;
    u_xlat6.xy = u_xlat16_1.xw * vec2(u_xlat9) + u_xlat2.xy;
    u_xlat6.xy = u_xlat6.xy + vec2(0.5, 0.5);
    u_xlat16_6.x = texture(_CloudTex, u_xlat6.xy).w;
    u_xlat9 = (-u_xlat16_6.x) + (-_DsEdgeC.w);
    u_xlat3.x = u_xlat3.x * u_xlat9 + u_xlat16_6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat3.x + u_xlat0.x;
    u_xlat3.xy = _DSData3.ww * vec2(1.0, -1.0) + vs_TEXCOORD2.xy;
    u_xlat1.xw = _CloudPos3.xy * _DSTex_ST.xy;
    u_xlat3.xy = u_xlat3.xy * _CloudPos3.zw + u_xlat1.xw;
    u_xlat1.xw = _DData3.xy * _Time.yy + vs_TEXCOORD1.xy;
    u_xlat16_1.xw = texture(_DTex, u_xlat1.xw).xy;
    u_xlat9 = _DData3.z * 0.5;
    u_xlat3.xy = u_xlat16_1.xw * vec2(u_xlat9) + u_xlat3.xy;
    u_xlat16_3 = texture(_DSTex, u_xlat3.xy).x;
    u_xlat3.x = u_xlat16_3 + (-_DSData3.z);
    u_xlat3.x = (-u_xlat3.x) + _DsEdgeRange;
    u_xlat3.x = max(u_xlat3.x, 0.0);
    u_xlat3.x = u_xlat3.x * _DsEdgeMul;
    u_xlat3.x = min(u_xlat3.x, 1.0);
    u_xlat2.xy = u_xlat4.xy * _CloudPos3.zw + _CloudPos3.xy;
    u_xlat6.xy = u_xlat16_1.xw * vec2(u_xlat9) + u_xlat2.xy;
    u_xlat6.xy = u_xlat6.xy + vec2(0.5, 0.5);
    u_xlat16_6.x = texture(_CloudTex, u_xlat6.xy).w;
    u_xlat9 = (-u_xlat16_6.x) + (-_DsEdgeC.w);
    u_xlat3.x = u_xlat3.x * u_xlat9 + u_xlat16_6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat3.x + u_xlat0.x;
    u_xlat3.xy = _DSData4.ww * vec2(1.0, -1.0) + vs_TEXCOORD2.xy;
    u_xlat1.xw = _CloudPos4.xy * _DSTex_ST.xy;
    u_xlat3.xy = u_xlat3.xy * _CloudPos4.zw + u_xlat1.xw;
    u_xlat1.xw = _DData4.xy * _Time.yy + vs_TEXCOORD1.xy;
    u_xlat16_1.xw = texture(_DTex, u_xlat1.xw).xy;
    u_xlat9 = _DData4.z * 0.5;
    u_xlat3.xy = u_xlat16_1.xw * vec2(u_xlat9) + u_xlat3.xy;
    u_xlat16_3 = texture(_DSTex, u_xlat3.xy).x;
    u_xlat3.x = u_xlat16_3 + (-_DSData4.z);
    u_xlat3.x = (-u_xlat3.x) + _DsEdgeRange;
    u_xlat3.x = max(u_xlat3.x, 0.0);
    u_xlat3.x = u_xlat3.x * _DsEdgeMul;
    u_xlat3.x = min(u_xlat3.x, 1.0);
    u_xlat2.xy = u_xlat4.xy * _CloudPos4.zw + _CloudPos4.xy;
    u_xlat6.xy = u_xlat16_1.xw * vec2(u_xlat9) + u_xlat2.xy;
    u_xlat6.xy = u_xlat6.xy + vec2(0.5, 0.5);
    u_xlat16_6.x = texture(_CloudTex, u_xlat6.xy).w;
    u_xlat9 = (-u_xlat16_6.x) + (-_DsEdgeC.w);
    u_xlat3.x = u_xlat3.x * u_xlat9 + u_xlat16_6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat3.x + u_xlat0.x;
    u_xlat3.xy = _DSData5.ww * vec2(1.0, -1.0) + vs_TEXCOORD2.xy;
    u_xlat1.xw = _CloudPos5.xy * _DSTex_ST.xy;
    u_xlat3.xy = u_xlat3.xy * _CloudPos5.zw + u_xlat1.xw;
    u_xlat1.xw = _DData5.xy * _Time.yy + vs_TEXCOORD1.xy;
    u_xlat16_1.xw = texture(_DTex, u_xlat1.xw).xy;
    u_xlat9 = _DData5.z * 0.5;
    u_xlat3.xy = u_xlat16_1.xw * vec2(u_xlat9) + u_xlat3.xy;
    u_xlat16_3 = texture(_DSTex, u_xlat3.xy).x;
    u_xlat3.x = u_xlat16_3 + (-_DSData5.z);
    u_xlat3.x = (-u_xlat3.x) + _DsEdgeRange;
    u_xlat3.x = max(u_xlat3.x, 0.0);
    u_xlat3.x = u_xlat3.x * _DsEdgeMul;
    u_xlat3.x = min(u_xlat3.x, 1.0);
    u_xlat2.xy = u_xlat4.xy * _CloudPos5.zw + _CloudPos5.xy;
    u_xlat6.xy = u_xlat16_1.xw * vec2(u_xlat9) + u_xlat2.xy;
    u_xlat6.xy = u_xlat6.xy + vec2(0.5, 0.5);
    u_xlat16_6.x = texture(_CloudTex, u_xlat6.xy).w;
    u_xlat9 = (-u_xlat16_6.x) + (-_DsEdgeC.w);
    u_xlat3.x = u_xlat3.x * u_xlat9 + u_xlat16_6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat3.x + u_xlat0.x;
    u_xlat3.xy = _DSData6.ww * vec2(1.0, -1.0) + vs_TEXCOORD2.xy;
    u_xlat1.xw = _CloudPos6.xy * _DSTex_ST.xy;
    u_xlat3.xy = u_xlat3.xy * _CloudPos6.zw + u_xlat1.xw;
    u_xlat1.xw = _DData6.xy * _Time.yy + vs_TEXCOORD1.xy;
    u_xlat16_1.xw = texture(_DTex, u_xlat1.xw).xy;
    u_xlat9 = _DData6.z * 0.5;
    u_xlat3.xy = u_xlat16_1.xw * vec2(u_xlat9) + u_xlat3.xy;
    u_xlat16_3 = texture(_DSTex, u_xlat3.xy).x;
    u_xlat3.x = u_xlat16_3 + (-_DSData6.z);
    u_xlat3.x = (-u_xlat3.x) + _DsEdgeRange;
    u_xlat3.x = max(u_xlat3.x, 0.0);
    u_xlat3.x = u_xlat3.x * _DsEdgeMul;
    u_xlat3.x = min(u_xlat3.x, 1.0);
    u_xlat2.xy = u_xlat4.xy * _CloudPos6.zw + _CloudPos6.xy;
    u_xlat6.xy = u_xlat16_1.xw * vec2(u_xlat9) + u_xlat2.xy;
    u_xlat6.xy = u_xlat6.xy + vec2(0.5, 0.5);
    u_xlat16_6.x = texture(_CloudTex, u_xlat6.xy).w;
    u_xlat9 = (-u_xlat16_6.x) + (-_DsEdgeC.w);
    u_xlat3.x = u_xlat3.x * u_xlat9 + u_xlat16_6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat3.x + u_xlat0.x;
    u_xlat3.xy = _DSData7.ww * vec2(1.0, -1.0) + vs_TEXCOORD2.xy;
    u_xlat1.xw = _CloudPos7.xy * _DSTex_ST.xy;
    u_xlat3.xy = u_xlat3.xy * _CloudPos7.zw + u_xlat1.xw;
    u_xlat1.xw = _DData7.xy * _Time.yy + vs_TEXCOORD1.xy;
    u_xlat16_1.xw = texture(_DTex, u_xlat1.xw).xy;
    u_xlat9 = _DData7.z * 0.5;
    u_xlat3.xy = u_xlat16_1.xw * vec2(u_xlat9) + u_xlat3.xy;
    u_xlat16_3 = texture(_DSTex, u_xlat3.xy).x;
    u_xlat3.x = u_xlat16_3 + (-_DSData7.z);
    u_xlat3.x = (-u_xlat3.x) + _DsEdgeRange;
    u_xlat3.x = max(u_xlat3.x, 0.0);
    u_xlat3.x = u_xlat3.x * _DsEdgeMul;
    u_xlat3.x = min(u_xlat3.x, 1.0);
    u_xlat2.xy = u_xlat4.xy * _CloudPos7.zw + _CloudPos7.xy;
    u_xlat6.xy = u_xlat16_1.xw * vec2(u_xlat9) + u_xlat2.xy;
    u_xlat6.xy = u_xlat6.xy + vec2(0.5, 0.5);
    u_xlat16_6.x = texture(_CloudTex, u_xlat6.xy).w;
    u_xlat9 = (-u_xlat16_6.x) + (-_DsEdgeC.w);
    u_xlat3.x = u_xlat3.x * u_xlat9 + u_xlat16_6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat3.x + u_xlat0.x;
    u_xlat3.xy = _DSData8.ww * vec2(1.0, -1.0) + vs_TEXCOORD2.xy;
    u_xlat1.xw = _CloudPos8.xy * _DSTex_ST.xy;
    u_xlat3.xy = u_xlat3.xy * _CloudPos8.zw + u_xlat1.xw;
    u_xlat1.xw = _DData8.xy * _Time.yy + vs_TEXCOORD1.xy;
    u_xlat16_1.xw = texture(_DTex, u_xlat1.xw).xy;
    u_xlat9 = _DData8.z * 0.5;
    u_xlat3.xy = u_xlat16_1.xw * vec2(u_xlat9) + u_xlat3.xy;
    u_xlat16_3 = texture(_DSTex, u_xlat3.xy).x;
    u_xlat3.x = u_xlat16_3 + (-_DSData8.z);
    u_xlat3.x = (-u_xlat3.x) + _DsEdgeRange;
    u_xlat3.x = max(u_xlat3.x, 0.0);
    u_xlat3.x = u_xlat3.x * _DsEdgeMul;
    u_xlat3.x = min(u_xlat3.x, 1.0);
    u_xlat2.xy = u_xlat4.xy * _CloudPos8.zw + _CloudPos8.xy;
    u_xlat4.xy = u_xlat4.xy * _CloudPos9.zw + _CloudPos9.xy;
    u_xlat6.xy = u_xlat16_1.xw * vec2(u_xlat9) + u_xlat2.xy;
    u_xlat6.xy = u_xlat6.xy + vec2(0.5, 0.5);
    u_xlat16_6.x = texture(_CloudTex, u_xlat6.xy).w;
    u_xlat9 = (-u_xlat16_6.x) + (-_DsEdgeC.w);
    u_xlat3.x = u_xlat3.x * u_xlat9 + u_xlat16_6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat3.x + u_xlat0.x;
    u_xlat3.xy = _DSData9.ww * vec2(1.0, -1.0) + vs_TEXCOORD2.xy;
    u_xlat1.xw = _CloudPos9.xy * _DSTex_ST.xy;
    u_xlat3.xy = u_xlat3.xy * _CloudPos9.zw + u_xlat1.xw;
    u_xlat1.xw = _DData9.xy * _Time.yy + vs_TEXCOORD1.xy;
    u_xlat16_1.xw = texture(_DTex, u_xlat1.xw).xy;
    u_xlat9 = _DData9.z * 0.5;
    u_xlat3.xy = u_xlat16_1.xw * vec2(u_xlat9) + u_xlat3.xy;
    u_xlat1.xy = u_xlat16_1.xw * vec2(u_xlat9) + u_xlat4.xy;
    u_xlat1.xy = u_xlat1.xy + vec2(0.5, 0.5);
    u_xlat16_9 = texture(_CloudTex, u_xlat1.xy).w;
    u_xlat16_3 = texture(_DSTex, u_xlat3.xy).x;
    u_xlat3.x = u_xlat16_3 + (-_DSData9.z);
    u_xlat3.x = (-u_xlat3.x) + _DsEdgeRange;
    u_xlat3.x = max(u_xlat3.x, 0.0);
    u_xlat3.x = u_xlat3.x * _DsEdgeMul;
    u_xlat3.x = min(u_xlat3.x, 1.0);
    u_xlat6.x = (-u_xlat16_9) + (-_DsEdgeC.w);
    u_xlat3.x = u_xlat3.x * u_xlat6.x + u_xlat16_9;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat3.x + u_xlat0.x;
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat3.x = (-_CloudGroupCol.w) + 1.0;
    SV_Target0.w = (-u_xlat0.x) * u_xlat3.x + u_xlat0.x;
    SV_Target0.xyz = _CloudGroupCol.xyz;
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
uniform 	vec4 _CanvasPositionFactor;
uniform 	vec4 _CloudTex_ST;
uniform 	vec4 _DTex_ST;
uniform 	vec4 _DSTex_ST;
uniform 	vec4 _LTex_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec2 in_TEXCOORD3;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD3;
out highp vec4 vs_COLOR0;
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
    u_xlat0.xy = in_TEXCOORD0.xy + _CanvasPositionFactor.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy * _CloudTex_ST.xy + _CloudTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD1.xy + _CanvasPositionFactor.xy;
    vs_TEXCOORD1.xy = u_xlat0.xy * _DTex_ST.xy + _DTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD3.xy + _CanvasPositionFactor.xy;
    vs_TEXCOORD3.xy = u_xlat0.xy * _LTex_ST.xy + _LTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD2.xy + _CanvasPositionFactor.xy;
    vs_TEXCOORD2.xy = u_xlat0.xy * _DSTex_ST.xy + _DSTex_ST.zw;
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
uniform 	vec4 _CloudGroupCol;
uniform 	vec4 _CloudPos0;
uniform 	vec4 _CloudPos1;
uniform 	vec4 _CloudPos2;
uniform 	vec4 _CloudPos3;
uniform 	vec4 _CloudPos4;
uniform 	vec4 _CloudPos5;
uniform 	vec4 _CloudPos6;
uniform 	vec4 _CloudPos7;
uniform 	vec4 _CloudPos8;
uniform 	vec4 _CloudPos9;
uniform 	vec4 _DData0;
uniform 	vec4 _DData1;
uniform 	vec4 _DData2;
uniform 	vec4 _DData3;
uniform 	vec4 _DData4;
uniform 	vec4 _DData5;
uniform 	vec4 _DData6;
uniform 	vec4 _DData7;
uniform 	vec4 _DData8;
uniform 	vec4 _DData9;
uniform 	vec4 _DSTex_ST;
uniform 	vec4 _DSData0;
uniform 	vec4 _DSData1;
uniform 	vec4 _DSData2;
uniform 	vec4 _DSData3;
uniform 	vec4 _DSData4;
uniform 	vec4 _DSData5;
uniform 	vec4 _DSData6;
uniform 	vec4 _DSData7;
uniform 	vec4 _DSData8;
uniform 	vec4 _DSData9;
uniform 	vec4 _DsEdgeC;
uniform 	float _DsEdgeRange;
uniform 	float _DsEdgeMul;
UNITY_LOCATION(0) uniform mediump sampler2D _DTex;
UNITY_LOCATION(1) uniform mediump sampler2D _CloudTex;
UNITY_LOCATION(2) uniform mediump sampler2D _DSTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
layout(location = 0) out highp vec4 SV_Target0;
vec2 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec2 u_xlat2;
vec2 u_xlat3;
mediump float u_xlat16_3;
vec2 u_xlat4;
vec2 u_xlat6;
mediump vec2 u_xlat16_6;
float u_xlat9;
mediump float u_xlat16_9;
void main()
{
    u_xlat0.xy = _DSData0.ww * vec2(1.0, -1.0) + vs_TEXCOORD2.xy;
    u_xlat6.xy = _CloudPos0.xy * _DSTex_ST.xy;
    u_xlat0.xy = u_xlat0.xy * _CloudPos0.zw + u_xlat6.xy;
    u_xlat6.xy = _DData0.xy * _Time.yy + vs_TEXCOORD1.xy;
    u_xlat16_6.xy = texture(_DTex, u_xlat6.xy).xy;
    u_xlat1.x = _DData0.z * 0.5;
    u_xlat0.xy = u_xlat16_6.xy * u_xlat1.xx + u_xlat0.xy;
    u_xlat16_0 = texture(_DSTex, u_xlat0.xy).x;
    u_xlat0.x = u_xlat16_0 + (-_DSData0.z);
    u_xlat0.x = (-u_xlat0.x) + _DsEdgeRange;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = u_xlat0.x * _DsEdgeMul;
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat4.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat2.xy = u_xlat4.xy * _CloudPos0.zw + _CloudPos0.xy;
    u_xlat3.xy = u_xlat16_6.xy * u_xlat1.xx + u_xlat2.xy;
    u_xlat3.xy = u_xlat3.xy + vec2(0.5, 0.5);
    u_xlat16_3 = texture(_CloudTex, u_xlat3.xy).w;
    u_xlat6.x = (-u_xlat16_3) + (-_DsEdgeC.w);
    u_xlat0.x = u_xlat0.x * u_xlat6.x + u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.xy = _DSData1.ww * vec2(1.0, -1.0) + vs_TEXCOORD2.xy;
    u_xlat1.xw = _CloudPos1.xy * _DSTex_ST.xy;
    u_xlat3.xy = u_xlat3.xy * _CloudPos1.zw + u_xlat1.xw;
    u_xlat1.xw = _DData1.xy * _Time.yy + vs_TEXCOORD1.xy;
    u_xlat16_1.xw = texture(_DTex, u_xlat1.xw).xy;
    u_xlat9 = _DData1.z * 0.5;
    u_xlat3.xy = u_xlat16_1.xw * vec2(u_xlat9) + u_xlat3.xy;
    u_xlat16_3 = texture(_DSTex, u_xlat3.xy).x;
    u_xlat3.x = u_xlat16_3 + (-_DSData1.z);
    u_xlat3.x = (-u_xlat3.x) + _DsEdgeRange;
    u_xlat3.x = max(u_xlat3.x, 0.0);
    u_xlat3.x = u_xlat3.x * _DsEdgeMul;
    u_xlat3.x = min(u_xlat3.x, 1.0);
    u_xlat2.xy = u_xlat4.xy * _CloudPos1.zw + _CloudPos1.xy;
    u_xlat6.xy = u_xlat16_1.xw * vec2(u_xlat9) + u_xlat2.xy;
    u_xlat6.xy = u_xlat6.xy + vec2(0.5, 0.5);
    u_xlat16_6.x = texture(_CloudTex, u_xlat6.xy).w;
    u_xlat9 = (-u_xlat16_6.x) + (-_DsEdgeC.w);
    u_xlat3.x = u_xlat3.x * u_xlat9 + u_xlat16_6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat3.x + u_xlat0.x;
    u_xlat3.xy = _DSData2.ww * vec2(1.0, -1.0) + vs_TEXCOORD2.xy;
    u_xlat1.xw = _CloudPos2.xy * _DSTex_ST.xy;
    u_xlat3.xy = u_xlat3.xy * _CloudPos2.zw + u_xlat1.xw;
    u_xlat1.xw = _DData2.xy * _Time.yy + vs_TEXCOORD1.xy;
    u_xlat16_1.xw = texture(_DTex, u_xlat1.xw).xy;
    u_xlat9 = _DData2.z * 0.5;
    u_xlat3.xy = u_xlat16_1.xw * vec2(u_xlat9) + u_xlat3.xy;
    u_xlat16_3 = texture(_DSTex, u_xlat3.xy).x;
    u_xlat3.x = u_xlat16_3 + (-_DSData2.z);
    u_xlat3.x = (-u_xlat3.x) + _DsEdgeRange;
    u_xlat3.x = max(u_xlat3.x, 0.0);
    u_xlat3.x = u_xlat3.x * _DsEdgeMul;
    u_xlat3.x = min(u_xlat3.x, 1.0);
    u_xlat2.xy = u_xlat4.xy * _CloudPos2.zw + _CloudPos2.xy;
    u_xlat6.xy = u_xlat16_1.xw * vec2(u_xlat9) + u_xlat2.xy;
    u_xlat6.xy = u_xlat6.xy + vec2(0.5, 0.5);
    u_xlat16_6.x = texture(_CloudTex, u_xlat6.xy).w;
    u_xlat9 = (-u_xlat16_6.x) + (-_DsEdgeC.w);
    u_xlat3.x = u_xlat3.x * u_xlat9 + u_xlat16_6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat3.x + u_xlat0.x;
    u_xlat3.xy = _DSData3.ww * vec2(1.0, -1.0) + vs_TEXCOORD2.xy;
    u_xlat1.xw = _CloudPos3.xy * _DSTex_ST.xy;
    u_xlat3.xy = u_xlat3.xy * _CloudPos3.zw + u_xlat1.xw;
    u_xlat1.xw = _DData3.xy * _Time.yy + vs_TEXCOORD1.xy;
    u_xlat16_1.xw = texture(_DTex, u_xlat1.xw).xy;
    u_xlat9 = _DData3.z * 0.5;
    u_xlat3.xy = u_xlat16_1.xw * vec2(u_xlat9) + u_xlat3.xy;
    u_xlat16_3 = texture(_DSTex, u_xlat3.xy).x;
    u_xlat3.x = u_xlat16_3 + (-_DSData3.z);
    u_xlat3.x = (-u_xlat3.x) + _DsEdgeRange;
    u_xlat3.x = max(u_xlat3.x, 0.0);
    u_xlat3.x = u_xlat3.x * _DsEdgeMul;
    u_xlat3.x = min(u_xlat3.x, 1.0);
    u_xlat2.xy = u_xlat4.xy * _CloudPos3.zw + _CloudPos3.xy;
    u_xlat6.xy = u_xlat16_1.xw * vec2(u_xlat9) + u_xlat2.xy;
    u_xlat6.xy = u_xlat6.xy + vec2(0.5, 0.5);
    u_xlat16_6.x = texture(_CloudTex, u_xlat6.xy).w;
    u_xlat9 = (-u_xlat16_6.x) + (-_DsEdgeC.w);
    u_xlat3.x = u_xlat3.x * u_xlat9 + u_xlat16_6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat3.x + u_xlat0.x;
    u_xlat3.xy = _DSData4.ww * vec2(1.0, -1.0) + vs_TEXCOORD2.xy;
    u_xlat1.xw = _CloudPos4.xy * _DSTex_ST.xy;
    u_xlat3.xy = u_xlat3.xy * _CloudPos4.zw + u_xlat1.xw;
    u_xlat1.xw = _DData4.xy * _Time.yy + vs_TEXCOORD1.xy;
    u_xlat16_1.xw = texture(_DTex, u_xlat1.xw).xy;
    u_xlat9 = _DData4.z * 0.5;
    u_xlat3.xy = u_xlat16_1.xw * vec2(u_xlat9) + u_xlat3.xy;
    u_xlat16_3 = texture(_DSTex, u_xlat3.xy).x;
    u_xlat3.x = u_xlat16_3 + (-_DSData4.z);
    u_xlat3.x = (-u_xlat3.x) + _DsEdgeRange;
    u_xlat3.x = max(u_xlat3.x, 0.0);
    u_xlat3.x = u_xlat3.x * _DsEdgeMul;
    u_xlat3.x = min(u_xlat3.x, 1.0);
    u_xlat2.xy = u_xlat4.xy * _CloudPos4.zw + _CloudPos4.xy;
    u_xlat6.xy = u_xlat16_1.xw * vec2(u_xlat9) + u_xlat2.xy;
    u_xlat6.xy = u_xlat6.xy + vec2(0.5, 0.5);
    u_xlat16_6.x = texture(_CloudTex, u_xlat6.xy).w;
    u_xlat9 = (-u_xlat16_6.x) + (-_DsEdgeC.w);
    u_xlat3.x = u_xlat3.x * u_xlat9 + u_xlat16_6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat3.x + u_xlat0.x;
    u_xlat3.xy = _DSData5.ww * vec2(1.0, -1.0) + vs_TEXCOORD2.xy;
    u_xlat1.xw = _CloudPos5.xy * _DSTex_ST.xy;
    u_xlat3.xy = u_xlat3.xy * _CloudPos5.zw + u_xlat1.xw;
    u_xlat1.xw = _DData5.xy * _Time.yy + vs_TEXCOORD1.xy;
    u_xlat16_1.xw = texture(_DTex, u_xlat1.xw).xy;
    u_xlat9 = _DData5.z * 0.5;
    u_xlat3.xy = u_xlat16_1.xw * vec2(u_xlat9) + u_xlat3.xy;
    u_xlat16_3 = texture(_DSTex, u_xlat3.xy).x;
    u_xlat3.x = u_xlat16_3 + (-_DSData5.z);
    u_xlat3.x = (-u_xlat3.x) + _DsEdgeRange;
    u_xlat3.x = max(u_xlat3.x, 0.0);
    u_xlat3.x = u_xlat3.x * _DsEdgeMul;
    u_xlat3.x = min(u_xlat3.x, 1.0);
    u_xlat2.xy = u_xlat4.xy * _CloudPos5.zw + _CloudPos5.xy;
    u_xlat6.xy = u_xlat16_1.xw * vec2(u_xlat9) + u_xlat2.xy;
    u_xlat6.xy = u_xlat6.xy + vec2(0.5, 0.5);
    u_xlat16_6.x = texture(_CloudTex, u_xlat6.xy).w;
    u_xlat9 = (-u_xlat16_6.x) + (-_DsEdgeC.w);
    u_xlat3.x = u_xlat3.x * u_xlat9 + u_xlat16_6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat3.x + u_xlat0.x;
    u_xlat3.xy = _DSData6.ww * vec2(1.0, -1.0) + vs_TEXCOORD2.xy;
    u_xlat1.xw = _CloudPos6.xy * _DSTex_ST.xy;
    u_xlat3.xy = u_xlat3.xy * _CloudPos6.zw + u_xlat1.xw;
    u_xlat1.xw = _DData6.xy * _Time.yy + vs_TEXCOORD1.xy;
    u_xlat16_1.xw = texture(_DTex, u_xlat1.xw).xy;
    u_xlat9 = _DData6.z * 0.5;
    u_xlat3.xy = u_xlat16_1.xw * vec2(u_xlat9) + u_xlat3.xy;
    u_xlat16_3 = texture(_DSTex, u_xlat3.xy).x;
    u_xlat3.x = u_xlat16_3 + (-_DSData6.z);
    u_xlat3.x = (-u_xlat3.x) + _DsEdgeRange;
    u_xlat3.x = max(u_xlat3.x, 0.0);
    u_xlat3.x = u_xlat3.x * _DsEdgeMul;
    u_xlat3.x = min(u_xlat3.x, 1.0);
    u_xlat2.xy = u_xlat4.xy * _CloudPos6.zw + _CloudPos6.xy;
    u_xlat6.xy = u_xlat16_1.xw * vec2(u_xlat9) + u_xlat2.xy;
    u_xlat6.xy = u_xlat6.xy + vec2(0.5, 0.5);
    u_xlat16_6.x = texture(_CloudTex, u_xlat6.xy).w;
    u_xlat9 = (-u_xlat16_6.x) + (-_DsEdgeC.w);
    u_xlat3.x = u_xlat3.x * u_xlat9 + u_xlat16_6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat3.x + u_xlat0.x;
    u_xlat3.xy = _DSData7.ww * vec2(1.0, -1.0) + vs_TEXCOORD2.xy;
    u_xlat1.xw = _CloudPos7.xy * _DSTex_ST.xy;
    u_xlat3.xy = u_xlat3.xy * _CloudPos7.zw + u_xlat1.xw;
    u_xlat1.xw = _DData7.xy * _Time.yy + vs_TEXCOORD1.xy;
    u_xlat16_1.xw = texture(_DTex, u_xlat1.xw).xy;
    u_xlat9 = _DData7.z * 0.5;
    u_xlat3.xy = u_xlat16_1.xw * vec2(u_xlat9) + u_xlat3.xy;
    u_xlat16_3 = texture(_DSTex, u_xlat3.xy).x;
    u_xlat3.x = u_xlat16_3 + (-_DSData7.z);
    u_xlat3.x = (-u_xlat3.x) + _DsEdgeRange;
    u_xlat3.x = max(u_xlat3.x, 0.0);
    u_xlat3.x = u_xlat3.x * _DsEdgeMul;
    u_xlat3.x = min(u_xlat3.x, 1.0);
    u_xlat2.xy = u_xlat4.xy * _CloudPos7.zw + _CloudPos7.xy;
    u_xlat6.xy = u_xlat16_1.xw * vec2(u_xlat9) + u_xlat2.xy;
    u_xlat6.xy = u_xlat6.xy + vec2(0.5, 0.5);
    u_xlat16_6.x = texture(_CloudTex, u_xlat6.xy).w;
    u_xlat9 = (-u_xlat16_6.x) + (-_DsEdgeC.w);
    u_xlat3.x = u_xlat3.x * u_xlat9 + u_xlat16_6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat3.x + u_xlat0.x;
    u_xlat3.xy = _DSData8.ww * vec2(1.0, -1.0) + vs_TEXCOORD2.xy;
    u_xlat1.xw = _CloudPos8.xy * _DSTex_ST.xy;
    u_xlat3.xy = u_xlat3.xy * _CloudPos8.zw + u_xlat1.xw;
    u_xlat1.xw = _DData8.xy * _Time.yy + vs_TEXCOORD1.xy;
    u_xlat16_1.xw = texture(_DTex, u_xlat1.xw).xy;
    u_xlat9 = _DData8.z * 0.5;
    u_xlat3.xy = u_xlat16_1.xw * vec2(u_xlat9) + u_xlat3.xy;
    u_xlat16_3 = texture(_DSTex, u_xlat3.xy).x;
    u_xlat3.x = u_xlat16_3 + (-_DSData8.z);
    u_xlat3.x = (-u_xlat3.x) + _DsEdgeRange;
    u_xlat3.x = max(u_xlat3.x, 0.0);
    u_xlat3.x = u_xlat3.x * _DsEdgeMul;
    u_xlat3.x = min(u_xlat3.x, 1.0);
    u_xlat2.xy = u_xlat4.xy * _CloudPos8.zw + _CloudPos8.xy;
    u_xlat4.xy = u_xlat4.xy * _CloudPos9.zw + _CloudPos9.xy;
    u_xlat6.xy = u_xlat16_1.xw * vec2(u_xlat9) + u_xlat2.xy;
    u_xlat6.xy = u_xlat6.xy + vec2(0.5, 0.5);
    u_xlat16_6.x = texture(_CloudTex, u_xlat6.xy).w;
    u_xlat9 = (-u_xlat16_6.x) + (-_DsEdgeC.w);
    u_xlat3.x = u_xlat3.x * u_xlat9 + u_xlat16_6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat3.x + u_xlat0.x;
    u_xlat3.xy = _DSData9.ww * vec2(1.0, -1.0) + vs_TEXCOORD2.xy;
    u_xlat1.xw = _CloudPos9.xy * _DSTex_ST.xy;
    u_xlat3.xy = u_xlat3.xy * _CloudPos9.zw + u_xlat1.xw;
    u_xlat1.xw = _DData9.xy * _Time.yy + vs_TEXCOORD1.xy;
    u_xlat16_1.xw = texture(_DTex, u_xlat1.xw).xy;
    u_xlat9 = _DData9.z * 0.5;
    u_xlat3.xy = u_xlat16_1.xw * vec2(u_xlat9) + u_xlat3.xy;
    u_xlat1.xy = u_xlat16_1.xw * vec2(u_xlat9) + u_xlat4.xy;
    u_xlat1.xy = u_xlat1.xy + vec2(0.5, 0.5);
    u_xlat16_9 = texture(_CloudTex, u_xlat1.xy).w;
    u_xlat16_3 = texture(_DSTex, u_xlat3.xy).x;
    u_xlat3.x = u_xlat16_3 + (-_DSData9.z);
    u_xlat3.x = (-u_xlat3.x) + _DsEdgeRange;
    u_xlat3.x = max(u_xlat3.x, 0.0);
    u_xlat3.x = u_xlat3.x * _DsEdgeMul;
    u_xlat3.x = min(u_xlat3.x, 1.0);
    u_xlat6.x = (-u_xlat16_9) + (-_DsEdgeC.w);
    u_xlat3.x = u_xlat3.x * u_xlat6.x + u_xlat16_9;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat3.x + u_xlat0.x;
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat3.x = (-_CloudGroupCol.w) + 1.0;
    SV_Target0.w = (-u_xlat0.x) * u_xlat3.x + u_xlat0.x;
    SV_Target0.xyz = _CloudGroupCol.xyz;
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
uniform 	vec4 _CanvasPositionFactor;
uniform 	vec4 _CloudTex_ST;
uniform 	vec4 _DTex_ST;
uniform 	vec4 _DSTex_ST;
uniform 	vec4 _LTex_ST;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec2 in_TEXCOORD3;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
out highp vec2 vs_TEXCOORD3;
out highp vec4 vs_COLOR0;
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
    u_xlat0.xy = in_TEXCOORD0.xy + _CanvasPositionFactor.xy;
    vs_TEXCOORD0.xy = u_xlat0.xy * _CloudTex_ST.xy + _CloudTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD1.xy + _CanvasPositionFactor.xy;
    vs_TEXCOORD1.xy = u_xlat0.xy * _DTex_ST.xy + _DTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD3.xy + _CanvasPositionFactor.xy;
    vs_TEXCOORD3.xy = u_xlat0.xy * _LTex_ST.xy + _LTex_ST.zw;
    u_xlat0.xy = in_TEXCOORD2.xy + _CanvasPositionFactor.xy;
    vs_TEXCOORD2.xy = u_xlat0.xy * _DSTex_ST.xy + _DSTex_ST.zw;
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
uniform 	vec4 _CloudGroupCol;
uniform 	vec4 _CloudPos0;
uniform 	vec4 _CloudPos1;
uniform 	vec4 _CloudPos2;
uniform 	vec4 _CloudPos3;
uniform 	vec4 _CloudPos4;
uniform 	vec4 _CloudPos5;
uniform 	vec4 _CloudPos6;
uniform 	vec4 _CloudPos7;
uniform 	vec4 _CloudPos8;
uniform 	vec4 _CloudPos9;
uniform 	vec4 _DData0;
uniform 	vec4 _DData1;
uniform 	vec4 _DData2;
uniform 	vec4 _DData3;
uniform 	vec4 _DData4;
uniform 	vec4 _DData5;
uniform 	vec4 _DData6;
uniform 	vec4 _DData7;
uniform 	vec4 _DData8;
uniform 	vec4 _DData9;
uniform 	vec4 _DSTex_ST;
uniform 	vec4 _DSData0;
uniform 	vec4 _DSData1;
uniform 	vec4 _DSData2;
uniform 	vec4 _DSData3;
uniform 	vec4 _DSData4;
uniform 	vec4 _DSData5;
uniform 	vec4 _DSData6;
uniform 	vec4 _DSData7;
uniform 	vec4 _DSData8;
uniform 	vec4 _DSData9;
uniform 	vec4 _DsEdgeC;
uniform 	float _DsEdgeRange;
uniform 	float _DsEdgeMul;
UNITY_LOCATION(0) uniform mediump sampler2D _DTex;
UNITY_LOCATION(1) uniform mediump sampler2D _CloudTex;
UNITY_LOCATION(2) uniform mediump sampler2D _DSTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
layout(location = 0) out highp vec4 SV_Target0;
vec2 u_xlat0;
mediump float u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec2 u_xlat2;
vec2 u_xlat3;
mediump float u_xlat16_3;
vec2 u_xlat4;
vec2 u_xlat6;
mediump vec2 u_xlat16_6;
float u_xlat9;
mediump float u_xlat16_9;
void main()
{
    u_xlat0.xy = _DSData0.ww * vec2(1.0, -1.0) + vs_TEXCOORD2.xy;
    u_xlat6.xy = _CloudPos0.xy * _DSTex_ST.xy;
    u_xlat0.xy = u_xlat0.xy * _CloudPos0.zw + u_xlat6.xy;
    u_xlat6.xy = _DData0.xy * _Time.yy + vs_TEXCOORD1.xy;
    u_xlat16_6.xy = texture(_DTex, u_xlat6.xy).xy;
    u_xlat1.x = _DData0.z * 0.5;
    u_xlat0.xy = u_xlat16_6.xy * u_xlat1.xx + u_xlat0.xy;
    u_xlat16_0 = texture(_DSTex, u_xlat0.xy).x;
    u_xlat0.x = u_xlat16_0 + (-_DSData0.z);
    u_xlat0.x = (-u_xlat0.x) + _DsEdgeRange;
    u_xlat0.x = max(u_xlat0.x, 0.0);
    u_xlat0.x = u_xlat0.x * _DsEdgeMul;
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat4.xy = vs_TEXCOORD0.xy + vec2(-0.5, -0.5);
    u_xlat2.xy = u_xlat4.xy * _CloudPos0.zw + _CloudPos0.xy;
    u_xlat3.xy = u_xlat16_6.xy * u_xlat1.xx + u_xlat2.xy;
    u_xlat3.xy = u_xlat3.xy + vec2(0.5, 0.5);
    u_xlat16_3 = texture(_CloudTex, u_xlat3.xy).w;
    u_xlat6.x = (-u_xlat16_3) + (-_DsEdgeC.w);
    u_xlat0.x = u_xlat0.x * u_xlat6.x + u_xlat16_3;
#ifdef UNITY_ADRENO_ES3
    u_xlat0.x = min(max(u_xlat0.x, 0.0), 1.0);
#else
    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
#endif
    u_xlat3.xy = _DSData1.ww * vec2(1.0, -1.0) + vs_TEXCOORD2.xy;
    u_xlat1.xw = _CloudPos1.xy * _DSTex_ST.xy;
    u_xlat3.xy = u_xlat3.xy * _CloudPos1.zw + u_xlat1.xw;
    u_xlat1.xw = _DData1.xy * _Time.yy + vs_TEXCOORD1.xy;
    u_xlat16_1.xw = texture(_DTex, u_xlat1.xw).xy;
    u_xlat9 = _DData1.z * 0.5;
    u_xlat3.xy = u_xlat16_1.xw * vec2(u_xlat9) + u_xlat3.xy;
    u_xlat16_3 = texture(_DSTex, u_xlat3.xy).x;
    u_xlat3.x = u_xlat16_3 + (-_DSData1.z);
    u_xlat3.x = (-u_xlat3.x) + _DsEdgeRange;
    u_xlat3.x = max(u_xlat3.x, 0.0);
    u_xlat3.x = u_xlat3.x * _DsEdgeMul;
    u_xlat3.x = min(u_xlat3.x, 1.0);
    u_xlat2.xy = u_xlat4.xy * _CloudPos1.zw + _CloudPos1.xy;
    u_xlat6.xy = u_xlat16_1.xw * vec2(u_xlat9) + u_xlat2.xy;
    u_xlat6.xy = u_xlat6.xy + vec2(0.5, 0.5);
    u_xlat16_6.x = texture(_CloudTex, u_xlat6.xy).w;
    u_xlat9 = (-u_xlat16_6.x) + (-_DsEdgeC.w);
    u_xlat3.x = u_xlat3.x * u_xlat9 + u_xlat16_6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat3.x + u_xlat0.x;
    u_xlat3.xy = _DSData2.ww * vec2(1.0, -1.0) + vs_TEXCOORD2.xy;
    u_xlat1.xw = _CloudPos2.xy * _DSTex_ST.xy;
    u_xlat3.xy = u_xlat3.xy * _CloudPos2.zw + u_xlat1.xw;
    u_xlat1.xw = _DData2.xy * _Time.yy + vs_TEXCOORD1.xy;
    u_xlat16_1.xw = texture(_DTex, u_xlat1.xw).xy;
    u_xlat9 = _DData2.z * 0.5;
    u_xlat3.xy = u_xlat16_1.xw * vec2(u_xlat9) + u_xlat3.xy;
    u_xlat16_3 = texture(_DSTex, u_xlat3.xy).x;
    u_xlat3.x = u_xlat16_3 + (-_DSData2.z);
    u_xlat3.x = (-u_xlat3.x) + _DsEdgeRange;
    u_xlat3.x = max(u_xlat3.x, 0.0);
    u_xlat3.x = u_xlat3.x * _DsEdgeMul;
    u_xlat3.x = min(u_xlat3.x, 1.0);
    u_xlat2.xy = u_xlat4.xy * _CloudPos2.zw + _CloudPos2.xy;
    u_xlat6.xy = u_xlat16_1.xw * vec2(u_xlat9) + u_xlat2.xy;
    u_xlat6.xy = u_xlat6.xy + vec2(0.5, 0.5);
    u_xlat16_6.x = texture(_CloudTex, u_xlat6.xy).w;
    u_xlat9 = (-u_xlat16_6.x) + (-_DsEdgeC.w);
    u_xlat3.x = u_xlat3.x * u_xlat9 + u_xlat16_6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat3.x + u_xlat0.x;
    u_xlat3.xy = _DSData3.ww * vec2(1.0, -1.0) + vs_TEXCOORD2.xy;
    u_xlat1.xw = _CloudPos3.xy * _DSTex_ST.xy;
    u_xlat3.xy = u_xlat3.xy * _CloudPos3.zw + u_xlat1.xw;
    u_xlat1.xw = _DData3.xy * _Time.yy + vs_TEXCOORD1.xy;
    u_xlat16_1.xw = texture(_DTex, u_xlat1.xw).xy;
    u_xlat9 = _DData3.z * 0.5;
    u_xlat3.xy = u_xlat16_1.xw * vec2(u_xlat9) + u_xlat3.xy;
    u_xlat16_3 = texture(_DSTex, u_xlat3.xy).x;
    u_xlat3.x = u_xlat16_3 + (-_DSData3.z);
    u_xlat3.x = (-u_xlat3.x) + _DsEdgeRange;
    u_xlat3.x = max(u_xlat3.x, 0.0);
    u_xlat3.x = u_xlat3.x * _DsEdgeMul;
    u_xlat3.x = min(u_xlat3.x, 1.0);
    u_xlat2.xy = u_xlat4.xy * _CloudPos3.zw + _CloudPos3.xy;
    u_xlat6.xy = u_xlat16_1.xw * vec2(u_xlat9) + u_xlat2.xy;
    u_xlat6.xy = u_xlat6.xy + vec2(0.5, 0.5);
    u_xlat16_6.x = texture(_CloudTex, u_xlat6.xy).w;
    u_xlat9 = (-u_xlat16_6.x) + (-_DsEdgeC.w);
    u_xlat3.x = u_xlat3.x * u_xlat9 + u_xlat16_6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat3.x + u_xlat0.x;
    u_xlat3.xy = _DSData4.ww * vec2(1.0, -1.0) + vs_TEXCOORD2.xy;
    u_xlat1.xw = _CloudPos4.xy * _DSTex_ST.xy;
    u_xlat3.xy = u_xlat3.xy * _CloudPos4.zw + u_xlat1.xw;
    u_xlat1.xw = _DData4.xy * _Time.yy + vs_TEXCOORD1.xy;
    u_xlat16_1.xw = texture(_DTex, u_xlat1.xw).xy;
    u_xlat9 = _DData4.z * 0.5;
    u_xlat3.xy = u_xlat16_1.xw * vec2(u_xlat9) + u_xlat3.xy;
    u_xlat16_3 = texture(_DSTex, u_xlat3.xy).x;
    u_xlat3.x = u_xlat16_3 + (-_DSData4.z);
    u_xlat3.x = (-u_xlat3.x) + _DsEdgeRange;
    u_xlat3.x = max(u_xlat3.x, 0.0);
    u_xlat3.x = u_xlat3.x * _DsEdgeMul;
    u_xlat3.x = min(u_xlat3.x, 1.0);
    u_xlat2.xy = u_xlat4.xy * _CloudPos4.zw + _CloudPos4.xy;
    u_xlat6.xy = u_xlat16_1.xw * vec2(u_xlat9) + u_xlat2.xy;
    u_xlat6.xy = u_xlat6.xy + vec2(0.5, 0.5);
    u_xlat16_6.x = texture(_CloudTex, u_xlat6.xy).w;
    u_xlat9 = (-u_xlat16_6.x) + (-_DsEdgeC.w);
    u_xlat3.x = u_xlat3.x * u_xlat9 + u_xlat16_6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat3.x + u_xlat0.x;
    u_xlat3.xy = _DSData5.ww * vec2(1.0, -1.0) + vs_TEXCOORD2.xy;
    u_xlat1.xw = _CloudPos5.xy * _DSTex_ST.xy;
    u_xlat3.xy = u_xlat3.xy * _CloudPos5.zw + u_xlat1.xw;
    u_xlat1.xw = _DData5.xy * _Time.yy + vs_TEXCOORD1.xy;
    u_xlat16_1.xw = texture(_DTex, u_xlat1.xw).xy;
    u_xlat9 = _DData5.z * 0.5;
    u_xlat3.xy = u_xlat16_1.xw * vec2(u_xlat9) + u_xlat3.xy;
    u_xlat16_3 = texture(_DSTex, u_xlat3.xy).x;
    u_xlat3.x = u_xlat16_3 + (-_DSData5.z);
    u_xlat3.x = (-u_xlat3.x) + _DsEdgeRange;
    u_xlat3.x = max(u_xlat3.x, 0.0);
    u_xlat3.x = u_xlat3.x * _DsEdgeMul;
    u_xlat3.x = min(u_xlat3.x, 1.0);
    u_xlat2.xy = u_xlat4.xy * _CloudPos5.zw + _CloudPos5.xy;
    u_xlat6.xy = u_xlat16_1.xw * vec2(u_xlat9) + u_xlat2.xy;
    u_xlat6.xy = u_xlat6.xy + vec2(0.5, 0.5);
    u_xlat16_6.x = texture(_CloudTex, u_xlat6.xy).w;
    u_xlat9 = (-u_xlat16_6.x) + (-_DsEdgeC.w);
    u_xlat3.x = u_xlat3.x * u_xlat9 + u_xlat16_6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat3.x + u_xlat0.x;
    u_xlat3.xy = _DSData6.ww * vec2(1.0, -1.0) + vs_TEXCOORD2.xy;
    u_xlat1.xw = _CloudPos6.xy * _DSTex_ST.xy;
    u_xlat3.xy = u_xlat3.xy * _CloudPos6.zw + u_xlat1.xw;
    u_xlat1.xw = _DData6.xy * _Time.yy + vs_TEXCOORD1.xy;
    u_xlat16_1.xw = texture(_DTex, u_xlat1.xw).xy;
    u_xlat9 = _DData6.z * 0.5;
    u_xlat3.xy = u_xlat16_1.xw * vec2(u_xlat9) + u_xlat3.xy;
    u_xlat16_3 = texture(_DSTex, u_xlat3.xy).x;
    u_xlat3.x = u_xlat16_3 + (-_DSData6.z);
    u_xlat3.x = (-u_xlat3.x) + _DsEdgeRange;
    u_xlat3.x = max(u_xlat3.x, 0.0);
    u_xlat3.x = u_xlat3.x * _DsEdgeMul;
    u_xlat3.x = min(u_xlat3.x, 1.0);
    u_xlat2.xy = u_xlat4.xy * _CloudPos6.zw + _CloudPos6.xy;
    u_xlat6.xy = u_xlat16_1.xw * vec2(u_xlat9) + u_xlat2.xy;
    u_xlat6.xy = u_xlat6.xy + vec2(0.5, 0.5);
    u_xlat16_6.x = texture(_CloudTex, u_xlat6.xy).w;
    u_xlat9 = (-u_xlat16_6.x) + (-_DsEdgeC.w);
    u_xlat3.x = u_xlat3.x * u_xlat9 + u_xlat16_6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat3.x + u_xlat0.x;
    u_xlat3.xy = _DSData7.ww * vec2(1.0, -1.0) + vs_TEXCOORD2.xy;
    u_xlat1.xw = _CloudPos7.xy * _DSTex_ST.xy;
    u_xlat3.xy = u_xlat3.xy * _CloudPos7.zw + u_xlat1.xw;
    u_xlat1.xw = _DData7.xy * _Time.yy + vs_TEXCOORD1.xy;
    u_xlat16_1.xw = texture(_DTex, u_xlat1.xw).xy;
    u_xlat9 = _DData7.z * 0.5;
    u_xlat3.xy = u_xlat16_1.xw * vec2(u_xlat9) + u_xlat3.xy;
    u_xlat16_3 = texture(_DSTex, u_xlat3.xy).x;
    u_xlat3.x = u_xlat16_3 + (-_DSData7.z);
    u_xlat3.x = (-u_xlat3.x) + _DsEdgeRange;
    u_xlat3.x = max(u_xlat3.x, 0.0);
    u_xlat3.x = u_xlat3.x * _DsEdgeMul;
    u_xlat3.x = min(u_xlat3.x, 1.0);
    u_xlat2.xy = u_xlat4.xy * _CloudPos7.zw + _CloudPos7.xy;
    u_xlat6.xy = u_xlat16_1.xw * vec2(u_xlat9) + u_xlat2.xy;
    u_xlat6.xy = u_xlat6.xy + vec2(0.5, 0.5);
    u_xlat16_6.x = texture(_CloudTex, u_xlat6.xy).w;
    u_xlat9 = (-u_xlat16_6.x) + (-_DsEdgeC.w);
    u_xlat3.x = u_xlat3.x * u_xlat9 + u_xlat16_6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat3.x + u_xlat0.x;
    u_xlat3.xy = _DSData8.ww * vec2(1.0, -1.0) + vs_TEXCOORD2.xy;
    u_xlat1.xw = _CloudPos8.xy * _DSTex_ST.xy;
    u_xlat3.xy = u_xlat3.xy * _CloudPos8.zw + u_xlat1.xw;
    u_xlat1.xw = _DData8.xy * _Time.yy + vs_TEXCOORD1.xy;
    u_xlat16_1.xw = texture(_DTex, u_xlat1.xw).xy;
    u_xlat9 = _DData8.z * 0.5;
    u_xlat3.xy = u_xlat16_1.xw * vec2(u_xlat9) + u_xlat3.xy;
    u_xlat16_3 = texture(_DSTex, u_xlat3.xy).x;
    u_xlat3.x = u_xlat16_3 + (-_DSData8.z);
    u_xlat3.x = (-u_xlat3.x) + _DsEdgeRange;
    u_xlat3.x = max(u_xlat3.x, 0.0);
    u_xlat3.x = u_xlat3.x * _DsEdgeMul;
    u_xlat3.x = min(u_xlat3.x, 1.0);
    u_xlat2.xy = u_xlat4.xy * _CloudPos8.zw + _CloudPos8.xy;
    u_xlat4.xy = u_xlat4.xy * _CloudPos9.zw + _CloudPos9.xy;
    u_xlat6.xy = u_xlat16_1.xw * vec2(u_xlat9) + u_xlat2.xy;
    u_xlat6.xy = u_xlat6.xy + vec2(0.5, 0.5);
    u_xlat16_6.x = texture(_CloudTex, u_xlat6.xy).w;
    u_xlat9 = (-u_xlat16_6.x) + (-_DsEdgeC.w);
    u_xlat3.x = u_xlat3.x * u_xlat9 + u_xlat16_6.x;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat3.x + u_xlat0.x;
    u_xlat3.xy = _DSData9.ww * vec2(1.0, -1.0) + vs_TEXCOORD2.xy;
    u_xlat1.xw = _CloudPos9.xy * _DSTex_ST.xy;
    u_xlat3.xy = u_xlat3.xy * _CloudPos9.zw + u_xlat1.xw;
    u_xlat1.xw = _DData9.xy * _Time.yy + vs_TEXCOORD1.xy;
    u_xlat16_1.xw = texture(_DTex, u_xlat1.xw).xy;
    u_xlat9 = _DData9.z * 0.5;
    u_xlat3.xy = u_xlat16_1.xw * vec2(u_xlat9) + u_xlat3.xy;
    u_xlat1.xy = u_xlat16_1.xw * vec2(u_xlat9) + u_xlat4.xy;
    u_xlat1.xy = u_xlat1.xy + vec2(0.5, 0.5);
    u_xlat16_9 = texture(_CloudTex, u_xlat1.xy).w;
    u_xlat16_3 = texture(_DSTex, u_xlat3.xy).x;
    u_xlat3.x = u_xlat16_3 + (-_DSData9.z);
    u_xlat3.x = (-u_xlat3.x) + _DsEdgeRange;
    u_xlat3.x = max(u_xlat3.x, 0.0);
    u_xlat3.x = u_xlat3.x * _DsEdgeMul;
    u_xlat3.x = min(u_xlat3.x, 1.0);
    u_xlat6.x = (-u_xlat16_9) + (-_DsEdgeC.w);
    u_xlat3.x = u_xlat3.x * u_xlat6.x + u_xlat16_9;
#ifdef UNITY_ADRENO_ES3
    u_xlat3.x = min(max(u_xlat3.x, 0.0), 1.0);
#else
    u_xlat3.x = clamp(u_xlat3.x, 0.0, 1.0);
#endif
    u_xlat0.x = u_xlat3.x + u_xlat0.x;
    u_xlat0.x = min(u_xlat0.x, 1.0);
    u_xlat3.x = (-_CloudGroupCol.w) + 1.0;
    SV_Target0.w = (-u_xlat0.x) * u_xlat3.x + u_xlat0.x;
    SV_Target0.xyz = _CloudGroupCol.xyz;
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