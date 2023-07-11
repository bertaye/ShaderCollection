Shader "Devutrino/CustomLighting-BlinnPhong"{
    Properties{
        _Color ("Color", Color) = (1,1,1,1)
    }
    SubShader{
        CGPROGRAM
        #pragma surface surf MyBlinnPhong
        half4 LightingMyBlinnPhong (SurfaceOutput s, half3 lightDir,half3 viewDir ,half atten){
            half3 h = normalize(lightDir + viewDir);

            half diff = max(0,dot(s.Normal,lightDir));
            float nh = max(0,dot(s.Normal,h));
            float spec = pow(nh,48);
            
            half4 c;
            c.rgb = (s.Albedo*_LightColor0.rgb*diff + _LightColor0.rgb*spec)*atten;
            c.a = s.Alpha;
            return c;
        }
        struct Input
        {
            float2 uv_MainTex;
        };
        fixed4 _Color;
        void surf (Input IN, inout SurfaceOutput o)
        {
            o.Albedo = _Color.rgb;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
