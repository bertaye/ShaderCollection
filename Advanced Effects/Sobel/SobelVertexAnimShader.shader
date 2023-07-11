Shader "Devutrino/SobelShader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Threshold ("Outline Threshold",Range (0,1)) = 0
        [MaterialToggle] _GrayScale ("UseGrayScale",Float) = 0
        [MaterialToggle] _ExtrudeAnim ("Extrude Animation",Float) = 0
        _Amount("Extrude",Range(1,5)) = 1

    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex: POSITION;
                float3 normal: NORMAL;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            float4 _MainTex_ST;
            float _Amount;
            float _ExtrudeAnim;

            v2f vert (appdata v)
            {
                v2f o;
                if (_ExtrudeAnim == 1) {
                    _Amount *= 0.001 + sin(_Time.y * 10) * 0.001;
                    v.vertex.xyz += v.normal * _Amount;
                }
                
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);

                return o;
            }
            sampler2D _MainTex;
            float _Threshold;
            float _GrayScale;
            fixed4 frag(v2f i) : SV_Target
            {
                float4 xGrad = float4(0.0, 0.0, 0.0, 0.0);
                float4 yGrad = float4(0.0, 0.0, 0.0, 0.0);
                float4 temp = float4(0.0,0.0,0.0,0.0);
                float sum = 0.0;
                float offsetX = 1.0 - _ScreenParams.z;
                float offsetY = 1.0 - _ScreenParams.w;
                float xoffset = 1.0 - _ScreenParams.z;
                float yoffset = 1.0 - _ScreenParams.w;

                //temp = tex2D(_MainTex, i.uv + float2(-offsetX, -offsetY));
                //xGrad += temp * -3.0;

                //temp = tex2D(_MainTex, i.uv + float2(offsetX, -offsetY));
                //xGrad += temp * 3.0;

                //temp = tex2D(_MainTex, i.uv + float2(-offsetX, 0.0));
                //xGrad += temp * -10.0;

                //temp = tex2D(_MainTex, i.uv + float2(-offsetX, 0.0));
                //xGrad += temp * 10.0;

                //temp = tex2D(_MainTex, i.uv + float2(-offsetX, offsetY));
                //xGrad += temp * -3.0;

                //temp = tex2D(_MainTex, i.uv + float2(offsetX, offsetY));
                //xGrad += temp * 3.0;

                //start calculating the x gradient
                temp = tex2D(_MainTex, i.uv + float2(-xoffset, yoffset));
                xGrad += temp * -1.0;

                temp = tex2D(_MainTex, i.uv + float2(-xoffset, 0));
                xGrad += temp * -2.0;

                temp = tex2D(_MainTex, i.uv + float2(-xoffset, -yoffset));
                xGrad += temp * -1.0;

                temp = tex2D(_MainTex, i.uv + float2(xoffset, yoffset));
                xGrad += temp * 1.0;

                temp = tex2D(_MainTex, i.uv + float2(xoffset, 0));
                xGrad += temp * 2.0;

                temp = tex2D(_MainTex, i.uv + float2(xoffset, -yoffset));
                xGrad += temp * 1.0;
                 
                //start calculating the y gradient
                temp = tex2D(_MainTex, i.uv + float2(-xoffset, yoffset));
                yGrad += temp * 1.0;

                temp = tex2D(_MainTex, i.uv + float2(0, yoffset));
                yGrad += temp * 2.0;

                temp = tex2D(_MainTex, i.uv + float2(xoffset, yoffset));
                yGrad += temp * 1.0;

                temp = tex2D(_MainTex, i.uv + float2(-xoffset, yoffset));
                yGrad += temp * -1.0;

                temp = tex2D(_MainTex, i.uv + float2(0, yoffset));
                yGrad += temp * -2.0;

                temp = tex2D(_MainTex, i.uv + float2(xoffset, yoffset));
                yGrad += temp * -1.0;
                /*temp = tex2D(_MainTex, i.uv + float2(-offsetX, -offsetY));
                yGrad += temp * 3.0;

                temp = tex2D(_MainTex, i.uv + float2(0.0, -offsetY));
                yGrad += temp * 10.0;

                temp = tex2D(_MainTex, i.uv + float2(offsetX, -offsetY));
                yGrad += temp * 3.0;

                temp = tex2D(_MainTex, i.uv + float2(-offsetX, offsetY));
                yGrad += temp * -3.0;

                temp = tex2D(_MainTex, i.uv + float2(0.0, offsetY));
                yGrad += temp * -10.0;

                temp = tex2D(_MainTex, i.uv + float2(offsetX, offsetY));
                yGrad += temp * -3.0;

                sum = sqrt((xGrad * xGrad) + (yGrad * yGrad));*/

                // sample the texture
                sum = sqrt((xGrad * xGrad) + (yGrad * yGrad));
                fixed4 col = tex2D(_MainTex, i.uv);

                if (sum > _Threshold)
                    col = float4(0.0, 0.0, 0.0, 1.0);
                else
                    if (_GrayScale == 0) {
                        /*col = float4(
                            (col.r * 0.3 + col.g * 0.59 + col.b * 0.11),
                            (col.r * 0.3 + col.g * 0.59 + col.b * 0.11),
                            (col.r * 0.3 + col.g * 0.59 + col.b * 0.11),
                            1.0);*/
                        if (col.r > 0.7 && col.g > 0.7 && col.b > 0.7) {
                            col = float4(col.rgb, 1.0);
                        }
                        else {
                            col = float4(sum, sum, sum, 1.0);
                        }
                    }
                    else {
                        col = float4(col.rgb, 1);
                    }
                    
                // apply fog
                return col;
            }
            ENDCG
        }
    }
}
