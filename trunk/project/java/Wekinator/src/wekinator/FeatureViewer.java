/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/*
 * FeatureViewer.java
 *
 * Created on Dec 13, 2009, 11:14:56 PM
 */

package wekinator;

import java.awt.Dimension;

/**
 *
 * @author rebecca
 */
public class FeatureViewer extends javax.swing.JFrame {

    ParameterMiniViewer[] viewers = null;
    /** Creates new form FeatureViewer */
    public FeatureViewer() {
        initComponents();
    }

    public void setNames(String[] names) {
        panelFeatures.removeAll();
        viewers = new ParameterMiniViewer[names.length];

        for (int i = 0; i < names.length; i++) {
           viewers[i] = new ParameterMiniViewer(names[i], 0.0);
                       viewers[i].setPreferredSize(new Dimension(409, 28));

            panelFeatures.add(viewers[i]);
        }

    }

    public void updateFeatures(double[] features) {
        if (features.length == viewers.length) {
            for (int i = 0; i < viewers.length; i++) {
            viewers[i].setValue(features[i]);
            }
        }

    }

    /** This method is called from within the constructor to
     * initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is
     * always regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jButton1 = new javax.swing.JButton();
        scrollFeaturePanel = new javax.swing.JScrollPane();
        panelFeatures = new javax.swing.JPanel();

        setDefaultCloseOperation(javax.swing.WindowConstants.DISPOSE_ON_CLOSE);
        setTitle("Features (will update when you record examples or run)");

        jButton1.setText("Close");
        jButton1.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jButton1ActionPerformed(evt);
            }
        });

        panelFeatures.setLayout(new javax.swing.BoxLayout(panelFeatures, javax.swing.BoxLayout.Y_AXIS));
        scrollFeaturePanel.setViewportView(panelFeatures);

        org.jdesktop.layout.GroupLayout layout = new org.jdesktop.layout.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
            .add(org.jdesktop.layout.GroupLayout.TRAILING, layout.createSequentialGroup()
                .addContainerGap(318, Short.MAX_VALUE)
                .add(jButton1)
                .addContainerGap())
            .add(scrollFeaturePanel, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, 414, Short.MAX_VALUE)
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
            .add(org.jdesktop.layout.GroupLayout.TRAILING, layout.createSequentialGroup()
                .add(scrollFeaturePanel, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, 262, Short.MAX_VALUE)
                .addPreferredGap(org.jdesktop.layout.LayoutStyle.UNRELATED)
                .add(jButton1))
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void jButton1ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jButton1ActionPerformed
        this.dispose();
    }//GEN-LAST:event_jButton1ActionPerformed

    /**
    * @param args the command line arguments
    */
    public static void main(String args[]) {
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                FeatureViewer fv = new FeatureViewer();
                String[] names = new String[2];
                names[0] = "abc";
                names[1] = "def";
                double[] vals = {0.0, 1.0};
                
                fv.setNames(names);
                fv.updateFeatures(vals);
                
                fv.setVisible(true);

            }
        });
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton jButton1;
    private javax.swing.JPanel panelFeatures;
    private javax.swing.JScrollPane scrollFeaturePanel;
    // End of variables declaration//GEN-END:variables

}
