Shader "Devutrino/BasicTextureBlend"
{
    Properties
    {
        _MainTex ("MainTex", 2D) = "black" {}
        _DecalTex ("Decal", 2D) = "black" {}
    }
        SubShader
    {
        Tags{"Queue" = "Geometry"}
        CGPROGRAM
        #pragma surface surf Lambert

        sampler2D _MainTex;
        sampler2D _DecalTex;

        struct Input {
            float2 uv_MainTex;
        };

        void surf(Input IN, inout SurfaceOutput o) {
            fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
        }


        ENDCG

        Blend One One
        Pass{
            SetTexture [_MainTex] { combine texture }
        }

    }
    FallBack "Diffuse"
}
