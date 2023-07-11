Shader "Devutrino/CoolReflection" {
	
	Properties {
		_exampleColor ("Example Color",Color) = (1,1,1,1)
		_exampleRange ("Example Range",Range(0,5)) = 1
		_exampleTex("Example Texture",2D) = "white" {}
		_exampleCube("Example Cube",CUBE) = ""{}
		_exampleFloat("Example Float",Float) = 0.5
		_exampleVector("Example Vector",Vector) = (0.5,1,1,1)
	}
	
	SubShader {
		CGPROGRAM
			#pragma surface surf Lambert

			struct Input
			{
				float2 uv_exampleTex;
				float3 worldRefl;
			};

			fixed4 _exampleColor;
			half _exampleRange;
			sampler2D _exampleTex;
			samplerCUBE _exampleCube;
			float _exampleFloat;
			float4 _exampleVector;

			void surf(Input IN, inout SurfaceOutput o)
			{
				o.Albedo = (tex2D(_exampleTex, IN.uv_exampleTex) * _exampleRange).rgb + _exampleColor;
				o.Emission = (texCUBE(_exampleCube, IN.worldRefl) * _exampleFloat).rgb;
			   // o.Albedo = _myAlbedo.rgb;
				//o.Emission = _myEmission.rgb;
				//o.Normal = _myNormal.rgb;
			}
		
		ENDCG
	}

	
	
}