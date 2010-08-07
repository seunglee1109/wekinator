package drawing;

import wekinator.Plog;
import wekinator.Plog.Msg;
import wekinator.SimpleDataset;
import wekinator.WekinatorRunner;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/*
 * GraphDataViewFrame.java
 *
 * Created on Feb 27, 2010, 12:50:59 PM
 */
/**
 *
 * @author rebecca
 */
public class GraphDataViewFrame extends javax.swing.JFrame {

    GraphDataViewApplet d = new GraphDataViewApplet();
    SimpleDataset myDataset = null;

    /** Creates new form GraphDataViewFrame */
    public GraphDataViewFrame(SimpleDataset dataset) {
        initComponents();
        //  add(d);
        // jPanel1.add(d);
        //  myDataset = dataset;
        d.setDataset(dataset);
        jPanel1.add(d);
        // jPanel1.setPreferredSize(new Dimension(600,400));
        d.init();
    }

    /** This method is called from within the constructor to
     * initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is
     * always regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jPanel1 = new javax.swing.JPanel();
        jButton1 = new javax.swing.JButton();

        setDefaultCloseOperation(javax.swing.WindowConstants.DISPOSE_ON_CLOSE);
        setMinimumSize(new java.awt.Dimension(600, 500));

        jPanel1.setMinimumSize(new java.awt.Dimension(600, 400));
        jPanel1.setPreferredSize(new java.awt.Dimension(600, 400));

        javax.swing.GroupLayout jPanel1Layout = new javax.swing.GroupLayout(jPanel1);
        jPanel1.setLayout(jPanel1Layout);
        jPanel1Layout.setHorizontalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 602, Short.MAX_VALUE)
        );
        jPanel1Layout.setVerticalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGap(0, 309, Short.MAX_VALUE)
        );

        jButton1.setText("Done");
        jButton1.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jButton1ActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(jPanel1, javax.swing.GroupLayout.DEFAULT_SIZE, 602, Short.MAX_VALUE)
                    .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                        .addContainerGap(525, Short.MAX_VALUE)
                        .addComponent(jButton1)))
                .addContainerGap())
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addComponent(jPanel1, javax.swing.GroupLayout.PREFERRED_SIZE, 309, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, 15, Short.MAX_VALUE)
                .addComponent(jButton1))
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void jButton1ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jButton1ActionPerformed
        if (WekinatorRunner.isLogging()) {
            Plog.log(Msg.GRAPHICAL_VIEWER_CLOSED);
        }
        this.dispose();
    }//GEN-LAST:event_jButton1ActionPerformed

    /**
     * @param args the command line arguments
     */
    public static void main(String args[]) {
        java.awt.EventQueue.invokeLater(new Runnable() {

            public void run() {
                boolean isDiscrete[] = {false, false, false, false};
                int numVals[] = {3, 2, 3, 4};
                String featureNames[] = {"F1", "f2", "F3", "f4", "f5", "f6"};
                String paramNames[] = {"P1", "p2", "p3", "p4"};
                SimpleDataset s = new SimpleDataset(6, 4, isDiscrete, numVals, featureNames, paramNames);
                for (int i = 0; i < 100; i++) {
                    double[] featureVals = new double[s.getNumFeatures()];
                    for (int j = 0; j < featureVals.length; j++) {
                        featureVals[j] = Math.random() * 10;
                    }
                    double[] paramVals = new double[s.getNumParameters()];
                    for (int j = 0; j < paramVals.length; j++) {
                        if (isDiscrete[j]) {
                            if (i % 5 == 0) {
                                paramVals[j] = Double.NaN;
                            } else {
                                paramVals[j] = (int) (Math.random() * (numVals[j]));
                            }
                        } else {
                            paramVals[j] = Math.random() * 10;
                        }
                    }
                    s.addInstance(featureVals, paramVals);
                }



                new GraphDataViewFrame(s).setVisible(true);
            }
        });
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton jButton1;
    private javax.swing.JPanel jPanel1;
    // End of variables declaration//GEN-END:variables
}
