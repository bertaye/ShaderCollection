Shader "Devutrino/CustomLighting-ToonRamp"{
    Properties{
        _Color ("Color", Color) = (1,1,1,1)
        _RampTex("Ramp Texture", 2D) = "white" {}
    }
    SubShader{
        CGPROGRAM
        #pragma surface surf ToonRamp
        sampler2D _RampTex;
        fixed4 _Color;
        half4 LightingToonRamp (SurfaceOutput s, half3 lightDir,half atten){
            
            float diff = dot (s.Normal,lightDir);
            
            diff = max(0,diff);
            float h = diff*0.9+0.1;
            float2 rh = h;

            float3 ramp = tex2D(_RampTex,rh).rgb;

            float4 c;
            c.rgb = s.Albedo*_LightColor0.rgb*ramp;
            c.a = s.Alpha;
            return c;
        }
        struct Input{
            float2 uv_MainTex;
        };
        void surf (Input IN, inout SurfaceOutput o){
            o.Albedo = _Color.rgb;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
