Shader "Custom/GalaxyBox" {
    Properties
    {
        _Cubemap("Cubemap", Cube) = "white" {}
        _TintColor("Tint Color", Color) = (0.5, 0.5, 0.5, 0.5)
    }

    CGINCLUDE

    #include "UnityCG.cginc"

    struct appdata_t
    {
        float4 position : POSITION;
        float3 texcoord : TEXCOORD0;
    };

    struct v2f
    {
        float4 position : POSITION;
        float3 texcoord : TEXCOORD0;
    };

    samplerCUBE _Cubemap;
    half4 _TintColor;
    float4x4 _RotationMatrix;

    v2f vert(appdata_t v)
    {
        v2f o;
        float4 p = mul(_RotationMatrix, v.position);
        o.position = mul(UNITY_MATRIX_MVP, p);
        o.texcoord = v.texcoord;
        return o;
    }

    half4 frag(v2f i) : COLOR
    {
        half4 c = texCUBE(_Cubemap, i.texcoord);
        return c * _TintColor * 2.0f;
    }

    ENDCG

    SubShader
    {
        Tags { "Queue"="Background" "RenderType"="Background" }
        Cull Off
        ZWrite Off
        Fog { Mode Off }
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma fragmentoption ARB_precision_hint_fastest
            ENDCG
        }
    } 
}
