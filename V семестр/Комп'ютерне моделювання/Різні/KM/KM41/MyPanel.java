package KM41;

import java.awt.Color;
import java.awt.Graphics;
import java.util.Random;
import javax.swing.JPanel;
public class MyPanel extends JPanel{
    private boolean drawen = false;
    private int[] _y;
    private int _m;
    private float max_delta_local = 0;
    
    public float getDeltaMax(){
        return max_delta_local - 10;
    }
    public void count(int N, int M, int A, int C, int D, double fi, double lmbd){
        drawen = true;
        _m = M;
        double[] w = new double[N]; // ����� ������������ �����
        double[] t = new double[N]; // ����� ������������ �����
        double alfa = 0;
        _y = new int[M];
        Random random = new Random();
        w[0] = 0.67510980;//random.nextDouble();
        if (w[0] <= fi){
            alfa = 2 * fi * lmbd;
        } else {
            alfa = 2 * (1 - fi) * lmbd;
        }
        t[0] = Math.abs(Math.log(w[0]) / alfa);
        t[0] -= (int)t[0];
        for (int i = 1; i < N; i++) {
            w[i] = (A * w[i - 1] + C) / D; // ��������� �����
            w[i] -= (int) w[i];
            if (w[i] <= fi){
                alfa = 2 * fi * lmbd;
            } else {
                alfa = 2 * (1 - fi) * lmbd;
            }
            t[i] = Math.abs(Math.log(w[i]) / alfa);
            t[i] -= (int)t[i];
        }
        for (int i = 0; i < N - 1; i++) {_y[(int) (t[i] * M)]++;}
        _y[M - 1]++;
        float[] delta = new float[M];
        float midsum = (float) N / M;
        max_delta_local = 0;
        for (int k = 0; k < M; k++){
            delta[k]=(Math.abs(_y[k]-midsum))*100/midsum;
            if (delta[k] > max_delta_local){
                max_delta_local = delta[k];
            }
        }
    }
    public void paint(Graphics g) {
        super.paint(g);
        System.out.println(drawen);
        if (drawen){
            g.drawLine(10, 360, 360, 360);
            g.drawLine(10, 10, 10, 360);
            int maxY = getMax(_y);
            int oneY = 350 / maxY;
            int oneX = 350 / _m;
            int color = 0x000FFF;
            Color c = new Color(color);
            for (int i = 0; i < _y.length; i++){
                g.setColor(c);
                g.fillRect((i + 1)*oneX, 360 - oneY * _y[i], oneX, oneY * _y[i]);
                c = new Color(color - i*(_m / 10));
            }
        }
    }
    private int getMax(int[] _y2) {
        int max = 0;
        for (int i = 0; i < _y2.length; i++){
            if (max < _y2[i]) max = _y2[i];
        }
        return max;
    }
}
