Shader "Devutrino/RimLogicalCutoff"
{
    Properties
    {
        _RimColor ("Color", Color) = (0,0.5,0.5,0.0)
      
    }
    SubShader
    {

        CGPROGRAM
        #pragma surface surf Lambert
        
        struct Input
        {
            float3 viewDir;
        };

        float4 _RimColor;
        float _RimPower;
        void surf (Input IN, inout SurfaceOutput o)
        {
            half rim = 1-saturate(dot(normalize(IN.viewDir),o.Normal));
            o.Emission = rim>0.5 ? float3(1,0,0):0;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
