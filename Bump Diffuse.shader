Shader "Devutrino/BumpDiffuse" {
    
    Properties {
        _myDiffuse ("Diffuse Texture",2D) = "white" {}
        _myDiffuseBG("Diffuse Background Texture",2D) = "white" {}
        _myBump ("Bump Texture",2D) = "white" {}
        _mySlider("Bump Amount",Range(0,10)) = 1
        _myBGSlider("BG Amount",Range(0,10)) = 0
        }
    
    SubShader {
        CGPROGRAM
            #pragma surface surf Lambert

            struct Input
            {
                float2 uv_myDiffuse;
                float2 uv_myDiffuseBG;
                float2 uv_myBump;
            	float3 worldRefl;
			};
            sampler2D _myDiffuseBG;
			sampler2D _myDiffuse;
			sampler2D _myBump;
            half _mySlider;
            half _myBGSlider;
            void surf(Input IN, inout SurfaceOutput o)
            {
				o.Albedo = (tex2D(_myDiffuse, IN.uv_myDiffuse)).rgb + (tex2D(_myDiffuseBG,IN.uv_myDiffuseBG).rgb
				                                                        *tex2D(_myDiffuseBG,IN.uv_myDiffuseBG).a)*_myBGSlider  ;
                o.Normal = UnpackNormal(tex2D(_myBump, IN.uv_myBump));
                o.Normal *= float3(_mySlider,_mySlider,1);
            }
        
        ENDCG
    }

    
    
}