Shader "Hidden/NewImageEffectShader"
{
    SubShader
    {
        // No culling or depth
        //Cull Off ZWrite Off ZTest Always
        
        Pass
        {
            CGPROGRAM
            
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_fog
            
            #include "UnityCG.cginc"
            
            struct appdata
            {
                float4 vertex: POSITION;
            };
            
            struct v2f
            {
                float4 vertex: SV_POSITION;
                // フォグ用のTEXCOORDのindexを指定(fogCoord)
                UNITY_FOG_COORDS(1)
            };
            
            v2f vert(appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                UNITY_TRANSFER_FOG(o, o.vertex);
                return o;
            }
            
            sampler2D _MainTex;
            
            fixed4 frag(v2f i): SV_Target
            {
                fixed4 col = 1;
                // フラグメントシェーダでの計算はこのマクロで
                UNITY_APPLY_FOG(i.fogCoord, col);
                return col;
            }
            ENDCG
            
        }
    }
}
