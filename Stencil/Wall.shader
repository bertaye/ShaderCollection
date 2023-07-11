Shader "Devutrino/Wall"
{
    Properties
    {
        _MainTex("Diffuse", 2D) = "white" {}
    }
        SubShader
    {
        Tags { "Queue" = "Geometry" }

        Stencil
        {
            Ref 1
            Comp notequal // if this stencil (ref 1) is NOT equal to what is already in the stencil buffer, then keep 
                        //this simply says if you dou find a 1 for this current pixel in the stencil buffer, DONT draw it(the wall).
            Pass keep   //if what you find is NOT 1, keep the current pixel(wall) 
        }

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Standard fullforwardshadows

        sampler2D _MainTex;

        struct Input {
            float2 uv_MainTex;
        };

        void surf(Input IN, inout SurfaceOutputStandard o) {
            // Albedo comes from a texture tinted by color
            fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
            o.Albedo = c.rgb;
        }
        ENDCG
    }
        FallBack "Diffuse"
}
