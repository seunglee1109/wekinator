/*
 * NewJFrame.java
 *
 * Created on January 24, 2009, 7:32 PM
 */
package wekinator;

import java.text.DecimalFormat;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author  rebecca
 */
public class ComputeAccuracy extends javax.swing.JFrame {

    private WekaOperator w;

    /** Creates new form NewJFrame */
    public ComputeAccuracy(WekaOperator w) {
        initComponents();
        this.w = w;
        int i = w.getNumRounds();

    }

    /** This method is called from within the constructor to
     * initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is
     * always regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jLabel2 = new javax.swing.JLabel();
        textNumFolds = new javax.swing.JTextField();
        buttonCancel = new javax.swing.JButton();
        buttonComputeCV = new javax.swing.JButton();
        buttonComputeCV1 = new javax.swing.JButton();
        labelResults = new javax.swing.JLabel();

        setDefaultCloseOperation(javax.swing.WindowConstants.DISPOSE_ON_CLOSE);
        setTitle("k-Nearest Neighbor Settings");

        jLabel2.setText("# folds");

        textNumFolds.setText("10");

        buttonCancel.setText("Close");
        buttonCancel.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                buttonCancelActionPerformed(evt);
            }
        });

        buttonComputeCV.setText("Compute cross-validation accuracy");
        buttonComputeCV.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                buttonComputeCVActionPerformed(evt);
            }
        });

        buttonComputeCV1.setText("Compute training accuracy");
        buttonComputeCV1.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                buttonComputeCV1ActionPerformed(evt);
            }
        });

        labelResults.setText("Results:");
        labelResults.setVerticalAlignment(javax.swing.SwingConstants.TOP);

        org.jdesktop.layout.GroupLayout layout = new org.jdesktop.layout.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
            .add(org.jdesktop.layout.GroupLayout.TRAILING, layout.createSequentialGroup()
                .addContainerGap(319, Short.MAX_VALUE)
                .add(buttonCancel)
                .addContainerGap())
            .add(layout.createSequentialGroup()
                .add(20, 20, 20)
                .add(layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
                    .add(labelResults, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, 375, Short.MAX_VALUE)
                    .add(buttonComputeCV1)
                    .add(layout.createSequentialGroup()
                        .add(buttonComputeCV)
                        .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                        .add(jLabel2)
                        .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                        .add(textNumFolds, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 44, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)))
                .addContainerGap())
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
            .add(layout.createSequentialGroup()
                .add(24, 24, 24)
                .add(layout.createParallelGroup(org.jdesktop.layout.GroupLayout.BASELINE)
                    .add(textNumFolds, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                    .add(buttonComputeCV)
                    .add(jLabel2))
                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                .add(buttonComputeCV1)
                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                .add(labelResults, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 48, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .add(buttonCancel)
                .addContainerGap())
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

private void buttonCancelActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_buttonCancelActionPerformed
    this.dispose();
}//GEN-LAST:event_buttonCancelActionPerformed

private void buttonComputeCVActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_buttonComputeCVActionPerformed
    int numFolds;
    try {
        numFolds = Integer.parseInt(textNumFolds.getText());
    } catch (NumberFormatException ex) {
        numFolds = 10;
        System.out.println("Number format exception: expected integer");
        textNumFolds.setText("10");
    }
    try {
        double[] results = w.computeCVAccuracy(numFolds);
        String s= "CV Results: ";
                DecimalFormat dd = new DecimalFormat("#.##");

        for (int i= 0; i < results.length; i++) {
            s += "p" + i + ": " + dd.format(results[i]);
            if (i < results.length - 1) {
                s += "; ";
            }
        }
        
        labelResults.setText(s);
                
                
    } catch (Exception ex) {
        Logger.getLogger(ComputeAccuracy.class.getName()).log(Level.SEVERE, null, ex);
    }

}//GEN-LAST:event_buttonComputeCVActionPerformed

private void buttonComputeCV1ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_buttonComputeCV1ActionPerformed
        try {
            double[] results = w.computeTrainingAccuracy();
            String s = "Training results: ";
            DecimalFormat dd = new DecimalFormat("#.##");

            for (int i = 0; i < results.length; i++) {
                s += "p" + i + ": " + dd.format(results[i]);
                if (i < results.length - 1) {
                    s += "; ";
                }
            }

            labelResults.setText(s);
        } catch (Exception ex) {
            Logger.getLogger(ComputeAccuracy.class.getName()).log(Level.SEVERE, null, ex);
        }


}//GEN-LAST:event_buttonComputeCV1ActionPerformed
    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton buttonCancel;
    private javax.swing.JButton buttonComputeCV;
    private javax.swing.JButton buttonComputeCV1;
    private javax.swing.JLabel jLabel2;
    private javax.swing.JLabel labelResults;
    private javax.swing.JTextField textNumFolds;
    // End of variables declaration//GEN-END:variables
}
