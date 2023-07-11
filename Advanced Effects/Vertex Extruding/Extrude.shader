Shader "Devutrino/Extrude"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Amount ("Extrude",Range(-1,1)) = 0.01
    }
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert vertex:vert //now it knows to find vertex shader!

        struct Input
        {
            float2 uv_MainTex;
        };

        float _Amount;

        struct appdata {
            float4 vertex: POSITION;
            float3 normal: NORMAL;
            float4 texcoord: TEXCOORD0;
        };

        void vert(inout appdata v) {
            v.vertex.xyz += v.normal * _Amount;
        }

        sampler2D _MainTex;
        void surf (Input IN, inout SurfaceOutput o)
        {
            o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
