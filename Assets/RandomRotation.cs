using UnityEngine;
using System.Collections;

public class RandomRotation : MonoBehaviour
{
    public float frequency1 = 0.1f;
    public float frequency2 = 0.1f;

    public float maxAngle1 = 360;
    public float maxAngle2 = 360;

    public Vector3 axis1 = Vector3.right;
    public Vector3 axis2 = Vector3.up;

    float seed1;
    float seed2;

    void Start()
    {
        seed1 = Random.value * 10;
        seed2 = Random.value * 10;
    }

	void Update()
    {
        transform.localRotation =
            Quaternion.AngleAxis(Mathf.PerlinNoise(Time.time * frequency1, seed1) * 360, axis1) *
            Quaternion.AngleAxis(Mathf.PerlinNoise(Time.time * frequency2, seed2) * 360, axis2);
	}
}
