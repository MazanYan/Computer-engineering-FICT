package kursach;

import javax.swing.Box;
import javax.swing.BoxLayout;
import javax.swing.JComponent;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JTextField;
import javax.swing.border.EmptyBorder;

import kursach.Parametrized;

public class ChangeWeightDialog extends EmptyDialog {
        private JTextField weightField;
        private Parametrized element;
        public ChangeWeightDialog(JFrame owner, Parametrized element) {
                super(owner);
                this.element = element;
                if (element instanceof Node)
                    setTitle("������� ���");
                else
                    setTitle("������� ����� ���������");
                pack();
                setLocation(owner.getX()+owner.getWidth()/2-getWidth()/2,
                                owner.getY()+owner.getHeight()/2-getHeight()/2);
                setVisible(true);
        }

        protected JPanel initControlsPanel() {
                JLabel weightLabel;
                if (element instanceof Node)
                    weightLabel = new JLabel("���: ");
                else
                    weightLabel = new JLabel("����� ���������: ");
                weightField = new JTextField(8);
                JPanel panel = new JPanel();
                panel.setLayout(new BoxLayout(panel, BoxLayout.X_AXIS));
                panel.setBorder(new EmptyBorder(5,5,5,5));
                panel.add(weightLabel);
                panel.add(Box.createHorizontalStrut(3));
                panel.add(weightField);
                return panel;
        }


        protected void approve() {
                if (!weightField.getText().equals("")) {
                        int weight = 0;
                        try {
                                weight = Integer.parseInt(weightField.getText());
                        }
                        catch (NumberFormatException e) {
                            if (element instanceof Node)
                                JOptionPane.showMessageDialog(this, "������� ����� �������� ����",
                                                "������", JOptionPane.ERROR_MESSAGE);
                            else
                                JOptionPane.showMessageDialog(this, "������� ����� �������� ������� ���������",
                                                "������", JOptionPane.ERROR_MESSAGE);
                                return;
                        }
                        element.setParameter(weight);
                        dispose();
                }
        }

        protected void cancel() {
                dispose();
        }
}
