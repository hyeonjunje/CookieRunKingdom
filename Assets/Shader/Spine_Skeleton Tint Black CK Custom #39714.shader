//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Spine/Skeleton Tint Black CK Custom" {
Properties {
[Enum(Off, 0, On, 1)] _Zwrite ("ZWrite", Float) = 0
[Toggle(_USE_CUTOFF)] _UseCutoff ("Use Cutoff", Float) = 0
_Cutoff ("Depth alpha cutoff", Range(0, 1)) = 0.1
[Toggle(_STRAIGHT_ALPHA_INPUT)] _StraightAlphaInput ("Straight Alpha Texture", Float) = 0
_Color ("Tint Color", Color) = (1,1,1,1)
_Black ("Black Point", Color) = (0,0,0,0)
[Toggle(GRAYSCALE)] _Gray ("GrayScale", Float) = 0
_MainTex ("MainTex", 2D) = "black" { }
_MaskTex ("MaskingTex", 2D) = "black" { }
_SubTex ("SubTex", 2D) = "black" { }
_SubTexMix ("SubTex Mix", Range(0, 1)) = 0
_SubTexScrollX ("SubTex Scroll X", Range(-10, 10)) = 0
_SubTexScrollY ("SubTex Scroll Y", Range(-10, 10)) = 0
_SubTexCol ("SubTex Color", Color) = (1,1,1,1)
_DistTex ("DistortionTex", 2D) = "black" { }
_Distortion ("Distortion", Range(0, 1)) = 0
_SubTexDistortion ("SubTex Distortion", Range(0, 1)) = 0
_DistScrollX ("Distortion Scroll X", Range(-10, 10)) = 0
_DistScrollY ("Distortion Scroll Y", Range(-10, 10)) = 0
_AdditiveColor ("Additive Color", Color) = (0,0,0,0)
_GlobalAdditiveIntensity ("Global Additive Intensity", Float) = 0
_GlobalAdditiveMixParameter ("Global Additive Mix Parameter", Float) = 0
}
SubShader {
 LOD 100
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Blend One OneMinusSrcAlpha, One OneMinusSrcAlpha
  ZWrite Off
  Cull Off
  Fog {
   Mode Off
  }
  GpuProgramID 1150
Program "vp" {
SubProgram "gles hw_tier00 " {
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec2 in_TEXCOORD1;
attribute highp vec2 in_TEXCOORD2;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD2.xy;
    u_xlat0.xyz = _Color.www * _Color.xyz;
    u_xlat0.w = _Color.w;
    vs_COLOR0 = u_xlat0 * in_COLOR0;
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
uniform 	vec4 _SubTex_ST;
uniform 	float _SubTexMix;
uniform 	float _SubTexScrollX;
uniform 	float _SubTexScrollY;
uniform 	vec4 _SubTexCol;
uniform 	vec4 _DistTex_ST;
uniform 	float _Distortion;
uniform 	float _SubTexDistortion;
uniform 	float _DistScrollX;
uniform 	float _DistScrollY;
uniform 	vec4 _Color;
uniform 	vec4 _Black;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
uniform 	float _GlobalAdditiveMixParameter;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _DistTex;
uniform lowp sampler2D _SubTex;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
float u_xlat4;
lowp vec3 u_xlat10_4;
vec2 u_xlat9;
float u_xlat12;
void main()
{
    u_xlat0.xy = _Time.yy * vec2(_DistScrollX, _DistScrollY);
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistTex_ST.xy + u_xlat0.xy;
    u_xlat10_0.xy = texture2D(_DistTex, u_xlat0.xy).xy;
    u_xlat1.x = u_xlat10_0.x + -0.5;
    u_xlat1.y = u_xlat10_0.y + _DistTex_ST.w;
    u_xlat0.x = u_xlat1.x + _DistTex_ST.z;
    u_xlat10_4.xyz = texture2D(_MaskTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.x = u_xlat10_4.y * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _SubTexDistortion;
    u_xlat9.xy = vs_TEXCOORD0.xy * _SubTex_ST.xy + u_xlat0.xx;
    u_xlat9.xy = vec2(_SubTexScrollX, _SubTexScrollY) * _Time.xx + u_xlat9.xy;
    u_xlat10_2 = texture2D(_SubTex, u_xlat9.xy);
    u_xlat3.x = _DistTex_ST.z;
    u_xlat3.y = -0.5;
    u_xlat1.xy = u_xlat1.xy + u_xlat3.xy;
    u_xlat0.xz = u_xlat10_4.yy * u_xlat1.xy;
    u_xlat0.xz = u_xlat0.xz * vec2(_Distortion) + vs_TEXCOORD0.xy;
    u_xlat10_1 = texture2D(_MainTex, u_xlat0.xz);
    u_xlat2 = u_xlat10_2 * _SubTexCol + (-u_xlat10_1);
    u_xlat0.x = u_xlat10_4.x * _SubTexMix;
    u_xlat4 = (-u_xlat10_4.z) + 1.0;
    u_xlat2 = u_xlat0.xxxx * u_xlat2 + u_xlat10_1;
    u_xlat0.x = u_xlat10_1.w * _Color.w;
    u_xlat1.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat3.xy = vs_TEXCOORD1.xy;
    u_xlat3.z = vs_TEXCOORD2.x;
    u_xlat3.xyz = u_xlat3.xyz + _Black.xyz;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xyz;
    u_xlat1.w = 0.0;
    u_xlat1 = u_xlat2 * vs_COLOR0 + u_xlat1;
    u_xlat1 = u_xlat0.xxxx * u_xlat1;
    u_xlat0.xzw = _GlobalAdditiveColor.www * _GlobalAdditiveColor.xyz;
    u_xlat0.xzw = u_xlat0.xzw * vec3(_GlobalAdditiveIntensity);
    u_xlat2.xyz = u_xlat1.xyz * vec3(u_xlat4) + (-u_xlat0.xzw);
    u_xlat1 = vec4(u_xlat4) * u_xlat1;
    u_xlat0.xyz = u_xlat1.www * u_xlat2.xyz + u_xlat0.xzw;
    u_xlat2.xyz = _GlobalAdditiveColor.xyz * u_xlat1.www + (-u_xlat1.xyz);
    u_xlat12 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
    u_xlat0.xyz = vec3(vec3(_GlobalAdditiveMixParameter, _GlobalAdditiveMixParameter, _GlobalAdditiveMixParameter)) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    SV_Target0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
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
uniform 	vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec2 in_TEXCOORD1;
attribute highp vec2 in_TEXCOORD2;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD2.xy;
    u_xlat0.xyz = _Color.www * _Color.xyz;
    u_xlat0.w = _Color.w;
    vs_COLOR0 = u_xlat0 * in_COLOR0;
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
uniform 	vec4 _SubTex_ST;
uniform 	float _SubTexMix;
uniform 	float _SubTexScrollX;
uniform 	float _SubTexScrollY;
uniform 	vec4 _SubTexCol;
uniform 	vec4 _DistTex_ST;
uniform 	float _Distortion;
uniform 	float _SubTexDistortion;
uniform 	float _DistScrollX;
uniform 	float _DistScrollY;
uniform 	vec4 _Color;
uniform 	vec4 _Black;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
uniform 	float _GlobalAdditiveMixParameter;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _DistTex;
uniform lowp sampler2D _SubTex;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
float u_xlat4;
lowp vec3 u_xlat10_4;
vec2 u_xlat9;
float u_xlat12;
void main()
{
    u_xlat0.xy = _Time.yy * vec2(_DistScrollX, _DistScrollY);
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistTex_ST.xy + u_xlat0.xy;
    u_xlat10_0.xy = texture2D(_DistTex, u_xlat0.xy).xy;
    u_xlat1.x = u_xlat10_0.x + -0.5;
    u_xlat1.y = u_xlat10_0.y + _DistTex_ST.w;
    u_xlat0.x = u_xlat1.x + _DistTex_ST.z;
    u_xlat10_4.xyz = texture2D(_MaskTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.x = u_xlat10_4.y * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _SubTexDistortion;
    u_xlat9.xy = vs_TEXCOORD0.xy * _SubTex_ST.xy + u_xlat0.xx;
    u_xlat9.xy = vec2(_SubTexScrollX, _SubTexScrollY) * _Time.xx + u_xlat9.xy;
    u_xlat10_2 = texture2D(_SubTex, u_xlat9.xy);
    u_xlat3.x = _DistTex_ST.z;
    u_xlat3.y = -0.5;
    u_xlat1.xy = u_xlat1.xy + u_xlat3.xy;
    u_xlat0.xz = u_xlat10_4.yy * u_xlat1.xy;
    u_xlat0.xz = u_xlat0.xz * vec2(_Distortion) + vs_TEXCOORD0.xy;
    u_xlat10_1 = texture2D(_MainTex, u_xlat0.xz);
    u_xlat2 = u_xlat10_2 * _SubTexCol + (-u_xlat10_1);
    u_xlat0.x = u_xlat10_4.x * _SubTexMix;
    u_xlat4 = (-u_xlat10_4.z) + 1.0;
    u_xlat2 = u_xlat0.xxxx * u_xlat2 + u_xlat10_1;
    u_xlat0.x = u_xlat10_1.w * _Color.w;
    u_xlat1.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat3.xy = vs_TEXCOORD1.xy;
    u_xlat3.z = vs_TEXCOORD2.x;
    u_xlat3.xyz = u_xlat3.xyz + _Black.xyz;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xyz;
    u_xlat1.w = 0.0;
    u_xlat1 = u_xlat2 * vs_COLOR0 + u_xlat1;
    u_xlat1 = u_xlat0.xxxx * u_xlat1;
    u_xlat0.xzw = _GlobalAdditiveColor.www * _GlobalAdditiveColor.xyz;
    u_xlat0.xzw = u_xlat0.xzw * vec3(_GlobalAdditiveIntensity);
    u_xlat2.xyz = u_xlat1.xyz * vec3(u_xlat4) + (-u_xlat0.xzw);
    u_xlat1 = vec4(u_xlat4) * u_xlat1;
    u_xlat0.xyz = u_xlat1.www * u_xlat2.xyz + u_xlat0.xzw;
    u_xlat2.xyz = _GlobalAdditiveColor.xyz * u_xlat1.www + (-u_xlat1.xyz);
    u_xlat12 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
    u_xlat0.xyz = vec3(vec3(_GlobalAdditiveMixParameter, _GlobalAdditiveMixParameter, _GlobalAdditiveMixParameter)) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    SV_Target0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
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
uniform 	vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec2 in_TEXCOORD1;
attribute highp vec2 in_TEXCOORD2;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD2.xy;
    u_xlat0.xyz = _Color.www * _Color.xyz;
    u_xlat0.w = _Color.w;
    vs_COLOR0 = u_xlat0 * in_COLOR0;
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
uniform 	vec4 _SubTex_ST;
uniform 	float _SubTexMix;
uniform 	float _SubTexScrollX;
uniform 	float _SubTexScrollY;
uniform 	vec4 _SubTexCol;
uniform 	vec4 _DistTex_ST;
uniform 	float _Distortion;
uniform 	float _SubTexDistortion;
uniform 	float _DistScrollX;
uniform 	float _DistScrollY;
uniform 	vec4 _Color;
uniform 	vec4 _Black;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
uniform 	float _GlobalAdditiveMixParameter;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _DistTex;
uniform lowp sampler2D _SubTex;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
float u_xlat4;
lowp vec3 u_xlat10_4;
vec2 u_xlat9;
float u_xlat12;
void main()
{
    u_xlat0.xy = _Time.yy * vec2(_DistScrollX, _DistScrollY);
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistTex_ST.xy + u_xlat0.xy;
    u_xlat10_0.xy = texture2D(_DistTex, u_xlat0.xy).xy;
    u_xlat1.x = u_xlat10_0.x + -0.5;
    u_xlat1.y = u_xlat10_0.y + _DistTex_ST.w;
    u_xlat0.x = u_xlat1.x + _DistTex_ST.z;
    u_xlat10_4.xyz = texture2D(_MaskTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.x = u_xlat10_4.y * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _SubTexDistortion;
    u_xlat9.xy = vs_TEXCOORD0.xy * _SubTex_ST.xy + u_xlat0.xx;
    u_xlat9.xy = vec2(_SubTexScrollX, _SubTexScrollY) * _Time.xx + u_xlat9.xy;
    u_xlat10_2 = texture2D(_SubTex, u_xlat9.xy);
    u_xlat3.x = _DistTex_ST.z;
    u_xlat3.y = -0.5;
    u_xlat1.xy = u_xlat1.xy + u_xlat3.xy;
    u_xlat0.xz = u_xlat10_4.yy * u_xlat1.xy;
    u_xlat0.xz = u_xlat0.xz * vec2(_Distortion) + vs_TEXCOORD0.xy;
    u_xlat10_1 = texture2D(_MainTex, u_xlat0.xz);
    u_xlat2 = u_xlat10_2 * _SubTexCol + (-u_xlat10_1);
    u_xlat0.x = u_xlat10_4.x * _SubTexMix;
    u_xlat4 = (-u_xlat10_4.z) + 1.0;
    u_xlat2 = u_xlat0.xxxx * u_xlat2 + u_xlat10_1;
    u_xlat0.x = u_xlat10_1.w * _Color.w;
    u_xlat1.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat3.xy = vs_TEXCOORD1.xy;
    u_xlat3.z = vs_TEXCOORD2.x;
    u_xlat3.xyz = u_xlat3.xyz + _Black.xyz;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xyz;
    u_xlat1.w = 0.0;
    u_xlat1 = u_xlat2 * vs_COLOR0 + u_xlat1;
    u_xlat1 = u_xlat0.xxxx * u_xlat1;
    u_xlat0.xzw = _GlobalAdditiveColor.www * _GlobalAdditiveColor.xyz;
    u_xlat0.xzw = u_xlat0.xzw * vec3(_GlobalAdditiveIntensity);
    u_xlat2.xyz = u_xlat1.xyz * vec3(u_xlat4) + (-u_xlat0.xzw);
    u_xlat1 = vec4(u_xlat4) * u_xlat1;
    u_xlat0.xyz = u_xlat1.www * u_xlat2.xyz + u_xlat0.xzw;
    u_xlat2.xyz = _GlobalAdditiveColor.xyz * u_xlat1.www + (-u_xlat1.xyz);
    u_xlat12 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
    u_xlat0.xyz = vec3(vec3(_GlobalAdditiveMixParameter, _GlobalAdditiveMixParameter, _GlobalAdditiveMixParameter)) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    SV_Target0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
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
uniform 	vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD2.xy;
    u_xlat0.xyz = _Color.www * _Color.xyz;
    u_xlat0.w = _Color.w;
    vs_COLOR0 = u_xlat0 * in_COLOR0;
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
uniform 	vec4 _SubTex_ST;
uniform 	float _SubTexMix;
uniform 	float _SubTexScrollX;
uniform 	float _SubTexScrollY;
uniform 	vec4 _SubTexCol;
uniform 	vec4 _DistTex_ST;
uniform 	float _Distortion;
uniform 	float _SubTexDistortion;
uniform 	float _DistScrollX;
uniform 	float _DistScrollY;
uniform 	vec4 _Color;
uniform 	vec4 _Black;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
uniform 	float _GlobalAdditiveMixParameter;
UNITY_LOCATION(0) uniform mediump sampler2D _MaskTex;
UNITY_LOCATION(1) uniform mediump sampler2D _DistTex;
UNITY_LOCATION(2) uniform mediump sampler2D _SubTex;
UNITY_LOCATION(3) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
float u_xlat4;
mediump vec3 u_xlat16_4;
vec2 u_xlat9;
float u_xlat12;
void main()
{
    u_xlat0.xy = _Time.yy * vec2(_DistScrollX, _DistScrollY);
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistTex_ST.xy + u_xlat0.xy;
    u_xlat16_0.xy = texture(_DistTex, u_xlat0.xy).xy;
    u_xlat1.x = u_xlat16_0.x + -0.5;
    u_xlat1.y = u_xlat16_0.y + _DistTex_ST.w;
    u_xlat0.x = u_xlat1.x + _DistTex_ST.z;
    u_xlat16_4.xyz = texture(_MaskTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.x = u_xlat16_4.y * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _SubTexDistortion;
    u_xlat9.xy = vs_TEXCOORD0.xy * _SubTex_ST.xy + u_xlat0.xx;
    u_xlat9.xy = vec2(_SubTexScrollX, _SubTexScrollY) * _Time.xx + u_xlat9.xy;
    u_xlat16_2 = texture(_SubTex, u_xlat9.xy);
    u_xlat3.x = _DistTex_ST.z;
    u_xlat3.y = -0.5;
    u_xlat1.xy = u_xlat1.xy + u_xlat3.xy;
    u_xlat0.xz = u_xlat16_4.yy * u_xlat1.xy;
    u_xlat0.xz = u_xlat0.xz * vec2(_Distortion) + vs_TEXCOORD0.xy;
    u_xlat16_1 = texture(_MainTex, u_xlat0.xz);
    u_xlat2 = u_xlat16_2 * _SubTexCol + (-u_xlat16_1);
    u_xlat0.x = u_xlat16_4.x * _SubTexMix;
    u_xlat4 = (-u_xlat16_4.z) + 1.0;
    u_xlat2 = u_xlat0.xxxx * u_xlat2 + u_xlat16_1;
    u_xlat0.x = u_xlat16_1.w * _Color.w;
    u_xlat1.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat3.xy = vs_TEXCOORD1.xy;
    u_xlat3.z = vs_TEXCOORD2.x;
    u_xlat3.xyz = u_xlat3.xyz + _Black.xyz;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xyz;
    u_xlat1.w = 0.0;
    u_xlat1 = u_xlat2 * vs_COLOR0 + u_xlat1;
    u_xlat1 = u_xlat0.xxxx * u_xlat1;
    u_xlat0.xzw = _GlobalAdditiveColor.www * _GlobalAdditiveColor.xyz;
    u_xlat0.xzw = u_xlat0.xzw * vec3(_GlobalAdditiveIntensity);
    u_xlat2.xyz = u_xlat1.xyz * vec3(u_xlat4) + (-u_xlat0.xzw);
    u_xlat1 = vec4(u_xlat4) * u_xlat1;
    u_xlat0.xyz = u_xlat1.www * u_xlat2.xyz + u_xlat0.xzw;
    u_xlat2.xyz = _GlobalAdditiveColor.xyz * u_xlat1.www + (-u_xlat1.xyz);
    u_xlat12 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
    u_xlat0.xyz = vec3(vec3(_GlobalAdditiveMixParameter, _GlobalAdditiveMixParameter, _GlobalAdditiveMixParameter)) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    SV_Target0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
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
uniform 	vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD2.xy;
    u_xlat0.xyz = _Color.www * _Color.xyz;
    u_xlat0.w = _Color.w;
    vs_COLOR0 = u_xlat0 * in_COLOR0;
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
uniform 	vec4 _SubTex_ST;
uniform 	float _SubTexMix;
uniform 	float _SubTexScrollX;
uniform 	float _SubTexScrollY;
uniform 	vec4 _SubTexCol;
uniform 	vec4 _DistTex_ST;
uniform 	float _Distortion;
uniform 	float _SubTexDistortion;
uniform 	float _DistScrollX;
uniform 	float _DistScrollY;
uniform 	vec4 _Color;
uniform 	vec4 _Black;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
uniform 	float _GlobalAdditiveMixParameter;
UNITY_LOCATION(0) uniform mediump sampler2D _MaskTex;
UNITY_LOCATION(1) uniform mediump sampler2D _DistTex;
UNITY_LOCATION(2) uniform mediump sampler2D _SubTex;
UNITY_LOCATION(3) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
float u_xlat4;
mediump vec3 u_xlat16_4;
vec2 u_xlat9;
float u_xlat12;
void main()
{
    u_xlat0.xy = _Time.yy * vec2(_DistScrollX, _DistScrollY);
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistTex_ST.xy + u_xlat0.xy;
    u_xlat16_0.xy = texture(_DistTex, u_xlat0.xy).xy;
    u_xlat1.x = u_xlat16_0.x + -0.5;
    u_xlat1.y = u_xlat16_0.y + _DistTex_ST.w;
    u_xlat0.x = u_xlat1.x + _DistTex_ST.z;
    u_xlat16_4.xyz = texture(_MaskTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.x = u_xlat16_4.y * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _SubTexDistortion;
    u_xlat9.xy = vs_TEXCOORD0.xy * _SubTex_ST.xy + u_xlat0.xx;
    u_xlat9.xy = vec2(_SubTexScrollX, _SubTexScrollY) * _Time.xx + u_xlat9.xy;
    u_xlat16_2 = texture(_SubTex, u_xlat9.xy);
    u_xlat3.x = _DistTex_ST.z;
    u_xlat3.y = -0.5;
    u_xlat1.xy = u_xlat1.xy + u_xlat3.xy;
    u_xlat0.xz = u_xlat16_4.yy * u_xlat1.xy;
    u_xlat0.xz = u_xlat0.xz * vec2(_Distortion) + vs_TEXCOORD0.xy;
    u_xlat16_1 = texture(_MainTex, u_xlat0.xz);
    u_xlat2 = u_xlat16_2 * _SubTexCol + (-u_xlat16_1);
    u_xlat0.x = u_xlat16_4.x * _SubTexMix;
    u_xlat4 = (-u_xlat16_4.z) + 1.0;
    u_xlat2 = u_xlat0.xxxx * u_xlat2 + u_xlat16_1;
    u_xlat0.x = u_xlat16_1.w * _Color.w;
    u_xlat1.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat3.xy = vs_TEXCOORD1.xy;
    u_xlat3.z = vs_TEXCOORD2.x;
    u_xlat3.xyz = u_xlat3.xyz + _Black.xyz;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xyz;
    u_xlat1.w = 0.0;
    u_xlat1 = u_xlat2 * vs_COLOR0 + u_xlat1;
    u_xlat1 = u_xlat0.xxxx * u_xlat1;
    u_xlat0.xzw = _GlobalAdditiveColor.www * _GlobalAdditiveColor.xyz;
    u_xlat0.xzw = u_xlat0.xzw * vec3(_GlobalAdditiveIntensity);
    u_xlat2.xyz = u_xlat1.xyz * vec3(u_xlat4) + (-u_xlat0.xzw);
    u_xlat1 = vec4(u_xlat4) * u_xlat1;
    u_xlat0.xyz = u_xlat1.www * u_xlat2.xyz + u_xlat0.xzw;
    u_xlat2.xyz = _GlobalAdditiveColor.xyz * u_xlat1.www + (-u_xlat1.xyz);
    u_xlat12 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
    u_xlat0.xyz = vec3(vec3(_GlobalAdditiveMixParameter, _GlobalAdditiveMixParameter, _GlobalAdditiveMixParameter)) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    SV_Target0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
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
uniform 	vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD2.xy;
    u_xlat0.xyz = _Color.www * _Color.xyz;
    u_xlat0.w = _Color.w;
    vs_COLOR0 = u_xlat0 * in_COLOR0;
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
uniform 	vec4 _SubTex_ST;
uniform 	float _SubTexMix;
uniform 	float _SubTexScrollX;
uniform 	float _SubTexScrollY;
uniform 	vec4 _SubTexCol;
uniform 	vec4 _DistTex_ST;
uniform 	float _Distortion;
uniform 	float _SubTexDistortion;
uniform 	float _DistScrollX;
uniform 	float _DistScrollY;
uniform 	vec4 _Color;
uniform 	vec4 _Black;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
uniform 	float _GlobalAdditiveMixParameter;
UNITY_LOCATION(0) uniform mediump sampler2D _MaskTex;
UNITY_LOCATION(1) uniform mediump sampler2D _DistTex;
UNITY_LOCATION(2) uniform mediump sampler2D _SubTex;
UNITY_LOCATION(3) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
float u_xlat4;
mediump vec3 u_xlat16_4;
vec2 u_xlat9;
float u_xlat12;
void main()
{
    u_xlat0.xy = _Time.yy * vec2(_DistScrollX, _DistScrollY);
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistTex_ST.xy + u_xlat0.xy;
    u_xlat16_0.xy = texture(_DistTex, u_xlat0.xy).xy;
    u_xlat1.x = u_xlat16_0.x + -0.5;
    u_xlat1.y = u_xlat16_0.y + _DistTex_ST.w;
    u_xlat0.x = u_xlat1.x + _DistTex_ST.z;
    u_xlat16_4.xyz = texture(_MaskTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.x = u_xlat16_4.y * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _SubTexDistortion;
    u_xlat9.xy = vs_TEXCOORD0.xy * _SubTex_ST.xy + u_xlat0.xx;
    u_xlat9.xy = vec2(_SubTexScrollX, _SubTexScrollY) * _Time.xx + u_xlat9.xy;
    u_xlat16_2 = texture(_SubTex, u_xlat9.xy);
    u_xlat3.x = _DistTex_ST.z;
    u_xlat3.y = -0.5;
    u_xlat1.xy = u_xlat1.xy + u_xlat3.xy;
    u_xlat0.xz = u_xlat16_4.yy * u_xlat1.xy;
    u_xlat0.xz = u_xlat0.xz * vec2(_Distortion) + vs_TEXCOORD0.xy;
    u_xlat16_1 = texture(_MainTex, u_xlat0.xz);
    u_xlat2 = u_xlat16_2 * _SubTexCol + (-u_xlat16_1);
    u_xlat0.x = u_xlat16_4.x * _SubTexMix;
    u_xlat4 = (-u_xlat16_4.z) + 1.0;
    u_xlat2 = u_xlat0.xxxx * u_xlat2 + u_xlat16_1;
    u_xlat0.x = u_xlat16_1.w * _Color.w;
    u_xlat1.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat3.xy = vs_TEXCOORD1.xy;
    u_xlat3.z = vs_TEXCOORD2.x;
    u_xlat3.xyz = u_xlat3.xyz + _Black.xyz;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xyz;
    u_xlat1.w = 0.0;
    u_xlat1 = u_xlat2 * vs_COLOR0 + u_xlat1;
    u_xlat1 = u_xlat0.xxxx * u_xlat1;
    u_xlat0.xzw = _GlobalAdditiveColor.www * _GlobalAdditiveColor.xyz;
    u_xlat0.xzw = u_xlat0.xzw * vec3(_GlobalAdditiveIntensity);
    u_xlat2.xyz = u_xlat1.xyz * vec3(u_xlat4) + (-u_xlat0.xzw);
    u_xlat1 = vec4(u_xlat4) * u_xlat1;
    u_xlat0.xyz = u_xlat1.www * u_xlat2.xyz + u_xlat0.xzw;
    u_xlat2.xyz = _GlobalAdditiveColor.xyz * u_xlat1.www + (-u_xlat1.xyz);
    u_xlat12 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    u_xlat1.xyz = vec3(u_xlat12) * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.xyz + (-u_xlat1.xyz);
    u_xlat0.xyz = vec3(vec3(_GlobalAdditiveMixParameter, _GlobalAdditiveMixParameter, _GlobalAdditiveMixParameter)) * u_xlat0.xyz + u_xlat1.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat1.www + (-u_xlat0.xyz);
    SV_Target0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.w = u_xlat1.w;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_USE_CUTOFF" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec2 in_TEXCOORD1;
attribute highp vec2 in_TEXCOORD2;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD2.xy;
    u_xlat0.xyz = _Color.www * _Color.xyz;
    u_xlat0.w = _Color.w;
    vs_COLOR0 = u_xlat0 * in_COLOR0;
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
uniform 	vec4 _SubTex_ST;
uniform 	float _SubTexMix;
uniform 	float _SubTexScrollX;
uniform 	float _SubTexScrollY;
uniform 	vec4 _SubTexCol;
uniform 	vec4 _DistTex_ST;
uniform 	float _Distortion;
uniform 	float _SubTexDistortion;
uniform 	float _DistScrollX;
uniform 	float _DistScrollY;
uniform 	vec4 _Color;
uniform 	vec4 _Black;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
uniform 	float _GlobalAdditiveMixParameter;
uniform 	float _Cutoff;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _DistTex;
uniform lowp sampler2D _SubTex;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
float u_xlat5;
float u_xlat8;
float u_xlat13;
void main()
{
    u_xlat0.xy = _Time.yy * vec2(_DistScrollX, _DistScrollY);
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistTex_ST.xy + u_xlat0.xy;
    u_xlat10_0.xy = texture2D(_DistTex, u_xlat0.xy).xy;
    u_xlat1.y = u_xlat10_0.y + _DistTex_ST.w;
    u_xlat1.x = u_xlat10_0.x + -0.5;
    u_xlat0.x = _DistTex_ST.z;
    u_xlat0.y = -0.5;
    u_xlat0.xy = u_xlat0.xy + u_xlat1.xy;
    u_xlat8 = u_xlat1.x + _DistTex_ST.z;
    u_xlat10_1.xyz = texture2D(_MaskTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xy = u_xlat0.xy * u_xlat10_1.yy;
    u_xlat0.xy = u_xlat0.xy * vec2(_Distortion) + vs_TEXCOORD0.xy;
    u_xlat10_2 = texture2D(_MainTex, u_xlat0.xy);
    u_xlat0.x = u_xlat10_2.w * _Color.w + (-_Cutoff);
    u_xlatb0 = u_xlat0.x<0.0;
    if(u_xlatb0){discard;}
    u_xlat0.x = u_xlat8 * u_xlat10_1.y;
    u_xlat0.x = u_xlat0.x * _SubTexDistortion;
    u_xlat0.xy = vs_TEXCOORD0.xy * _SubTex_ST.xy + u_xlat0.xx;
    u_xlat0.xy = vec2(_SubTexScrollX, _SubTexScrollY) * _Time.xx + u_xlat0.xy;
    u_xlat10_0 = texture2D(_SubTex, u_xlat0.xy);
    u_xlat0 = u_xlat10_0 * _SubTexCol + (-u_xlat10_2);
    u_xlat1.x = u_xlat10_1.x * _SubTexMix;
    u_xlat5 = (-u_xlat10_1.z) + 1.0;
    u_xlat0 = u_xlat1.xxxx * u_xlat0 + u_xlat10_2;
    u_xlat1.x = u_xlat10_2.w * _Color.w;
    u_xlat2.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat3.xy = vs_TEXCOORD1.xy;
    u_xlat3.z = vs_TEXCOORD2.x;
    u_xlat3.xyz = u_xlat3.xyz + _Black.xyz;
    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.xyz;
    u_xlat2.w = 0.0;
    u_xlat0 = u_xlat0 * vs_COLOR0 + u_xlat2;
    u_xlat0 = u_xlat1.xxxx * u_xlat0;
    u_xlat1.xzw = _GlobalAdditiveColor.www * _GlobalAdditiveColor.xyz;
    u_xlat1.xzw = u_xlat1.xzw * vec3(_GlobalAdditiveIntensity);
    u_xlat2.xyz = u_xlat0.xyz * vec3(u_xlat5) + (-u_xlat1.xzw);
    u_xlat0 = vec4(u_xlat5) * u_xlat0;
    u_xlat1.xyz = u_xlat0.www * u_xlat2.xyz + u_xlat1.xzw;
    u_xlat2.xyz = _GlobalAdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    u_xlat13 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    u_xlat0.xyz = vec3(u_xlat13) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    u_xlat0.xyz = vec3(vec3(_GlobalAdditiveMixParameter, _GlobalAdditiveMixParameter, _GlobalAdditiveMixParameter)) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    SV_Target0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.w = u_xlat0.w;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_USE_CUTOFF" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec2 in_TEXCOORD1;
attribute highp vec2 in_TEXCOORD2;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD2.xy;
    u_xlat0.xyz = _Color.www * _Color.xyz;
    u_xlat0.w = _Color.w;
    vs_COLOR0 = u_xlat0 * in_COLOR0;
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
uniform 	vec4 _SubTex_ST;
uniform 	float _SubTexMix;
uniform 	float _SubTexScrollX;
uniform 	float _SubTexScrollY;
uniform 	vec4 _SubTexCol;
uniform 	vec4 _DistTex_ST;
uniform 	float _Distortion;
uniform 	float _SubTexDistortion;
uniform 	float _DistScrollX;
uniform 	float _DistScrollY;
uniform 	vec4 _Color;
uniform 	vec4 _Black;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
uniform 	float _GlobalAdditiveMixParameter;
uniform 	float _Cutoff;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _DistTex;
uniform lowp sampler2D _SubTex;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
float u_xlat5;
float u_xlat8;
float u_xlat13;
void main()
{
    u_xlat0.xy = _Time.yy * vec2(_DistScrollX, _DistScrollY);
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistTex_ST.xy + u_xlat0.xy;
    u_xlat10_0.xy = texture2D(_DistTex, u_xlat0.xy).xy;
    u_xlat1.y = u_xlat10_0.y + _DistTex_ST.w;
    u_xlat1.x = u_xlat10_0.x + -0.5;
    u_xlat0.x = _DistTex_ST.z;
    u_xlat0.y = -0.5;
    u_xlat0.xy = u_xlat0.xy + u_xlat1.xy;
    u_xlat8 = u_xlat1.x + _DistTex_ST.z;
    u_xlat10_1.xyz = texture2D(_MaskTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xy = u_xlat0.xy * u_xlat10_1.yy;
    u_xlat0.xy = u_xlat0.xy * vec2(_Distortion) + vs_TEXCOORD0.xy;
    u_xlat10_2 = texture2D(_MainTex, u_xlat0.xy);
    u_xlat0.x = u_xlat10_2.w * _Color.w + (-_Cutoff);
    u_xlatb0 = u_xlat0.x<0.0;
    if(u_xlatb0){discard;}
    u_xlat0.x = u_xlat8 * u_xlat10_1.y;
    u_xlat0.x = u_xlat0.x * _SubTexDistortion;
    u_xlat0.xy = vs_TEXCOORD0.xy * _SubTex_ST.xy + u_xlat0.xx;
    u_xlat0.xy = vec2(_SubTexScrollX, _SubTexScrollY) * _Time.xx + u_xlat0.xy;
    u_xlat10_0 = texture2D(_SubTex, u_xlat0.xy);
    u_xlat0 = u_xlat10_0 * _SubTexCol + (-u_xlat10_2);
    u_xlat1.x = u_xlat10_1.x * _SubTexMix;
    u_xlat5 = (-u_xlat10_1.z) + 1.0;
    u_xlat0 = u_xlat1.xxxx * u_xlat0 + u_xlat10_2;
    u_xlat1.x = u_xlat10_2.w * _Color.w;
    u_xlat2.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat3.xy = vs_TEXCOORD1.xy;
    u_xlat3.z = vs_TEXCOORD2.x;
    u_xlat3.xyz = u_xlat3.xyz + _Black.xyz;
    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.xyz;
    u_xlat2.w = 0.0;
    u_xlat0 = u_xlat0 * vs_COLOR0 + u_xlat2;
    u_xlat0 = u_xlat1.xxxx * u_xlat0;
    u_xlat1.xzw = _GlobalAdditiveColor.www * _GlobalAdditiveColor.xyz;
    u_xlat1.xzw = u_xlat1.xzw * vec3(_GlobalAdditiveIntensity);
    u_xlat2.xyz = u_xlat0.xyz * vec3(u_xlat5) + (-u_xlat1.xzw);
    u_xlat0 = vec4(u_xlat5) * u_xlat0;
    u_xlat1.xyz = u_xlat0.www * u_xlat2.xyz + u_xlat1.xzw;
    u_xlat2.xyz = _GlobalAdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    u_xlat13 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    u_xlat0.xyz = vec3(u_xlat13) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    u_xlat0.xyz = vec3(vec3(_GlobalAdditiveMixParameter, _GlobalAdditiveMixParameter, _GlobalAdditiveMixParameter)) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    SV_Target0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.w = u_xlat0.w;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_USE_CUTOFF" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec2 in_TEXCOORD1;
attribute highp vec2 in_TEXCOORD2;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD2.xy;
    u_xlat0.xyz = _Color.www * _Color.xyz;
    u_xlat0.w = _Color.w;
    vs_COLOR0 = u_xlat0 * in_COLOR0;
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
uniform 	vec4 _SubTex_ST;
uniform 	float _SubTexMix;
uniform 	float _SubTexScrollX;
uniform 	float _SubTexScrollY;
uniform 	vec4 _SubTexCol;
uniform 	vec4 _DistTex_ST;
uniform 	float _Distortion;
uniform 	float _SubTexDistortion;
uniform 	float _DistScrollX;
uniform 	float _DistScrollY;
uniform 	vec4 _Color;
uniform 	vec4 _Black;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
uniform 	float _GlobalAdditiveMixParameter;
uniform 	float _Cutoff;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _DistTex;
uniform lowp sampler2D _SubTex;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec4 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec3 u_xlat10_1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
vec3 u_xlat3;
float u_xlat5;
float u_xlat8;
float u_xlat13;
void main()
{
    u_xlat0.xy = _Time.yy * vec2(_DistScrollX, _DistScrollY);
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistTex_ST.xy + u_xlat0.xy;
    u_xlat10_0.xy = texture2D(_DistTex, u_xlat0.xy).xy;
    u_xlat1.y = u_xlat10_0.y + _DistTex_ST.w;
    u_xlat1.x = u_xlat10_0.x + -0.5;
    u_xlat0.x = _DistTex_ST.z;
    u_xlat0.y = -0.5;
    u_xlat0.xy = u_xlat0.xy + u_xlat1.xy;
    u_xlat8 = u_xlat1.x + _DistTex_ST.z;
    u_xlat10_1.xyz = texture2D(_MaskTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xy = u_xlat0.xy * u_xlat10_1.yy;
    u_xlat0.xy = u_xlat0.xy * vec2(_Distortion) + vs_TEXCOORD0.xy;
    u_xlat10_2 = texture2D(_MainTex, u_xlat0.xy);
    u_xlat0.x = u_xlat10_2.w * _Color.w + (-_Cutoff);
    u_xlatb0 = u_xlat0.x<0.0;
    if(u_xlatb0){discard;}
    u_xlat0.x = u_xlat8 * u_xlat10_1.y;
    u_xlat0.x = u_xlat0.x * _SubTexDistortion;
    u_xlat0.xy = vs_TEXCOORD0.xy * _SubTex_ST.xy + u_xlat0.xx;
    u_xlat0.xy = vec2(_SubTexScrollX, _SubTexScrollY) * _Time.xx + u_xlat0.xy;
    u_xlat10_0 = texture2D(_SubTex, u_xlat0.xy);
    u_xlat0 = u_xlat10_0 * _SubTexCol + (-u_xlat10_2);
    u_xlat1.x = u_xlat10_1.x * _SubTexMix;
    u_xlat5 = (-u_xlat10_1.z) + 1.0;
    u_xlat0 = u_xlat1.xxxx * u_xlat0 + u_xlat10_2;
    u_xlat1.x = u_xlat10_2.w * _Color.w;
    u_xlat2.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat3.xy = vs_TEXCOORD1.xy;
    u_xlat3.z = vs_TEXCOORD2.x;
    u_xlat3.xyz = u_xlat3.xyz + _Black.xyz;
    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.xyz;
    u_xlat2.w = 0.0;
    u_xlat0 = u_xlat0 * vs_COLOR0 + u_xlat2;
    u_xlat0 = u_xlat1.xxxx * u_xlat0;
    u_xlat1.xzw = _GlobalAdditiveColor.www * _GlobalAdditiveColor.xyz;
    u_xlat1.xzw = u_xlat1.xzw * vec3(_GlobalAdditiveIntensity);
    u_xlat2.xyz = u_xlat0.xyz * vec3(u_xlat5) + (-u_xlat1.xzw);
    u_xlat0 = vec4(u_xlat5) * u_xlat0;
    u_xlat1.xyz = u_xlat0.www * u_xlat2.xyz + u_xlat1.xzw;
    u_xlat2.xyz = _GlobalAdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    u_xlat13 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    u_xlat0.xyz = vec3(u_xlat13) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    u_xlat0.xyz = vec3(vec3(_GlobalAdditiveMixParameter, _GlobalAdditiveMixParameter, _GlobalAdditiveMixParameter)) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    SV_Target0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.w = u_xlat0.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USE_CUTOFF" }
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
uniform 	vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD2.xy;
    u_xlat0.xyz = _Color.www * _Color.xyz;
    u_xlat0.w = _Color.w;
    vs_COLOR0 = u_xlat0 * in_COLOR0;
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
uniform 	vec4 _SubTex_ST;
uniform 	float _SubTexMix;
uniform 	float _SubTexScrollX;
uniform 	float _SubTexScrollY;
uniform 	vec4 _SubTexCol;
uniform 	vec4 _DistTex_ST;
uniform 	float _Distortion;
uniform 	float _SubTexDistortion;
uniform 	float _DistScrollX;
uniform 	float _DistScrollY;
uniform 	vec4 _Color;
uniform 	vec4 _Black;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
uniform 	float _GlobalAdditiveMixParameter;
uniform 	float _Cutoff;
UNITY_LOCATION(0) uniform mediump sampler2D _MaskTex;
UNITY_LOCATION(1) uniform mediump sampler2D _DistTex;
UNITY_LOCATION(2) uniform mediump sampler2D _SubTex;
UNITY_LOCATION(3) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
float u_xlat5;
float u_xlat8;
float u_xlat13;
void main()
{
    u_xlat0.xy = _Time.yy * vec2(_DistScrollX, _DistScrollY);
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistTex_ST.xy + u_xlat0.xy;
    u_xlat16_0.xy = texture(_DistTex, u_xlat0.xy).xy;
    u_xlat1.y = u_xlat16_0.y + _DistTex_ST.w;
    u_xlat1.x = u_xlat16_0.x + -0.5;
    u_xlat0.x = _DistTex_ST.z;
    u_xlat0.y = -0.5;
    u_xlat0.xy = u_xlat0.xy + u_xlat1.xy;
    u_xlat8 = u_xlat1.x + _DistTex_ST.z;
    u_xlat16_1.xyz = texture(_MaskTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xy = u_xlat0.xy * u_xlat16_1.yy;
    u_xlat0.xy = u_xlat0.xy * vec2(_Distortion) + vs_TEXCOORD0.xy;
    u_xlat16_2 = texture(_MainTex, u_xlat0.xy);
    u_xlat0.x = u_xlat16_2.w * _Color.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if(u_xlatb0){discard;}
    u_xlat0.x = u_xlat8 * u_xlat16_1.y;
    u_xlat0.x = u_xlat0.x * _SubTexDistortion;
    u_xlat0.xy = vs_TEXCOORD0.xy * _SubTex_ST.xy + u_xlat0.xx;
    u_xlat0.xy = vec2(_SubTexScrollX, _SubTexScrollY) * _Time.xx + u_xlat0.xy;
    u_xlat16_0 = texture(_SubTex, u_xlat0.xy);
    u_xlat0 = u_xlat16_0 * _SubTexCol + (-u_xlat16_2);
    u_xlat1.x = u_xlat16_1.x * _SubTexMix;
    u_xlat5 = (-u_xlat16_1.z) + 1.0;
    u_xlat0 = u_xlat1.xxxx * u_xlat0 + u_xlat16_2;
    u_xlat1.x = u_xlat16_2.w * _Color.w;
    u_xlat2.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat3.xy = vs_TEXCOORD1.xy;
    u_xlat3.z = vs_TEXCOORD2.x;
    u_xlat3.xyz = u_xlat3.xyz + _Black.xyz;
    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.xyz;
    u_xlat2.w = 0.0;
    u_xlat0 = u_xlat0 * vs_COLOR0 + u_xlat2;
    u_xlat0 = u_xlat1.xxxx * u_xlat0;
    u_xlat1.xzw = _GlobalAdditiveColor.www * _GlobalAdditiveColor.xyz;
    u_xlat1.xzw = u_xlat1.xzw * vec3(_GlobalAdditiveIntensity);
    u_xlat2.xyz = u_xlat0.xyz * vec3(u_xlat5) + (-u_xlat1.xzw);
    u_xlat0 = vec4(u_xlat5) * u_xlat0;
    u_xlat1.xyz = u_xlat0.www * u_xlat2.xyz + u_xlat1.xzw;
    u_xlat2.xyz = _GlobalAdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    u_xlat13 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    u_xlat0.xyz = vec3(u_xlat13) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    u_xlat0.xyz = vec3(vec3(_GlobalAdditiveMixParameter, _GlobalAdditiveMixParameter, _GlobalAdditiveMixParameter)) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    SV_Target0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.w = u_xlat0.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USE_CUTOFF" }
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
uniform 	vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD2.xy;
    u_xlat0.xyz = _Color.www * _Color.xyz;
    u_xlat0.w = _Color.w;
    vs_COLOR0 = u_xlat0 * in_COLOR0;
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
uniform 	vec4 _SubTex_ST;
uniform 	float _SubTexMix;
uniform 	float _SubTexScrollX;
uniform 	float _SubTexScrollY;
uniform 	vec4 _SubTexCol;
uniform 	vec4 _DistTex_ST;
uniform 	float _Distortion;
uniform 	float _SubTexDistortion;
uniform 	float _DistScrollX;
uniform 	float _DistScrollY;
uniform 	vec4 _Color;
uniform 	vec4 _Black;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
uniform 	float _GlobalAdditiveMixParameter;
uniform 	float _Cutoff;
UNITY_LOCATION(0) uniform mediump sampler2D _MaskTex;
UNITY_LOCATION(1) uniform mediump sampler2D _DistTex;
UNITY_LOCATION(2) uniform mediump sampler2D _SubTex;
UNITY_LOCATION(3) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
float u_xlat5;
float u_xlat8;
float u_xlat13;
void main()
{
    u_xlat0.xy = _Time.yy * vec2(_DistScrollX, _DistScrollY);
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistTex_ST.xy + u_xlat0.xy;
    u_xlat16_0.xy = texture(_DistTex, u_xlat0.xy).xy;
    u_xlat1.y = u_xlat16_0.y + _DistTex_ST.w;
    u_xlat1.x = u_xlat16_0.x + -0.5;
    u_xlat0.x = _DistTex_ST.z;
    u_xlat0.y = -0.5;
    u_xlat0.xy = u_xlat0.xy + u_xlat1.xy;
    u_xlat8 = u_xlat1.x + _DistTex_ST.z;
    u_xlat16_1.xyz = texture(_MaskTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xy = u_xlat0.xy * u_xlat16_1.yy;
    u_xlat0.xy = u_xlat0.xy * vec2(_Distortion) + vs_TEXCOORD0.xy;
    u_xlat16_2 = texture(_MainTex, u_xlat0.xy);
    u_xlat0.x = u_xlat16_2.w * _Color.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if(u_xlatb0){discard;}
    u_xlat0.x = u_xlat8 * u_xlat16_1.y;
    u_xlat0.x = u_xlat0.x * _SubTexDistortion;
    u_xlat0.xy = vs_TEXCOORD0.xy * _SubTex_ST.xy + u_xlat0.xx;
    u_xlat0.xy = vec2(_SubTexScrollX, _SubTexScrollY) * _Time.xx + u_xlat0.xy;
    u_xlat16_0 = texture(_SubTex, u_xlat0.xy);
    u_xlat0 = u_xlat16_0 * _SubTexCol + (-u_xlat16_2);
    u_xlat1.x = u_xlat16_1.x * _SubTexMix;
    u_xlat5 = (-u_xlat16_1.z) + 1.0;
    u_xlat0 = u_xlat1.xxxx * u_xlat0 + u_xlat16_2;
    u_xlat1.x = u_xlat16_2.w * _Color.w;
    u_xlat2.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat3.xy = vs_TEXCOORD1.xy;
    u_xlat3.z = vs_TEXCOORD2.x;
    u_xlat3.xyz = u_xlat3.xyz + _Black.xyz;
    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.xyz;
    u_xlat2.w = 0.0;
    u_xlat0 = u_xlat0 * vs_COLOR0 + u_xlat2;
    u_xlat0 = u_xlat1.xxxx * u_xlat0;
    u_xlat1.xzw = _GlobalAdditiveColor.www * _GlobalAdditiveColor.xyz;
    u_xlat1.xzw = u_xlat1.xzw * vec3(_GlobalAdditiveIntensity);
    u_xlat2.xyz = u_xlat0.xyz * vec3(u_xlat5) + (-u_xlat1.xzw);
    u_xlat0 = vec4(u_xlat5) * u_xlat0;
    u_xlat1.xyz = u_xlat0.www * u_xlat2.xyz + u_xlat1.xzw;
    u_xlat2.xyz = _GlobalAdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    u_xlat13 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    u_xlat0.xyz = vec3(u_xlat13) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    u_xlat0.xyz = vec3(vec3(_GlobalAdditiveMixParameter, _GlobalAdditiveMixParameter, _GlobalAdditiveMixParameter)) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    SV_Target0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.w = u_xlat0.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USE_CUTOFF" }
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
uniform 	vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD2.xy;
    u_xlat0.xyz = _Color.www * _Color.xyz;
    u_xlat0.w = _Color.w;
    vs_COLOR0 = u_xlat0 * in_COLOR0;
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
uniform 	vec4 _SubTex_ST;
uniform 	float _SubTexMix;
uniform 	float _SubTexScrollX;
uniform 	float _SubTexScrollY;
uniform 	vec4 _SubTexCol;
uniform 	vec4 _DistTex_ST;
uniform 	float _Distortion;
uniform 	float _SubTexDistortion;
uniform 	float _DistScrollX;
uniform 	float _DistScrollY;
uniform 	vec4 _Color;
uniform 	vec4 _Black;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
uniform 	float _GlobalAdditiveMixParameter;
uniform 	float _Cutoff;
UNITY_LOCATION(0) uniform mediump sampler2D _MaskTex;
UNITY_LOCATION(1) uniform mediump sampler2D _DistTex;
UNITY_LOCATION(2) uniform mediump sampler2D _SubTex;
UNITY_LOCATION(3) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec4 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec3 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec3 u_xlat3;
float u_xlat5;
float u_xlat8;
float u_xlat13;
void main()
{
    u_xlat0.xy = _Time.yy * vec2(_DistScrollX, _DistScrollY);
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistTex_ST.xy + u_xlat0.xy;
    u_xlat16_0.xy = texture(_DistTex, u_xlat0.xy).xy;
    u_xlat1.y = u_xlat16_0.y + _DistTex_ST.w;
    u_xlat1.x = u_xlat16_0.x + -0.5;
    u_xlat0.x = _DistTex_ST.z;
    u_xlat0.y = -0.5;
    u_xlat0.xy = u_xlat0.xy + u_xlat1.xy;
    u_xlat8 = u_xlat1.x + _DistTex_ST.z;
    u_xlat16_1.xyz = texture(_MaskTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xy = u_xlat0.xy * u_xlat16_1.yy;
    u_xlat0.xy = u_xlat0.xy * vec2(_Distortion) + vs_TEXCOORD0.xy;
    u_xlat16_2 = texture(_MainTex, u_xlat0.xy);
    u_xlat0.x = u_xlat16_2.w * _Color.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if(u_xlatb0){discard;}
    u_xlat0.x = u_xlat8 * u_xlat16_1.y;
    u_xlat0.x = u_xlat0.x * _SubTexDistortion;
    u_xlat0.xy = vs_TEXCOORD0.xy * _SubTex_ST.xy + u_xlat0.xx;
    u_xlat0.xy = vec2(_SubTexScrollX, _SubTexScrollY) * _Time.xx + u_xlat0.xy;
    u_xlat16_0 = texture(_SubTex, u_xlat0.xy);
    u_xlat0 = u_xlat16_0 * _SubTexCol + (-u_xlat16_2);
    u_xlat1.x = u_xlat16_1.x * _SubTexMix;
    u_xlat5 = (-u_xlat16_1.z) + 1.0;
    u_xlat0 = u_xlat1.xxxx * u_xlat0 + u_xlat16_2;
    u_xlat1.x = u_xlat16_2.w * _Color.w;
    u_xlat2.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat3.xy = vs_TEXCOORD1.xy;
    u_xlat3.z = vs_TEXCOORD2.x;
    u_xlat3.xyz = u_xlat3.xyz + _Black.xyz;
    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.xyz;
    u_xlat2.w = 0.0;
    u_xlat0 = u_xlat0 * vs_COLOR0 + u_xlat2;
    u_xlat0 = u_xlat1.xxxx * u_xlat0;
    u_xlat1.xzw = _GlobalAdditiveColor.www * _GlobalAdditiveColor.xyz;
    u_xlat1.xzw = u_xlat1.xzw * vec3(_GlobalAdditiveIntensity);
    u_xlat2.xyz = u_xlat0.xyz * vec3(u_xlat5) + (-u_xlat1.xzw);
    u_xlat0 = vec4(u_xlat5) * u_xlat0;
    u_xlat1.xyz = u_xlat0.www * u_xlat2.xyz + u_xlat1.xzw;
    u_xlat2.xyz = _GlobalAdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    u_xlat13 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    u_xlat0.xyz = vec3(u_xlat13) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    u_xlat0.xyz = vec3(vec3(_GlobalAdditiveMixParameter, _GlobalAdditiveMixParameter, _GlobalAdditiveMixParameter)) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    SV_Target0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.w = u_xlat0.w;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_STRAIGHT_ALPHA_INPUT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec2 in_TEXCOORD1;
attribute highp vec2 in_TEXCOORD2;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD2.xy;
    u_xlat0.xyz = _Color.www * _Color.xyz;
    u_xlat0.w = _Color.w;
    vs_COLOR0 = u_xlat0 * in_COLOR0;
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
uniform 	vec4 _SubTex_ST;
uniform 	float _SubTexMix;
uniform 	float _SubTexScrollX;
uniform 	float _SubTexScrollY;
uniform 	vec4 _SubTexCol;
uniform 	vec4 _DistTex_ST;
uniform 	float _Distortion;
uniform 	float _SubTexDistortion;
uniform 	float _DistScrollX;
uniform 	float _DistScrollY;
uniform 	vec4 _Black;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
uniform 	float _GlobalAdditiveMixParameter;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _DistTex;
uniform lowp sampler2D _SubTex;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
float u_xlat3;
float u_xlat6;
float u_xlat10;
void main()
{
    u_xlat0.xy = _Time.yy * vec2(_DistScrollX, _DistScrollY);
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistTex_ST.xy + u_xlat0.xy;
    u_xlat10_0.xy = texture2D(_DistTex, u_xlat0.xy).xy;
    u_xlat1.y = u_xlat10_0.y + _DistTex_ST.w;
    u_xlat1.x = u_xlat10_0.x + -0.5;
    u_xlat0.x = _DistTex_ST.z;
    u_xlat0.y = -0.5;
    u_xlat0.xy = u_xlat0.xy + u_xlat1.xy;
    u_xlat6 = u_xlat1.x + _DistTex_ST.z;
    u_xlat10_1.xy = texture2D(_MaskTex, vs_TEXCOORD0.xy).xy;
    u_xlat0.xy = u_xlat0.xy * u_xlat10_1.yy;
    u_xlat0.xy = u_xlat0.xy * vec2(_Distortion) + vs_TEXCOORD0.xy;
    u_xlat10_2 = texture2D(_MainTex, u_xlat0.xy);
    u_xlat0.x = u_xlat6 * u_xlat10_1.y;
    u_xlat3 = u_xlat10_1.x * _SubTexMix;
    u_xlat0.x = u_xlat0.x * _SubTexDistortion;
    u_xlat0.xz = vs_TEXCOORD0.xy * _SubTex_ST.xy + u_xlat0.xx;
    u_xlat0.xz = vec2(_SubTexScrollX, _SubTexScrollY) * _Time.xx + u_xlat0.xz;
    u_xlat10_1 = texture2D(_SubTex, u_xlat0.xz);
    u_xlat1 = u_xlat10_1 * _SubTexCol + (-u_xlat10_2);
    u_xlat0 = vec4(u_xlat3) * u_xlat1 + u_xlat10_2;
    u_xlat1.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat2.xy = vs_TEXCOORD1.xy;
    u_xlat2.z = vs_TEXCOORD2.x;
    u_xlat2.xyz = u_xlat2.xyz + _Black.xyz;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.w = 0.0;
    u_xlat0 = u_xlat0 * vs_COLOR0 + u_xlat1;
    u_xlat1.xyz = _GlobalAdditiveColor.www * _GlobalAdditiveColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_GlobalAdditiveIntensity);
    u_xlat2.xyz = u_xlat0.xyz * u_xlat0.www + (-u_xlat1.xyz);
    u_xlat1.xyz = u_xlat0.www * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.www * u_xlat0.xyz;
    u_xlat2.xyz = _GlobalAdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    u_xlat10 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    u_xlat0.xyz = vec3(u_xlat10) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    u_xlat0.xyz = vec3(vec3(_GlobalAdditiveMixParameter, _GlobalAdditiveMixParameter, _GlobalAdditiveMixParameter)) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    SV_Target0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.w = u_xlat0.w;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_STRAIGHT_ALPHA_INPUT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec2 in_TEXCOORD1;
attribute highp vec2 in_TEXCOORD2;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD2.xy;
    u_xlat0.xyz = _Color.www * _Color.xyz;
    u_xlat0.w = _Color.w;
    vs_COLOR0 = u_xlat0 * in_COLOR0;
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
uniform 	vec4 _SubTex_ST;
uniform 	float _SubTexMix;
uniform 	float _SubTexScrollX;
uniform 	float _SubTexScrollY;
uniform 	vec4 _SubTexCol;
uniform 	vec4 _DistTex_ST;
uniform 	float _Distortion;
uniform 	float _SubTexDistortion;
uniform 	float _DistScrollX;
uniform 	float _DistScrollY;
uniform 	vec4 _Black;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
uniform 	float _GlobalAdditiveMixParameter;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _DistTex;
uniform lowp sampler2D _SubTex;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
float u_xlat3;
float u_xlat6;
float u_xlat10;
void main()
{
    u_xlat0.xy = _Time.yy * vec2(_DistScrollX, _DistScrollY);
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistTex_ST.xy + u_xlat0.xy;
    u_xlat10_0.xy = texture2D(_DistTex, u_xlat0.xy).xy;
    u_xlat1.y = u_xlat10_0.y + _DistTex_ST.w;
    u_xlat1.x = u_xlat10_0.x + -0.5;
    u_xlat0.x = _DistTex_ST.z;
    u_xlat0.y = -0.5;
    u_xlat0.xy = u_xlat0.xy + u_xlat1.xy;
    u_xlat6 = u_xlat1.x + _DistTex_ST.z;
    u_xlat10_1.xy = texture2D(_MaskTex, vs_TEXCOORD0.xy).xy;
    u_xlat0.xy = u_xlat0.xy * u_xlat10_1.yy;
    u_xlat0.xy = u_xlat0.xy * vec2(_Distortion) + vs_TEXCOORD0.xy;
    u_xlat10_2 = texture2D(_MainTex, u_xlat0.xy);
    u_xlat0.x = u_xlat6 * u_xlat10_1.y;
    u_xlat3 = u_xlat10_1.x * _SubTexMix;
    u_xlat0.x = u_xlat0.x * _SubTexDistortion;
    u_xlat0.xz = vs_TEXCOORD0.xy * _SubTex_ST.xy + u_xlat0.xx;
    u_xlat0.xz = vec2(_SubTexScrollX, _SubTexScrollY) * _Time.xx + u_xlat0.xz;
    u_xlat10_1 = texture2D(_SubTex, u_xlat0.xz);
    u_xlat1 = u_xlat10_1 * _SubTexCol + (-u_xlat10_2);
    u_xlat0 = vec4(u_xlat3) * u_xlat1 + u_xlat10_2;
    u_xlat1.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat2.xy = vs_TEXCOORD1.xy;
    u_xlat2.z = vs_TEXCOORD2.x;
    u_xlat2.xyz = u_xlat2.xyz + _Black.xyz;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.w = 0.0;
    u_xlat0 = u_xlat0 * vs_COLOR0 + u_xlat1;
    u_xlat1.xyz = _GlobalAdditiveColor.www * _GlobalAdditiveColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_GlobalAdditiveIntensity);
    u_xlat2.xyz = u_xlat0.xyz * u_xlat0.www + (-u_xlat1.xyz);
    u_xlat1.xyz = u_xlat0.www * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.www * u_xlat0.xyz;
    u_xlat2.xyz = _GlobalAdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    u_xlat10 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    u_xlat0.xyz = vec3(u_xlat10) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    u_xlat0.xyz = vec3(vec3(_GlobalAdditiveMixParameter, _GlobalAdditiveMixParameter, _GlobalAdditiveMixParameter)) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    SV_Target0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.w = u_xlat0.w;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_STRAIGHT_ALPHA_INPUT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec2 in_TEXCOORD1;
attribute highp vec2 in_TEXCOORD2;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD2.xy;
    u_xlat0.xyz = _Color.www * _Color.xyz;
    u_xlat0.w = _Color.w;
    vs_COLOR0 = u_xlat0 * in_COLOR0;
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
uniform 	vec4 _SubTex_ST;
uniform 	float _SubTexMix;
uniform 	float _SubTexScrollX;
uniform 	float _SubTexScrollY;
uniform 	vec4 _SubTexCol;
uniform 	vec4 _DistTex_ST;
uniform 	float _Distortion;
uniform 	float _SubTexDistortion;
uniform 	float _DistScrollX;
uniform 	float _DistScrollY;
uniform 	vec4 _Black;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
uniform 	float _GlobalAdditiveMixParameter;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _DistTex;
uniform lowp sampler2D _SubTex;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
float u_xlat3;
float u_xlat6;
float u_xlat10;
void main()
{
    u_xlat0.xy = _Time.yy * vec2(_DistScrollX, _DistScrollY);
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistTex_ST.xy + u_xlat0.xy;
    u_xlat10_0.xy = texture2D(_DistTex, u_xlat0.xy).xy;
    u_xlat1.y = u_xlat10_0.y + _DistTex_ST.w;
    u_xlat1.x = u_xlat10_0.x + -0.5;
    u_xlat0.x = _DistTex_ST.z;
    u_xlat0.y = -0.5;
    u_xlat0.xy = u_xlat0.xy + u_xlat1.xy;
    u_xlat6 = u_xlat1.x + _DistTex_ST.z;
    u_xlat10_1.xy = texture2D(_MaskTex, vs_TEXCOORD0.xy).xy;
    u_xlat0.xy = u_xlat0.xy * u_xlat10_1.yy;
    u_xlat0.xy = u_xlat0.xy * vec2(_Distortion) + vs_TEXCOORD0.xy;
    u_xlat10_2 = texture2D(_MainTex, u_xlat0.xy);
    u_xlat0.x = u_xlat6 * u_xlat10_1.y;
    u_xlat3 = u_xlat10_1.x * _SubTexMix;
    u_xlat0.x = u_xlat0.x * _SubTexDistortion;
    u_xlat0.xz = vs_TEXCOORD0.xy * _SubTex_ST.xy + u_xlat0.xx;
    u_xlat0.xz = vec2(_SubTexScrollX, _SubTexScrollY) * _Time.xx + u_xlat0.xz;
    u_xlat10_1 = texture2D(_SubTex, u_xlat0.xz);
    u_xlat1 = u_xlat10_1 * _SubTexCol + (-u_xlat10_2);
    u_xlat0 = vec4(u_xlat3) * u_xlat1 + u_xlat10_2;
    u_xlat1.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat2.xy = vs_TEXCOORD1.xy;
    u_xlat2.z = vs_TEXCOORD2.x;
    u_xlat2.xyz = u_xlat2.xyz + _Black.xyz;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.w = 0.0;
    u_xlat0 = u_xlat0 * vs_COLOR0 + u_xlat1;
    u_xlat1.xyz = _GlobalAdditiveColor.www * _GlobalAdditiveColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_GlobalAdditiveIntensity);
    u_xlat2.xyz = u_xlat0.xyz * u_xlat0.www + (-u_xlat1.xyz);
    u_xlat1.xyz = u_xlat0.www * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.www * u_xlat0.xyz;
    u_xlat2.xyz = _GlobalAdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    u_xlat10 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    u_xlat0.xyz = vec3(u_xlat10) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    u_xlat0.xyz = vec3(vec3(_GlobalAdditiveMixParameter, _GlobalAdditiveMixParameter, _GlobalAdditiveMixParameter)) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    SV_Target0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.w = u_xlat0.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_STRAIGHT_ALPHA_INPUT" }
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
uniform 	vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD2.xy;
    u_xlat0.xyz = _Color.www * _Color.xyz;
    u_xlat0.w = _Color.w;
    vs_COLOR0 = u_xlat0 * in_COLOR0;
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
uniform 	vec4 _SubTex_ST;
uniform 	float _SubTexMix;
uniform 	float _SubTexScrollX;
uniform 	float _SubTexScrollY;
uniform 	vec4 _SubTexCol;
uniform 	vec4 _DistTex_ST;
uniform 	float _Distortion;
uniform 	float _SubTexDistortion;
uniform 	float _DistScrollX;
uniform 	float _DistScrollY;
uniform 	vec4 _Black;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
uniform 	float _GlobalAdditiveMixParameter;
UNITY_LOCATION(0) uniform mediump sampler2D _MaskTex;
UNITY_LOCATION(1) uniform mediump sampler2D _DistTex;
UNITY_LOCATION(2) uniform mediump sampler2D _SubTex;
UNITY_LOCATION(3) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
float u_xlat3;
float u_xlat6;
float u_xlat10;
void main()
{
    u_xlat0.xy = _Time.yy * vec2(_DistScrollX, _DistScrollY);
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistTex_ST.xy + u_xlat0.xy;
    u_xlat16_0.xy = texture(_DistTex, u_xlat0.xy).xy;
    u_xlat1.y = u_xlat16_0.y + _DistTex_ST.w;
    u_xlat1.x = u_xlat16_0.x + -0.5;
    u_xlat0.x = _DistTex_ST.z;
    u_xlat0.y = -0.5;
    u_xlat0.xy = u_xlat0.xy + u_xlat1.xy;
    u_xlat6 = u_xlat1.x + _DistTex_ST.z;
    u_xlat16_1.xy = texture(_MaskTex, vs_TEXCOORD0.xy).xy;
    u_xlat0.xy = u_xlat0.xy * u_xlat16_1.yy;
    u_xlat0.xy = u_xlat0.xy * vec2(_Distortion) + vs_TEXCOORD0.xy;
    u_xlat16_2 = texture(_MainTex, u_xlat0.xy);
    u_xlat0.x = u_xlat6 * u_xlat16_1.y;
    u_xlat3 = u_xlat16_1.x * _SubTexMix;
    u_xlat0.x = u_xlat0.x * _SubTexDistortion;
    u_xlat0.xz = vs_TEXCOORD0.xy * _SubTex_ST.xy + u_xlat0.xx;
    u_xlat0.xz = vec2(_SubTexScrollX, _SubTexScrollY) * _Time.xx + u_xlat0.xz;
    u_xlat16_1 = texture(_SubTex, u_xlat0.xz);
    u_xlat1 = u_xlat16_1 * _SubTexCol + (-u_xlat16_2);
    u_xlat0 = vec4(u_xlat3) * u_xlat1 + u_xlat16_2;
    u_xlat1.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat2.xy = vs_TEXCOORD1.xy;
    u_xlat2.z = vs_TEXCOORD2.x;
    u_xlat2.xyz = u_xlat2.xyz + _Black.xyz;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.w = 0.0;
    u_xlat0 = u_xlat0 * vs_COLOR0 + u_xlat1;
    u_xlat1.xyz = _GlobalAdditiveColor.www * _GlobalAdditiveColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_GlobalAdditiveIntensity);
    u_xlat2.xyz = u_xlat0.xyz * u_xlat0.www + (-u_xlat1.xyz);
    u_xlat1.xyz = u_xlat0.www * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.www * u_xlat0.xyz;
    u_xlat2.xyz = _GlobalAdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    u_xlat10 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    u_xlat0.xyz = vec3(u_xlat10) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    u_xlat0.xyz = vec3(vec3(_GlobalAdditiveMixParameter, _GlobalAdditiveMixParameter, _GlobalAdditiveMixParameter)) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    SV_Target0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.w = u_xlat0.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_STRAIGHT_ALPHA_INPUT" }
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
uniform 	vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD2.xy;
    u_xlat0.xyz = _Color.www * _Color.xyz;
    u_xlat0.w = _Color.w;
    vs_COLOR0 = u_xlat0 * in_COLOR0;
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
uniform 	vec4 _SubTex_ST;
uniform 	float _SubTexMix;
uniform 	float _SubTexScrollX;
uniform 	float _SubTexScrollY;
uniform 	vec4 _SubTexCol;
uniform 	vec4 _DistTex_ST;
uniform 	float _Distortion;
uniform 	float _SubTexDistortion;
uniform 	float _DistScrollX;
uniform 	float _DistScrollY;
uniform 	vec4 _Black;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
uniform 	float _GlobalAdditiveMixParameter;
UNITY_LOCATION(0) uniform mediump sampler2D _MaskTex;
UNITY_LOCATION(1) uniform mediump sampler2D _DistTex;
UNITY_LOCATION(2) uniform mediump sampler2D _SubTex;
UNITY_LOCATION(3) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
float u_xlat3;
float u_xlat6;
float u_xlat10;
void main()
{
    u_xlat0.xy = _Time.yy * vec2(_DistScrollX, _DistScrollY);
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistTex_ST.xy + u_xlat0.xy;
    u_xlat16_0.xy = texture(_DistTex, u_xlat0.xy).xy;
    u_xlat1.y = u_xlat16_0.y + _DistTex_ST.w;
    u_xlat1.x = u_xlat16_0.x + -0.5;
    u_xlat0.x = _DistTex_ST.z;
    u_xlat0.y = -0.5;
    u_xlat0.xy = u_xlat0.xy + u_xlat1.xy;
    u_xlat6 = u_xlat1.x + _DistTex_ST.z;
    u_xlat16_1.xy = texture(_MaskTex, vs_TEXCOORD0.xy).xy;
    u_xlat0.xy = u_xlat0.xy * u_xlat16_1.yy;
    u_xlat0.xy = u_xlat0.xy * vec2(_Distortion) + vs_TEXCOORD0.xy;
    u_xlat16_2 = texture(_MainTex, u_xlat0.xy);
    u_xlat0.x = u_xlat6 * u_xlat16_1.y;
    u_xlat3 = u_xlat16_1.x * _SubTexMix;
    u_xlat0.x = u_xlat0.x * _SubTexDistortion;
    u_xlat0.xz = vs_TEXCOORD0.xy * _SubTex_ST.xy + u_xlat0.xx;
    u_xlat0.xz = vec2(_SubTexScrollX, _SubTexScrollY) * _Time.xx + u_xlat0.xz;
    u_xlat16_1 = texture(_SubTex, u_xlat0.xz);
    u_xlat1 = u_xlat16_1 * _SubTexCol + (-u_xlat16_2);
    u_xlat0 = vec4(u_xlat3) * u_xlat1 + u_xlat16_2;
    u_xlat1.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat2.xy = vs_TEXCOORD1.xy;
    u_xlat2.z = vs_TEXCOORD2.x;
    u_xlat2.xyz = u_xlat2.xyz + _Black.xyz;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.w = 0.0;
    u_xlat0 = u_xlat0 * vs_COLOR0 + u_xlat1;
    u_xlat1.xyz = _GlobalAdditiveColor.www * _GlobalAdditiveColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_GlobalAdditiveIntensity);
    u_xlat2.xyz = u_xlat0.xyz * u_xlat0.www + (-u_xlat1.xyz);
    u_xlat1.xyz = u_xlat0.www * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.www * u_xlat0.xyz;
    u_xlat2.xyz = _GlobalAdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    u_xlat10 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    u_xlat0.xyz = vec3(u_xlat10) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    u_xlat0.xyz = vec3(vec3(_GlobalAdditiveMixParameter, _GlobalAdditiveMixParameter, _GlobalAdditiveMixParameter)) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    SV_Target0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.w = u_xlat0.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_STRAIGHT_ALPHA_INPUT" }
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
uniform 	vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD2.xy;
    u_xlat0.xyz = _Color.www * _Color.xyz;
    u_xlat0.w = _Color.w;
    vs_COLOR0 = u_xlat0 * in_COLOR0;
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
uniform 	vec4 _SubTex_ST;
uniform 	float _SubTexMix;
uniform 	float _SubTexScrollX;
uniform 	float _SubTexScrollY;
uniform 	vec4 _SubTexCol;
uniform 	vec4 _DistTex_ST;
uniform 	float _Distortion;
uniform 	float _SubTexDistortion;
uniform 	float _DistScrollX;
uniform 	float _DistScrollY;
uniform 	vec4 _Black;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
uniform 	float _GlobalAdditiveMixParameter;
UNITY_LOCATION(0) uniform mediump sampler2D _MaskTex;
UNITY_LOCATION(1) uniform mediump sampler2D _DistTex;
UNITY_LOCATION(2) uniform mediump sampler2D _SubTex;
UNITY_LOCATION(3) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
float u_xlat3;
float u_xlat6;
float u_xlat10;
void main()
{
    u_xlat0.xy = _Time.yy * vec2(_DistScrollX, _DistScrollY);
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistTex_ST.xy + u_xlat0.xy;
    u_xlat16_0.xy = texture(_DistTex, u_xlat0.xy).xy;
    u_xlat1.y = u_xlat16_0.y + _DistTex_ST.w;
    u_xlat1.x = u_xlat16_0.x + -0.5;
    u_xlat0.x = _DistTex_ST.z;
    u_xlat0.y = -0.5;
    u_xlat0.xy = u_xlat0.xy + u_xlat1.xy;
    u_xlat6 = u_xlat1.x + _DistTex_ST.z;
    u_xlat16_1.xy = texture(_MaskTex, vs_TEXCOORD0.xy).xy;
    u_xlat0.xy = u_xlat0.xy * u_xlat16_1.yy;
    u_xlat0.xy = u_xlat0.xy * vec2(_Distortion) + vs_TEXCOORD0.xy;
    u_xlat16_2 = texture(_MainTex, u_xlat0.xy);
    u_xlat0.x = u_xlat6 * u_xlat16_1.y;
    u_xlat3 = u_xlat16_1.x * _SubTexMix;
    u_xlat0.x = u_xlat0.x * _SubTexDistortion;
    u_xlat0.xz = vs_TEXCOORD0.xy * _SubTex_ST.xy + u_xlat0.xx;
    u_xlat0.xz = vec2(_SubTexScrollX, _SubTexScrollY) * _Time.xx + u_xlat0.xz;
    u_xlat16_1 = texture(_SubTex, u_xlat0.xz);
    u_xlat1 = u_xlat16_1 * _SubTexCol + (-u_xlat16_2);
    u_xlat0 = vec4(u_xlat3) * u_xlat1 + u_xlat16_2;
    u_xlat1.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat2.xy = vs_TEXCOORD1.xy;
    u_xlat2.z = vs_TEXCOORD2.x;
    u_xlat2.xyz = u_xlat2.xyz + _Black.xyz;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.w = 0.0;
    u_xlat0 = u_xlat0 * vs_COLOR0 + u_xlat1;
    u_xlat1.xyz = _GlobalAdditiveColor.www * _GlobalAdditiveColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_GlobalAdditiveIntensity);
    u_xlat2.xyz = u_xlat0.xyz * u_xlat0.www + (-u_xlat1.xyz);
    u_xlat1.xyz = u_xlat0.www * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.www * u_xlat0.xyz;
    u_xlat2.xyz = _GlobalAdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    u_xlat10 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    u_xlat0.xyz = vec3(u_xlat10) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    u_xlat0.xyz = vec3(vec3(_GlobalAdditiveMixParameter, _GlobalAdditiveMixParameter, _GlobalAdditiveMixParameter)) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    SV_Target0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.w = u_xlat0.w;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_STRAIGHT_ALPHA_INPUT" "_USE_CUTOFF" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec2 in_TEXCOORD1;
attribute highp vec2 in_TEXCOORD2;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD2.xy;
    u_xlat0.xyz = _Color.www * _Color.xyz;
    u_xlat0.w = _Color.w;
    vs_COLOR0 = u_xlat0 * in_COLOR0;
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
uniform 	vec4 _SubTex_ST;
uniform 	float _SubTexMix;
uniform 	float _SubTexScrollX;
uniform 	float _SubTexScrollY;
uniform 	vec4 _SubTexCol;
uniform 	vec4 _DistTex_ST;
uniform 	float _Distortion;
uniform 	float _SubTexDistortion;
uniform 	float _DistScrollX;
uniform 	float _DistScrollY;
uniform 	vec4 _Color;
uniform 	vec4 _Black;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
uniform 	float _GlobalAdditiveMixParameter;
uniform 	float _Cutoff;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _DistTex;
uniform lowp sampler2D _SubTex;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
float u_xlat3;
float u_xlat6;
float u_xlat10;
void main()
{
    u_xlat0.xy = _Time.yy * vec2(_DistScrollX, _DistScrollY);
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistTex_ST.xy + u_xlat0.xy;
    u_xlat10_0.xy = texture2D(_DistTex, u_xlat0.xy).xy;
    u_xlat1.y = u_xlat10_0.y + _DistTex_ST.w;
    u_xlat1.x = u_xlat10_0.x + -0.5;
    u_xlat0.x = _DistTex_ST.z;
    u_xlat0.y = -0.5;
    u_xlat0.xy = u_xlat0.xy + u_xlat1.xy;
    u_xlat6 = u_xlat1.x + _DistTex_ST.z;
    u_xlat10_1.xy = texture2D(_MaskTex, vs_TEXCOORD0.xy).xy;
    u_xlat0.xy = u_xlat0.xy * u_xlat10_1.yy;
    u_xlat0.xy = u_xlat0.xy * vec2(_Distortion) + vs_TEXCOORD0.xy;
    u_xlat10_2 = texture2D(_MainTex, u_xlat0.xy);
    u_xlat0.x = u_xlat10_2.w * _Color.w + (-_Cutoff);
    u_xlatb0 = u_xlat0.x<0.0;
    if(u_xlatb0){discard;}
    u_xlat0.x = u_xlat6 * u_xlat10_1.y;
    u_xlat3 = u_xlat10_1.x * _SubTexMix;
    u_xlat0.x = u_xlat0.x * _SubTexDistortion;
    u_xlat0.xz = vs_TEXCOORD0.xy * _SubTex_ST.xy + u_xlat0.xx;
    u_xlat0.xz = vec2(_SubTexScrollX, _SubTexScrollY) * _Time.xx + u_xlat0.xz;
    u_xlat10_1 = texture2D(_SubTex, u_xlat0.xz);
    u_xlat1 = u_xlat10_1 * _SubTexCol + (-u_xlat10_2);
    u_xlat0 = vec4(u_xlat3) * u_xlat1 + u_xlat10_2;
    u_xlat1.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat2.xy = vs_TEXCOORD1.xy;
    u_xlat2.z = vs_TEXCOORD2.x;
    u_xlat2.xyz = u_xlat2.xyz + _Black.xyz;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.w = 0.0;
    u_xlat0 = u_xlat0 * vs_COLOR0 + u_xlat1;
    u_xlat1.xyz = _GlobalAdditiveColor.www * _GlobalAdditiveColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_GlobalAdditiveIntensity);
    u_xlat2.xyz = u_xlat0.xyz * u_xlat0.www + (-u_xlat1.xyz);
    u_xlat1.xyz = u_xlat0.www * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.www * u_xlat0.xyz;
    u_xlat2.xyz = _GlobalAdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    u_xlat10 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    u_xlat0.xyz = vec3(u_xlat10) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    u_xlat0.xyz = vec3(vec3(_GlobalAdditiveMixParameter, _GlobalAdditiveMixParameter, _GlobalAdditiveMixParameter)) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    SV_Target0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.w = u_xlat0.w;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_STRAIGHT_ALPHA_INPUT" "_USE_CUTOFF" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec2 in_TEXCOORD1;
attribute highp vec2 in_TEXCOORD2;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD2.xy;
    u_xlat0.xyz = _Color.www * _Color.xyz;
    u_xlat0.w = _Color.w;
    vs_COLOR0 = u_xlat0 * in_COLOR0;
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
uniform 	vec4 _SubTex_ST;
uniform 	float _SubTexMix;
uniform 	float _SubTexScrollX;
uniform 	float _SubTexScrollY;
uniform 	vec4 _SubTexCol;
uniform 	vec4 _DistTex_ST;
uniform 	float _Distortion;
uniform 	float _SubTexDistortion;
uniform 	float _DistScrollX;
uniform 	float _DistScrollY;
uniform 	vec4 _Color;
uniform 	vec4 _Black;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
uniform 	float _GlobalAdditiveMixParameter;
uniform 	float _Cutoff;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _DistTex;
uniform lowp sampler2D _SubTex;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
float u_xlat3;
float u_xlat6;
float u_xlat10;
void main()
{
    u_xlat0.xy = _Time.yy * vec2(_DistScrollX, _DistScrollY);
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistTex_ST.xy + u_xlat0.xy;
    u_xlat10_0.xy = texture2D(_DistTex, u_xlat0.xy).xy;
    u_xlat1.y = u_xlat10_0.y + _DistTex_ST.w;
    u_xlat1.x = u_xlat10_0.x + -0.5;
    u_xlat0.x = _DistTex_ST.z;
    u_xlat0.y = -0.5;
    u_xlat0.xy = u_xlat0.xy + u_xlat1.xy;
    u_xlat6 = u_xlat1.x + _DistTex_ST.z;
    u_xlat10_1.xy = texture2D(_MaskTex, vs_TEXCOORD0.xy).xy;
    u_xlat0.xy = u_xlat0.xy * u_xlat10_1.yy;
    u_xlat0.xy = u_xlat0.xy * vec2(_Distortion) + vs_TEXCOORD0.xy;
    u_xlat10_2 = texture2D(_MainTex, u_xlat0.xy);
    u_xlat0.x = u_xlat10_2.w * _Color.w + (-_Cutoff);
    u_xlatb0 = u_xlat0.x<0.0;
    if(u_xlatb0){discard;}
    u_xlat0.x = u_xlat6 * u_xlat10_1.y;
    u_xlat3 = u_xlat10_1.x * _SubTexMix;
    u_xlat0.x = u_xlat0.x * _SubTexDistortion;
    u_xlat0.xz = vs_TEXCOORD0.xy * _SubTex_ST.xy + u_xlat0.xx;
    u_xlat0.xz = vec2(_SubTexScrollX, _SubTexScrollY) * _Time.xx + u_xlat0.xz;
    u_xlat10_1 = texture2D(_SubTex, u_xlat0.xz);
    u_xlat1 = u_xlat10_1 * _SubTexCol + (-u_xlat10_2);
    u_xlat0 = vec4(u_xlat3) * u_xlat1 + u_xlat10_2;
    u_xlat1.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat2.xy = vs_TEXCOORD1.xy;
    u_xlat2.z = vs_TEXCOORD2.x;
    u_xlat2.xyz = u_xlat2.xyz + _Black.xyz;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.w = 0.0;
    u_xlat0 = u_xlat0 * vs_COLOR0 + u_xlat1;
    u_xlat1.xyz = _GlobalAdditiveColor.www * _GlobalAdditiveColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_GlobalAdditiveIntensity);
    u_xlat2.xyz = u_xlat0.xyz * u_xlat0.www + (-u_xlat1.xyz);
    u_xlat1.xyz = u_xlat0.www * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.www * u_xlat0.xyz;
    u_xlat2.xyz = _GlobalAdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    u_xlat10 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    u_xlat0.xyz = vec3(u_xlat10) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    u_xlat0.xyz = vec3(vec3(_GlobalAdditiveMixParameter, _GlobalAdditiveMixParameter, _GlobalAdditiveMixParameter)) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    SV_Target0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.w = u_xlat0.w;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_STRAIGHT_ALPHA_INPUT" "_USE_CUTOFF" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec2 in_TEXCOORD1;
attribute highp vec2 in_TEXCOORD2;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD2.xy;
    u_xlat0.xyz = _Color.www * _Color.xyz;
    u_xlat0.w = _Color.w;
    vs_COLOR0 = u_xlat0 * in_COLOR0;
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
uniform 	vec4 _SubTex_ST;
uniform 	float _SubTexMix;
uniform 	float _SubTexScrollX;
uniform 	float _SubTexScrollY;
uniform 	vec4 _SubTexCol;
uniform 	vec4 _DistTex_ST;
uniform 	float _Distortion;
uniform 	float _SubTexDistortion;
uniform 	float _DistScrollX;
uniform 	float _DistScrollY;
uniform 	vec4 _Color;
uniform 	vec4 _Black;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
uniform 	float _GlobalAdditiveMixParameter;
uniform 	float _Cutoff;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _DistTex;
uniform lowp sampler2D _SubTex;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
float u_xlat3;
float u_xlat6;
float u_xlat10;
void main()
{
    u_xlat0.xy = _Time.yy * vec2(_DistScrollX, _DistScrollY);
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistTex_ST.xy + u_xlat0.xy;
    u_xlat10_0.xy = texture2D(_DistTex, u_xlat0.xy).xy;
    u_xlat1.y = u_xlat10_0.y + _DistTex_ST.w;
    u_xlat1.x = u_xlat10_0.x + -0.5;
    u_xlat0.x = _DistTex_ST.z;
    u_xlat0.y = -0.5;
    u_xlat0.xy = u_xlat0.xy + u_xlat1.xy;
    u_xlat6 = u_xlat1.x + _DistTex_ST.z;
    u_xlat10_1.xy = texture2D(_MaskTex, vs_TEXCOORD0.xy).xy;
    u_xlat0.xy = u_xlat0.xy * u_xlat10_1.yy;
    u_xlat0.xy = u_xlat0.xy * vec2(_Distortion) + vs_TEXCOORD0.xy;
    u_xlat10_2 = texture2D(_MainTex, u_xlat0.xy);
    u_xlat0.x = u_xlat10_2.w * _Color.w + (-_Cutoff);
    u_xlatb0 = u_xlat0.x<0.0;
    if(u_xlatb0){discard;}
    u_xlat0.x = u_xlat6 * u_xlat10_1.y;
    u_xlat3 = u_xlat10_1.x * _SubTexMix;
    u_xlat0.x = u_xlat0.x * _SubTexDistortion;
    u_xlat0.xz = vs_TEXCOORD0.xy * _SubTex_ST.xy + u_xlat0.xx;
    u_xlat0.xz = vec2(_SubTexScrollX, _SubTexScrollY) * _Time.xx + u_xlat0.xz;
    u_xlat10_1 = texture2D(_SubTex, u_xlat0.xz);
    u_xlat1 = u_xlat10_1 * _SubTexCol + (-u_xlat10_2);
    u_xlat0 = vec4(u_xlat3) * u_xlat1 + u_xlat10_2;
    u_xlat1.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat2.xy = vs_TEXCOORD1.xy;
    u_xlat2.z = vs_TEXCOORD2.x;
    u_xlat2.xyz = u_xlat2.xyz + _Black.xyz;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.w = 0.0;
    u_xlat0 = u_xlat0 * vs_COLOR0 + u_xlat1;
    u_xlat1.xyz = _GlobalAdditiveColor.www * _GlobalAdditiveColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_GlobalAdditiveIntensity);
    u_xlat2.xyz = u_xlat0.xyz * u_xlat0.www + (-u_xlat1.xyz);
    u_xlat1.xyz = u_xlat0.www * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.www * u_xlat0.xyz;
    u_xlat2.xyz = _GlobalAdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    u_xlat10 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    u_xlat0.xyz = vec3(u_xlat10) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    u_xlat0.xyz = vec3(vec3(_GlobalAdditiveMixParameter, _GlobalAdditiveMixParameter, _GlobalAdditiveMixParameter)) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    SV_Target0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.w = u_xlat0.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_STRAIGHT_ALPHA_INPUT" "_USE_CUTOFF" }
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
uniform 	vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD2.xy;
    u_xlat0.xyz = _Color.www * _Color.xyz;
    u_xlat0.w = _Color.w;
    vs_COLOR0 = u_xlat0 * in_COLOR0;
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
uniform 	vec4 _SubTex_ST;
uniform 	float _SubTexMix;
uniform 	float _SubTexScrollX;
uniform 	float _SubTexScrollY;
uniform 	vec4 _SubTexCol;
uniform 	vec4 _DistTex_ST;
uniform 	float _Distortion;
uniform 	float _SubTexDistortion;
uniform 	float _DistScrollX;
uniform 	float _DistScrollY;
uniform 	vec4 _Color;
uniform 	vec4 _Black;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
uniform 	float _GlobalAdditiveMixParameter;
uniform 	float _Cutoff;
UNITY_LOCATION(0) uniform mediump sampler2D _MaskTex;
UNITY_LOCATION(1) uniform mediump sampler2D _DistTex;
UNITY_LOCATION(2) uniform mediump sampler2D _SubTex;
UNITY_LOCATION(3) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
float u_xlat3;
float u_xlat6;
float u_xlat10;
void main()
{
    u_xlat0.xy = _Time.yy * vec2(_DistScrollX, _DistScrollY);
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistTex_ST.xy + u_xlat0.xy;
    u_xlat16_0.xy = texture(_DistTex, u_xlat0.xy).xy;
    u_xlat1.y = u_xlat16_0.y + _DistTex_ST.w;
    u_xlat1.x = u_xlat16_0.x + -0.5;
    u_xlat0.x = _DistTex_ST.z;
    u_xlat0.y = -0.5;
    u_xlat0.xy = u_xlat0.xy + u_xlat1.xy;
    u_xlat6 = u_xlat1.x + _DistTex_ST.z;
    u_xlat16_1.xy = texture(_MaskTex, vs_TEXCOORD0.xy).xy;
    u_xlat0.xy = u_xlat0.xy * u_xlat16_1.yy;
    u_xlat0.xy = u_xlat0.xy * vec2(_Distortion) + vs_TEXCOORD0.xy;
    u_xlat16_2 = texture(_MainTex, u_xlat0.xy);
    u_xlat0.x = u_xlat16_2.w * _Color.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if(u_xlatb0){discard;}
    u_xlat0.x = u_xlat6 * u_xlat16_1.y;
    u_xlat3 = u_xlat16_1.x * _SubTexMix;
    u_xlat0.x = u_xlat0.x * _SubTexDistortion;
    u_xlat0.xz = vs_TEXCOORD0.xy * _SubTex_ST.xy + u_xlat0.xx;
    u_xlat0.xz = vec2(_SubTexScrollX, _SubTexScrollY) * _Time.xx + u_xlat0.xz;
    u_xlat16_1 = texture(_SubTex, u_xlat0.xz);
    u_xlat1 = u_xlat16_1 * _SubTexCol + (-u_xlat16_2);
    u_xlat0 = vec4(u_xlat3) * u_xlat1 + u_xlat16_2;
    u_xlat1.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat2.xy = vs_TEXCOORD1.xy;
    u_xlat2.z = vs_TEXCOORD2.x;
    u_xlat2.xyz = u_xlat2.xyz + _Black.xyz;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.w = 0.0;
    u_xlat0 = u_xlat0 * vs_COLOR0 + u_xlat1;
    u_xlat1.xyz = _GlobalAdditiveColor.www * _GlobalAdditiveColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_GlobalAdditiveIntensity);
    u_xlat2.xyz = u_xlat0.xyz * u_xlat0.www + (-u_xlat1.xyz);
    u_xlat1.xyz = u_xlat0.www * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.www * u_xlat0.xyz;
    u_xlat2.xyz = _GlobalAdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    u_xlat10 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    u_xlat0.xyz = vec3(u_xlat10) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    u_xlat0.xyz = vec3(vec3(_GlobalAdditiveMixParameter, _GlobalAdditiveMixParameter, _GlobalAdditiveMixParameter)) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    SV_Target0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.w = u_xlat0.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_STRAIGHT_ALPHA_INPUT" "_USE_CUTOFF" }
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
uniform 	vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD2.xy;
    u_xlat0.xyz = _Color.www * _Color.xyz;
    u_xlat0.w = _Color.w;
    vs_COLOR0 = u_xlat0 * in_COLOR0;
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
uniform 	vec4 _SubTex_ST;
uniform 	float _SubTexMix;
uniform 	float _SubTexScrollX;
uniform 	float _SubTexScrollY;
uniform 	vec4 _SubTexCol;
uniform 	vec4 _DistTex_ST;
uniform 	float _Distortion;
uniform 	float _SubTexDistortion;
uniform 	float _DistScrollX;
uniform 	float _DistScrollY;
uniform 	vec4 _Color;
uniform 	vec4 _Black;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
uniform 	float _GlobalAdditiveMixParameter;
uniform 	float _Cutoff;
UNITY_LOCATION(0) uniform mediump sampler2D _MaskTex;
UNITY_LOCATION(1) uniform mediump sampler2D _DistTex;
UNITY_LOCATION(2) uniform mediump sampler2D _SubTex;
UNITY_LOCATION(3) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
float u_xlat3;
float u_xlat6;
float u_xlat10;
void main()
{
    u_xlat0.xy = _Time.yy * vec2(_DistScrollX, _DistScrollY);
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistTex_ST.xy + u_xlat0.xy;
    u_xlat16_0.xy = texture(_DistTex, u_xlat0.xy).xy;
    u_xlat1.y = u_xlat16_0.y + _DistTex_ST.w;
    u_xlat1.x = u_xlat16_0.x + -0.5;
    u_xlat0.x = _DistTex_ST.z;
    u_xlat0.y = -0.5;
    u_xlat0.xy = u_xlat0.xy + u_xlat1.xy;
    u_xlat6 = u_xlat1.x + _DistTex_ST.z;
    u_xlat16_1.xy = texture(_MaskTex, vs_TEXCOORD0.xy).xy;
    u_xlat0.xy = u_xlat0.xy * u_xlat16_1.yy;
    u_xlat0.xy = u_xlat0.xy * vec2(_Distortion) + vs_TEXCOORD0.xy;
    u_xlat16_2 = texture(_MainTex, u_xlat0.xy);
    u_xlat0.x = u_xlat16_2.w * _Color.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if(u_xlatb0){discard;}
    u_xlat0.x = u_xlat6 * u_xlat16_1.y;
    u_xlat3 = u_xlat16_1.x * _SubTexMix;
    u_xlat0.x = u_xlat0.x * _SubTexDistortion;
    u_xlat0.xz = vs_TEXCOORD0.xy * _SubTex_ST.xy + u_xlat0.xx;
    u_xlat0.xz = vec2(_SubTexScrollX, _SubTexScrollY) * _Time.xx + u_xlat0.xz;
    u_xlat16_1 = texture(_SubTex, u_xlat0.xz);
    u_xlat1 = u_xlat16_1 * _SubTexCol + (-u_xlat16_2);
    u_xlat0 = vec4(u_xlat3) * u_xlat1 + u_xlat16_2;
    u_xlat1.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat2.xy = vs_TEXCOORD1.xy;
    u_xlat2.z = vs_TEXCOORD2.x;
    u_xlat2.xyz = u_xlat2.xyz + _Black.xyz;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.w = 0.0;
    u_xlat0 = u_xlat0 * vs_COLOR0 + u_xlat1;
    u_xlat1.xyz = _GlobalAdditiveColor.www * _GlobalAdditiveColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_GlobalAdditiveIntensity);
    u_xlat2.xyz = u_xlat0.xyz * u_xlat0.www + (-u_xlat1.xyz);
    u_xlat1.xyz = u_xlat0.www * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.www * u_xlat0.xyz;
    u_xlat2.xyz = _GlobalAdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    u_xlat10 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    u_xlat0.xyz = vec3(u_xlat10) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    u_xlat0.xyz = vec3(vec3(_GlobalAdditiveMixParameter, _GlobalAdditiveMixParameter, _GlobalAdditiveMixParameter)) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    SV_Target0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.w = u_xlat0.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_STRAIGHT_ALPHA_INPUT" "_USE_CUTOFF" }
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
uniform 	vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD2.xy;
    u_xlat0.xyz = _Color.www * _Color.xyz;
    u_xlat0.w = _Color.w;
    vs_COLOR0 = u_xlat0 * in_COLOR0;
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
uniform 	vec4 _SubTex_ST;
uniform 	float _SubTexMix;
uniform 	float _SubTexScrollX;
uniform 	float _SubTexScrollY;
uniform 	vec4 _SubTexCol;
uniform 	vec4 _DistTex_ST;
uniform 	float _Distortion;
uniform 	float _SubTexDistortion;
uniform 	float _DistScrollX;
uniform 	float _DistScrollY;
uniform 	vec4 _Color;
uniform 	vec4 _Black;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
uniform 	float _GlobalAdditiveMixParameter;
uniform 	float _Cutoff;
UNITY_LOCATION(0) uniform mediump sampler2D _MaskTex;
UNITY_LOCATION(1) uniform mediump sampler2D _DistTex;
UNITY_LOCATION(2) uniform mediump sampler2D _SubTex;
UNITY_LOCATION(3) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
float u_xlat3;
float u_xlat6;
float u_xlat10;
void main()
{
    u_xlat0.xy = _Time.yy * vec2(_DistScrollX, _DistScrollY);
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistTex_ST.xy + u_xlat0.xy;
    u_xlat16_0.xy = texture(_DistTex, u_xlat0.xy).xy;
    u_xlat1.y = u_xlat16_0.y + _DistTex_ST.w;
    u_xlat1.x = u_xlat16_0.x + -0.5;
    u_xlat0.x = _DistTex_ST.z;
    u_xlat0.y = -0.5;
    u_xlat0.xy = u_xlat0.xy + u_xlat1.xy;
    u_xlat6 = u_xlat1.x + _DistTex_ST.z;
    u_xlat16_1.xy = texture(_MaskTex, vs_TEXCOORD0.xy).xy;
    u_xlat0.xy = u_xlat0.xy * u_xlat16_1.yy;
    u_xlat0.xy = u_xlat0.xy * vec2(_Distortion) + vs_TEXCOORD0.xy;
    u_xlat16_2 = texture(_MainTex, u_xlat0.xy);
    u_xlat0.x = u_xlat16_2.w * _Color.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if(u_xlatb0){discard;}
    u_xlat0.x = u_xlat6 * u_xlat16_1.y;
    u_xlat3 = u_xlat16_1.x * _SubTexMix;
    u_xlat0.x = u_xlat0.x * _SubTexDistortion;
    u_xlat0.xz = vs_TEXCOORD0.xy * _SubTex_ST.xy + u_xlat0.xx;
    u_xlat0.xz = vec2(_SubTexScrollX, _SubTexScrollY) * _Time.xx + u_xlat0.xz;
    u_xlat16_1 = texture(_SubTex, u_xlat0.xz);
    u_xlat1 = u_xlat16_1 * _SubTexCol + (-u_xlat16_2);
    u_xlat0 = vec4(u_xlat3) * u_xlat1 + u_xlat16_2;
    u_xlat1.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat2.xy = vs_TEXCOORD1.xy;
    u_xlat2.z = vs_TEXCOORD2.x;
    u_xlat2.xyz = u_xlat2.xyz + _Black.xyz;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.w = 0.0;
    u_xlat0 = u_xlat0 * vs_COLOR0 + u_xlat1;
    u_xlat1.xyz = _GlobalAdditiveColor.www * _GlobalAdditiveColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_GlobalAdditiveIntensity);
    u_xlat2.xyz = u_xlat0.xyz * u_xlat0.www + (-u_xlat1.xyz);
    u_xlat1.xyz = u_xlat0.www * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat0.xyz = u_xlat0.www * u_xlat0.xyz;
    u_xlat2.xyz = _GlobalAdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    u_xlat10 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    u_xlat0.xyz = vec3(u_xlat10) * u_xlat2.xyz + u_xlat0.xyz;
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    u_xlat0.xyz = vec3(vec3(_GlobalAdditiveMixParameter, _GlobalAdditiveMixParameter, _GlobalAdditiveMixParameter)) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    SV_Target0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.w = u_xlat0.w;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "GRAYSCALE" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec2 in_TEXCOORD1;
attribute highp vec2 in_TEXCOORD2;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD2.xy;
    u_xlat0.xyz = _Color.www * _Color.xyz;
    u_xlat0.w = _Color.w;
    vs_COLOR0 = u_xlat0 * in_COLOR0;
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
uniform 	vec4 _SubTex_ST;
uniform 	float _SubTexMix;
uniform 	float _SubTexScrollX;
uniform 	float _SubTexScrollY;
uniform 	vec4 _SubTexCol;
uniform 	vec4 _DistTex_ST;
uniform 	float _Distortion;
uniform 	float _SubTexDistortion;
uniform 	float _DistScrollX;
uniform 	float _DistScrollY;
uniform 	vec4 _Color;
uniform 	vec4 _Black;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
uniform 	float _GlobalAdditiveMixParameter;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _DistTex;
uniform lowp sampler2D _SubTex;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
vec2 u_xlat3;
float u_xlat4;
lowp vec3 u_xlat10_4;
float u_xlat8;
vec2 u_xlat9;
vec2 u_xlat11;
void main()
{
    u_xlat0.xy = _Time.yy * vec2(_DistScrollX, _DistScrollY);
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistTex_ST.xy + u_xlat0.xy;
    u_xlat10_0.xy = texture2D(_DistTex, u_xlat0.xy).xy;
    u_xlat1.x = u_xlat10_0.x + -0.5;
    u_xlat1.y = u_xlat10_0.y + _DistTex_ST.w;
    u_xlat0.x = u_xlat1.x + _DistTex_ST.z;
    u_xlat10_4.xyz = texture2D(_MaskTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.x = u_xlat10_4.y * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _SubTexDistortion;
    u_xlat9.xy = vs_TEXCOORD0.xy * _SubTex_ST.xy + u_xlat0.xx;
    u_xlat9.xy = vec2(_SubTexScrollX, _SubTexScrollY) * _Time.xx + u_xlat9.xy;
    u_xlat10_2 = texture2D(_SubTex, u_xlat9.xy);
    u_xlat3.x = _DistTex_ST.z;
    u_xlat3.y = float(-0.5);
    u_xlat11.x = float(0.333299994);
    u_xlat1.xy = u_xlat1.xy + u_xlat3.xy;
    u_xlat0.xz = u_xlat10_4.yy * u_xlat1.xy;
    u_xlat0.xz = u_xlat0.xz * vec2(_Distortion) + vs_TEXCOORD0.xy;
    u_xlat10_1 = texture2D(_MainTex, u_xlat0.xz);
    u_xlat2 = u_xlat10_2 * _SubTexCol + (-u_xlat10_1);
    u_xlat0.x = u_xlat10_4.x * _SubTexMix;
    u_xlat4 = (-u_xlat10_4.z) + 1.0;
    u_xlat2 = u_xlat0.xxxx * u_xlat2 + u_xlat10_1;
    u_xlat11.y = u_xlat10_1.w * _Color.w;
    u_xlat0.xzw = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat1.xy = vs_TEXCOORD1.xy;
    u_xlat1.z = vs_TEXCOORD2.x;
    u_xlat1.xyz = u_xlat1.xyz + _Black.xyz;
    u_xlat1.xyz = u_xlat0.xzw * u_xlat1.xyz;
    u_xlat1.w = 0.0;
    u_xlat1 = u_xlat2.xwyz * vs_COLOR0.xwyz + u_xlat1.xwyz;
    u_xlat0.x = u_xlat1.z + u_xlat1.x;
    u_xlat0.x = u_xlat1.w + u_xlat0.x;
    u_xlat1.x = u_xlat11.y * u_xlat0.x;
    u_xlat0.xz = u_xlat11.xy * u_xlat1.xy;
    u_xlat1.xyz = _GlobalAdditiveColor.www * _GlobalAdditiveColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_GlobalAdditiveIntensity);
    u_xlat2.xyz = u_xlat0.xxx * vec3(u_xlat4) + (-u_xlat1.xyz);
    u_xlat0.xy = vec2(u_xlat4) * u_xlat0.xz;
    u_xlat1.xyz = u_xlat0.yyy * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat2.xyz = _GlobalAdditiveColor.xyz * u_xlat0.yyy + (-u_xlat0.xxx);
    u_xlat8 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    u_xlat0.xzw = vec3(u_xlat8) * u_xlat2.xyz + u_xlat0.xxx;
    u_xlat1.xyz = (-u_xlat0.xzw) + u_xlat1.xyz;
    u_xlat0.xzw = vec3(vec3(_GlobalAdditiveMixParameter, _GlobalAdditiveMixParameter, _GlobalAdditiveMixParameter)) * u_xlat1.xyz + u_xlat0.xzw;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat0.yyy + (-u_xlat0.xzw);
    SV_Target0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xzw;
    SV_Target0.w = u_xlat0.y;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "GRAYSCALE" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec2 in_TEXCOORD1;
attribute highp vec2 in_TEXCOORD2;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD2.xy;
    u_xlat0.xyz = _Color.www * _Color.xyz;
    u_xlat0.w = _Color.w;
    vs_COLOR0 = u_xlat0 * in_COLOR0;
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
uniform 	vec4 _SubTex_ST;
uniform 	float _SubTexMix;
uniform 	float _SubTexScrollX;
uniform 	float _SubTexScrollY;
uniform 	vec4 _SubTexCol;
uniform 	vec4 _DistTex_ST;
uniform 	float _Distortion;
uniform 	float _SubTexDistortion;
uniform 	float _DistScrollX;
uniform 	float _DistScrollY;
uniform 	vec4 _Color;
uniform 	vec4 _Black;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
uniform 	float _GlobalAdditiveMixParameter;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _DistTex;
uniform lowp sampler2D _SubTex;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
vec2 u_xlat3;
float u_xlat4;
lowp vec3 u_xlat10_4;
float u_xlat8;
vec2 u_xlat9;
vec2 u_xlat11;
void main()
{
    u_xlat0.xy = _Time.yy * vec2(_DistScrollX, _DistScrollY);
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistTex_ST.xy + u_xlat0.xy;
    u_xlat10_0.xy = texture2D(_DistTex, u_xlat0.xy).xy;
    u_xlat1.x = u_xlat10_0.x + -0.5;
    u_xlat1.y = u_xlat10_0.y + _DistTex_ST.w;
    u_xlat0.x = u_xlat1.x + _DistTex_ST.z;
    u_xlat10_4.xyz = texture2D(_MaskTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.x = u_xlat10_4.y * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _SubTexDistortion;
    u_xlat9.xy = vs_TEXCOORD0.xy * _SubTex_ST.xy + u_xlat0.xx;
    u_xlat9.xy = vec2(_SubTexScrollX, _SubTexScrollY) * _Time.xx + u_xlat9.xy;
    u_xlat10_2 = texture2D(_SubTex, u_xlat9.xy);
    u_xlat3.x = _DistTex_ST.z;
    u_xlat3.y = float(-0.5);
    u_xlat11.x = float(0.333299994);
    u_xlat1.xy = u_xlat1.xy + u_xlat3.xy;
    u_xlat0.xz = u_xlat10_4.yy * u_xlat1.xy;
    u_xlat0.xz = u_xlat0.xz * vec2(_Distortion) + vs_TEXCOORD0.xy;
    u_xlat10_1 = texture2D(_MainTex, u_xlat0.xz);
    u_xlat2 = u_xlat10_2 * _SubTexCol + (-u_xlat10_1);
    u_xlat0.x = u_xlat10_4.x * _SubTexMix;
    u_xlat4 = (-u_xlat10_4.z) + 1.0;
    u_xlat2 = u_xlat0.xxxx * u_xlat2 + u_xlat10_1;
    u_xlat11.y = u_xlat10_1.w * _Color.w;
    u_xlat0.xzw = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat1.xy = vs_TEXCOORD1.xy;
    u_xlat1.z = vs_TEXCOORD2.x;
    u_xlat1.xyz = u_xlat1.xyz + _Black.xyz;
    u_xlat1.xyz = u_xlat0.xzw * u_xlat1.xyz;
    u_xlat1.w = 0.0;
    u_xlat1 = u_xlat2.xwyz * vs_COLOR0.xwyz + u_xlat1.xwyz;
    u_xlat0.x = u_xlat1.z + u_xlat1.x;
    u_xlat0.x = u_xlat1.w + u_xlat0.x;
    u_xlat1.x = u_xlat11.y * u_xlat0.x;
    u_xlat0.xz = u_xlat11.xy * u_xlat1.xy;
    u_xlat1.xyz = _GlobalAdditiveColor.www * _GlobalAdditiveColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_GlobalAdditiveIntensity);
    u_xlat2.xyz = u_xlat0.xxx * vec3(u_xlat4) + (-u_xlat1.xyz);
    u_xlat0.xy = vec2(u_xlat4) * u_xlat0.xz;
    u_xlat1.xyz = u_xlat0.yyy * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat2.xyz = _GlobalAdditiveColor.xyz * u_xlat0.yyy + (-u_xlat0.xxx);
    u_xlat8 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    u_xlat0.xzw = vec3(u_xlat8) * u_xlat2.xyz + u_xlat0.xxx;
    u_xlat1.xyz = (-u_xlat0.xzw) + u_xlat1.xyz;
    u_xlat0.xzw = vec3(vec3(_GlobalAdditiveMixParameter, _GlobalAdditiveMixParameter, _GlobalAdditiveMixParameter)) * u_xlat1.xyz + u_xlat0.xzw;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat0.yyy + (-u_xlat0.xzw);
    SV_Target0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xzw;
    SV_Target0.w = u_xlat0.y;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "GRAYSCALE" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec2 in_TEXCOORD1;
attribute highp vec2 in_TEXCOORD2;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD2.xy;
    u_xlat0.xyz = _Color.www * _Color.xyz;
    u_xlat0.w = _Color.w;
    vs_COLOR0 = u_xlat0 * in_COLOR0;
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
uniform 	vec4 _SubTex_ST;
uniform 	float _SubTexMix;
uniform 	float _SubTexScrollX;
uniform 	float _SubTexScrollY;
uniform 	vec4 _SubTexCol;
uniform 	vec4 _DistTex_ST;
uniform 	float _Distortion;
uniform 	float _SubTexDistortion;
uniform 	float _DistScrollX;
uniform 	float _DistScrollY;
uniform 	vec4 _Color;
uniform 	vec4 _Black;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
uniform 	float _GlobalAdditiveMixParameter;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _DistTex;
uniform lowp sampler2D _SubTex;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
vec2 u_xlat3;
float u_xlat4;
lowp vec3 u_xlat10_4;
float u_xlat8;
vec2 u_xlat9;
vec2 u_xlat11;
void main()
{
    u_xlat0.xy = _Time.yy * vec2(_DistScrollX, _DistScrollY);
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistTex_ST.xy + u_xlat0.xy;
    u_xlat10_0.xy = texture2D(_DistTex, u_xlat0.xy).xy;
    u_xlat1.x = u_xlat10_0.x + -0.5;
    u_xlat1.y = u_xlat10_0.y + _DistTex_ST.w;
    u_xlat0.x = u_xlat1.x + _DistTex_ST.z;
    u_xlat10_4.xyz = texture2D(_MaskTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.x = u_xlat10_4.y * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _SubTexDistortion;
    u_xlat9.xy = vs_TEXCOORD0.xy * _SubTex_ST.xy + u_xlat0.xx;
    u_xlat9.xy = vec2(_SubTexScrollX, _SubTexScrollY) * _Time.xx + u_xlat9.xy;
    u_xlat10_2 = texture2D(_SubTex, u_xlat9.xy);
    u_xlat3.x = _DistTex_ST.z;
    u_xlat3.y = float(-0.5);
    u_xlat11.x = float(0.333299994);
    u_xlat1.xy = u_xlat1.xy + u_xlat3.xy;
    u_xlat0.xz = u_xlat10_4.yy * u_xlat1.xy;
    u_xlat0.xz = u_xlat0.xz * vec2(_Distortion) + vs_TEXCOORD0.xy;
    u_xlat10_1 = texture2D(_MainTex, u_xlat0.xz);
    u_xlat2 = u_xlat10_2 * _SubTexCol + (-u_xlat10_1);
    u_xlat0.x = u_xlat10_4.x * _SubTexMix;
    u_xlat4 = (-u_xlat10_4.z) + 1.0;
    u_xlat2 = u_xlat0.xxxx * u_xlat2 + u_xlat10_1;
    u_xlat11.y = u_xlat10_1.w * _Color.w;
    u_xlat0.xzw = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat1.xy = vs_TEXCOORD1.xy;
    u_xlat1.z = vs_TEXCOORD2.x;
    u_xlat1.xyz = u_xlat1.xyz + _Black.xyz;
    u_xlat1.xyz = u_xlat0.xzw * u_xlat1.xyz;
    u_xlat1.w = 0.0;
    u_xlat1 = u_xlat2.xwyz * vs_COLOR0.xwyz + u_xlat1.xwyz;
    u_xlat0.x = u_xlat1.z + u_xlat1.x;
    u_xlat0.x = u_xlat1.w + u_xlat0.x;
    u_xlat1.x = u_xlat11.y * u_xlat0.x;
    u_xlat0.xz = u_xlat11.xy * u_xlat1.xy;
    u_xlat1.xyz = _GlobalAdditiveColor.www * _GlobalAdditiveColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_GlobalAdditiveIntensity);
    u_xlat2.xyz = u_xlat0.xxx * vec3(u_xlat4) + (-u_xlat1.xyz);
    u_xlat0.xy = vec2(u_xlat4) * u_xlat0.xz;
    u_xlat1.xyz = u_xlat0.yyy * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat2.xyz = _GlobalAdditiveColor.xyz * u_xlat0.yyy + (-u_xlat0.xxx);
    u_xlat8 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    u_xlat0.xzw = vec3(u_xlat8) * u_xlat2.xyz + u_xlat0.xxx;
    u_xlat1.xyz = (-u_xlat0.xzw) + u_xlat1.xyz;
    u_xlat0.xzw = vec3(vec3(_GlobalAdditiveMixParameter, _GlobalAdditiveMixParameter, _GlobalAdditiveMixParameter)) * u_xlat1.xyz + u_xlat0.xzw;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat0.yyy + (-u_xlat0.xzw);
    SV_Target0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xzw;
    SV_Target0.w = u_xlat0.y;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "GRAYSCALE" }
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
uniform 	vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD2.xy;
    u_xlat0.xyz = _Color.www * _Color.xyz;
    u_xlat0.w = _Color.w;
    vs_COLOR0 = u_xlat0 * in_COLOR0;
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
uniform 	vec4 _SubTex_ST;
uniform 	float _SubTexMix;
uniform 	float _SubTexScrollX;
uniform 	float _SubTexScrollY;
uniform 	vec4 _SubTexCol;
uniform 	vec4 _DistTex_ST;
uniform 	float _Distortion;
uniform 	float _SubTexDistortion;
uniform 	float _DistScrollX;
uniform 	float _DistScrollY;
uniform 	vec4 _Color;
uniform 	vec4 _Black;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
uniform 	float _GlobalAdditiveMixParameter;
UNITY_LOCATION(0) uniform mediump sampler2D _MaskTex;
UNITY_LOCATION(1) uniform mediump sampler2D _DistTex;
UNITY_LOCATION(2) uniform mediump sampler2D _SubTex;
UNITY_LOCATION(3) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec2 u_xlat3;
float u_xlat4;
mediump vec3 u_xlat16_4;
float u_xlat8;
vec2 u_xlat9;
vec2 u_xlat11;
void main()
{
    u_xlat0.xy = _Time.yy * vec2(_DistScrollX, _DistScrollY);
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistTex_ST.xy + u_xlat0.xy;
    u_xlat16_0.xy = texture(_DistTex, u_xlat0.xy).xy;
    u_xlat1.x = u_xlat16_0.x + -0.5;
    u_xlat1.y = u_xlat16_0.y + _DistTex_ST.w;
    u_xlat0.x = u_xlat1.x + _DistTex_ST.z;
    u_xlat16_4.xyz = texture(_MaskTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.x = u_xlat16_4.y * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _SubTexDistortion;
    u_xlat9.xy = vs_TEXCOORD0.xy * _SubTex_ST.xy + u_xlat0.xx;
    u_xlat9.xy = vec2(_SubTexScrollX, _SubTexScrollY) * _Time.xx + u_xlat9.xy;
    u_xlat16_2 = texture(_SubTex, u_xlat9.xy);
    u_xlat3.x = _DistTex_ST.z;
    u_xlat3.y = float(-0.5);
    u_xlat11.x = float(0.333299994);
    u_xlat1.xy = u_xlat1.xy + u_xlat3.xy;
    u_xlat0.xz = u_xlat16_4.yy * u_xlat1.xy;
    u_xlat0.xz = u_xlat0.xz * vec2(_Distortion) + vs_TEXCOORD0.xy;
    u_xlat16_1 = texture(_MainTex, u_xlat0.xz);
    u_xlat2 = u_xlat16_2 * _SubTexCol + (-u_xlat16_1);
    u_xlat0.x = u_xlat16_4.x * _SubTexMix;
    u_xlat4 = (-u_xlat16_4.z) + 1.0;
    u_xlat2 = u_xlat0.xxxx * u_xlat2 + u_xlat16_1;
    u_xlat11.y = u_xlat16_1.w * _Color.w;
    u_xlat0.xzw = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat1.xy = vs_TEXCOORD1.xy;
    u_xlat1.z = vs_TEXCOORD2.x;
    u_xlat1.xyz = u_xlat1.xyz + _Black.xyz;
    u_xlat1.xyz = u_xlat0.xzw * u_xlat1.xyz;
    u_xlat1.w = 0.0;
    u_xlat1 = u_xlat2.xwyz * vs_COLOR0.xwyz + u_xlat1.xwyz;
    u_xlat0.x = u_xlat1.z + u_xlat1.x;
    u_xlat0.x = u_xlat1.w + u_xlat0.x;
    u_xlat1.x = u_xlat11.y * u_xlat0.x;
    u_xlat0.xz = u_xlat11.xy * u_xlat1.xy;
    u_xlat1.xyz = _GlobalAdditiveColor.www * _GlobalAdditiveColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_GlobalAdditiveIntensity);
    u_xlat2.xyz = u_xlat0.xxx * vec3(u_xlat4) + (-u_xlat1.xyz);
    u_xlat0.xy = vec2(u_xlat4) * u_xlat0.xz;
    u_xlat1.xyz = u_xlat0.yyy * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat2.xyz = _GlobalAdditiveColor.xyz * u_xlat0.yyy + (-u_xlat0.xxx);
    u_xlat8 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    u_xlat0.xzw = vec3(u_xlat8) * u_xlat2.xyz + u_xlat0.xxx;
    u_xlat1.xyz = (-u_xlat0.xzw) + u_xlat1.xyz;
    u_xlat0.xzw = vec3(vec3(_GlobalAdditiveMixParameter, _GlobalAdditiveMixParameter, _GlobalAdditiveMixParameter)) * u_xlat1.xyz + u_xlat0.xzw;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat0.yyy + (-u_xlat0.xzw);
    SV_Target0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xzw;
    SV_Target0.w = u_xlat0.y;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "GRAYSCALE" }
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
uniform 	vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD2.xy;
    u_xlat0.xyz = _Color.www * _Color.xyz;
    u_xlat0.w = _Color.w;
    vs_COLOR0 = u_xlat0 * in_COLOR0;
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
uniform 	vec4 _SubTex_ST;
uniform 	float _SubTexMix;
uniform 	float _SubTexScrollX;
uniform 	float _SubTexScrollY;
uniform 	vec4 _SubTexCol;
uniform 	vec4 _DistTex_ST;
uniform 	float _Distortion;
uniform 	float _SubTexDistortion;
uniform 	float _DistScrollX;
uniform 	float _DistScrollY;
uniform 	vec4 _Color;
uniform 	vec4 _Black;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
uniform 	float _GlobalAdditiveMixParameter;
UNITY_LOCATION(0) uniform mediump sampler2D _MaskTex;
UNITY_LOCATION(1) uniform mediump sampler2D _DistTex;
UNITY_LOCATION(2) uniform mediump sampler2D _SubTex;
UNITY_LOCATION(3) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec2 u_xlat3;
float u_xlat4;
mediump vec3 u_xlat16_4;
float u_xlat8;
vec2 u_xlat9;
vec2 u_xlat11;
void main()
{
    u_xlat0.xy = _Time.yy * vec2(_DistScrollX, _DistScrollY);
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistTex_ST.xy + u_xlat0.xy;
    u_xlat16_0.xy = texture(_DistTex, u_xlat0.xy).xy;
    u_xlat1.x = u_xlat16_0.x + -0.5;
    u_xlat1.y = u_xlat16_0.y + _DistTex_ST.w;
    u_xlat0.x = u_xlat1.x + _DistTex_ST.z;
    u_xlat16_4.xyz = texture(_MaskTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.x = u_xlat16_4.y * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _SubTexDistortion;
    u_xlat9.xy = vs_TEXCOORD0.xy * _SubTex_ST.xy + u_xlat0.xx;
    u_xlat9.xy = vec2(_SubTexScrollX, _SubTexScrollY) * _Time.xx + u_xlat9.xy;
    u_xlat16_2 = texture(_SubTex, u_xlat9.xy);
    u_xlat3.x = _DistTex_ST.z;
    u_xlat3.y = float(-0.5);
    u_xlat11.x = float(0.333299994);
    u_xlat1.xy = u_xlat1.xy + u_xlat3.xy;
    u_xlat0.xz = u_xlat16_4.yy * u_xlat1.xy;
    u_xlat0.xz = u_xlat0.xz * vec2(_Distortion) + vs_TEXCOORD0.xy;
    u_xlat16_1 = texture(_MainTex, u_xlat0.xz);
    u_xlat2 = u_xlat16_2 * _SubTexCol + (-u_xlat16_1);
    u_xlat0.x = u_xlat16_4.x * _SubTexMix;
    u_xlat4 = (-u_xlat16_4.z) + 1.0;
    u_xlat2 = u_xlat0.xxxx * u_xlat2 + u_xlat16_1;
    u_xlat11.y = u_xlat16_1.w * _Color.w;
    u_xlat0.xzw = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat1.xy = vs_TEXCOORD1.xy;
    u_xlat1.z = vs_TEXCOORD2.x;
    u_xlat1.xyz = u_xlat1.xyz + _Black.xyz;
    u_xlat1.xyz = u_xlat0.xzw * u_xlat1.xyz;
    u_xlat1.w = 0.0;
    u_xlat1 = u_xlat2.xwyz * vs_COLOR0.xwyz + u_xlat1.xwyz;
    u_xlat0.x = u_xlat1.z + u_xlat1.x;
    u_xlat0.x = u_xlat1.w + u_xlat0.x;
    u_xlat1.x = u_xlat11.y * u_xlat0.x;
    u_xlat0.xz = u_xlat11.xy * u_xlat1.xy;
    u_xlat1.xyz = _GlobalAdditiveColor.www * _GlobalAdditiveColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_GlobalAdditiveIntensity);
    u_xlat2.xyz = u_xlat0.xxx * vec3(u_xlat4) + (-u_xlat1.xyz);
    u_xlat0.xy = vec2(u_xlat4) * u_xlat0.xz;
    u_xlat1.xyz = u_xlat0.yyy * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat2.xyz = _GlobalAdditiveColor.xyz * u_xlat0.yyy + (-u_xlat0.xxx);
    u_xlat8 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    u_xlat0.xzw = vec3(u_xlat8) * u_xlat2.xyz + u_xlat0.xxx;
    u_xlat1.xyz = (-u_xlat0.xzw) + u_xlat1.xyz;
    u_xlat0.xzw = vec3(vec3(_GlobalAdditiveMixParameter, _GlobalAdditiveMixParameter, _GlobalAdditiveMixParameter)) * u_xlat1.xyz + u_xlat0.xzw;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat0.yyy + (-u_xlat0.xzw);
    SV_Target0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xzw;
    SV_Target0.w = u_xlat0.y;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "GRAYSCALE" }
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
uniform 	vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD2.xy;
    u_xlat0.xyz = _Color.www * _Color.xyz;
    u_xlat0.w = _Color.w;
    vs_COLOR0 = u_xlat0 * in_COLOR0;
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
uniform 	vec4 _SubTex_ST;
uniform 	float _SubTexMix;
uniform 	float _SubTexScrollX;
uniform 	float _SubTexScrollY;
uniform 	vec4 _SubTexCol;
uniform 	vec4 _DistTex_ST;
uniform 	float _Distortion;
uniform 	float _SubTexDistortion;
uniform 	float _DistScrollX;
uniform 	float _DistScrollY;
uniform 	vec4 _Color;
uniform 	vec4 _Black;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
uniform 	float _GlobalAdditiveMixParameter;
UNITY_LOCATION(0) uniform mediump sampler2D _MaskTex;
UNITY_LOCATION(1) uniform mediump sampler2D _DistTex;
UNITY_LOCATION(2) uniform mediump sampler2D _SubTex;
UNITY_LOCATION(3) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec2 u_xlat3;
float u_xlat4;
mediump vec3 u_xlat16_4;
float u_xlat8;
vec2 u_xlat9;
vec2 u_xlat11;
void main()
{
    u_xlat0.xy = _Time.yy * vec2(_DistScrollX, _DistScrollY);
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistTex_ST.xy + u_xlat0.xy;
    u_xlat16_0.xy = texture(_DistTex, u_xlat0.xy).xy;
    u_xlat1.x = u_xlat16_0.x + -0.5;
    u_xlat1.y = u_xlat16_0.y + _DistTex_ST.w;
    u_xlat0.x = u_xlat1.x + _DistTex_ST.z;
    u_xlat16_4.xyz = texture(_MaskTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.x = u_xlat16_4.y * u_xlat0.x;
    u_xlat0.x = u_xlat0.x * _SubTexDistortion;
    u_xlat9.xy = vs_TEXCOORD0.xy * _SubTex_ST.xy + u_xlat0.xx;
    u_xlat9.xy = vec2(_SubTexScrollX, _SubTexScrollY) * _Time.xx + u_xlat9.xy;
    u_xlat16_2 = texture(_SubTex, u_xlat9.xy);
    u_xlat3.x = _DistTex_ST.z;
    u_xlat3.y = float(-0.5);
    u_xlat11.x = float(0.333299994);
    u_xlat1.xy = u_xlat1.xy + u_xlat3.xy;
    u_xlat0.xz = u_xlat16_4.yy * u_xlat1.xy;
    u_xlat0.xz = u_xlat0.xz * vec2(_Distortion) + vs_TEXCOORD0.xy;
    u_xlat16_1 = texture(_MainTex, u_xlat0.xz);
    u_xlat2 = u_xlat16_2 * _SubTexCol + (-u_xlat16_1);
    u_xlat0.x = u_xlat16_4.x * _SubTexMix;
    u_xlat4 = (-u_xlat16_4.z) + 1.0;
    u_xlat2 = u_xlat0.xxxx * u_xlat2 + u_xlat16_1;
    u_xlat11.y = u_xlat16_1.w * _Color.w;
    u_xlat0.xzw = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat1.xy = vs_TEXCOORD1.xy;
    u_xlat1.z = vs_TEXCOORD2.x;
    u_xlat1.xyz = u_xlat1.xyz + _Black.xyz;
    u_xlat1.xyz = u_xlat0.xzw * u_xlat1.xyz;
    u_xlat1.w = 0.0;
    u_xlat1 = u_xlat2.xwyz * vs_COLOR0.xwyz + u_xlat1.xwyz;
    u_xlat0.x = u_xlat1.z + u_xlat1.x;
    u_xlat0.x = u_xlat1.w + u_xlat0.x;
    u_xlat1.x = u_xlat11.y * u_xlat0.x;
    u_xlat0.xz = u_xlat11.xy * u_xlat1.xy;
    u_xlat1.xyz = _GlobalAdditiveColor.www * _GlobalAdditiveColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_GlobalAdditiveIntensity);
    u_xlat2.xyz = u_xlat0.xxx * vec3(u_xlat4) + (-u_xlat1.xyz);
    u_xlat0.xy = vec2(u_xlat4) * u_xlat0.xz;
    u_xlat1.xyz = u_xlat0.yyy * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat2.xyz = _GlobalAdditiveColor.xyz * u_xlat0.yyy + (-u_xlat0.xxx);
    u_xlat8 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    u_xlat0.xzw = vec3(u_xlat8) * u_xlat2.xyz + u_xlat0.xxx;
    u_xlat1.xyz = (-u_xlat0.xzw) + u_xlat1.xyz;
    u_xlat0.xzw = vec3(vec3(_GlobalAdditiveMixParameter, _GlobalAdditiveMixParameter, _GlobalAdditiveMixParameter)) * u_xlat1.xyz + u_xlat0.xzw;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat0.yyy + (-u_xlat0.xzw);
    SV_Target0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xzw;
    SV_Target0.w = u_xlat0.y;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "GRAYSCALE" "_USE_CUTOFF" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec2 in_TEXCOORD1;
attribute highp vec2 in_TEXCOORD2;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD2.xy;
    u_xlat0.xyz = _Color.www * _Color.xyz;
    u_xlat0.w = _Color.w;
    vs_COLOR0 = u_xlat0 * in_COLOR0;
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
uniform 	vec4 _SubTex_ST;
uniform 	float _SubTexMix;
uniform 	float _SubTexScrollX;
uniform 	float _SubTexScrollY;
uniform 	vec4 _SubTexCol;
uniform 	vec4 _DistTex_ST;
uniform 	float _Distortion;
uniform 	float _SubTexDistortion;
uniform 	float _DistScrollX;
uniform 	float _DistScrollY;
uniform 	vec4 _Color;
uniform 	vec4 _Black;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
uniform 	float _GlobalAdditiveMixParameter;
uniform 	float _Cutoff;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _DistTex;
uniform lowp sampler2D _SubTex;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
vec4 u_xlat3;
lowp vec4 u_xlat10_3;
float u_xlat4;
lowp vec3 u_xlat10_5;
vec2 u_xlat8;
void main()
{
    u_xlat0.xy = _Time.yy * vec2(_DistScrollX, _DistScrollY);
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistTex_ST.xy + u_xlat0.xy;
    u_xlat10_0.xy = texture2D(_DistTex, u_xlat0.xy).xy;
    u_xlat1.y = u_xlat10_0.y + _DistTex_ST.w;
    u_xlat1.x = u_xlat10_0.x + -0.5;
    u_xlat0.x = _DistTex_ST.z;
    u_xlat0.y = float(-0.5);
    u_xlat8.x = float(0.333299994);
    u_xlat0.xy = u_xlat0.xy + u_xlat1.xy;
    u_xlat1.x = u_xlat1.x + _DistTex_ST.z;
    u_xlat10_5.xyz = texture2D(_MaskTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xy = u_xlat0.xy * u_xlat10_5.yy;
    u_xlat0.xy = u_xlat0.xy * vec2(_Distortion) + vs_TEXCOORD0.xy;
    u_xlat10_2 = texture2D(_MainTex, u_xlat0.xy);
    u_xlat0.x = u_xlat10_2.w * _Color.w + (-_Cutoff);
    u_xlatb0 = u_xlat0.x<0.0;
    if(u_xlatb0){discard;}
    u_xlat0.x = u_xlat10_5.y * u_xlat1.x;
    u_xlat0.x = u_xlat0.x * _SubTexDistortion;
    u_xlat0.xy = vs_TEXCOORD0.xy * _SubTex_ST.xy + u_xlat0.xx;
    u_xlat0.xy = vec2(_SubTexScrollX, _SubTexScrollY) * _Time.xx + u_xlat0.xy;
    u_xlat10_3 = texture2D(_SubTex, u_xlat0.xy);
    u_xlat3 = u_xlat10_3 * _SubTexCol + (-u_xlat10_2);
    u_xlat0.x = u_xlat10_5.x * _SubTexMix;
    u_xlat4 = (-u_xlat10_5.z) + 1.0;
    u_xlat1 = u_xlat0.xxxx * u_xlat3 + u_xlat10_2;
    u_xlat8.y = u_xlat10_2.w * _Color.w;
    u_xlat2.xyz = (-u_xlat1.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat3.xy = vs_TEXCOORD1.xy;
    u_xlat3.z = vs_TEXCOORD2.x;
    u_xlat3.xyz = u_xlat3.xyz + _Black.xyz;
    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.xyz;
    u_xlat2.w = 0.0;
    u_xlat1 = u_xlat1.xwyz * vs_COLOR0.xwyz + u_xlat2.xwyz;
    u_xlat0.x = u_xlat1.z + u_xlat1.x;
    u_xlat0.x = u_xlat1.w + u_xlat0.x;
    u_xlat1.x = u_xlat8.y * u_xlat0.x;
    u_xlat0.xz = u_xlat8.xy * u_xlat1.xy;
    u_xlat1.xyz = _GlobalAdditiveColor.www * _GlobalAdditiveColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_GlobalAdditiveIntensity);
    u_xlat2.xyz = u_xlat0.xxx * vec3(u_xlat4) + (-u_xlat1.xyz);
    u_xlat0.xy = vec2(u_xlat4) * u_xlat0.xz;
    u_xlat1.xyz = u_xlat0.yyy * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat2.xyz = _GlobalAdditiveColor.xyz * u_xlat0.yyy + (-u_xlat0.xxx);
    u_xlat8.x = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    u_xlat0.xzw = u_xlat8.xxx * u_xlat2.xyz + u_xlat0.xxx;
    u_xlat1.xyz = (-u_xlat0.xzw) + u_xlat1.xyz;
    u_xlat0.xzw = vec3(vec3(_GlobalAdditiveMixParameter, _GlobalAdditiveMixParameter, _GlobalAdditiveMixParameter)) * u_xlat1.xyz + u_xlat0.xzw;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat0.yyy + (-u_xlat0.xzw);
    SV_Target0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xzw;
    SV_Target0.w = u_xlat0.y;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "GRAYSCALE" "_USE_CUTOFF" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec2 in_TEXCOORD1;
attribute highp vec2 in_TEXCOORD2;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD2.xy;
    u_xlat0.xyz = _Color.www * _Color.xyz;
    u_xlat0.w = _Color.w;
    vs_COLOR0 = u_xlat0 * in_COLOR0;
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
uniform 	vec4 _SubTex_ST;
uniform 	float _SubTexMix;
uniform 	float _SubTexScrollX;
uniform 	float _SubTexScrollY;
uniform 	vec4 _SubTexCol;
uniform 	vec4 _DistTex_ST;
uniform 	float _Distortion;
uniform 	float _SubTexDistortion;
uniform 	float _DistScrollX;
uniform 	float _DistScrollY;
uniform 	vec4 _Color;
uniform 	vec4 _Black;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
uniform 	float _GlobalAdditiveMixParameter;
uniform 	float _Cutoff;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _DistTex;
uniform lowp sampler2D _SubTex;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
vec4 u_xlat3;
lowp vec4 u_xlat10_3;
float u_xlat4;
lowp vec3 u_xlat10_5;
vec2 u_xlat8;
void main()
{
    u_xlat0.xy = _Time.yy * vec2(_DistScrollX, _DistScrollY);
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistTex_ST.xy + u_xlat0.xy;
    u_xlat10_0.xy = texture2D(_DistTex, u_xlat0.xy).xy;
    u_xlat1.y = u_xlat10_0.y + _DistTex_ST.w;
    u_xlat1.x = u_xlat10_0.x + -0.5;
    u_xlat0.x = _DistTex_ST.z;
    u_xlat0.y = float(-0.5);
    u_xlat8.x = float(0.333299994);
    u_xlat0.xy = u_xlat0.xy + u_xlat1.xy;
    u_xlat1.x = u_xlat1.x + _DistTex_ST.z;
    u_xlat10_5.xyz = texture2D(_MaskTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xy = u_xlat0.xy * u_xlat10_5.yy;
    u_xlat0.xy = u_xlat0.xy * vec2(_Distortion) + vs_TEXCOORD0.xy;
    u_xlat10_2 = texture2D(_MainTex, u_xlat0.xy);
    u_xlat0.x = u_xlat10_2.w * _Color.w + (-_Cutoff);
    u_xlatb0 = u_xlat0.x<0.0;
    if(u_xlatb0){discard;}
    u_xlat0.x = u_xlat10_5.y * u_xlat1.x;
    u_xlat0.x = u_xlat0.x * _SubTexDistortion;
    u_xlat0.xy = vs_TEXCOORD0.xy * _SubTex_ST.xy + u_xlat0.xx;
    u_xlat0.xy = vec2(_SubTexScrollX, _SubTexScrollY) * _Time.xx + u_xlat0.xy;
    u_xlat10_3 = texture2D(_SubTex, u_xlat0.xy);
    u_xlat3 = u_xlat10_3 * _SubTexCol + (-u_xlat10_2);
    u_xlat0.x = u_xlat10_5.x * _SubTexMix;
    u_xlat4 = (-u_xlat10_5.z) + 1.0;
    u_xlat1 = u_xlat0.xxxx * u_xlat3 + u_xlat10_2;
    u_xlat8.y = u_xlat10_2.w * _Color.w;
    u_xlat2.xyz = (-u_xlat1.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat3.xy = vs_TEXCOORD1.xy;
    u_xlat3.z = vs_TEXCOORD2.x;
    u_xlat3.xyz = u_xlat3.xyz + _Black.xyz;
    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.xyz;
    u_xlat2.w = 0.0;
    u_xlat1 = u_xlat1.xwyz * vs_COLOR0.xwyz + u_xlat2.xwyz;
    u_xlat0.x = u_xlat1.z + u_xlat1.x;
    u_xlat0.x = u_xlat1.w + u_xlat0.x;
    u_xlat1.x = u_xlat8.y * u_xlat0.x;
    u_xlat0.xz = u_xlat8.xy * u_xlat1.xy;
    u_xlat1.xyz = _GlobalAdditiveColor.www * _GlobalAdditiveColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_GlobalAdditiveIntensity);
    u_xlat2.xyz = u_xlat0.xxx * vec3(u_xlat4) + (-u_xlat1.xyz);
    u_xlat0.xy = vec2(u_xlat4) * u_xlat0.xz;
    u_xlat1.xyz = u_xlat0.yyy * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat2.xyz = _GlobalAdditiveColor.xyz * u_xlat0.yyy + (-u_xlat0.xxx);
    u_xlat8.x = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    u_xlat0.xzw = u_xlat8.xxx * u_xlat2.xyz + u_xlat0.xxx;
    u_xlat1.xyz = (-u_xlat0.xzw) + u_xlat1.xyz;
    u_xlat0.xzw = vec3(vec3(_GlobalAdditiveMixParameter, _GlobalAdditiveMixParameter, _GlobalAdditiveMixParameter)) * u_xlat1.xyz + u_xlat0.xzw;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat0.yyy + (-u_xlat0.xzw);
    SV_Target0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xzw;
    SV_Target0.w = u_xlat0.y;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "GRAYSCALE" "_USE_CUTOFF" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec2 in_TEXCOORD1;
attribute highp vec2 in_TEXCOORD2;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD2.xy;
    u_xlat0.xyz = _Color.www * _Color.xyz;
    u_xlat0.w = _Color.w;
    vs_COLOR0 = u_xlat0 * in_COLOR0;
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
uniform 	vec4 _SubTex_ST;
uniform 	float _SubTexMix;
uniform 	float _SubTexScrollX;
uniform 	float _SubTexScrollY;
uniform 	vec4 _SubTexCol;
uniform 	vec4 _DistTex_ST;
uniform 	float _Distortion;
uniform 	float _SubTexDistortion;
uniform 	float _DistScrollX;
uniform 	float _DistScrollY;
uniform 	vec4 _Color;
uniform 	vec4 _Black;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
uniform 	float _GlobalAdditiveMixParameter;
uniform 	float _Cutoff;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _DistTex;
uniform lowp sampler2D _SubTex;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
lowp vec4 u_xlat10_2;
vec4 u_xlat3;
lowp vec4 u_xlat10_3;
float u_xlat4;
lowp vec3 u_xlat10_5;
vec2 u_xlat8;
void main()
{
    u_xlat0.xy = _Time.yy * vec2(_DistScrollX, _DistScrollY);
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistTex_ST.xy + u_xlat0.xy;
    u_xlat10_0.xy = texture2D(_DistTex, u_xlat0.xy).xy;
    u_xlat1.y = u_xlat10_0.y + _DistTex_ST.w;
    u_xlat1.x = u_xlat10_0.x + -0.5;
    u_xlat0.x = _DistTex_ST.z;
    u_xlat0.y = float(-0.5);
    u_xlat8.x = float(0.333299994);
    u_xlat0.xy = u_xlat0.xy + u_xlat1.xy;
    u_xlat1.x = u_xlat1.x + _DistTex_ST.z;
    u_xlat10_5.xyz = texture2D(_MaskTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xy = u_xlat0.xy * u_xlat10_5.yy;
    u_xlat0.xy = u_xlat0.xy * vec2(_Distortion) + vs_TEXCOORD0.xy;
    u_xlat10_2 = texture2D(_MainTex, u_xlat0.xy);
    u_xlat0.x = u_xlat10_2.w * _Color.w + (-_Cutoff);
    u_xlatb0 = u_xlat0.x<0.0;
    if(u_xlatb0){discard;}
    u_xlat0.x = u_xlat10_5.y * u_xlat1.x;
    u_xlat0.x = u_xlat0.x * _SubTexDistortion;
    u_xlat0.xy = vs_TEXCOORD0.xy * _SubTex_ST.xy + u_xlat0.xx;
    u_xlat0.xy = vec2(_SubTexScrollX, _SubTexScrollY) * _Time.xx + u_xlat0.xy;
    u_xlat10_3 = texture2D(_SubTex, u_xlat0.xy);
    u_xlat3 = u_xlat10_3 * _SubTexCol + (-u_xlat10_2);
    u_xlat0.x = u_xlat10_5.x * _SubTexMix;
    u_xlat4 = (-u_xlat10_5.z) + 1.0;
    u_xlat1 = u_xlat0.xxxx * u_xlat3 + u_xlat10_2;
    u_xlat8.y = u_xlat10_2.w * _Color.w;
    u_xlat2.xyz = (-u_xlat1.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat3.xy = vs_TEXCOORD1.xy;
    u_xlat3.z = vs_TEXCOORD2.x;
    u_xlat3.xyz = u_xlat3.xyz + _Black.xyz;
    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.xyz;
    u_xlat2.w = 0.0;
    u_xlat1 = u_xlat1.xwyz * vs_COLOR0.xwyz + u_xlat2.xwyz;
    u_xlat0.x = u_xlat1.z + u_xlat1.x;
    u_xlat0.x = u_xlat1.w + u_xlat0.x;
    u_xlat1.x = u_xlat8.y * u_xlat0.x;
    u_xlat0.xz = u_xlat8.xy * u_xlat1.xy;
    u_xlat1.xyz = _GlobalAdditiveColor.www * _GlobalAdditiveColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_GlobalAdditiveIntensity);
    u_xlat2.xyz = u_xlat0.xxx * vec3(u_xlat4) + (-u_xlat1.xyz);
    u_xlat0.xy = vec2(u_xlat4) * u_xlat0.xz;
    u_xlat1.xyz = u_xlat0.yyy * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat2.xyz = _GlobalAdditiveColor.xyz * u_xlat0.yyy + (-u_xlat0.xxx);
    u_xlat8.x = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    u_xlat0.xzw = u_xlat8.xxx * u_xlat2.xyz + u_xlat0.xxx;
    u_xlat1.xyz = (-u_xlat0.xzw) + u_xlat1.xyz;
    u_xlat0.xzw = vec3(vec3(_GlobalAdditiveMixParameter, _GlobalAdditiveMixParameter, _GlobalAdditiveMixParameter)) * u_xlat1.xyz + u_xlat0.xzw;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat0.yyy + (-u_xlat0.xzw);
    SV_Target0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xzw;
    SV_Target0.w = u_xlat0.y;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "GRAYSCALE" "_USE_CUTOFF" }
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
uniform 	vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD2.xy;
    u_xlat0.xyz = _Color.www * _Color.xyz;
    u_xlat0.w = _Color.w;
    vs_COLOR0 = u_xlat0 * in_COLOR0;
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
uniform 	vec4 _SubTex_ST;
uniform 	float _SubTexMix;
uniform 	float _SubTexScrollX;
uniform 	float _SubTexScrollY;
uniform 	vec4 _SubTexCol;
uniform 	vec4 _DistTex_ST;
uniform 	float _Distortion;
uniform 	float _SubTexDistortion;
uniform 	float _DistScrollX;
uniform 	float _DistScrollY;
uniform 	vec4 _Color;
uniform 	vec4 _Black;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
uniform 	float _GlobalAdditiveMixParameter;
uniform 	float _Cutoff;
UNITY_LOCATION(0) uniform mediump sampler2D _MaskTex;
UNITY_LOCATION(1) uniform mediump sampler2D _DistTex;
UNITY_LOCATION(2) uniform mediump sampler2D _SubTex;
UNITY_LOCATION(3) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
float u_xlat4;
mediump vec3 u_xlat16_5;
vec2 u_xlat8;
void main()
{
    u_xlat0.xy = _Time.yy * vec2(_DistScrollX, _DistScrollY);
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistTex_ST.xy + u_xlat0.xy;
    u_xlat16_0.xy = texture(_DistTex, u_xlat0.xy).xy;
    u_xlat1.y = u_xlat16_0.y + _DistTex_ST.w;
    u_xlat1.x = u_xlat16_0.x + -0.5;
    u_xlat0.x = _DistTex_ST.z;
    u_xlat0.y = float(-0.5);
    u_xlat8.x = float(0.333299994);
    u_xlat0.xy = u_xlat0.xy + u_xlat1.xy;
    u_xlat1.x = u_xlat1.x + _DistTex_ST.z;
    u_xlat16_5.xyz = texture(_MaskTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xy = u_xlat0.xy * u_xlat16_5.yy;
    u_xlat0.xy = u_xlat0.xy * vec2(_Distortion) + vs_TEXCOORD0.xy;
    u_xlat16_2 = texture(_MainTex, u_xlat0.xy);
    u_xlat0.x = u_xlat16_2.w * _Color.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if(u_xlatb0){discard;}
    u_xlat0.x = u_xlat16_5.y * u_xlat1.x;
    u_xlat0.x = u_xlat0.x * _SubTexDistortion;
    u_xlat0.xy = vs_TEXCOORD0.xy * _SubTex_ST.xy + u_xlat0.xx;
    u_xlat0.xy = vec2(_SubTexScrollX, _SubTexScrollY) * _Time.xx + u_xlat0.xy;
    u_xlat16_3 = texture(_SubTex, u_xlat0.xy);
    u_xlat3 = u_xlat16_3 * _SubTexCol + (-u_xlat16_2);
    u_xlat0.x = u_xlat16_5.x * _SubTexMix;
    u_xlat4 = (-u_xlat16_5.z) + 1.0;
    u_xlat1 = u_xlat0.xxxx * u_xlat3 + u_xlat16_2;
    u_xlat8.y = u_xlat16_2.w * _Color.w;
    u_xlat2.xyz = (-u_xlat1.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat3.xy = vs_TEXCOORD1.xy;
    u_xlat3.z = vs_TEXCOORD2.x;
    u_xlat3.xyz = u_xlat3.xyz + _Black.xyz;
    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.xyz;
    u_xlat2.w = 0.0;
    u_xlat1 = u_xlat1.xwyz * vs_COLOR0.xwyz + u_xlat2.xwyz;
    u_xlat0.x = u_xlat1.z + u_xlat1.x;
    u_xlat0.x = u_xlat1.w + u_xlat0.x;
    u_xlat1.x = u_xlat8.y * u_xlat0.x;
    u_xlat0.xz = u_xlat8.xy * u_xlat1.xy;
    u_xlat1.xyz = _GlobalAdditiveColor.www * _GlobalAdditiveColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_GlobalAdditiveIntensity);
    u_xlat2.xyz = u_xlat0.xxx * vec3(u_xlat4) + (-u_xlat1.xyz);
    u_xlat0.xy = vec2(u_xlat4) * u_xlat0.xz;
    u_xlat1.xyz = u_xlat0.yyy * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat2.xyz = _GlobalAdditiveColor.xyz * u_xlat0.yyy + (-u_xlat0.xxx);
    u_xlat8.x = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    u_xlat0.xzw = u_xlat8.xxx * u_xlat2.xyz + u_xlat0.xxx;
    u_xlat1.xyz = (-u_xlat0.xzw) + u_xlat1.xyz;
    u_xlat0.xzw = vec3(vec3(_GlobalAdditiveMixParameter, _GlobalAdditiveMixParameter, _GlobalAdditiveMixParameter)) * u_xlat1.xyz + u_xlat0.xzw;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat0.yyy + (-u_xlat0.xzw);
    SV_Target0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xzw;
    SV_Target0.w = u_xlat0.y;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "GRAYSCALE" "_USE_CUTOFF" }
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
uniform 	vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD2.xy;
    u_xlat0.xyz = _Color.www * _Color.xyz;
    u_xlat0.w = _Color.w;
    vs_COLOR0 = u_xlat0 * in_COLOR0;
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
uniform 	vec4 _SubTex_ST;
uniform 	float _SubTexMix;
uniform 	float _SubTexScrollX;
uniform 	float _SubTexScrollY;
uniform 	vec4 _SubTexCol;
uniform 	vec4 _DistTex_ST;
uniform 	float _Distortion;
uniform 	float _SubTexDistortion;
uniform 	float _DistScrollX;
uniform 	float _DistScrollY;
uniform 	vec4 _Color;
uniform 	vec4 _Black;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
uniform 	float _GlobalAdditiveMixParameter;
uniform 	float _Cutoff;
UNITY_LOCATION(0) uniform mediump sampler2D _MaskTex;
UNITY_LOCATION(1) uniform mediump sampler2D _DistTex;
UNITY_LOCATION(2) uniform mediump sampler2D _SubTex;
UNITY_LOCATION(3) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
float u_xlat4;
mediump vec3 u_xlat16_5;
vec2 u_xlat8;
void main()
{
    u_xlat0.xy = _Time.yy * vec2(_DistScrollX, _DistScrollY);
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistTex_ST.xy + u_xlat0.xy;
    u_xlat16_0.xy = texture(_DistTex, u_xlat0.xy).xy;
    u_xlat1.y = u_xlat16_0.y + _DistTex_ST.w;
    u_xlat1.x = u_xlat16_0.x + -0.5;
    u_xlat0.x = _DistTex_ST.z;
    u_xlat0.y = float(-0.5);
    u_xlat8.x = float(0.333299994);
    u_xlat0.xy = u_xlat0.xy + u_xlat1.xy;
    u_xlat1.x = u_xlat1.x + _DistTex_ST.z;
    u_xlat16_5.xyz = texture(_MaskTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xy = u_xlat0.xy * u_xlat16_5.yy;
    u_xlat0.xy = u_xlat0.xy * vec2(_Distortion) + vs_TEXCOORD0.xy;
    u_xlat16_2 = texture(_MainTex, u_xlat0.xy);
    u_xlat0.x = u_xlat16_2.w * _Color.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if(u_xlatb0){discard;}
    u_xlat0.x = u_xlat16_5.y * u_xlat1.x;
    u_xlat0.x = u_xlat0.x * _SubTexDistortion;
    u_xlat0.xy = vs_TEXCOORD0.xy * _SubTex_ST.xy + u_xlat0.xx;
    u_xlat0.xy = vec2(_SubTexScrollX, _SubTexScrollY) * _Time.xx + u_xlat0.xy;
    u_xlat16_3 = texture(_SubTex, u_xlat0.xy);
    u_xlat3 = u_xlat16_3 * _SubTexCol + (-u_xlat16_2);
    u_xlat0.x = u_xlat16_5.x * _SubTexMix;
    u_xlat4 = (-u_xlat16_5.z) + 1.0;
    u_xlat1 = u_xlat0.xxxx * u_xlat3 + u_xlat16_2;
    u_xlat8.y = u_xlat16_2.w * _Color.w;
    u_xlat2.xyz = (-u_xlat1.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat3.xy = vs_TEXCOORD1.xy;
    u_xlat3.z = vs_TEXCOORD2.x;
    u_xlat3.xyz = u_xlat3.xyz + _Black.xyz;
    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.xyz;
    u_xlat2.w = 0.0;
    u_xlat1 = u_xlat1.xwyz * vs_COLOR0.xwyz + u_xlat2.xwyz;
    u_xlat0.x = u_xlat1.z + u_xlat1.x;
    u_xlat0.x = u_xlat1.w + u_xlat0.x;
    u_xlat1.x = u_xlat8.y * u_xlat0.x;
    u_xlat0.xz = u_xlat8.xy * u_xlat1.xy;
    u_xlat1.xyz = _GlobalAdditiveColor.www * _GlobalAdditiveColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_GlobalAdditiveIntensity);
    u_xlat2.xyz = u_xlat0.xxx * vec3(u_xlat4) + (-u_xlat1.xyz);
    u_xlat0.xy = vec2(u_xlat4) * u_xlat0.xz;
    u_xlat1.xyz = u_xlat0.yyy * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat2.xyz = _GlobalAdditiveColor.xyz * u_xlat0.yyy + (-u_xlat0.xxx);
    u_xlat8.x = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    u_xlat0.xzw = u_xlat8.xxx * u_xlat2.xyz + u_xlat0.xxx;
    u_xlat1.xyz = (-u_xlat0.xzw) + u_xlat1.xyz;
    u_xlat0.xzw = vec3(vec3(_GlobalAdditiveMixParameter, _GlobalAdditiveMixParameter, _GlobalAdditiveMixParameter)) * u_xlat1.xyz + u_xlat0.xzw;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat0.yyy + (-u_xlat0.xzw);
    SV_Target0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xzw;
    SV_Target0.w = u_xlat0.y;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "GRAYSCALE" "_USE_CUTOFF" }
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
uniform 	vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD2.xy;
    u_xlat0.xyz = _Color.www * _Color.xyz;
    u_xlat0.w = _Color.w;
    vs_COLOR0 = u_xlat0 * in_COLOR0;
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
uniform 	vec4 _SubTex_ST;
uniform 	float _SubTexMix;
uniform 	float _SubTexScrollX;
uniform 	float _SubTexScrollY;
uniform 	vec4 _SubTexCol;
uniform 	vec4 _DistTex_ST;
uniform 	float _Distortion;
uniform 	float _SubTexDistortion;
uniform 	float _DistScrollX;
uniform 	float _DistScrollY;
uniform 	vec4 _Color;
uniform 	vec4 _Black;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
uniform 	float _GlobalAdditiveMixParameter;
uniform 	float _Cutoff;
UNITY_LOCATION(0) uniform mediump sampler2D _MaskTex;
UNITY_LOCATION(1) uniform mediump sampler2D _DistTex;
UNITY_LOCATION(2) uniform mediump sampler2D _SubTex;
UNITY_LOCATION(3) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
vec4 u_xlat2;
mediump vec4 u_xlat16_2;
vec4 u_xlat3;
mediump vec4 u_xlat16_3;
float u_xlat4;
mediump vec3 u_xlat16_5;
vec2 u_xlat8;
void main()
{
    u_xlat0.xy = _Time.yy * vec2(_DistScrollX, _DistScrollY);
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistTex_ST.xy + u_xlat0.xy;
    u_xlat16_0.xy = texture(_DistTex, u_xlat0.xy).xy;
    u_xlat1.y = u_xlat16_0.y + _DistTex_ST.w;
    u_xlat1.x = u_xlat16_0.x + -0.5;
    u_xlat0.x = _DistTex_ST.z;
    u_xlat0.y = float(-0.5);
    u_xlat8.x = float(0.333299994);
    u_xlat0.xy = u_xlat0.xy + u_xlat1.xy;
    u_xlat1.x = u_xlat1.x + _DistTex_ST.z;
    u_xlat16_5.xyz = texture(_MaskTex, vs_TEXCOORD0.xy).xyz;
    u_xlat0.xy = u_xlat0.xy * u_xlat16_5.yy;
    u_xlat0.xy = u_xlat0.xy * vec2(_Distortion) + vs_TEXCOORD0.xy;
    u_xlat16_2 = texture(_MainTex, u_xlat0.xy);
    u_xlat0.x = u_xlat16_2.w * _Color.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if(u_xlatb0){discard;}
    u_xlat0.x = u_xlat16_5.y * u_xlat1.x;
    u_xlat0.x = u_xlat0.x * _SubTexDistortion;
    u_xlat0.xy = vs_TEXCOORD0.xy * _SubTex_ST.xy + u_xlat0.xx;
    u_xlat0.xy = vec2(_SubTexScrollX, _SubTexScrollY) * _Time.xx + u_xlat0.xy;
    u_xlat16_3 = texture(_SubTex, u_xlat0.xy);
    u_xlat3 = u_xlat16_3 * _SubTexCol + (-u_xlat16_2);
    u_xlat0.x = u_xlat16_5.x * _SubTexMix;
    u_xlat4 = (-u_xlat16_5.z) + 1.0;
    u_xlat1 = u_xlat0.xxxx * u_xlat3 + u_xlat16_2;
    u_xlat8.y = u_xlat16_2.w * _Color.w;
    u_xlat2.xyz = (-u_xlat1.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat3.xy = vs_TEXCOORD1.xy;
    u_xlat3.z = vs_TEXCOORD2.x;
    u_xlat3.xyz = u_xlat3.xyz + _Black.xyz;
    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.xyz;
    u_xlat2.w = 0.0;
    u_xlat1 = u_xlat1.xwyz * vs_COLOR0.xwyz + u_xlat2.xwyz;
    u_xlat0.x = u_xlat1.z + u_xlat1.x;
    u_xlat0.x = u_xlat1.w + u_xlat0.x;
    u_xlat1.x = u_xlat8.y * u_xlat0.x;
    u_xlat0.xz = u_xlat8.xy * u_xlat1.xy;
    u_xlat1.xyz = _GlobalAdditiveColor.www * _GlobalAdditiveColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_GlobalAdditiveIntensity);
    u_xlat2.xyz = u_xlat0.xxx * vec3(u_xlat4) + (-u_xlat1.xyz);
    u_xlat0.xy = vec2(u_xlat4) * u_xlat0.xz;
    u_xlat1.xyz = u_xlat0.yyy * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat2.xyz = _GlobalAdditiveColor.xyz * u_xlat0.yyy + (-u_xlat0.xxx);
    u_xlat8.x = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    u_xlat0.xzw = u_xlat8.xxx * u_xlat2.xyz + u_xlat0.xxx;
    u_xlat1.xyz = (-u_xlat0.xzw) + u_xlat1.xyz;
    u_xlat0.xzw = vec3(vec3(_GlobalAdditiveMixParameter, _GlobalAdditiveMixParameter, _GlobalAdditiveMixParameter)) * u_xlat1.xyz + u_xlat0.xzw;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat0.yyy + (-u_xlat0.xzw);
    SV_Target0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xzw;
    SV_Target0.w = u_xlat0.y;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "GRAYSCALE" "_STRAIGHT_ALPHA_INPUT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec2 in_TEXCOORD1;
attribute highp vec2 in_TEXCOORD2;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD2.xy;
    u_xlat0.xyz = _Color.www * _Color.xyz;
    u_xlat0.w = _Color.w;
    vs_COLOR0 = u_xlat0 * in_COLOR0;
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
uniform 	vec4 _SubTex_ST;
uniform 	float _SubTexMix;
uniform 	float _SubTexScrollX;
uniform 	float _SubTexScrollY;
uniform 	vec4 _SubTexCol;
uniform 	vec4 _DistTex_ST;
uniform 	float _Distortion;
uniform 	float _SubTexDistortion;
uniform 	float _DistScrollX;
uniform 	float _DistScrollY;
uniform 	vec4 _Black;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
uniform 	float _GlobalAdditiveMixParameter;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _DistTex;
uniform lowp sampler2D _SubTex;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
float u_xlat3;
float u_xlat6;
void main()
{
    u_xlat0.xy = _Time.yy * vec2(_DistScrollX, _DistScrollY);
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistTex_ST.xy + u_xlat0.xy;
    u_xlat10_0.xy = texture2D(_DistTex, u_xlat0.xy).xy;
    u_xlat1.y = u_xlat10_0.y + _DistTex_ST.w;
    u_xlat1.x = u_xlat10_0.x + -0.5;
    u_xlat0.x = _DistTex_ST.z;
    u_xlat0.y = -0.5;
    u_xlat0.xy = u_xlat0.xy + u_xlat1.xy;
    u_xlat6 = u_xlat1.x + _DistTex_ST.z;
    u_xlat10_1.xy = texture2D(_MaskTex, vs_TEXCOORD0.xy).xy;
    u_xlat0.xy = u_xlat0.xy * u_xlat10_1.yy;
    u_xlat0.xy = u_xlat0.xy * vec2(_Distortion) + vs_TEXCOORD0.xy;
    u_xlat10_2 = texture2D(_MainTex, u_xlat0.xy);
    u_xlat0.x = u_xlat6 * u_xlat10_1.y;
    u_xlat3 = u_xlat10_1.x * _SubTexMix;
    u_xlat0.x = u_xlat0.x * _SubTexDistortion;
    u_xlat0.xz = vs_TEXCOORD0.xy * _SubTex_ST.xy + u_xlat0.xx;
    u_xlat0.xz = vec2(_SubTexScrollX, _SubTexScrollY) * _Time.xx + u_xlat0.xz;
    u_xlat10_1 = texture2D(_SubTex, u_xlat0.xz);
    u_xlat1 = u_xlat10_1 * _SubTexCol + (-u_xlat10_2);
    u_xlat0 = vec4(u_xlat3) * u_xlat1 + u_xlat10_2;
    u_xlat1.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat2.xy = vs_TEXCOORD1.xy;
    u_xlat2.z = vs_TEXCOORD2.x;
    u_xlat2.xyz = u_xlat2.xyz + _Black.xyz;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.w = 0.0;
    u_xlat0 = u_xlat0 * vs_COLOR0 + u_xlat1;
    u_xlat0.x = u_xlat0.y + u_xlat0.x;
    u_xlat0.x = u_xlat0.z + u_xlat0.x;
    u_xlat0.x = u_xlat0.w * u_xlat0.x;
    u_xlat1.xyz = _GlobalAdditiveColor.www * _GlobalAdditiveColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_GlobalAdditiveIntensity);
    u_xlat2.xyz = u_xlat0.xxx * vec3(0.333299994, 0.333299994, 0.333299994) + (-u_xlat1.xyz);
    u_xlat0.x = u_xlat0.x * 0.333299994;
    u_xlat1.xyz = u_xlat0.www * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat2.xyz = _GlobalAdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xxx);
    u_xlat3 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    u_xlat0.xyz = vec3(u_xlat3) * u_xlat2.xyz + u_xlat0.xxx;
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    u_xlat0.xyz = vec3(vec3(_GlobalAdditiveMixParameter, _GlobalAdditiveMixParameter, _GlobalAdditiveMixParameter)) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    SV_Target0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.w = u_xlat0.w;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "GRAYSCALE" "_STRAIGHT_ALPHA_INPUT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec2 in_TEXCOORD1;
attribute highp vec2 in_TEXCOORD2;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD2.xy;
    u_xlat0.xyz = _Color.www * _Color.xyz;
    u_xlat0.w = _Color.w;
    vs_COLOR0 = u_xlat0 * in_COLOR0;
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
uniform 	vec4 _SubTex_ST;
uniform 	float _SubTexMix;
uniform 	float _SubTexScrollX;
uniform 	float _SubTexScrollY;
uniform 	vec4 _SubTexCol;
uniform 	vec4 _DistTex_ST;
uniform 	float _Distortion;
uniform 	float _SubTexDistortion;
uniform 	float _DistScrollX;
uniform 	float _DistScrollY;
uniform 	vec4 _Black;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
uniform 	float _GlobalAdditiveMixParameter;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _DistTex;
uniform lowp sampler2D _SubTex;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
float u_xlat3;
float u_xlat6;
void main()
{
    u_xlat0.xy = _Time.yy * vec2(_DistScrollX, _DistScrollY);
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistTex_ST.xy + u_xlat0.xy;
    u_xlat10_0.xy = texture2D(_DistTex, u_xlat0.xy).xy;
    u_xlat1.y = u_xlat10_0.y + _DistTex_ST.w;
    u_xlat1.x = u_xlat10_0.x + -0.5;
    u_xlat0.x = _DistTex_ST.z;
    u_xlat0.y = -0.5;
    u_xlat0.xy = u_xlat0.xy + u_xlat1.xy;
    u_xlat6 = u_xlat1.x + _DistTex_ST.z;
    u_xlat10_1.xy = texture2D(_MaskTex, vs_TEXCOORD0.xy).xy;
    u_xlat0.xy = u_xlat0.xy * u_xlat10_1.yy;
    u_xlat0.xy = u_xlat0.xy * vec2(_Distortion) + vs_TEXCOORD0.xy;
    u_xlat10_2 = texture2D(_MainTex, u_xlat0.xy);
    u_xlat0.x = u_xlat6 * u_xlat10_1.y;
    u_xlat3 = u_xlat10_1.x * _SubTexMix;
    u_xlat0.x = u_xlat0.x * _SubTexDistortion;
    u_xlat0.xz = vs_TEXCOORD0.xy * _SubTex_ST.xy + u_xlat0.xx;
    u_xlat0.xz = vec2(_SubTexScrollX, _SubTexScrollY) * _Time.xx + u_xlat0.xz;
    u_xlat10_1 = texture2D(_SubTex, u_xlat0.xz);
    u_xlat1 = u_xlat10_1 * _SubTexCol + (-u_xlat10_2);
    u_xlat0 = vec4(u_xlat3) * u_xlat1 + u_xlat10_2;
    u_xlat1.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat2.xy = vs_TEXCOORD1.xy;
    u_xlat2.z = vs_TEXCOORD2.x;
    u_xlat2.xyz = u_xlat2.xyz + _Black.xyz;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.w = 0.0;
    u_xlat0 = u_xlat0 * vs_COLOR0 + u_xlat1;
    u_xlat0.x = u_xlat0.y + u_xlat0.x;
    u_xlat0.x = u_xlat0.z + u_xlat0.x;
    u_xlat0.x = u_xlat0.w * u_xlat0.x;
    u_xlat1.xyz = _GlobalAdditiveColor.www * _GlobalAdditiveColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_GlobalAdditiveIntensity);
    u_xlat2.xyz = u_xlat0.xxx * vec3(0.333299994, 0.333299994, 0.333299994) + (-u_xlat1.xyz);
    u_xlat0.x = u_xlat0.x * 0.333299994;
    u_xlat1.xyz = u_xlat0.www * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat2.xyz = _GlobalAdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xxx);
    u_xlat3 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    u_xlat0.xyz = vec3(u_xlat3) * u_xlat2.xyz + u_xlat0.xxx;
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    u_xlat0.xyz = vec3(vec3(_GlobalAdditiveMixParameter, _GlobalAdditiveMixParameter, _GlobalAdditiveMixParameter)) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    SV_Target0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.w = u_xlat0.w;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "GRAYSCALE" "_STRAIGHT_ALPHA_INPUT" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec2 in_TEXCOORD1;
attribute highp vec2 in_TEXCOORD2;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD2.xy;
    u_xlat0.xyz = _Color.www * _Color.xyz;
    u_xlat0.w = _Color.w;
    vs_COLOR0 = u_xlat0 * in_COLOR0;
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
uniform 	vec4 _SubTex_ST;
uniform 	float _SubTexMix;
uniform 	float _SubTexScrollX;
uniform 	float _SubTexScrollY;
uniform 	vec4 _SubTexCol;
uniform 	vec4 _DistTex_ST;
uniform 	float _Distortion;
uniform 	float _SubTexDistortion;
uniform 	float _DistScrollX;
uniform 	float _DistScrollY;
uniform 	vec4 _Black;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
uniform 	float _GlobalAdditiveMixParameter;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _DistTex;
uniform lowp sampler2D _SubTex;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
float u_xlat3;
float u_xlat6;
void main()
{
    u_xlat0.xy = _Time.yy * vec2(_DistScrollX, _DistScrollY);
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistTex_ST.xy + u_xlat0.xy;
    u_xlat10_0.xy = texture2D(_DistTex, u_xlat0.xy).xy;
    u_xlat1.y = u_xlat10_0.y + _DistTex_ST.w;
    u_xlat1.x = u_xlat10_0.x + -0.5;
    u_xlat0.x = _DistTex_ST.z;
    u_xlat0.y = -0.5;
    u_xlat0.xy = u_xlat0.xy + u_xlat1.xy;
    u_xlat6 = u_xlat1.x + _DistTex_ST.z;
    u_xlat10_1.xy = texture2D(_MaskTex, vs_TEXCOORD0.xy).xy;
    u_xlat0.xy = u_xlat0.xy * u_xlat10_1.yy;
    u_xlat0.xy = u_xlat0.xy * vec2(_Distortion) + vs_TEXCOORD0.xy;
    u_xlat10_2 = texture2D(_MainTex, u_xlat0.xy);
    u_xlat0.x = u_xlat6 * u_xlat10_1.y;
    u_xlat3 = u_xlat10_1.x * _SubTexMix;
    u_xlat0.x = u_xlat0.x * _SubTexDistortion;
    u_xlat0.xz = vs_TEXCOORD0.xy * _SubTex_ST.xy + u_xlat0.xx;
    u_xlat0.xz = vec2(_SubTexScrollX, _SubTexScrollY) * _Time.xx + u_xlat0.xz;
    u_xlat10_1 = texture2D(_SubTex, u_xlat0.xz);
    u_xlat1 = u_xlat10_1 * _SubTexCol + (-u_xlat10_2);
    u_xlat0 = vec4(u_xlat3) * u_xlat1 + u_xlat10_2;
    u_xlat1.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat2.xy = vs_TEXCOORD1.xy;
    u_xlat2.z = vs_TEXCOORD2.x;
    u_xlat2.xyz = u_xlat2.xyz + _Black.xyz;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.w = 0.0;
    u_xlat0 = u_xlat0 * vs_COLOR0 + u_xlat1;
    u_xlat0.x = u_xlat0.y + u_xlat0.x;
    u_xlat0.x = u_xlat0.z + u_xlat0.x;
    u_xlat0.x = u_xlat0.w * u_xlat0.x;
    u_xlat1.xyz = _GlobalAdditiveColor.www * _GlobalAdditiveColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_GlobalAdditiveIntensity);
    u_xlat2.xyz = u_xlat0.xxx * vec3(0.333299994, 0.333299994, 0.333299994) + (-u_xlat1.xyz);
    u_xlat0.x = u_xlat0.x * 0.333299994;
    u_xlat1.xyz = u_xlat0.www * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat2.xyz = _GlobalAdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xxx);
    u_xlat3 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    u_xlat0.xyz = vec3(u_xlat3) * u_xlat2.xyz + u_xlat0.xxx;
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    u_xlat0.xyz = vec3(vec3(_GlobalAdditiveMixParameter, _GlobalAdditiveMixParameter, _GlobalAdditiveMixParameter)) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    SV_Target0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.w = u_xlat0.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "GRAYSCALE" "_STRAIGHT_ALPHA_INPUT" }
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
uniform 	vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD2.xy;
    u_xlat0.xyz = _Color.www * _Color.xyz;
    u_xlat0.w = _Color.w;
    vs_COLOR0 = u_xlat0 * in_COLOR0;
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
uniform 	vec4 _SubTex_ST;
uniform 	float _SubTexMix;
uniform 	float _SubTexScrollX;
uniform 	float _SubTexScrollY;
uniform 	vec4 _SubTexCol;
uniform 	vec4 _DistTex_ST;
uniform 	float _Distortion;
uniform 	float _SubTexDistortion;
uniform 	float _DistScrollX;
uniform 	float _DistScrollY;
uniform 	vec4 _Black;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
uniform 	float _GlobalAdditiveMixParameter;
UNITY_LOCATION(0) uniform mediump sampler2D _MaskTex;
UNITY_LOCATION(1) uniform mediump sampler2D _DistTex;
UNITY_LOCATION(2) uniform mediump sampler2D _SubTex;
UNITY_LOCATION(3) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
float u_xlat3;
float u_xlat6;
void main()
{
    u_xlat0.xy = _Time.yy * vec2(_DistScrollX, _DistScrollY);
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistTex_ST.xy + u_xlat0.xy;
    u_xlat16_0.xy = texture(_DistTex, u_xlat0.xy).xy;
    u_xlat1.y = u_xlat16_0.y + _DistTex_ST.w;
    u_xlat1.x = u_xlat16_0.x + -0.5;
    u_xlat0.x = _DistTex_ST.z;
    u_xlat0.y = -0.5;
    u_xlat0.xy = u_xlat0.xy + u_xlat1.xy;
    u_xlat6 = u_xlat1.x + _DistTex_ST.z;
    u_xlat16_1.xy = texture(_MaskTex, vs_TEXCOORD0.xy).xy;
    u_xlat0.xy = u_xlat0.xy * u_xlat16_1.yy;
    u_xlat0.xy = u_xlat0.xy * vec2(_Distortion) + vs_TEXCOORD0.xy;
    u_xlat16_2 = texture(_MainTex, u_xlat0.xy);
    u_xlat0.x = u_xlat6 * u_xlat16_1.y;
    u_xlat3 = u_xlat16_1.x * _SubTexMix;
    u_xlat0.x = u_xlat0.x * _SubTexDistortion;
    u_xlat0.xz = vs_TEXCOORD0.xy * _SubTex_ST.xy + u_xlat0.xx;
    u_xlat0.xz = vec2(_SubTexScrollX, _SubTexScrollY) * _Time.xx + u_xlat0.xz;
    u_xlat16_1 = texture(_SubTex, u_xlat0.xz);
    u_xlat1 = u_xlat16_1 * _SubTexCol + (-u_xlat16_2);
    u_xlat0 = vec4(u_xlat3) * u_xlat1 + u_xlat16_2;
    u_xlat1.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat2.xy = vs_TEXCOORD1.xy;
    u_xlat2.z = vs_TEXCOORD2.x;
    u_xlat2.xyz = u_xlat2.xyz + _Black.xyz;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.w = 0.0;
    u_xlat0 = u_xlat0 * vs_COLOR0 + u_xlat1;
    u_xlat0.x = u_xlat0.y + u_xlat0.x;
    u_xlat0.x = u_xlat0.z + u_xlat0.x;
    u_xlat0.x = u_xlat0.w * u_xlat0.x;
    u_xlat1.xyz = _GlobalAdditiveColor.www * _GlobalAdditiveColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_GlobalAdditiveIntensity);
    u_xlat2.xyz = u_xlat0.xxx * vec3(0.333299994, 0.333299994, 0.333299994) + (-u_xlat1.xyz);
    u_xlat0.x = u_xlat0.x * 0.333299994;
    u_xlat1.xyz = u_xlat0.www * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat2.xyz = _GlobalAdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xxx);
    u_xlat3 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    u_xlat0.xyz = vec3(u_xlat3) * u_xlat2.xyz + u_xlat0.xxx;
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    u_xlat0.xyz = vec3(vec3(_GlobalAdditiveMixParameter, _GlobalAdditiveMixParameter, _GlobalAdditiveMixParameter)) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    SV_Target0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.w = u_xlat0.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "GRAYSCALE" "_STRAIGHT_ALPHA_INPUT" }
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
uniform 	vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD2.xy;
    u_xlat0.xyz = _Color.www * _Color.xyz;
    u_xlat0.w = _Color.w;
    vs_COLOR0 = u_xlat0 * in_COLOR0;
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
uniform 	vec4 _SubTex_ST;
uniform 	float _SubTexMix;
uniform 	float _SubTexScrollX;
uniform 	float _SubTexScrollY;
uniform 	vec4 _SubTexCol;
uniform 	vec4 _DistTex_ST;
uniform 	float _Distortion;
uniform 	float _SubTexDistortion;
uniform 	float _DistScrollX;
uniform 	float _DistScrollY;
uniform 	vec4 _Black;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
uniform 	float _GlobalAdditiveMixParameter;
UNITY_LOCATION(0) uniform mediump sampler2D _MaskTex;
UNITY_LOCATION(1) uniform mediump sampler2D _DistTex;
UNITY_LOCATION(2) uniform mediump sampler2D _SubTex;
UNITY_LOCATION(3) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
float u_xlat3;
float u_xlat6;
void main()
{
    u_xlat0.xy = _Time.yy * vec2(_DistScrollX, _DistScrollY);
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistTex_ST.xy + u_xlat0.xy;
    u_xlat16_0.xy = texture(_DistTex, u_xlat0.xy).xy;
    u_xlat1.y = u_xlat16_0.y + _DistTex_ST.w;
    u_xlat1.x = u_xlat16_0.x + -0.5;
    u_xlat0.x = _DistTex_ST.z;
    u_xlat0.y = -0.5;
    u_xlat0.xy = u_xlat0.xy + u_xlat1.xy;
    u_xlat6 = u_xlat1.x + _DistTex_ST.z;
    u_xlat16_1.xy = texture(_MaskTex, vs_TEXCOORD0.xy).xy;
    u_xlat0.xy = u_xlat0.xy * u_xlat16_1.yy;
    u_xlat0.xy = u_xlat0.xy * vec2(_Distortion) + vs_TEXCOORD0.xy;
    u_xlat16_2 = texture(_MainTex, u_xlat0.xy);
    u_xlat0.x = u_xlat6 * u_xlat16_1.y;
    u_xlat3 = u_xlat16_1.x * _SubTexMix;
    u_xlat0.x = u_xlat0.x * _SubTexDistortion;
    u_xlat0.xz = vs_TEXCOORD0.xy * _SubTex_ST.xy + u_xlat0.xx;
    u_xlat0.xz = vec2(_SubTexScrollX, _SubTexScrollY) * _Time.xx + u_xlat0.xz;
    u_xlat16_1 = texture(_SubTex, u_xlat0.xz);
    u_xlat1 = u_xlat16_1 * _SubTexCol + (-u_xlat16_2);
    u_xlat0 = vec4(u_xlat3) * u_xlat1 + u_xlat16_2;
    u_xlat1.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat2.xy = vs_TEXCOORD1.xy;
    u_xlat2.z = vs_TEXCOORD2.x;
    u_xlat2.xyz = u_xlat2.xyz + _Black.xyz;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.w = 0.0;
    u_xlat0 = u_xlat0 * vs_COLOR0 + u_xlat1;
    u_xlat0.x = u_xlat0.y + u_xlat0.x;
    u_xlat0.x = u_xlat0.z + u_xlat0.x;
    u_xlat0.x = u_xlat0.w * u_xlat0.x;
    u_xlat1.xyz = _GlobalAdditiveColor.www * _GlobalAdditiveColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_GlobalAdditiveIntensity);
    u_xlat2.xyz = u_xlat0.xxx * vec3(0.333299994, 0.333299994, 0.333299994) + (-u_xlat1.xyz);
    u_xlat0.x = u_xlat0.x * 0.333299994;
    u_xlat1.xyz = u_xlat0.www * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat2.xyz = _GlobalAdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xxx);
    u_xlat3 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    u_xlat0.xyz = vec3(u_xlat3) * u_xlat2.xyz + u_xlat0.xxx;
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    u_xlat0.xyz = vec3(vec3(_GlobalAdditiveMixParameter, _GlobalAdditiveMixParameter, _GlobalAdditiveMixParameter)) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    SV_Target0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.w = u_xlat0.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "GRAYSCALE" "_STRAIGHT_ALPHA_INPUT" }
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
uniform 	vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD2.xy;
    u_xlat0.xyz = _Color.www * _Color.xyz;
    u_xlat0.w = _Color.w;
    vs_COLOR0 = u_xlat0 * in_COLOR0;
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
uniform 	vec4 _SubTex_ST;
uniform 	float _SubTexMix;
uniform 	float _SubTexScrollX;
uniform 	float _SubTexScrollY;
uniform 	vec4 _SubTexCol;
uniform 	vec4 _DistTex_ST;
uniform 	float _Distortion;
uniform 	float _SubTexDistortion;
uniform 	float _DistScrollX;
uniform 	float _DistScrollY;
uniform 	vec4 _Black;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
uniform 	float _GlobalAdditiveMixParameter;
UNITY_LOCATION(0) uniform mediump sampler2D _MaskTex;
UNITY_LOCATION(1) uniform mediump sampler2D _DistTex;
UNITY_LOCATION(2) uniform mediump sampler2D _SubTex;
UNITY_LOCATION(3) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
float u_xlat3;
float u_xlat6;
void main()
{
    u_xlat0.xy = _Time.yy * vec2(_DistScrollX, _DistScrollY);
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistTex_ST.xy + u_xlat0.xy;
    u_xlat16_0.xy = texture(_DistTex, u_xlat0.xy).xy;
    u_xlat1.y = u_xlat16_0.y + _DistTex_ST.w;
    u_xlat1.x = u_xlat16_0.x + -0.5;
    u_xlat0.x = _DistTex_ST.z;
    u_xlat0.y = -0.5;
    u_xlat0.xy = u_xlat0.xy + u_xlat1.xy;
    u_xlat6 = u_xlat1.x + _DistTex_ST.z;
    u_xlat16_1.xy = texture(_MaskTex, vs_TEXCOORD0.xy).xy;
    u_xlat0.xy = u_xlat0.xy * u_xlat16_1.yy;
    u_xlat0.xy = u_xlat0.xy * vec2(_Distortion) + vs_TEXCOORD0.xy;
    u_xlat16_2 = texture(_MainTex, u_xlat0.xy);
    u_xlat0.x = u_xlat6 * u_xlat16_1.y;
    u_xlat3 = u_xlat16_1.x * _SubTexMix;
    u_xlat0.x = u_xlat0.x * _SubTexDistortion;
    u_xlat0.xz = vs_TEXCOORD0.xy * _SubTex_ST.xy + u_xlat0.xx;
    u_xlat0.xz = vec2(_SubTexScrollX, _SubTexScrollY) * _Time.xx + u_xlat0.xz;
    u_xlat16_1 = texture(_SubTex, u_xlat0.xz);
    u_xlat1 = u_xlat16_1 * _SubTexCol + (-u_xlat16_2);
    u_xlat0 = vec4(u_xlat3) * u_xlat1 + u_xlat16_2;
    u_xlat1.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat2.xy = vs_TEXCOORD1.xy;
    u_xlat2.z = vs_TEXCOORD2.x;
    u_xlat2.xyz = u_xlat2.xyz + _Black.xyz;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.w = 0.0;
    u_xlat0 = u_xlat0 * vs_COLOR0 + u_xlat1;
    u_xlat0.x = u_xlat0.y + u_xlat0.x;
    u_xlat0.x = u_xlat0.z + u_xlat0.x;
    u_xlat0.x = u_xlat0.w * u_xlat0.x;
    u_xlat1.xyz = _GlobalAdditiveColor.www * _GlobalAdditiveColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_GlobalAdditiveIntensity);
    u_xlat2.xyz = u_xlat0.xxx * vec3(0.333299994, 0.333299994, 0.333299994) + (-u_xlat1.xyz);
    u_xlat0.x = u_xlat0.x * 0.333299994;
    u_xlat1.xyz = u_xlat0.www * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat2.xyz = _GlobalAdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xxx);
    u_xlat3 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    u_xlat0.xyz = vec3(u_xlat3) * u_xlat2.xyz + u_xlat0.xxx;
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    u_xlat0.xyz = vec3(vec3(_GlobalAdditiveMixParameter, _GlobalAdditiveMixParameter, _GlobalAdditiveMixParameter)) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    SV_Target0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.w = u_xlat0.w;
    return;
}

#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "GRAYSCALE" "_STRAIGHT_ALPHA_INPUT" "_USE_CUTOFF" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec2 in_TEXCOORD1;
attribute highp vec2 in_TEXCOORD2;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD2.xy;
    u_xlat0.xyz = _Color.www * _Color.xyz;
    u_xlat0.w = _Color.w;
    vs_COLOR0 = u_xlat0 * in_COLOR0;
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
uniform 	vec4 _SubTex_ST;
uniform 	float _SubTexMix;
uniform 	float _SubTexScrollX;
uniform 	float _SubTexScrollY;
uniform 	vec4 _SubTexCol;
uniform 	vec4 _DistTex_ST;
uniform 	float _Distortion;
uniform 	float _SubTexDistortion;
uniform 	float _DistScrollX;
uniform 	float _DistScrollY;
uniform 	vec4 _Color;
uniform 	vec4 _Black;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
uniform 	float _GlobalAdditiveMixParameter;
uniform 	float _Cutoff;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _DistTex;
uniform lowp sampler2D _SubTex;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
float u_xlat3;
float u_xlat6;
void main()
{
    u_xlat0.xy = _Time.yy * vec2(_DistScrollX, _DistScrollY);
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistTex_ST.xy + u_xlat0.xy;
    u_xlat10_0.xy = texture2D(_DistTex, u_xlat0.xy).xy;
    u_xlat1.y = u_xlat10_0.y + _DistTex_ST.w;
    u_xlat1.x = u_xlat10_0.x + -0.5;
    u_xlat0.x = _DistTex_ST.z;
    u_xlat0.y = -0.5;
    u_xlat0.xy = u_xlat0.xy + u_xlat1.xy;
    u_xlat6 = u_xlat1.x + _DistTex_ST.z;
    u_xlat10_1.xy = texture2D(_MaskTex, vs_TEXCOORD0.xy).xy;
    u_xlat0.xy = u_xlat0.xy * u_xlat10_1.yy;
    u_xlat0.xy = u_xlat0.xy * vec2(_Distortion) + vs_TEXCOORD0.xy;
    u_xlat10_2 = texture2D(_MainTex, u_xlat0.xy);
    u_xlat0.x = u_xlat10_2.w * _Color.w + (-_Cutoff);
    u_xlatb0 = u_xlat0.x<0.0;
    if(u_xlatb0){discard;}
    u_xlat0.x = u_xlat6 * u_xlat10_1.y;
    u_xlat3 = u_xlat10_1.x * _SubTexMix;
    u_xlat0.x = u_xlat0.x * _SubTexDistortion;
    u_xlat0.xz = vs_TEXCOORD0.xy * _SubTex_ST.xy + u_xlat0.xx;
    u_xlat0.xz = vec2(_SubTexScrollX, _SubTexScrollY) * _Time.xx + u_xlat0.xz;
    u_xlat10_1 = texture2D(_SubTex, u_xlat0.xz);
    u_xlat1 = u_xlat10_1 * _SubTexCol + (-u_xlat10_2);
    u_xlat0 = vec4(u_xlat3) * u_xlat1 + u_xlat10_2;
    u_xlat1.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat2.xy = vs_TEXCOORD1.xy;
    u_xlat2.z = vs_TEXCOORD2.x;
    u_xlat2.xyz = u_xlat2.xyz + _Black.xyz;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.w = 0.0;
    u_xlat0 = u_xlat0 * vs_COLOR0 + u_xlat1;
    u_xlat0.x = u_xlat0.y + u_xlat0.x;
    u_xlat0.x = u_xlat0.z + u_xlat0.x;
    u_xlat0.x = u_xlat0.w * u_xlat0.x;
    u_xlat1.xyz = _GlobalAdditiveColor.www * _GlobalAdditiveColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_GlobalAdditiveIntensity);
    u_xlat2.xyz = u_xlat0.xxx * vec3(0.333299994, 0.333299994, 0.333299994) + (-u_xlat1.xyz);
    u_xlat0.x = u_xlat0.x * 0.333299994;
    u_xlat1.xyz = u_xlat0.www * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat2.xyz = _GlobalAdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xxx);
    u_xlat3 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    u_xlat0.xyz = vec3(u_xlat3) * u_xlat2.xyz + u_xlat0.xxx;
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    u_xlat0.xyz = vec3(vec3(_GlobalAdditiveMixParameter, _GlobalAdditiveMixParameter, _GlobalAdditiveMixParameter)) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    SV_Target0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.w = u_xlat0.w;
    return;
}

#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "GRAYSCALE" "_STRAIGHT_ALPHA_INPUT" "_USE_CUTOFF" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec2 in_TEXCOORD1;
attribute highp vec2 in_TEXCOORD2;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD2.xy;
    u_xlat0.xyz = _Color.www * _Color.xyz;
    u_xlat0.w = _Color.w;
    vs_COLOR0 = u_xlat0 * in_COLOR0;
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
uniform 	vec4 _SubTex_ST;
uniform 	float _SubTexMix;
uniform 	float _SubTexScrollX;
uniform 	float _SubTexScrollY;
uniform 	vec4 _SubTexCol;
uniform 	vec4 _DistTex_ST;
uniform 	float _Distortion;
uniform 	float _SubTexDistortion;
uniform 	float _DistScrollX;
uniform 	float _DistScrollY;
uniform 	vec4 _Color;
uniform 	vec4 _Black;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
uniform 	float _GlobalAdditiveMixParameter;
uniform 	float _Cutoff;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _DistTex;
uniform lowp sampler2D _SubTex;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
float u_xlat3;
float u_xlat6;
void main()
{
    u_xlat0.xy = _Time.yy * vec2(_DistScrollX, _DistScrollY);
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistTex_ST.xy + u_xlat0.xy;
    u_xlat10_0.xy = texture2D(_DistTex, u_xlat0.xy).xy;
    u_xlat1.y = u_xlat10_0.y + _DistTex_ST.w;
    u_xlat1.x = u_xlat10_0.x + -0.5;
    u_xlat0.x = _DistTex_ST.z;
    u_xlat0.y = -0.5;
    u_xlat0.xy = u_xlat0.xy + u_xlat1.xy;
    u_xlat6 = u_xlat1.x + _DistTex_ST.z;
    u_xlat10_1.xy = texture2D(_MaskTex, vs_TEXCOORD0.xy).xy;
    u_xlat0.xy = u_xlat0.xy * u_xlat10_1.yy;
    u_xlat0.xy = u_xlat0.xy * vec2(_Distortion) + vs_TEXCOORD0.xy;
    u_xlat10_2 = texture2D(_MainTex, u_xlat0.xy);
    u_xlat0.x = u_xlat10_2.w * _Color.w + (-_Cutoff);
    u_xlatb0 = u_xlat0.x<0.0;
    if(u_xlatb0){discard;}
    u_xlat0.x = u_xlat6 * u_xlat10_1.y;
    u_xlat3 = u_xlat10_1.x * _SubTexMix;
    u_xlat0.x = u_xlat0.x * _SubTexDistortion;
    u_xlat0.xz = vs_TEXCOORD0.xy * _SubTex_ST.xy + u_xlat0.xx;
    u_xlat0.xz = vec2(_SubTexScrollX, _SubTexScrollY) * _Time.xx + u_xlat0.xz;
    u_xlat10_1 = texture2D(_SubTex, u_xlat0.xz);
    u_xlat1 = u_xlat10_1 * _SubTexCol + (-u_xlat10_2);
    u_xlat0 = vec4(u_xlat3) * u_xlat1 + u_xlat10_2;
    u_xlat1.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat2.xy = vs_TEXCOORD1.xy;
    u_xlat2.z = vs_TEXCOORD2.x;
    u_xlat2.xyz = u_xlat2.xyz + _Black.xyz;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.w = 0.0;
    u_xlat0 = u_xlat0 * vs_COLOR0 + u_xlat1;
    u_xlat0.x = u_xlat0.y + u_xlat0.x;
    u_xlat0.x = u_xlat0.z + u_xlat0.x;
    u_xlat0.x = u_xlat0.w * u_xlat0.x;
    u_xlat1.xyz = _GlobalAdditiveColor.www * _GlobalAdditiveColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_GlobalAdditiveIntensity);
    u_xlat2.xyz = u_xlat0.xxx * vec3(0.333299994, 0.333299994, 0.333299994) + (-u_xlat1.xyz);
    u_xlat0.x = u_xlat0.x * 0.333299994;
    u_xlat1.xyz = u_xlat0.www * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat2.xyz = _GlobalAdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xxx);
    u_xlat3 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    u_xlat0.xyz = vec3(u_xlat3) * u_xlat2.xyz + u_xlat0.xxx;
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    u_xlat0.xyz = vec3(vec3(_GlobalAdditiveMixParameter, _GlobalAdditiveMixParameter, _GlobalAdditiveMixParameter)) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    SV_Target0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.w = u_xlat0.w;
    return;
}

#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "GRAYSCALE" "_STRAIGHT_ALPHA_INPUT" "_USE_CUTOFF" }
"#ifdef VERTEX
#version 100

uniform 	vec4 hlslcc_mtx4x4unity_ObjectToWorld[4];
uniform 	vec4 hlslcc_mtx4x4unity_MatrixVP[4];
uniform 	vec4 _Color;
attribute highp vec4 in_POSITION0;
attribute highp vec2 in_TEXCOORD0;
attribute highp vec2 in_TEXCOORD1;
attribute highp vec2 in_TEXCOORD2;
attribute highp vec4 in_COLOR0;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD2.xy;
    u_xlat0.xyz = _Color.www * _Color.xyz;
    u_xlat0.w = _Color.w;
    vs_COLOR0 = u_xlat0 * in_COLOR0;
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
uniform 	vec4 _SubTex_ST;
uniform 	float _SubTexMix;
uniform 	float _SubTexScrollX;
uniform 	float _SubTexScrollY;
uniform 	vec4 _SubTexCol;
uniform 	vec4 _DistTex_ST;
uniform 	float _Distortion;
uniform 	float _SubTexDistortion;
uniform 	float _DistScrollX;
uniform 	float _DistScrollY;
uniform 	vec4 _Color;
uniform 	vec4 _Black;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
uniform 	float _GlobalAdditiveMixParameter;
uniform 	float _Cutoff;
uniform lowp sampler2D _MaskTex;
uniform lowp sampler2D _DistTex;
uniform lowp sampler2D _SubTex;
uniform lowp sampler2D _MainTex;
varying highp vec2 vs_TEXCOORD0;
varying highp vec2 vs_TEXCOORD1;
varying highp vec2 vs_TEXCOORD2;
varying highp vec4 vs_COLOR0;
#define SV_Target0 gl_FragData[0]
vec4 u_xlat0;
lowp vec2 u_xlat10_0;
bool u_xlatb0;
vec4 u_xlat1;
lowp vec4 u_xlat10_1;
vec3 u_xlat2;
lowp vec4 u_xlat10_2;
float u_xlat3;
float u_xlat6;
void main()
{
    u_xlat0.xy = _Time.yy * vec2(_DistScrollX, _DistScrollY);
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistTex_ST.xy + u_xlat0.xy;
    u_xlat10_0.xy = texture2D(_DistTex, u_xlat0.xy).xy;
    u_xlat1.y = u_xlat10_0.y + _DistTex_ST.w;
    u_xlat1.x = u_xlat10_0.x + -0.5;
    u_xlat0.x = _DistTex_ST.z;
    u_xlat0.y = -0.5;
    u_xlat0.xy = u_xlat0.xy + u_xlat1.xy;
    u_xlat6 = u_xlat1.x + _DistTex_ST.z;
    u_xlat10_1.xy = texture2D(_MaskTex, vs_TEXCOORD0.xy).xy;
    u_xlat0.xy = u_xlat0.xy * u_xlat10_1.yy;
    u_xlat0.xy = u_xlat0.xy * vec2(_Distortion) + vs_TEXCOORD0.xy;
    u_xlat10_2 = texture2D(_MainTex, u_xlat0.xy);
    u_xlat0.x = u_xlat10_2.w * _Color.w + (-_Cutoff);
    u_xlatb0 = u_xlat0.x<0.0;
    if(u_xlatb0){discard;}
    u_xlat0.x = u_xlat6 * u_xlat10_1.y;
    u_xlat3 = u_xlat10_1.x * _SubTexMix;
    u_xlat0.x = u_xlat0.x * _SubTexDistortion;
    u_xlat0.xz = vs_TEXCOORD0.xy * _SubTex_ST.xy + u_xlat0.xx;
    u_xlat0.xz = vec2(_SubTexScrollX, _SubTexScrollY) * _Time.xx + u_xlat0.xz;
    u_xlat10_1 = texture2D(_SubTex, u_xlat0.xz);
    u_xlat1 = u_xlat10_1 * _SubTexCol + (-u_xlat10_2);
    u_xlat0 = vec4(u_xlat3) * u_xlat1 + u_xlat10_2;
    u_xlat1.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat2.xy = vs_TEXCOORD1.xy;
    u_xlat2.z = vs_TEXCOORD2.x;
    u_xlat2.xyz = u_xlat2.xyz + _Black.xyz;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.w = 0.0;
    u_xlat0 = u_xlat0 * vs_COLOR0 + u_xlat1;
    u_xlat0.x = u_xlat0.y + u_xlat0.x;
    u_xlat0.x = u_xlat0.z + u_xlat0.x;
    u_xlat0.x = u_xlat0.w * u_xlat0.x;
    u_xlat1.xyz = _GlobalAdditiveColor.www * _GlobalAdditiveColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_GlobalAdditiveIntensity);
    u_xlat2.xyz = u_xlat0.xxx * vec3(0.333299994, 0.333299994, 0.333299994) + (-u_xlat1.xyz);
    u_xlat0.x = u_xlat0.x * 0.333299994;
    u_xlat1.xyz = u_xlat0.www * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat2.xyz = _GlobalAdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xxx);
    u_xlat3 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    u_xlat0.xyz = vec3(u_xlat3) * u_xlat2.xyz + u_xlat0.xxx;
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    u_xlat0.xyz = vec3(vec3(_GlobalAdditiveMixParameter, _GlobalAdditiveMixParameter, _GlobalAdditiveMixParameter)) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    SV_Target0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.w = u_xlat0.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier00 " {
Keywords { "GRAYSCALE" "_STRAIGHT_ALPHA_INPUT" "_USE_CUTOFF" }
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
uniform 	vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD2.xy;
    u_xlat0.xyz = _Color.www * _Color.xyz;
    u_xlat0.w = _Color.w;
    vs_COLOR0 = u_xlat0 * in_COLOR0;
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
uniform 	vec4 _SubTex_ST;
uniform 	float _SubTexMix;
uniform 	float _SubTexScrollX;
uniform 	float _SubTexScrollY;
uniform 	vec4 _SubTexCol;
uniform 	vec4 _DistTex_ST;
uniform 	float _Distortion;
uniform 	float _SubTexDistortion;
uniform 	float _DistScrollX;
uniform 	float _DistScrollY;
uniform 	vec4 _Color;
uniform 	vec4 _Black;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
uniform 	float _GlobalAdditiveMixParameter;
uniform 	float _Cutoff;
UNITY_LOCATION(0) uniform mediump sampler2D _MaskTex;
UNITY_LOCATION(1) uniform mediump sampler2D _DistTex;
UNITY_LOCATION(2) uniform mediump sampler2D _SubTex;
UNITY_LOCATION(3) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
float u_xlat3;
float u_xlat6;
void main()
{
    u_xlat0.xy = _Time.yy * vec2(_DistScrollX, _DistScrollY);
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistTex_ST.xy + u_xlat0.xy;
    u_xlat16_0.xy = texture(_DistTex, u_xlat0.xy).xy;
    u_xlat1.y = u_xlat16_0.y + _DistTex_ST.w;
    u_xlat1.x = u_xlat16_0.x + -0.5;
    u_xlat0.x = _DistTex_ST.z;
    u_xlat0.y = -0.5;
    u_xlat0.xy = u_xlat0.xy + u_xlat1.xy;
    u_xlat6 = u_xlat1.x + _DistTex_ST.z;
    u_xlat16_1.xy = texture(_MaskTex, vs_TEXCOORD0.xy).xy;
    u_xlat0.xy = u_xlat0.xy * u_xlat16_1.yy;
    u_xlat0.xy = u_xlat0.xy * vec2(_Distortion) + vs_TEXCOORD0.xy;
    u_xlat16_2 = texture(_MainTex, u_xlat0.xy);
    u_xlat0.x = u_xlat16_2.w * _Color.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if(u_xlatb0){discard;}
    u_xlat0.x = u_xlat6 * u_xlat16_1.y;
    u_xlat3 = u_xlat16_1.x * _SubTexMix;
    u_xlat0.x = u_xlat0.x * _SubTexDistortion;
    u_xlat0.xz = vs_TEXCOORD0.xy * _SubTex_ST.xy + u_xlat0.xx;
    u_xlat0.xz = vec2(_SubTexScrollX, _SubTexScrollY) * _Time.xx + u_xlat0.xz;
    u_xlat16_1 = texture(_SubTex, u_xlat0.xz);
    u_xlat1 = u_xlat16_1 * _SubTexCol + (-u_xlat16_2);
    u_xlat0 = vec4(u_xlat3) * u_xlat1 + u_xlat16_2;
    u_xlat1.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat2.xy = vs_TEXCOORD1.xy;
    u_xlat2.z = vs_TEXCOORD2.x;
    u_xlat2.xyz = u_xlat2.xyz + _Black.xyz;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.w = 0.0;
    u_xlat0 = u_xlat0 * vs_COLOR0 + u_xlat1;
    u_xlat0.x = u_xlat0.y + u_xlat0.x;
    u_xlat0.x = u_xlat0.z + u_xlat0.x;
    u_xlat0.x = u_xlat0.w * u_xlat0.x;
    u_xlat1.xyz = _GlobalAdditiveColor.www * _GlobalAdditiveColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_GlobalAdditiveIntensity);
    u_xlat2.xyz = u_xlat0.xxx * vec3(0.333299994, 0.333299994, 0.333299994) + (-u_xlat1.xyz);
    u_xlat0.x = u_xlat0.x * 0.333299994;
    u_xlat1.xyz = u_xlat0.www * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat2.xyz = _GlobalAdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xxx);
    u_xlat3 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    u_xlat0.xyz = vec3(u_xlat3) * u_xlat2.xyz + u_xlat0.xxx;
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    u_xlat0.xyz = vec3(vec3(_GlobalAdditiveMixParameter, _GlobalAdditiveMixParameter, _GlobalAdditiveMixParameter)) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    SV_Target0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.w = u_xlat0.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier01 " {
Keywords { "GRAYSCALE" "_STRAIGHT_ALPHA_INPUT" "_USE_CUTOFF" }
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
uniform 	vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD2.xy;
    u_xlat0.xyz = _Color.www * _Color.xyz;
    u_xlat0.w = _Color.w;
    vs_COLOR0 = u_xlat0 * in_COLOR0;
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
uniform 	vec4 _SubTex_ST;
uniform 	float _SubTexMix;
uniform 	float _SubTexScrollX;
uniform 	float _SubTexScrollY;
uniform 	vec4 _SubTexCol;
uniform 	vec4 _DistTex_ST;
uniform 	float _Distortion;
uniform 	float _SubTexDistortion;
uniform 	float _DistScrollX;
uniform 	float _DistScrollY;
uniform 	vec4 _Color;
uniform 	vec4 _Black;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
uniform 	float _GlobalAdditiveMixParameter;
uniform 	float _Cutoff;
UNITY_LOCATION(0) uniform mediump sampler2D _MaskTex;
UNITY_LOCATION(1) uniform mediump sampler2D _DistTex;
UNITY_LOCATION(2) uniform mediump sampler2D _SubTex;
UNITY_LOCATION(3) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
float u_xlat3;
float u_xlat6;
void main()
{
    u_xlat0.xy = _Time.yy * vec2(_DistScrollX, _DistScrollY);
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistTex_ST.xy + u_xlat0.xy;
    u_xlat16_0.xy = texture(_DistTex, u_xlat0.xy).xy;
    u_xlat1.y = u_xlat16_0.y + _DistTex_ST.w;
    u_xlat1.x = u_xlat16_0.x + -0.5;
    u_xlat0.x = _DistTex_ST.z;
    u_xlat0.y = -0.5;
    u_xlat0.xy = u_xlat0.xy + u_xlat1.xy;
    u_xlat6 = u_xlat1.x + _DistTex_ST.z;
    u_xlat16_1.xy = texture(_MaskTex, vs_TEXCOORD0.xy).xy;
    u_xlat0.xy = u_xlat0.xy * u_xlat16_1.yy;
    u_xlat0.xy = u_xlat0.xy * vec2(_Distortion) + vs_TEXCOORD0.xy;
    u_xlat16_2 = texture(_MainTex, u_xlat0.xy);
    u_xlat0.x = u_xlat16_2.w * _Color.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if(u_xlatb0){discard;}
    u_xlat0.x = u_xlat6 * u_xlat16_1.y;
    u_xlat3 = u_xlat16_1.x * _SubTexMix;
    u_xlat0.x = u_xlat0.x * _SubTexDistortion;
    u_xlat0.xz = vs_TEXCOORD0.xy * _SubTex_ST.xy + u_xlat0.xx;
    u_xlat0.xz = vec2(_SubTexScrollX, _SubTexScrollY) * _Time.xx + u_xlat0.xz;
    u_xlat16_1 = texture(_SubTex, u_xlat0.xz);
    u_xlat1 = u_xlat16_1 * _SubTexCol + (-u_xlat16_2);
    u_xlat0 = vec4(u_xlat3) * u_xlat1 + u_xlat16_2;
    u_xlat1.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat2.xy = vs_TEXCOORD1.xy;
    u_xlat2.z = vs_TEXCOORD2.x;
    u_xlat2.xyz = u_xlat2.xyz + _Black.xyz;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.w = 0.0;
    u_xlat0 = u_xlat0 * vs_COLOR0 + u_xlat1;
    u_xlat0.x = u_xlat0.y + u_xlat0.x;
    u_xlat0.x = u_xlat0.z + u_xlat0.x;
    u_xlat0.x = u_xlat0.w * u_xlat0.x;
    u_xlat1.xyz = _GlobalAdditiveColor.www * _GlobalAdditiveColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_GlobalAdditiveIntensity);
    u_xlat2.xyz = u_xlat0.xxx * vec3(0.333299994, 0.333299994, 0.333299994) + (-u_xlat1.xyz);
    u_xlat0.x = u_xlat0.x * 0.333299994;
    u_xlat1.xyz = u_xlat0.www * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat2.xyz = _GlobalAdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xxx);
    u_xlat3 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    u_xlat0.xyz = vec3(u_xlat3) * u_xlat2.xyz + u_xlat0.xxx;
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    u_xlat0.xyz = vec3(vec3(_GlobalAdditiveMixParameter, _GlobalAdditiveMixParameter, _GlobalAdditiveMixParameter)) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    SV_Target0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.w = u_xlat0.w;
    return;
}

#endif
"
}
SubProgram "gles3 hw_tier02 " {
Keywords { "GRAYSCALE" "_STRAIGHT_ALPHA_INPUT" "_USE_CUTOFF" }
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
uniform 	vec4 _Color;
in highp vec4 in_POSITION0;
in highp vec2 in_TEXCOORD0;
in highp vec2 in_TEXCOORD1;
in highp vec2 in_TEXCOORD2;
in highp vec4 in_COLOR0;
out highp vec2 vs_TEXCOORD0;
out highp vec2 vs_TEXCOORD1;
out highp vec2 vs_TEXCOORD2;
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
    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
    vs_TEXCOORD1.xy = in_TEXCOORD1.xy;
    vs_TEXCOORD2.xy = in_TEXCOORD2.xy;
    u_xlat0.xyz = _Color.www * _Color.xyz;
    u_xlat0.w = _Color.w;
    vs_COLOR0 = u_xlat0 * in_COLOR0;
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
uniform 	vec4 _SubTex_ST;
uniform 	float _SubTexMix;
uniform 	float _SubTexScrollX;
uniform 	float _SubTexScrollY;
uniform 	vec4 _SubTexCol;
uniform 	vec4 _DistTex_ST;
uniform 	float _Distortion;
uniform 	float _SubTexDistortion;
uniform 	float _DistScrollX;
uniform 	float _DistScrollY;
uniform 	vec4 _Color;
uniform 	vec4 _Black;
uniform 	vec4 _AdditiveColor;
uniform 	vec4 _GlobalAdditiveColor;
uniform 	float _GlobalAdditiveIntensity;
uniform 	float _GlobalAdditiveMixParameter;
uniform 	float _Cutoff;
UNITY_LOCATION(0) uniform mediump sampler2D _MaskTex;
UNITY_LOCATION(1) uniform mediump sampler2D _DistTex;
UNITY_LOCATION(2) uniform mediump sampler2D _SubTex;
UNITY_LOCATION(3) uniform mediump sampler2D _MainTex;
in highp vec2 vs_TEXCOORD0;
in highp vec2 vs_TEXCOORD1;
in highp vec2 vs_TEXCOORD2;
in highp vec4 vs_COLOR0;
layout(location = 0) out highp vec4 SV_Target0;
vec4 u_xlat0;
mediump vec2 u_xlat16_0;
bool u_xlatb0;
vec4 u_xlat1;
mediump vec4 u_xlat16_1;
vec3 u_xlat2;
mediump vec4 u_xlat16_2;
float u_xlat3;
float u_xlat6;
void main()
{
    u_xlat0.xy = _Time.yy * vec2(_DistScrollX, _DistScrollY);
    u_xlat0.xy = vs_TEXCOORD0.xy * _DistTex_ST.xy + u_xlat0.xy;
    u_xlat16_0.xy = texture(_DistTex, u_xlat0.xy).xy;
    u_xlat1.y = u_xlat16_0.y + _DistTex_ST.w;
    u_xlat1.x = u_xlat16_0.x + -0.5;
    u_xlat0.x = _DistTex_ST.z;
    u_xlat0.y = -0.5;
    u_xlat0.xy = u_xlat0.xy + u_xlat1.xy;
    u_xlat6 = u_xlat1.x + _DistTex_ST.z;
    u_xlat16_1.xy = texture(_MaskTex, vs_TEXCOORD0.xy).xy;
    u_xlat0.xy = u_xlat0.xy * u_xlat16_1.yy;
    u_xlat0.xy = u_xlat0.xy * vec2(_Distortion) + vs_TEXCOORD0.xy;
    u_xlat16_2 = texture(_MainTex, u_xlat0.xy);
    u_xlat0.x = u_xlat16_2.w * _Color.w + (-_Cutoff);
#ifdef UNITY_ADRENO_ES3
    u_xlatb0 = !!(u_xlat0.x<0.0);
#else
    u_xlatb0 = u_xlat0.x<0.0;
#endif
    if(u_xlatb0){discard;}
    u_xlat0.x = u_xlat6 * u_xlat16_1.y;
    u_xlat3 = u_xlat16_1.x * _SubTexMix;
    u_xlat0.x = u_xlat0.x * _SubTexDistortion;
    u_xlat0.xz = vs_TEXCOORD0.xy * _SubTex_ST.xy + u_xlat0.xx;
    u_xlat0.xz = vec2(_SubTexScrollX, _SubTexScrollY) * _Time.xx + u_xlat0.xz;
    u_xlat16_1 = texture(_SubTex, u_xlat0.xz);
    u_xlat1 = u_xlat16_1 * _SubTexCol + (-u_xlat16_2);
    u_xlat0 = vec4(u_xlat3) * u_xlat1 + u_xlat16_2;
    u_xlat1.xyz = (-u_xlat0.xyz) + vec3(1.0, 1.0, 1.0);
    u_xlat2.xy = vs_TEXCOORD1.xy;
    u_xlat2.z = vs_TEXCOORD2.x;
    u_xlat2.xyz = u_xlat2.xyz + _Black.xyz;
    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xyz;
    u_xlat1.w = 0.0;
    u_xlat0 = u_xlat0 * vs_COLOR0 + u_xlat1;
    u_xlat0.x = u_xlat0.y + u_xlat0.x;
    u_xlat0.x = u_xlat0.z + u_xlat0.x;
    u_xlat0.x = u_xlat0.w * u_xlat0.x;
    u_xlat1.xyz = _GlobalAdditiveColor.www * _GlobalAdditiveColor.xyz;
    u_xlat1.xyz = u_xlat1.xyz * vec3(_GlobalAdditiveIntensity);
    u_xlat2.xyz = u_xlat0.xxx * vec3(0.333299994, 0.333299994, 0.333299994) + (-u_xlat1.xyz);
    u_xlat0.x = u_xlat0.x * 0.333299994;
    u_xlat1.xyz = u_xlat0.www * u_xlat2.xyz + u_xlat1.xyz;
    u_xlat2.xyz = _GlobalAdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xxx);
    u_xlat3 = _GlobalAdditiveColor.w * _GlobalAdditiveIntensity;
    u_xlat0.xyz = vec3(u_xlat3) * u_xlat2.xyz + u_xlat0.xxx;
    u_xlat1.xyz = (-u_xlat0.xyz) + u_xlat1.xyz;
    u_xlat0.xyz = vec3(vec3(_GlobalAdditiveMixParameter, _GlobalAdditiveMixParameter, _GlobalAdditiveMixParameter)) * u_xlat1.xyz + u_xlat0.xyz;
    u_xlat1.xyz = _AdditiveColor.xyz * u_xlat0.www + (-u_xlat0.xyz);
    SV_Target0.xyz = _AdditiveColor.www * u_xlat1.xyz + u_xlat0.xyz;
    SV_Target0.w = u_xlat0.w;
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
SubProgram "gles hw_tier00 " {
Keywords { "_USE_CUTOFF" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_USE_CUTOFF" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_USE_CUTOFF" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_USE_CUTOFF" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_USE_CUTOFF" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_USE_CUTOFF" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_STRAIGHT_ALPHA_INPUT" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_STRAIGHT_ALPHA_INPUT" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_STRAIGHT_ALPHA_INPUT" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_STRAIGHT_ALPHA_INPUT" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_STRAIGHT_ALPHA_INPUT" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_STRAIGHT_ALPHA_INPUT" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_STRAIGHT_ALPHA_INPUT" "_USE_CUTOFF" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_STRAIGHT_ALPHA_INPUT" "_USE_CUTOFF" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_STRAIGHT_ALPHA_INPUT" "_USE_CUTOFF" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "_STRAIGHT_ALPHA_INPUT" "_USE_CUTOFF" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "_STRAIGHT_ALPHA_INPUT" "_USE_CUTOFF" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "_STRAIGHT_ALPHA_INPUT" "_USE_CUTOFF" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "GRAYSCALE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "GRAYSCALE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "GRAYSCALE" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "GRAYSCALE" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "GRAYSCALE" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "GRAYSCALE" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "GRAYSCALE" "_USE_CUTOFF" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "GRAYSCALE" "_USE_CUTOFF" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "GRAYSCALE" "_USE_CUTOFF" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "GRAYSCALE" "_USE_CUTOFF" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "GRAYSCALE" "_USE_CUTOFF" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "GRAYSCALE" "_USE_CUTOFF" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "GRAYSCALE" "_STRAIGHT_ALPHA_INPUT" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "GRAYSCALE" "_STRAIGHT_ALPHA_INPUT" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "GRAYSCALE" "_STRAIGHT_ALPHA_INPUT" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "GRAYSCALE" "_STRAIGHT_ALPHA_INPUT" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "GRAYSCALE" "_STRAIGHT_ALPHA_INPUT" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "GRAYSCALE" "_STRAIGHT_ALPHA_INPUT" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "GRAYSCALE" "_STRAIGHT_ALPHA_INPUT" "_USE_CUTOFF" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "GRAYSCALE" "_STRAIGHT_ALPHA_INPUT" "_USE_CUTOFF" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "GRAYSCALE" "_STRAIGHT_ALPHA_INPUT" "_USE_CUTOFF" }
""
}
SubProgram "gles3 hw_tier00 " {
Keywords { "GRAYSCALE" "_STRAIGHT_ALPHA_INPUT" "_USE_CUTOFF" }
""
}
SubProgram "gles3 hw_tier01 " {
Keywords { "GRAYSCALE" "_STRAIGHT_ALPHA_INPUT" "_USE_CUTOFF" }
""
}
SubProgram "gles3 hw_tier02 " {
Keywords { "GRAYSCALE" "_STRAIGHT_ALPHA_INPUT" "_USE_CUTOFF" }
""
}
}
}
}
}