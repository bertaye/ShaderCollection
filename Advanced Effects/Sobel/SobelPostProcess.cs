using UnityEngine;
using System.Collections;

[ExecuteInEditMode]
public class SobelPostProcess : MonoBehaviour {

    public float threshold;
    public float extrude = 0;
    public bool GrayScale = true;
    private Material material;

    void Awake() {
        material = new Material(Shader.Find("Devutrino/SobelShader")); //Use the shader.
    }

    void OnRenderImage(RenderTexture source, RenderTexture destination) //Before the buffer is sent to the camera, modify it with above shader.
    {
        if (threshold >= 1.0) {
            Graphics.Blit(source, destination); //Intensity is 0. Blit the image straight to the screen.
            return;
        }
        if (threshold < 0.0)
            threshold = 0.0f;
        material.SetFloat("_GrayScale", GrayScale ? 1.0f : 0.0f);
        material.SetFloat("_Threshold", threshold); //Uniform the value to the shader.
        Graphics.Blit(source, destination, material); //Blit the modified image to the screen.
    }
}