public class Data {
    private int F1, F2;
    private int [][] MC;
    private int a;
    
    public Data() {
        F1 = 0;
        F2 = 0;
    }
    //����� ����������� ����� ��������
    public int[][] copyMC() {
        return Lab5.clone(MC);
    }
    public int copya() {
        return a;
    }
    //����� ������������ �� �����
    public synchronized void InputSynchro() {
        try {
            while (F2 < 3) {
                wait();
            }
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }
    //������ �� ��������� �����
    public synchronized void InputSignal() {
        F2++;
        notifyAll();
    }
    //����� ������������ �� ����� (������)
    public synchronized void OutputSynchro() {
        try {
            while (F1 < Lab5.P - 1) {
                wait();
            }
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }
    //������ �� ��������� �����
    public synchronized void CalcEndSignal() {
        F1++;
        notifyAll();
    }
    
    public synchronized void writeMC(int [][] MT1) {
        MC = Lab5.clone(MT1);
    }
    
    public synchronized void writea(int t) {
    	a = t;
    }
}
