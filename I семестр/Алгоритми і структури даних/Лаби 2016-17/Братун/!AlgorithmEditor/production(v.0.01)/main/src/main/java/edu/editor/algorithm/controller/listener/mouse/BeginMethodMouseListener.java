package edu.editor.algorithm.controller.listener.mouse;

import java.awt.event.MouseEvent;
import java.io.Serializable;


import edu.editor.algorithm.model.AlgorithmModel;
import edu.editor.algorithm.model.component.block.BeginMethod;
import edu.editor.algorithm.view.panel.AlgorithmPanel;

public class BeginMethodMouseListener extends BlockMouseListener implements Serializable{
	
	private static final long serialVersionUID = 2199786785007302291L;

	public BeginMethodMouseListener(AlgorithmPanel panel) {
		super(panel);
	}
	
	@Override
	public void mouseClicked(MouseEvent e) {
		AlgorithmModel model = panel.getModel();
		switch (e.getButton()) {
		case MouseEvent.BUTTON1:
			model.deselectAll();
			if (e.getClickCount() == 2) {
				
			} else {
				if (e.getClickCount() == 1) {
					if (!model.contains(e.getX(), e.getY())) {
						model.addComponent(new BeginMethod(e.getX(), e.getY()));
						/*if (!isBeginBlock()) {
							model.addComponent(new BeginMethod(e.getX(), e.getY()));
						} else {
							JOptionPane.showMessageDialog(null, "Begin block is exist.", "Error operation", JOptionPane.ERROR_MESSAGE);
						}*/
					} else {
						model.setSelected(e.getX(), e.getY());
					}
				}
			}
			break;
		case MouseEvent.BUTTON2:
			
			break;
		case MouseEvent.BUTTON3:
			
			break;
		}
		panel.repaint();
	}

	/*private boolean isBeginBlock() {
		AlgorithmModel model = panel.getModel();
		for (int i = 0; i < model.getComponents().size(); i++) {
			if (model.getComponents().get(i) instanceof Begin &&
					!(model.getComponents().get(i) instanceof BeginMethod)) {
				return true;
			}
		}
		return false;
	}*/
}