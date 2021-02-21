# CNN_Accelerator(FPGA Design)



This Project is for my EEE3313 class in Yonsei.

The Goals of the project are making CNN(Convolution Neural Network) by FPGA and evaluating the performance by CPU.

I used Vivado tool from Xilinx Inc.

You should follow the baseline configuration in "baseline_configuration.png" or It is allowed to add the verilog file in the design section.

The total file hierarchy is showed in "file_hierarchy.png", you can see it as below.


<code>
1. Design Source
    -top(design_1_warpper.v)
        -p_1: vector_add(vector_add.v)
        -sf_1: start_end(start_end.v)
        -design_1_i : design_1(design_1.bd)
    
2. Constraints
    -constrs_1
        -top.xdc
   
3. Simulation Sources
    -sim_1
        -test_bench(design_1_wrapper.v)
        -top
</code> <br>
       
 Add your files like this, and you can simulate by using test_bench module, and you can execute and compare the result to typical C code(go to "Lanch SDK" menu).
 
 Copy and paste the "main.c" in the C language editor window. You can see the execution time for the CNN in both FPGA and CPU.
