double inverseLerp(double a, double b, double v) => ((v - a) / (b - a));

double lerp(double a, double b, double t) => (1.0 - t) * a + b * t;

double remap(double iMin, double iMax, double oMin, double oMax, double v) => lerp(oMin, oMax, inverseLerp(iMin, iMax, v));
